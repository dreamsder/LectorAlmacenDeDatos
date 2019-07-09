#include "moduloreportes.h"
#include <Utilidades/database.h>
#include <QFile>
#include <QDebug>
#include <QString>
#include <QDir>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlRecord>
#include <QSplitter>
#include <QVariant>
#include <QTextDocument>
#include <QPrinter>
#include <QDesktopServices>
#include <QUrl>

QString _tiempoReporte="";


ModuloReportes::ModuloReportes(QObject *parent) :
    QObject(parent)
{}

QString ModuloReportes::retornaDirectorioReporteWeb() const{

    if(QDir::rootPath()=="/"){
        return  QDir::homePath()+"/.preview.html";
    }else{
        return  "/LectorAlmacen/preview.html";
    }
}
QString ModuloReportes::retornaDirectorioReporteWebSinLinks() const{

    if(QDir::rootPath()=="/"){
        return  QDir::homePath()+"/.previewSinLinks.html";
    }else{
        return  "/LectorAlmacen/previewSinLinks.html";
    }
}

QString ModuloReportes::retornaDirectorioEstiloCssPDF() const{

    if(QDir::rootPath()=="/"){
        return  "/opt/LectorAlmacen/estilo.css";
    }else{
        return  QDir::rootPath()+"/LectorAlmacen/estilo.css";
    }
}
QString ModuloReportes::retornaDirectorioEstiloCssHTML() const{

    if(QDir::rootPath()=="/"){
        return  "/opt/LectorAlmacen/estilo.css";
    }else{
        return  "estilo.css";
    }
}
QString ModuloReportes::retornaDirectorioBanner() const{

    if(QDir::rootPath()=="/"){
        return  "/opt/LectorAlmacen/banner.png";
    }else{
        return  "banner.png";
    }
}
QString ModuloReportes::retornaDirectorioPDF() const{

    if(QDir::rootPath()=="/"){
        return  QDir::homePath()+"/";
    }else{
        return  QDir::rootPath()+"/LectorAlmacen/Reporte/";
    }
}

QString ModuloReportes::generarReporte(QString _whereDinamico,bool _soloCuadroReclamos,bool _excluirCausasExternas,
                                       bool _sinLinks,bool _ocultarReclamosSinCausasExternas, bool _ocultarCuadroDeAsistencias,
                                       QString _consultaSegunAsistenciaResolucion, bool _fusionarCuadroCausasExternas,
                                       QString _codigoPerfilesTiempoResolucion

                                       ) const {

    int colorEstiloAlterno=0;
    double cantidadReclamosHardware=0;
    double cantidadReclamosSoftware=0;
    double cantidadReclamosCausasExternas=0;

    QFile previewHTML;

    Database::cehqueStatusAccesoMysql("local");
    bool conexion=true;
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }


    // qDebug()<< _whereDinamico;
    if(conexion){

        QString _consultaSqlSinWhere="select       "
                "REC.razonCliente as 'Cliente',    "
                "REC.nombreSucursal as 'Sucursal', "
                "sum(1) as 'Asistencias',          "
                "case when sum(case when REC.codigoArea=1 then 1 else 0 end)=0 then '' else sum(case when REC.codigoArea=1 then 1 else 0 end) end as 'Hardware', "
                "case when sum(case when REC.codigoArea=2 then 1 else 0 end)=0 then '' else sum(case when REC.codigoArea=2 then 1 else 0 end) end   as 'Sistemas', "
                "case when sum(case when REC.codigoTipoReclamo=2 then 1 else 0 end)=0 then '' else sum(case when REC.codigoTipoReclamo=2 then 1 else 0 end)   end as 'Fuera Horario', "
                "case when sum(case when REC.codigoCoordinado=1 then 1 else 0 end)=0 then ''  else  sum(case when REC.codigoCoordinado=1 then 1 else 0 end)   end    as 'Coordinados'     "
                "from Reclamos  "
                "REC where 1=1  ";

        QString _groupBy="group by REC.codigoCliente,REC.codigoSucursal  order by REC.razonCliente,REC.codigoSucursal";

        QString _consultaSqlSinWhereTotales="select       "
                "'Total' as 'Cliente',    "
                "REC.nombreSucursal as 'Sucursal', "
                "sum(1) as 'Asistencias',          "
                "sum(case when REC.codigoArea=1 then 1 else 0 end) as 'Hardware', "
                "sum(case when REC.codigoArea=2 then 1 else 0 end) as 'Sistemas', "
                "sum(case when REC.codigoTipoReclamo=2 then 1 else 0 end) as 'Fuera Horario', "
                "sum(case when REC.codigoCoordinado=1 then 1 else 0 end) as 'Coordinados'     "
                "from Reclamos  "
                "REC where 1=1  ";



        QString _consultaClientesSeleccionados=" select REC.razonCliente as 'Cliente'  from Reclamos  REC where 1=1 ";

        QString _consultaClientesSeleccionadosConCodigoCliente;
        if(_ocultarReclamosSinCausasExternas){
            _consultaClientesSeleccionadosConCodigoCliente=" select REC.razonCliente as 'Cliente',REC.codigoCliente  from Reclamos  REC where 1=1 and REC.causaAtribuida!='SISTECO' ";
        }else{
            _consultaClientesSeleccionadosConCodigoCliente=" select REC.razonCliente as 'Cliente',REC.codigoCliente  from Reclamos  REC where 1=1 ";
        }


        QString _consultaSucursalesSeleccionadosConCodigoSucursal;
        if(_ocultarReclamosSinCausasExternas){
            _consultaSucursalesSeleccionadosConCodigoSucursal=" select REC.nombreSucursal as 'Cliente',REC.codigoSucursal  from Reclamos  REC where 1=1 and REC.causaAtribuida!='SISTECO' ";
        }else{
            _consultaSucursalesSeleccionadosConCodigoSucursal=" select REC.nombreSucursal as 'Cliente',REC.codigoSucursal  from Reclamos  REC where 1=1 ";
        }


        QString _consultaCodigoReclamosSeleccionadosClienteSucursal;
        if(_ocultarReclamosSinCausasExternas){
            _consultaCodigoReclamosSeleccionadosClienteSucursal=" select REC.codigoReclamo,REC.nombreTecnicoResponsable,REC.direccionSucursal,REC.nombreDepartamento,"
                    "REC.fechaCompletaReclamo,REC.horaCompletaReclamo , REC.nombreTipo,REC.nombreMarca, REC.nombreModelo,REC.nombreSolicitante,REC.nombreFirmoCierre "
                    " ,REC.numeroSerie,REC.causaAtribuida,REC.nombreCausa,REC.causaDeCliente,REC.tituloReclamo,REC.codigoCoordinado,REC.fechaCompletaFinalizacion,REC.horaCompletaFinalizacion,REC.tiempoEsperaRespuestaCliente from Reclamos  REC where 1=1 and REC.causaAtribuida!='SISTECO' ";
        }else{
            _consultaCodigoReclamosSeleccionadosClienteSucursal=" select REC.codigoReclamo,REC.nombreTecnicoResponsable,REC.direccionSucursal,REC.nombreDepartamento,"
                    "REC.fechaCompletaReclamo,REC.horaCompletaReclamo , REC.nombreTipo,REC.nombreMarca, REC.nombreModelo,REC.nombreSolicitante,REC.nombreFirmoCierre "
                    " ,REC.numeroSerie,REC.causaAtribuida,REC.nombreCausa,REC.causaDeCliente,REC.tituloReclamo,REC.codigoCoordinado,REC.fechaCompletaFinalizacion,REC.horaCompletaFinalizacion,REC.tiempoEsperaRespuestaCliente from Reclamos  REC where 1=1 ";
        }


        ///Consultas para obtener datos
        QString _consultaCausasExternasSoftware="select REC.nombreCausa, sum(1),sum(1) from Reclamos REC where REC.causaAtribuida!='SISTECO' and REC.codigoArea=2 ";
        QString _consultaCausasExternasHardware="select REC.nombreCausa, sum(1),sum(1) from Reclamos REC where REC.causaAtribuida!='SISTECO' and REC.codigoArea=1 ";
        QString _consultaCausasExternasTotalesSoftware="select count(*) from Reclamos REC where REC.causaAtribuida!='SISTECO' and REC.codigoArea=2 ";
        QString _consultaCausasExternasTotalesHardware="select count(*) from Reclamos REC where REC.causaAtribuida!='SISTECO' and REC.codigoArea=1 ";
        QString _consultaCantidadReclamosHardware="select count(*) from Reclamos REC where 1=1 and REC.codigoArea=1 ";
        QString _consultaCantidadReclamosSoftware="select count(*) from Reclamos REC where 1=1 and REC.codigoArea=2 ";
        QString _consultaAniosSeleccionados=" select sub.Anio from ( select REC.codigoAnio as 'Anio'  from Reclamos  REC where 1=1 ";
        QString _consultaDetalleDeCausasExternasTotales="select REC.codigoCausa, sum(1),REC.nombreCausa  from Reclamos REC where REC.causaAtribuida!='SISTECO' ";
        QString _consultaDetalleDeCausasClienteYSucursales="select REC.codigoCausa, sum(1), REC.codigoCliente,REC.razonCliente,REC.codigoSucursal,REC.nombreSucursal  from Reclamos REC where REC.causaAtribuida!='SISTECO' ";
        QString _consultaAsistenciasSegunTiempoResolucion= _consultaSegunAsistenciaResolucion; //"SELECT sum(1), case when tiempoResolucion<=239 then 'Menos de 4 hrs' WHEN tiempoResolucion>239 and tiempoResolucion<=479 THEN 'Entre 4 y 8 hrs'    else 'La incidencia reportada necesitó análisis de desarrollo'  end ,tiempoResolucion, sum(tiempoResolucion)  FROM Reclamos REC  where 1=1 ";

        /// Causas externas de software y hardware
        QString _consultaCausasExternasFusionadas="select REC.nombreCausa, sum(1),sum(1) from Reclamos REC where REC.causaAtribuida!='SISTECO'  ";
        QString _consultaCausasExternasFusionadasTotalesSoftwareyHardware="select count(*) from Reclamos REC where REC.causaAtribuida!='SISTECO'  ";



        ///Group by's para las consultas anteriores
        QString _groupByCodigoReclamo=" group by REC.codigoReclamo order by REC.codigoReclamo ";
        QString _groupByConsultaClientes=" group by REC.codigoCliente order by REC.razonCliente ";
        QString _groupByConsultaSucursales=" group by REC.codigoSucursal order by REC.codigoSucursal ";
        QString _groupByAniosSeleccionados=" ) sub group by sub.Anio order by sub.Anio "; // " group by REC.codigoAnio order by REC.codigoAnio ";
        QString _consultaMesesSeleccionados=" select REC.nombreMes as 'Mes'  from Reclamos  REC where 1=1 ";
        QString _groupByMesesSeleccionados=" group by REC.codigoMes order by REC.codigoMes ";
        QString _groupByCausasExternas=" group by REC.codigoCausa order by 2 desc ";
        QString _groupByDetalleDeCausasExternasClientesYSucursales=" group by REC.codigoCausa,REC.codigoCliente,REC.codigoSucursal order by 2 desc, 4 asc,  6 asc ";
        QString _groupByAsistenciasSegunTiempoResolucion= " group by 2 order by 3 asc ";

        QString _consultaAniosSeleccionadosDemo=_consultaAniosSeleccionados;
      //  qDebug()<< _consultaAniosSeleccionadosDemo.append(_whereDinamico).append(_groupByAniosSeleccionados);

        QSqlQuery queryAnios = Database::consultaSql(_consultaAniosSeleccionados.append(_whereDinamico).append(_groupByAniosSeleccionados),"local");



        QSqlQuery queryClientes = Database::consultaSql(_consultaClientesSeleccionados.append(_whereDinamico).append(_groupByConsultaClientes),"local");
        QSqlQuery queryMeses;




        ///Calculo el total de reclamos segun el area
        QSqlQuery queryCantidadReclamos = Database::consultaSql(_consultaCantidadReclamosHardware.append(_whereDinamico),"local");
        if(queryCantidadReclamos.first()){
            cantidadReclamosHardware=queryCantidadReclamos.value(0).toInt();
        }

        queryCantidadReclamos.clear();
        queryCantidadReclamos = Database::consultaSql(_consultaCantidadReclamosSoftware.append(_whereDinamico),"local");
        if(queryCantidadReclamos.first()){
            cantidadReclamosSoftware=queryCantidadReclamos.value(0).toInt();
        }



        QSqlQuery query = Database::consultaSql(_consultaSqlSinWhere.append(_whereDinamico).append(_groupBy),"local");

        if(_sinLinks){
            previewHTML.setFileName(retornaDirectorioReporteWebSinLinks());
        }else{
            previewHTML.setFileName(retornaDirectorioReporteWeb());
        }

        QTextStream out(&previewHTML);
        previewHTML.open(QIODevice::WriteOnly);


        out << "<!DOCTYPE html>";
        out << "\n<html lang=\"es\">";
        out << "\n<head>";
        out << "\n<meta charset=\"UTF-8\"/>";
        out << "\n<title>Reporte</title>";
        out << "\n<link rel=\"stylesheet\" href=\""+retornaDirectorioEstiloCssHTML()+"\">";
        out << "\n</head>";
        out << "\n<body>";




        ///Lista de Clientes a mostrar
        out << "\n<header>";


        if(_sinLinks){
            out << "<div class=\"listaClientesCabezal\"  width=\"100%\"  >";
            out << "<img class=\"logoBanner\"  src=\""+retornaDirectorioBanner()+"\" width=\"299\" height=\"114\"  />";
            out << "</div><br><br><br><br>";
        }

        out << "\n<div class=\"listaClientesCabezal\"  align=\"left\">";

        while(queryClientes.next()){
            out << queryClientes.value(0).toString();
            if(queryClientes.next()){
                queryClientes.previous();
                out << " - ";
            }

        }
        out << "</div>";


        ///Lista de años y meses a mostrar
        while(queryAnios.next()){
            out << "\n<div class=\"aniosYMeses\" align=\"left\">";

            out << queryAnios.value(0).toString()+" - ";

            QString consultaMeses=_consultaMesesSeleccionados;


            queryMeses = Database::consultaSql(consultaMeses.append(_whereDinamico).append(" and REC.codigoAnio='"+queryAnios.value(0).toString()+"' ").append(_groupByMesesSeleccionados),"local");

            while(queryMeses.next()){
                out << queryMeses.value(0).toString();
                if(queryMeses.next()){
                    queryMeses.previous();
                    out << " - ";
                }
            }
            queryMeses.clear();
            out << "</div>";
        }

        out << "\n</header>";


        if(query.first()){
            if(query.value(0).toString()!=""){

                out << "\n<section>";
                out << "\n<article>";
                out << "\n<table width=\"100%\">";
                out << "\n<thead>";
                out << "\n<tr>";


                ///Imprimo la cabecera de la tabla de asistencias por cliente
                for(int i=0;i< query.record().count();i++){

                    if(!i==0)
                        out << "\n<th class=\"cabeceraTablaResumenPrincipal\">"+query.record().fieldName(i)+"</th>";

                }
                out << "\n</tr>";
                out << "\n</thead>";

                out << "\n<tbody>";

                ///Imprimo el contenido de la tabla
                query.previous();
                while(query.next()){
                    out << "\n<tr>";

                    for(int j=0;j< query.record().count();j++){
                        if(j==1){

                        }else{
                            if(j==0){

                                out << "\n<th class=\"columnaClienteSucursalResumenPrincipal\" align:left;>"+query.value(j).toString()+"<br  align:left;color:#f9f9f9; >"+query.value(1).toString()+"</th>";
                            }else{
                                if(colorEstiloAlterno==0){
                                    out << "\n<th class=\"formatoFilaIntercalada1_ResumenPrincipal\" >"+query.value(j).toString()+"</th>";

                                }else if(colorEstiloAlterno==1){
                                    out << "\n<th class=\"formatoFilaIntercalada2_ResumenPrincipal\">"+query.value(j).toString()+"</th>";
                                }
                            }
                        }
                    }
                    out << "\n</tr>";
                    if(colorEstiloAlterno==0){
                        colorEstiloAlterno=1;
                    }else if(colorEstiloAlterno==1){
                        colorEstiloAlterno=0;
                    }
                }
                out << "\n</tbody>";

                out << "\n<tfoot>";


                out << "\n<tr>";


                ///Imprimo la cabecera de la tabla de asistencias por cliente
                for(int i=0;i< query.record().count();i++){
                    if(i==0){
                        out << "\n<th class=\"cabeceraTablaResumenPrincipal\">TOTAL</th>";
                    }else if(i==1){

                    }else{
                        out << "\n<th class=\"cabeceraTablaResumenPrincipal\">"+query.record().fieldName(i)+"</th>";
                    }
                }
                out << "\n</tr>";

                out << "\n<tr>";

                //// Imprimo los totales en la tabla
                QSqlQuery query2 = Database::consultaSql(_consultaSqlSinWhereTotales.append(_whereDinamico).append(" group by 1"),"local");

                if(query2.first()){

                    for(int k=0;k< query2.record().count();k++){

                        if(k==0){
                            out << "\n<th class=\"pieTotalResumenPrincipal\"></th>";
                        }else if(k==1){

                        }else{
                            out << "\n<th class=\"pieTotalResumenPrincipal\">"+query2.value(k).toString()+"</th>";
                        }
                    }
                }
                out << "\n</tr>";
                out << "\n</tfoot>";
                out << "\n</table>";
                out << "\n</article>";
                out << "\n</section>";

            }else{
                return "0";
            }



            /// Levanto los datos del perfil asociado
            QSqlQuery queryPerfilesTiempoResolucion= Database::consultaSql("select textoTiempoClienteTerceros,mostrarCoordinado,mostrarHoraFinalizado,mostrarTextoTiempoClienteTerceros,mostrarTiempoPromedioAsistencias from PerfilesTiempoResolucion where codigoPerfilesTiempoResolucion='"+_codigoPerfilesTiempoResolucion+"'","local");
            queryPerfilesTiempoResolucion.first();


            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /// Chequeo si tengo que excluir el cuadro de asistencias por hora segun tiempo de resolucion. Si es true, el cuadro no aparece, si es false, el cuadro aparece.
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(!_ocultarCuadroDeAsistencias && _consultaAsistenciasSegunTiempoResolucion!=""){

                colorEstiloAlterno=0;
                //  bool _tieneAsistenciasConTiempoMayorAochoHoras=false;
                QSqlQuery queryCuadroAsistenciasPorTiempoResuelto = Database::consultaSql(_consultaAsistenciasSegunTiempoResolucion.append(_whereDinamico).append(_groupByAsistenciasSegunTiempoResolucion),"local");



                if(queryCuadroAsistenciasPorTiempoResuelto.first()){
                    if(queryCuadroAsistenciasPorTiempoResuelto.value(0).toString()!=""){

                        out << "\n<section>";
                        out << "\n<article>";
                        out << "\n<table  width=\"100%\">";
                        out << "\n<thead>";
                        out << "\n<tr>";
                        out << "\n<th width=\"35%\" class=\"cabeceraCuadroTiempos\">TIEMPO DE RESOLUCION</th>";
                        out << "\n<th width=\"20%\" class=\"cabeceraCuadroTiempos\">CANTIDAD DE ASISTENCIAS</th>";
                        out << "\n<th width=\"25%\" class=\"cabeceraCuadroTiempos\">% SOBRE TOTAL</th>";

                        //Chequeo si muestro el tiempo promedio por asistencia
                        if(queryPerfilesTiempoResolucion.value(4).toString()=="1"){
                            out << "\n<th width=\"20%\" class=\"cabeceraCuadroTiempos\">TIEMPO PROMEDIO ASISTENCIA</th>";
                        }


                        out << "\n</tr>";
                        out << "\n</thead>";
                        out << "\n<tbody>";

                        ///Imprimo el contenido de la tabla
                        queryCuadroAsistenciasPorTiempoResuelto.previous();

                     /*   ///Obtengo el total de tiempo de las asistencias de éste cuadro
                        long totalTiempoAsistencias=0;
                        while(queryCuadroAsistenciasPorTiempoResuelto.next()){
                             totalTiempoAsistencias+=queryCuadroAsistenciasPorTiempoResuelto.value(3).toLongLong();
                        }*/





                        queryCuadroAsistenciasPorTiempoResuelto.first();
                        queryCuadroAsistenciasPorTiempoResuelto.previous();


                        while(queryCuadroAsistenciasPorTiempoResuelto.next()){
                            out << "\n<tr>";

                            for(int j=0;j< queryCuadroAsistenciasPorTiempoResuelto.record().count();j++){

                                if(queryCuadroAsistenciasPorTiempoResuelto.value(1).toString().trimmed()!="Otro"){

                                    if(j==0){
                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoFilaIntercalada1_CuadroTiempos\" align=\"left\" >"+queryCuadroAsistenciasPorTiempoResuelto.value(1).toString()+"</th>";
                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoFilaIntercalada2_CuadroTiempos\" align=\"left\" >"+queryCuadroAsistenciasPorTiempoResuelto.value(1).toString()+"</th>";
                                        }
                                    }else if(j==1){
                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoFilaIntercalada1_CuadroTiempos\" align=\"center\" >"+queryCuadroAsistenciasPorTiempoResuelto.value(0).toString()+"</th>";
                                            out << "\n<th class=\"formatoFilaIntercalada1_CuadroTiempos\" >"+QString::number((100/(cantidadReclamosHardware+cantidadReclamosSoftware))*queryCuadroAsistenciasPorTiempoResuelto.value(0).toDouble(),'f',2)+" % </th>";

                                            //Chequeo si muestro el tiempo promedio por asistencia
                                            if(queryPerfilesTiempoResolucion.value(4).toString()=="1"){
                                                out << "\n<th class=\"formatoFilaIntercalada1_CuadroTiempos\" >"+retornarTiempoTotalEnHoras(queryCuadroAsistenciasPorTiempoResuelto.value(4).toDouble())+" hs.</th>";
                                            }


                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoFilaIntercalada2_CuadroTiempos\" align=\"center\" >"+queryCuadroAsistenciasPorTiempoResuelto.value(0).toString()+"</th>";
                                            out << "\n<th class=\"formatoFilaIntercalada2_CuadroTiempos\" >"+QString::number((100/(cantidadReclamosHardware+cantidadReclamosSoftware))*queryCuadroAsistenciasPorTiempoResuelto.value(0).toDouble(),'f',2)+" % </th>";

                                            //Chequeo si muestro el tiempo promedio por asistencia
                                            if(queryPerfilesTiempoResolucion.value(4).toString()=="1"){
                                                out << "\n<th class=\"formatoFilaIntercalada2_CuadroTiempos\" >"+retornarTiempoTotalEnHoras(queryCuadroAsistenciasPorTiempoResuelto.value(4).toDouble())+" hs.</th>";
                                            }
                                        }
                                    }
                                }
                            }
                            out << "\n</tr>";
                            if(colorEstiloAlterno==0){
                                colorEstiloAlterno=1;
                            }else if(colorEstiloAlterno==1){
                                colorEstiloAlterno=0;
                            }
                        }

                        out << "\n</tbody>";
                        out << "\n</table>";
                        out << "\n</article>";
                        out << "\n</section>";
                    }
                }
            }


            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /// Chequeo si tengo que excluir el cuadro de causas externas. Si es true, el cuadro no aparece, si es false, el cuadro aparece.
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if(!_excluirCausasExternas){



                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////// Chequeo si hay que fusionar los cuadros de causas externas  /////////////////////////////////////
                if(_fusionarCuadroCausasExternas){


                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////// CUADRO CAUSAS EXTERNAS FUSIONADAS  //////////////////////////////////////////////////////////////
                    colorEstiloAlterno=0;
                    QSqlQuery queryCausasExternasFusionadas = Database::consultaSql(_consultaCausasExternasFusionadas.append(_whereDinamico).append(_groupByCausasExternas),"local");

                    if(queryCausasExternasFusionadas.first()){
                        if(queryCausasExternasFusionadas.value(0).toString()!=""){

                            out << "\n<section>";
                            out << "\n<article>";
                            out << "\n<table  width=\"100%\">";
                            out << "\n<thead>";
                            out << "\n<tr>";
                            out << "\n<th width=\"55%\" class=\"cabeceraCuadroCausasExternasSoftware\">CAUSAS EXTERNAS</th>";
                            out << "\n<th width=\"20%\" class=\"cabeceraCuadroCausasExternasSoftware\">ASISTENCIAS</th>";
                            out << "\n<th width=\"25%\" class=\"cabeceraCuadroCausasExternasSoftware\">% SOBRE EL TOTAL</th>";
                            out << "\n</tr>";
                            out << "\n</thead>";

                            out << "\n<tbody>";

                            ///Imprimo el contenido de la tabla
                            queryCausasExternasFusionadas.previous();
                            while(queryCausasExternasFusionadas.next()){
                                out << "\n<tr>";

                                for(int j=0;j< queryCausasExternasFusionadas.record().count();j++){

                                    if(j==0){
                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoColumna1_FilaIntercalada1_CausaExternaSoftware\" >"+queryCausasExternasFusionadas.value(j).toString()+"</th>";
                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoColumna1_FilaIntercalada2_CausaExternaSoftware\" >"+queryCausasExternasFusionadas.value(j).toString()+"</th>";
                                        }
                                    }else if(j==1){
                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoFilaIntercalada1_CausaExternaSoftware\" >"+queryCausasExternasFusionadas.value(j).toString()+"</th>";

                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoFilaIntercalada2_CausaExternaSoftware\">"+queryCausasExternasFusionadas.value(j).toString()+"</th>";
                                        }
                                    }else if(j==2){


                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoFilaIntercalada1_CausaExternaSoftware\" >"+QString::number((100/(cantidadReclamosSoftware+cantidadReclamosHardware))*queryCausasExternasFusionadas.value(j).toDouble(),'f',2)+" %</th>";

                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoFilaIntercalada2_CausaExternaSoftware\" >"+QString::number((100/(cantidadReclamosSoftware+cantidadReclamosHardware))*queryCausasExternasFusionadas.value(j).toDouble(),'f',2)+" %</th>";

                                        }
                                    }

                                }
                                out << "\n</tr>";
                                if(colorEstiloAlterno==0){
                                    colorEstiloAlterno=1;
                                }else if(colorEstiloAlterno==1){
                                    colorEstiloAlterno=0;
                                }
                            }

                            out << "\n</tbody>";
                            out << "\n<tfoot>";
                            out << "\n<tr>";


                            //// Imprimo los totales en la tabla de causas externas software
                            QSqlQuery queryCausasExternasFusionadasTotaltes = Database::consultaSql(_consultaCausasExternasFusionadasTotalesSoftwareyHardware.append(_whereDinamico),"local");

                            if(queryCausasExternasFusionadasTotaltes.first()){

                           //     cantidadReclamosCausasExternas+=queryCausasExternasFusionadasTotaltes.value(0).toDouble();

                                out << "\n<th class=\"pieTotalCuadroCausasExternasSoftware\">SUBTOTAL</th>";
                                out << "\n<th class=\"pieTotalCuadroCausasExternasSoftware\">"+queryCausasExternasFusionadasTotaltes.value(0).toString()+"</th>";
                                out << "\n<th class=\"pieTotalCuadroCausasExternasSoftware\">"+QString::number((100/(cantidadReclamosSoftware+cantidadReclamosHardware))*queryCausasExternasFusionadasTotaltes.value(0).toDouble(),'f',2)+" %</th>";
                            }
                            out << "\n</tr>";
                            out << "\n</tfoot>";
                            out << "\n</table>";
                            out << "\n</article>";
                            out << "\n</section>";
                        }
                    }





                }else{
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////// CUADRO CAUSA EXTERNA SOFTWARE  //////////////////////////////////////////////////////////////////
                    colorEstiloAlterno=0;
                    QSqlQuery queryCausasExternasSoftware = Database::consultaSql(_consultaCausasExternasSoftware.append(_whereDinamico).append(_groupByCausasExternas),"local");

                    if(queryCausasExternasSoftware.first()){
                        if(queryCausasExternasSoftware.value(0).toString()!=""){

                            out << "\n<section>";
                            out << "\n<article>";
                            out << "\n<table  width=\"100%\">";
                            out << "\n<thead>";
                            out << "\n<tr>";
                            out << "\n<th width=\"55%\" class=\"cabeceraCuadroCausasExternasSoftware\">SISTEMAS - CAUSAS EXTERNAS</th>";
                            out << "\n<th width=\"20%\" class=\"cabeceraCuadroCausasExternasSoftware\">ASISTENCIAS</th>";
                            out << "\n<th width=\"25%\" class=\"cabeceraCuadroCausasExternasSoftware\">% SOBRE SOFTWARE</th>";
                            out << "\n</tr>";
                            out << "\n</thead>";

                            out << "\n<tbody>";

                            ///Imprimo el contenido de la tabla
                            queryCausasExternasSoftware.previous();
                            while(queryCausasExternasSoftware.next()){
                                out << "\n<tr>";

                                for(int j=0;j< queryCausasExternasSoftware.record().count();j++){

                                    if(j==0){
                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoColumna1_FilaIntercalada1_CausaExternaSoftware\" >"+queryCausasExternasSoftware.value(j).toString()+"</th>";
                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoColumna1_FilaIntercalada2_CausaExternaSoftware\" >"+queryCausasExternasSoftware.value(j).toString()+"</th>";
                                        }
                                    }else if(j==1){
                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoFilaIntercalada1_CausaExternaSoftware\" >"+queryCausasExternasSoftware.value(j).toString()+"</th>";

                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoFilaIntercalada2_CausaExternaSoftware\">"+queryCausasExternasSoftware.value(j).toString()+"</th>";
                                        }
                                    }else if(j==2){


                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoFilaIntercalada1_CausaExternaSoftware\" >"+QString::number((100/cantidadReclamosSoftware)*queryCausasExternasSoftware.value(j).toDouble(),'f',2)+" %</th>";

                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoFilaIntercalada2_CausaExternaSoftware\" >"+QString::number((100/cantidadReclamosSoftware)*queryCausasExternasSoftware.value(j).toDouble(),'f',2)+" %</th>";

                                        }
                                    }

                                }
                                out << "\n</tr>";
                                if(colorEstiloAlterno==0){
                                    colorEstiloAlterno=1;
                                }else if(colorEstiloAlterno==1){
                                    colorEstiloAlterno=0;
                                }
                            }

                            out << "\n</tbody>";
                            out << "\n<tfoot>";
                            out << "\n<tr>";


                            //// Imprimo los totales en la tabla de causas externas software
                            QSqlQuery queryCausasExternasTotaltesSoftware = Database::consultaSql(_consultaCausasExternasTotalesSoftware.append(_whereDinamico),"local");

                            if(queryCausasExternasTotaltesSoftware.first()){

                                cantidadReclamosCausasExternas+=queryCausasExternasTotaltesSoftware.value(0).toDouble();

                                out << "\n<th class=\"pieTotalCuadroCausasExternasSoftware\">SUBTOTAL</th>";
                                out << "\n<th class=\"pieTotalCuadroCausasExternasSoftware\">"+queryCausasExternasTotaltesSoftware.value(0).toString()+"</th>";
                                out << "\n<th class=\"pieTotalCuadroCausasExternasSoftware\">"+QString::number((100/cantidadReclamosSoftware)*queryCausasExternasTotaltesSoftware.value(0).toDouble(),'f',2)+" %</th>";
                            }
                            out << "\n</tr>";
                            out << "\n</tfoot>";
                            out << "\n</table>";
                            out << "\n</article>";
                            out << "\n</section>";
                        }
                    }




                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////// CUADRO CAUSA EXTERNA HARDWARE  //////////////////////////////////////////////////////////////////
                    colorEstiloAlterno=0;
                    QSqlQuery queryCausasExternasHardware = Database::consultaSql(_consultaCausasExternasHardware.append(_whereDinamico).append(_groupByCausasExternas),"local");

                    if(queryCausasExternasHardware.first()){
                        if(queryCausasExternasHardware.value(0).toString()!=""){

                            out << "\n<section>";
                            out << "\n<article>";
                            out << "\n<table  width=\"100%\">";
                            out << "\n<thead>";
                            out << "\n<tr>";
                            out << "\n<th width=\"55%\" class=\"cabeceraCuadroCausasExternasHardware\">HARDWARE - CAUSAS EXTERNAS</th>";
                            out << "\n<th width=\"20%\" class=\"cabeceraCuadroCausasExternasHardware\">ASISTENCIAS</th>";
                            out << "\n<th width=\"25%\" class=\"cabeceraCuadroCausasExternasHardware\">% SOBRE HARDWARE</th>";
                            out << "\n</tr>";
                            out << "\n</thead>";
                            out << "\n<tbody>";

                            ///Imprimo el contenido de la tabla
                            queryCausasExternasHardware.previous();
                            while(queryCausasExternasHardware.next()){
                                out << "\n<tr>";

                                for(int j=0;j< queryCausasExternasHardware.record().count();j++){

                                    if(j==0){
                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoColumna1_FilaIntercalada1_CausaExternaHardware\" >"+queryCausasExternasHardware.value(j).toString()+"</th>";
                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoColumna1_FilaIntercalada2_CausaExternaHardware\" >"+queryCausasExternasHardware.value(j).toString()+"</th>";
                                        }
                                    }else if(j==1){

                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoFilaIntercalada1_CausaExternaHardware\" >"+queryCausasExternasHardware.value(j).toString()+"</th>";

                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoFilaIntercalada2_CausaExternaHardware\">"+queryCausasExternasHardware.value(j).toString()+"</th>";
                                        }
                                    }else if(j==2){

                                        if(colorEstiloAlterno==0){
                                            out << "\n<th class=\"formatoFilaIntercalada1_CausaExternaHardware\" >"+QString::number((100/cantidadReclamosHardware)*queryCausasExternasHardware.value(j).toDouble(),'f',2)+" %</th>";

                                        }else if(colorEstiloAlterno==1){
                                            out << "\n<th class=\"formatoFilaIntercalada2_CausaExternaHardware\" >"+QString::number((100/cantidadReclamosHardware)*queryCausasExternasHardware.value(j).toDouble(),'f',2)+" %</th>";

                                        }
                                    }

                                }
                                out << "\n</tr>";
                                if(colorEstiloAlterno==0){
                                    colorEstiloAlterno=1;
                                }else if(colorEstiloAlterno==1){
                                    colorEstiloAlterno=0;
                                }
                            }

                            out << "\n</tbody>";
                            out << "\n<tfoot>";
                            out << "\n<tr>";


                            //// Imprimo los totales en la tabla de causas externas hardware
                            QSqlQuery queryCausasExternasTotaltesHardware = Database::consultaSql(_consultaCausasExternasTotalesHardware.append(_whereDinamico),"local");

                            if(queryCausasExternasTotaltesHardware.first()){

                                cantidadReclamosCausasExternas+=queryCausasExternasTotaltesHardware.value(0).toDouble();

                                out << "\n<th width=\"55%\" class=\"pieTotalCuadroCausasExternasHardware\">SUBTOTAL</th>";
                                out << "\n<th width=\"20%\" class=\"pieTotalCuadroCausasExternasHardware\">"+queryCausasExternasTotaltesHardware.value(0).toString()+"</th>";
                                out << "\n<th width=\"25%\" class=\"pieTotalCuadroCausasExternasHardware\">"+QString::number((100/cantidadReclamosHardware)*queryCausasExternasTotaltesHardware.value(0).toDouble(),'f',2)+" %</th>";
                            }


                            out << "\n</tr>";
                            out << "\n</tfoot>";
                            out << "\n</table>";
                            out << "\n</article>";
                            out << "\n</section>";
                        }
                    }


                }



                //// Muestro el cuadro de detalle de causas externas
                QSqlQuery queryDetalleCausasExternasTotales = Database::consultaSql(_consultaDetalleDeCausasExternasTotales.append(_whereDinamico).append(_groupByCausasExternas),"local");

                QString _respaldoConsultaDetalleCausasExternasClientesySucursales;

                if(queryDetalleCausasExternasTotales.first()){
                    queryDetalleCausasExternasTotales.previous();
                    while(queryDetalleCausasExternasTotales.next()){

                        _respaldoConsultaDetalleCausasExternasClientesySucursales=_consultaDetalleDeCausasClienteYSucursales;

                        if(queryDetalleCausasExternasTotales.value(0).toString()!=""){


                            out << "\n<section class=\"formatoSection_detalleCausasExternas\">";
                            out << "\n<article class=\"formatoArticle_detalleCausasExternas\">";
                            out << "\n<table class=\"formatoTabla_detalleCausasExternas\" width=\"100%\">";
                            out << "\n<thead class=\"formatoCabezalTabla_detalleCausasExternas\">";
                            out << "\n<tr class=\"formatoFilaCabezalTabla_detalleCausasExternas\">";
                            out << "\n<th width=\"35%\" class=\"cabeceraTabla_detalleCausasExternas\"></th>";
                            out << "\n<th width=\"50%\" class=\"cabeceraTabla_detalleCausasExternas\" align=\"left\">"+queryDetalleCausasExternasTotales.value(2).toString().trimmed()+"</th>";
                            out << "\n<th width=\"15%\" class=\"cabeceraTabla_detalleCausasExternas\">Asistencias</th>";
                            out << "\n</tr>";
                            out << "\n</thead>";
                            out << "\n<tbody>";

                            QSqlQuery queryDetalleCausasExternasClientesYsucursales = Database::consultaSql(_respaldoConsultaDetalleCausasExternasClientesySucursales.append(" and REC.codigoCausa='"+queryDetalleCausasExternasTotales.value(0).toString()+"' ").append(_whereDinamico).append(_groupByDetalleDeCausasExternasClientesYSucursales),"local");
                            if(queryDetalleCausasExternasClientesYsucursales.first()){
                                queryDetalleCausasExternasClientesYsucursales.previous();
                                while(queryDetalleCausasExternasClientesYsucursales.next()){

                                    out << "\n<tr class=\"formatoFilaTabla_detalleCausasExternas\">";
                                    out << "\n<th class=\"formatoFilaIntercalada1_CausaExterna\" align=\"left\">"+queryDetalleCausasExternasClientesYsucursales.value(3).toString()+"</th>";
                                    out << "\n<th class=\"formatoFilaIntercalada1_CausaExterna\" align=\"left\">"+queryDetalleCausasExternasClientesYsucursales.value(5).toString()+"</th>";
                                    out << "\n<th class=\"formatoFilaIntercalada2_CausaExterna\" align=\"center\">"+queryDetalleCausasExternasClientesYsucursales.value(1).toString()+"</th>";
                                    out << "\n</tr>";

                                }
                            }
                            out << "\n</tbody>";
                            out << "\n</table>";
                            out << "\n</article>";
                            out << "\n</section>";
                        }
                    }
                }
            }




            /// Chequeo si tengo que generar solo el cuadro de reclamos. Si es true, genera solo el cuadro de reclamos, si es false, se
            /// generan todos los reclamos por cliente y sucursal.
            if(!_soloCuadroReclamos){

                /// Imprimo los registros por reclamo para todos los clientes, por sucursal
                QSqlQuery queryClientesConCodigo = Database::consultaSql(_consultaClientesSeleccionadosConCodigoCliente.append(_whereDinamico).append(_groupByConsultaClientes),"local");
                QSqlQuery querySucursalesConCodigo;
                QSqlQuery queryCodigoReclamoClienteSucursales;
                QSqlQuery queryTareas;
                QSqlQuery queryConceptos;
                out << "\n\n";
                while(queryClientesConCodigo.next()){
                    out << "\n<div class=\"titulo\" align=\"left\"><br><PRE> <u><b>Cliente:  "+queryClientesConCodigo.value(0).toString().toUpper()+"</b></u></PRE></div>";

                    QString _variableConsultaSucursalesSeleccionadosConCodigoSucursal=_consultaSucursalesSeleccionadosConCodigoSucursal;
                    querySucursalesConCodigo=Database::consultaSql(_variableConsultaSucursalesSeleccionadosConCodigoSucursal.append(_whereDinamico).append(" and REC.codigoCliente='"+queryClientesConCodigo.value(1).toString()+"'").append(_groupByConsultaSucursales),"local");
                    while(querySucursalesConCodigo.next()){
                        out << "\n<div class=\"titulo\" align=\"left\"><br><PRE><b>        Sucursal:  "+querySucursalesConCodigo.value(0).toString().toUpper()+"</b></PRE></div>";


                        QString _variableConsultaCodigoReclamosSeleccionadosClienteSucursal=_consultaCodigoReclamosSeleccionadosClienteSucursal;
                        queryCodigoReclamoClienteSucursales=Database::consultaSql(_variableConsultaCodigoReclamosSeleccionadosClienteSucursal.append(_whereDinamico).append(" and REC.codigoCliente='"+queryClientesConCodigo.value(1).toString()+"' and REC.codigoSucursal='"+querySucursalesConCodigo.value(1).toString()+"' ").append(_groupByCodigoReclamo),"local");

                     //   qDebug()<< queryCodigoReclamoClienteSucursales.lastQuery();

                        while(queryCodigoReclamoClienteSucursales.next()){

                            out << "\n<article>";
                            out << "\n<table  width=\"100%\" >";
                            out << "\n<tbody>";


                            out << "\n<tr >";

                            QString mensajeCoordinado="Reclamo Coordinado";
                            QString fechaHoraFinalizado= "Finalizado: "+queryCodigoReclamoClienteSucursales.value(17).toString().trimmed()+" - "+queryCodigoReclamoClienteSucursales.value(18).toString().trimmed();

                            QString classMenmsajeCoordinado="formatoFilaCoordinado";

                            if(queryCodigoReclamoClienteSucursales.value(16).toString().trimmed()=="0"){
                                    mensajeCoordinado="";
                                    classMenmsajeCoordinado="formatoFilaIntercalada1_Reclamos";
                            }

                            //Chequeo si muestro la etiqueta de Reclamo coordinado
                            if(queryPerfilesTiempoResolucion.value(1).toString()=="0"){
                                mensajeCoordinado="";
                                classMenmsajeCoordinado="formatoFilaIntercalada1_Reclamos";
                            }

                            //Chequeo si muestro la etiqueta de fecha hora finalizado
                            if(queryPerfilesTiempoResolucion.value(2).toString()=="0"){
                                fechaHoraFinalizado="";
                            }




                            if(_sinLinks){
                                out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada1_Reclamos\"text-align:left; >Asistencia técnica N°:     "+queryCodigoReclamoClienteSucursales.value(0).toString().trimmed()+"</td>";
                                out << "\n<td colspan=\"3\" class=\""+classMenmsajeCoordinado+"\"text-align:left;  >"+mensajeCoordinado+"</td>";

                            }else{
                                out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada1_Reclamos\"text-align:left; >Asistencia técnica N°:     <a href=\"http://madai.sisteco.uy/madai/recXPerfilModificar.php?idReclamo="+queryCodigoReclamoClienteSucursales.value(0).toString().trimmed()+"\" >"+queryCodigoReclamoClienteSucursales.value(0).toString().trimmed()+"</a>    </td>";
                                out << "\n<td colspan=\"3\" class=\""+classMenmsajeCoordinado+"\"text-align:left;  >"+mensajeCoordinado+"</td>";

                            }


                            out << "\n</tr>";

                            out << "\n<tr>";
                            out << "\n<td  colspan=\"1\" class=\"formatoFilaIntercalada2_Reclamos\" text-align:left;>Cliente: "+queryClientesConCodigo.value(0).toString().trimmed()+"</td>";
                            out << "\n<td colspan=\"3\" class=\"formatoFilaIntercalada2_Reclamos\"text-align:left; >Sucursal: "+querySucursalesConCodigo.value(0).toString().trimmed()+"</td>";
                            out << "\n</tr>";

                            out << "\n<tr>";
                            out << "\n<td  colspan=\"1\" class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>Dirección: "+queryCodigoReclamoClienteSucursales.value(2).toString().trimmed()+"</td>";
                            out << "\n<td colspan=\"3\" class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>Departamento: "+queryCodigoReclamoClienteSucursales.value(3).toString().trimmed()+"</td>";
                            out << "\n</tr>";


                            out << "\n<tr>";
                            out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada2_Reclamos\" text-align:left;>Fecha: "+queryCodigoReclamoClienteSucursales.value(4).toString().trimmed()+"</td>";
                            out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada2_Reclamos\" text-align:left;>Hora llamado: "+queryCodigoReclamoClienteSucursales.value(5).toString().trimmed()+"</td>";
                            out << "\n<td colspan=\"2\" class=\"formatoFilaIntercalada2_Reclamos\" text-align:left;>"+fechaHoraFinalizado+"</td>";

                            out << "\n</tr>";


                            out << "\n<tr>";
                            out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>Tipo: "+queryCodigoReclamoClienteSucursales.value(6).toString().trimmed()+"</td>";
                            out << "\n<td class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>Marca: "+queryCodigoReclamoClienteSucursales.value(7).toString().trimmed()+"</td>";
                            out << "\n<td class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>Modelo: "+queryCodigoReclamoClienteSucursales.value(8).toString().trimmed()+"</td>";

                            if(queryCodigoReclamoClienteSucursales.value(11).toString().trimmed()==""){
                                out << "\n<td class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>Serie: - - - - - - - - - - -</td>";
                            }else{
                                out << "\n<td class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>Serie: "+queryCodigoReclamoClienteSucursales.value(11).toString().trimmed()+"</td>";
                            }
                            out << "\n</tr>";



                            out << "\n<tr>";
                            out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada2_Reclamos\" text-align:left;>Solicitante: "+queryCodigoReclamoClienteSucursales.value(9).toString().trimmed()+"</td>";
                            out << "\n<td colspan=\"3\" class=\"formatoFilaIntercalada2_Reclamos\" text-align:left;>Firma del cliente: "+queryCodigoReclamoClienteSucursales.value(10).toString().trimmed()+"</td>";
                            out << "\n</tr>";


                            QString _vacio="";
                            out << "\n<tr>";
                            out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>Título del reclamo según cliente: "+_vacio.trimmed()+"</td>";
                            out << "\n<td colspan=\"3\" class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>"+queryCodigoReclamoClienteSucursales.value(15).toString().trimmed()+"</td>";
                            out << "\n</tr>";


                            out << "\n<tr>";
                            out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada2_Reclamos\" text-align:left;>Tareas: </td>";
                            out << "\n<td colspan=\"3\" class=\"formatoFilaIntercalada2_Reclamos\" text-align:left;>";
                            queryTareas=Database::consultaSql("select nombreTareaReporte from Tareas where idReclamo='"+queryCodigoReclamoClienteSucursales.value(0).toString().trimmed()+"' group by nombreTareaReporte  order by fechaTarea,horaTarea","local");
                            int contadorTareas=1;
                            while(queryTareas.next()){

                                if(contadorTareas!=1){
                                    out << "<br>"+QString::number(contadorTareas)+") "+queryTareas.value(0).toString().trimmed().toUpper();
                                }else{
                                    out << QString::number(contadorTareas)+") "+queryTareas.value(0).toString().trimmed().toUpper();
                                }

                                contadorTareas++;
                            }
                            out << "</td>";
                            out << "\n</tr>";


                            queryConceptos=Database::consultaSql("select nombreConcepto from Conceptos where idReclamo='"+queryCodigoReclamoClienteSucursales.value(0).toString().trimmed()+"'","local");

                            if(queryConceptos.size()!=0){
                                out << "\n<tr>";
                                out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>Conceptos a facturar: </td>";
                                out << "\n<td colspan=\"3\" class=\"formatoFilaIntercalada1_Reclamos\" text-align:left;>";
                                int contadorConceptos=1;
                                while(queryConceptos.next()){

                                    if(contadorConceptos!=1){
                                        out << "<br>"+QString::number(contadorConceptos)+") "+queryConceptos.value(0).toString().trimmed().toUpper();
                                    }else{
                                        out << QString::number(contadorConceptos)+") "+queryConceptos.value(0).toString().trimmed().toUpper();
                                    }

                                    contadorConceptos++;
                                }
                                out << "</td>";
                                out << "\n</tr>";
                            }


                            if(queryCodigoReclamoClienteSucursales.value(12).toString().trimmed()!="SISTECO"){
                                out << "\n<tr>";
                                out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada3_Reclamos\" text-align:left;>Causa externa: </td>";
                                out << "\n<td colspan=\"3\" class=\"formatoFilaIntercalada3_Reclamos\" text-align:left;>"+queryCodigoReclamoClienteSucursales.value(13).toString().trimmed()+"</td>";
                                out << "\n</tr>";

                                out << "\n<tr>";
                                out << "\n<td colspan=\"1\" class=\"formatoFilaIntercalada3_Reclamos\" text-align:left;>Detalle: </td>";
                                out << "\n<td colspan=\"3\" class=\"formatoFilaIntercalada3_Reclamos\" text-align:left;>"+queryCodigoReclamoClienteSucursales.value(14).toString().trimmed()+"</td>";
                                out << "\n</tr>";
                            }


                            if(queryCodigoReclamoClienteSucursales.value(19).toString().trimmed()!="0" && queryPerfilesTiempoResolucion.value(3).toString()=="1"){

                                QString  textoAmostrar=queryPerfilesTiempoResolucion.value(0).toString().trimmed();

                                QString tiempoClienteHora=QString::number(queryCodigoReclamoClienteSucursales.value(19).toInt()/60);
                                QString tiempoClienteMinutos=QString::number((queryCodigoReclamoClienteSucursales.value(19).toInt())%60);

                                if(tiempoClienteHora.length()==1){
                                    tiempoClienteHora="0"+tiempoClienteHora;
                                }

                                if(tiempoClienteMinutos.length()==1){
                                    tiempoClienteMinutos="0"+tiempoClienteMinutos;
                                }

                                textoAmostrar.replace("%tc%",tiempoClienteHora+":"+tiempoClienteMinutos);

                                out << "\n<tr>";
                                out << "\n<td colspan=\"4\" class=\"formatoFilaIntercalada2_Reclamos\" text-align:left;>"+textoAmostrar+"</td>";
                                out << "\n</tr>";




                            }



                            out << "\n</tbody>";
                            out << "\n</table>";
                            out << "\n</article>";

                            out << "\n<hr>";
                        }
                    }
                }
            }
        }else{
            return "0";
        }
        out << "\n<footer>";
        out << "\n</footer>";
        out << "\n</body>";
        out << "\n</html>";

        previewHTML.close();
        return "1";


    }else{return "-1";}
}

bool ModuloReportes::imprimirReporteEnPDF(QString _filtroReporte)const{

    QFile previewHTML(retornaDirectorioReporteWebSinLinks());
    previewHTML.open(QIODevice::ReadOnly);

    QFile estiloCSS(retornaDirectorioEstiloCssPDF());
    estiloCSS.open(QIODevice::ReadOnly);

    QString const html = QString::fromAscii(previewHTML.readAll());
    QString const estilo = QString::fromAscii(estiloCSS.readAll());

    QTextDocument doc;
    QFont fuente;

    //fuente.setPointSize(8);
    doc.setDefaultFont(fuente);
    doc.setDocumentMargin(10);
    doc.setDefaultStyleSheet(estilo);
    doc.setHtml(html);


    QPrinter printer;
    printer.setPageMargins(0,0,0,0,QPrinter::Millimeter);
    printer.setCreator("Sisteco S.A.");

    if(QDir::rootPath()=="/"){
    }else{
        if(!QDir(QDir::rootPath()+"/LectorAlmacen/Reporte" ).exists()){
            QDir directorio;
            if(!directorio.mkdir(QDir::rootPath()+"/LectorAlmacen/Reporte")){
                return false;
            }
        }
    }

    printer.setOutputFileName(retornaDirectorioPDF()+retornaNombreReportePDF(_filtroReporte));
    printer.setOutputFormat(QPrinter::PdfFormat);
    doc.print(&printer);

    return true;
}



void ModuloReportes::abrirNavegadorArchivos()const{
    if(QDir::rootPath()=="/"){
        QDesktopServices::openUrl(QUrl(QDir::homePath()));
    }else{
        QDesktopServices::openUrl(QUrl(QDir::rootPath()+"/LectorAlmacen/Reporte"));
    }
}

QString ModuloReportes::retornaNombreReportePDF(QString _whereDinamico) const {


    QString _nombreReportePDF="";
    Database::cehqueStatusAccesoMysql("local");
    bool conexion=true;
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }

    if(conexion){

        QString _consultaClientesSeleccionados=" select REC.razonCliente as 'Cliente'  from Reclamos  REC where 1=1 ";
        QString _groupByConsultaClientes=" group by REC.codigoCliente order by REC.razonCliente ";

        QString _consultaAniosSeleccionados=" select sub.Anio'Anio' from (select REC.codigoAnio as 'Anio'  from Reclamos  REC where 1=1 ";
        QString _groupByAniosSeleccionados="  order by REC.codigoAnio) sub group by sub.Anio ";
        //QString _groupByAniosSeleccionados=" group by REC.codigoAnio order by REC.codigoAnio) ";

        QString _consultaMesesSeleccionados=" select REC.nombreMes as 'Mes'  from Reclamos  REC where 1=1 ";
        QString _groupByMesesSeleccionados=" group by REC.codigoMes order by REC.codigoMes ";


        QSqlQuery queryClientes = Database::consultaSql(_consultaClientesSeleccionados.append(_whereDinamico).append(_groupByConsultaClientes),"local");
        QSqlQuery queryAnios = Database::consultaSql(_consultaAniosSeleccionados.append(_whereDinamico).append(_groupByAniosSeleccionados),"local");

        QSqlQuery queryMeses;



        ///Cliente a mostrar
        queryClientes.next();
        _nombreReportePDF+=queryClientes.value(0).toString()+"-";


        ///Meses a mostrar
        queryAnios.next();
        queryMeses = Database::consultaSql(_consultaMesesSeleccionados.append(_whereDinamico).append(" and REC.codigoAnio='"+queryAnios.value(0).toString()+"' ").append(_groupByMesesSeleccionados),"local");
        while(queryMeses.next()){
            _nombreReportePDF+=queryMeses.value(0).toString()+"-";
        }


        ///Años a mostrar

        queryAnios.previous();
        while(queryAnios.next()){
            _nombreReportePDF+=queryAnios.value(0).toString();
            if(queryAnios.next()){
                _nombreReportePDF+="-";
                queryAnios.previous();
            }
        }


        return _nombreReportePDF+".pdf";

    }else{return "reporte-BD_ERROR.pdf";}
}


QString ModuloReportes::retornarTiempoTotalEnHoras(double _tiempoTotal) const{

    _tiempoReporte = QString::number(((int)_tiempoTotal/60),'f',0)+":"+QString::number(((int)_tiempoTotal%60),'f',0);

    QStringList list;
    list= _tiempoReporte.split(":");
    if(list.at(0).length()==1){
        _tiempoReporte=_tiempoReporte.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempoReporte=_tiempoReporte.insert(_tiempoReporte.indexOf(":")+1,"0");
    }
    return _tiempoReporte;
}

