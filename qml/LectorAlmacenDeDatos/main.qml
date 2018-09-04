import QtQuick 1.1
import QtWebKit 1.1
import "Controles"
import "Delegados"
import "ConsultasSql.js" as Consulta

Rectangle {
    id: rectPrincipal
    width: 1024
    height: 700
    color: "#eae7e7"
    smooth: true

    property string campoComodin:""
    property string campoOpcional:""
    property string whereDinamico : ""
    property string _whereHastaEsteMonento:""

    property string _groupByFiltros : ""
    property string _primerFiltroControl : ""
    property string _segundoFiltroControl : ""
    property string _armoConsultaSql: ""

    property string colorFila: "#eef0f5"
    property string guiaDeFiltros: ""
    property string orderBySql : ""
    property string ordenAutomatico: ""

    property bool banderaPrimerFiltro: true
    property bool banderaPrimerFiltroListaBotones: true
    property bool banderaBotonAnterior: false
    property int cantidadAsistenciasTotales: 0

    property int totalMinutosEstadoNuevoTotal : 0
    property int totalMinutosEstadoAsignadoTotal : 0
    property int totalMinutosEsperaRespuestaClienteTotal : 0
    property int totalMinutosEsperaRespuestaObjetosTotal : 0
    property int totalMinutosTareasTotal : 0
    property int totalMinutosResolucionTotal : 0

    property string id_codigoPerfilesTiempoResolucion: "0"

    property int contadorReclamosIterados: -1

    ///cero son los orders que no son por comodin, uno es por comodin
    property int tipoDeOrden: 1


    property int  codigoint: 0

    property string cuerpoConsuta: " sum(REC.tiempoMesaEntrada)'tiempoMesaEntrada', "
                                   +"sum(REC.tiempoEstadoNuevo)'tiempoEstadoNuevo', "
                                   +"sum(REC.tiempoEstadoAsignado)'tiempoEstadoAsignado', "
                                   +"sum(REC.tiempoEsperaRespuestaCliente)'tiempoEsperaRespuestaCliente', "
                                   +"sum(REC.tiempoEsperaRespuestaObjetos)'tiempoEsperaRespuestaObjetos', "
                                   +"sum(REC.tiempoTareas)'tiempoTareas', "
                                   +"sum(REC.tiempoResolucion)'tiempoResolucion', ";


    property string _version: "1.16.0 - 04/09/2018"
    /// 0.44.0 - Se agrega el control de tolerancia de 10 minutos.
    /// 0.47.0 - Se agrego en la lista de botones, los registros que seleccionamos en el filtro anterior.
    /// 0.47.1 - Se corrige un error en el filtro de numero de reclamos.
    /// 0.48.0 - Se agrega en los reportes el cuadro Causas externas.
    /// 0.49.0 - Se modifica el boton de los filtros, para que no se desactiven al volver a precionarlos.
    /// 0.49.1 - Se agrega mensaje de generación de reporte pdf.
    /// 0.50.0 - Se separa el cuadro de causas externas por area, software y hardware.
    /// 0.51.0 - Se agrega la posibilidad de abrir un link externo del reclamo, en el cuadro de tareas.
    /// 0.52.0 - Se agrega en el reporte, la totalización del cuadro causas externa software y hardware.
    /// 0.53.0 - Se agrega en el reporte, la posibilidad de navegar por los reclamos web.
    /// 0.53.1 - Se corrige un error al intentar mostrar el reclamo de las tareas.
    /// 0.53.2 - Se crea un nuevo reporte pdf para quitarle los links a los reclamos.
    /// 0.53.3 - Se arregla una excepción al listar todas las tareas y luego elegir otro registro.
    /// 0.54.0 - Se arrego el filtro Conceptos, el cual funciona identico a las tareas.
    /// 0.54.1 - Se arregla una excepción al reconectarse a la base de datos.
    /// 0.55.0 - Se agrega un boton para ocultar los reclamos que no tienen causa externa.
    ///        - Se quita la totalizacion de las cuasas externas.
    ///        - Los cuadros de causas externas ahora se calculan segun el total de cada area, y no sobre el total general de los reclamos.
    ///        - Se cambia el titulo de la columna % sobre el total para las causas externas, por % sobre[area correspondiente]
    /// 0.56.0 - Cambio en los textos de los cuadros de los reportes.
    /// 0.56.1 - Corrección en tildes de textos de los cuadros de reportes.
    /// 0.57.0 - Se quita de los reportes, en el cuerpo de los reclamos el nombre del tecnico.
    /// 0.57.1 - Se corrige un error al generar el reporte PDF con el cambio de quitar el tecnico.
    /// 1.0.0  - Se agrega al reporte los cuadros de detalles de causas externas, y se comienza a numerar como versión release.
    /// 1.1.0  - Se modifica el cabezal de descripción de causas externas en el cuadro de detalle, para centrarlo al medio.
    /// 1.2.0  - Se agrega el filtro Entrada, que hace referencia al campo idCamino en madai.
    ///        - Se activa por defecto el boton excluir reclamos sin causa externa en los reportes.
    /// 1.3.0  - Se agrega un nuevo checkbox para mostrar u ocultar en los reportes las asistencias por tiempo de resolución.
    /// 1.3.1  - Se corrige un problema con la linea de información del cuadro de tiempos por asistencias en los reportes.
    ///        - Se cambia el nombre al checkbox de cuadro de asistencias por cuadro de tiempos.
    /// 1.4.0  - Se re-escribe es archivo de estilos para contemplar todas las configuraciones posibles.
    ///        - Se agrega un boton de maximizar para la ventana de reportes.
    /// 1.4.1  - Se corrige un error de llamado al bloque de css referente al cuadro principal.
    /// 1.5.0  - Se agrega la posibilidad de cargar un logo en el reporte pdf.
    /// 1.5.1  - Se quitan saltos de linea despues de la imagen de logo.
    /// 1.6.0  - Se modifica el cuadro de reporte tiempos por asistencia para que sea igual en formato al de causas externas.
    /// 1.6.1  - Se corrige la distancia del cabezal del reporte debajo del banner.
    /// 1.7.0  - Se agrega en el reporte principal los encaezados al final de total. Se corrige el icono de maximizar/minizar para que sea blanco.
    ///        - Se habilita el maximizar con doble clic y mover la ventana de reportes aunque este maximizada.
    /// 1.8.0  - Se modifican los filtros para guardar el orden seleccionado y mantenerlo en las consultas.
    ///        - Se agregaron flechas para indicar cual es el orden que esta corriendo actualmente en la seleccion.
    /// 1.9.0  - 03/03/2014 - Se agrega combobox para seleccionar el rango de tiempo de los reclamos a mostrar en el cuadro de asistencia por tiempos.
    /// 1.10.0 - 05/03/2014 - Se agrega el boton de Sintomas. Se agrega un checkbox para fusionar las causas externas.
    /// 1.10.1 - 06/03/2014 - Se arregla el texto de horas en los cuadros de tiempo.
    /// 1.10.2 - 17/03/2014 - Se modifican las opciones por defecto en los reportes.
    /// 1.10.3 - 05/05/2014 - Se fija el tamaño del banner.png en 299x114px.
    /// 1.11.0 - 15/05/2014 - Se agrega el control por perfil desde el archivo de configuraciones para restringir la visualizacion de los tecnicos, y de los totales.
    ///        - 15/05/2014 - Se modifica el autoalineado del campo comodin, segun el ancho de la ventana.
    /// 1.12.0 - 13/11/2014 - Se modifican la fecha y hora de los reportes para mostras los datos de cuando se creo el reporte.
    /// 1.13.0 - 16/09/2016 - Se modifica la generación del reporte para que tome mas escalas de horas de resolución, hasta 24 horas. Ademas, se mostraran todos los reclamos como en "Analisis" que pasen a la ultima escala seleccionada.
    /// 1.13.1 - 16/09/2016 - Se modifica el rango de escala de horas para contemplar hasta 30.
    /// 1.14.0 - 29/09/2016 - Se agrega el boton Servicio.
    /// 1.14.1 - 29/09/2016 - Corrección sobre el boton de servico.
    /// 1.15.0 - 20/10/2016 - Cambio en texto de filtro de escalas en reporte.
    ///        - 20/10/2016 - Se crea pantalla para configurar los filtros del sistema.
    /// 1.15.1 - 25/10/2016 - Se corrige filtro de sucursales, que daba error al combinarlo con otros filtros.
    /// 1.15.2 - 05/06/2018 - Se corrigen las url que apuntan a madai.
    /// 1.16.0 - 04/09/2018 - Se agrega configuración para mostrar u ocultar información de reclamo coordinado, fecha fin del reclamo y nota al pie con información sobre espera respuesta del cliente(variable %tc%).
    property string orden:"ascendente"

    ListModel{
        id:modeloListaDeReclamos
    }


    ListModel{
        id:modeloListaTipoDocumentosVirtual
        ListElement{
            codigoItem:"1"
            descripcionItem:"Hasta 1 hora"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"2"
            descripcionItem:"Hasta 2 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"3"
            descripcionItem:"Hasta 3 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"4"
            descripcionItem:"Hasta 4 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"5"
            descripcionItem:"Hasta 5 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"6"
            descripcionItem:"Hasta 6 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"7"
            descripcionItem:"Hasta 7 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"8"
            descripcionItem:"Hasta 8 horas"
            checkBoxActivo:false
        }


        ListElement{
            codigoItem:"9"
            descripcionItem:"Hasta 9 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"10"
            descripcionItem:"Hasta 10 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"11"
            descripcionItem:"Hasta 11 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"12"
            descripcionItem:"Hasta 12 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"13"
            descripcionItem:"Hasta 13 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"14"
            descripcionItem:"Hasta 14 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"15"
            descripcionItem:"Hasta 15 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"16"
            descripcionItem:"Hasta 16 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"17"
            descripcionItem:"Hasta 17 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"18"
            descripcionItem:"Hasta 18 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"19"
            descripcionItem:"Hasta 19 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"20"
            descripcionItem:"Hasta 20 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"21"
            descripcionItem:"Hasta 21 horas"
            checkBoxActivo:false
        }

        ListElement{
            codigoItem:"22"
            descripcionItem:"Hasta 22 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"23"
            descripcionItem:"Hasta 23 horas"
            checkBoxActivo:false
        }

        ListElement{
            codigoItem:"24"
            descripcionItem:"Hasta 24 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"25"
            descripcionItem:"Hasta 25 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"26"
            descripcionItem:"Hasta 26 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"27"
            descripcionItem:"Hasta 27 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"28"
            descripcionItem:"Hasta 28 horas"
            checkBoxActivo:false
        }
        ListElement{
            codigoItem:"29"
            descripcionItem:"Hasta 29 horas"
            checkBoxActivo:false
        }


        ListElement{
            codigoItem:"30"
            descripcionItem:"Hasta 30 horas"
            checkBoxActivo:false
        }
    }


    /// Modelos de listas para los campos seleccionados, aparecen en los botones
    ListModel{ id:modeloListaAniosSeleccionados  }
    ListModel{ id:modeloListaMesesSeleccionados  }
    ListModel{ id:modeloListaClientesSeleccionados }
    ListModel{ id:modeloListaCoordinadoSeleccionados }
    ListModel{ id:modeloListaAreaSeleccionados }
    ListModel{ id:modeloListaDiaSeleccionados }
    ListModel{ id:modeloListaDiaSemanaSeleccionados }
    ListModel{ id:modeloListaHoraSeleccionados }
    ListModel{ id:modeloListaDepartamentoSeleccionados }
    ListModel{ id:modeloListaSucursalSeleccionados }
    ListModel{ id:modeloListaCausaSeleccionados }
    ListModel{ id:modeloListaMarcaSeleccionados }
    ListModel{ id:modeloListaModeloSeleccionados }
    ListModel{ id:modeloListaNumeroReclamoSeleccionados }
    ListModel{ id:modeloListaSerieSeleccionados }
    ListModel{ id:modeloListaTareaSeleccionados }
    ListModel{ id:modeloListaTecnicoSeleccionados }
    ListModel{ id:modeloListaTipoReclamoSeleccionados }
    ListModel{ id:modeloListaConceptosSeleccionados }
    ListModel{ id:modeloListaentradasCaminosSeleccionados }

    ListModel{ id:modeloSintomasSeleccionados }

    ListModel{ id:modeloServiciosSeleccionados }

    onContadorReclamosIteradosChanged:{
        if(contadorReclamosIterados!=0 && contadorReclamosIterados!=-1){
            btnFiltroAnterior.opacidadRectPrincipal=1
            btnFiltroAnterior.setearActivo()
        }else{
            btnFiltroAnterior.opacidadRectPrincipal=0.3
            btnFiltroAnterior.setearInactivo()
        }
    }

    function setearbotonesAlFiltrar(i){


        //   console.log(Consulta.laConsultasSqlSoloSelect(i))

        if(modeloReclamos.retornarEstadoDeComparacionDeString("codigodeaños",Consulta.laConsultasSqlSoloSelect(i)) || modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoAnio",Consulta.laConsultasSqlSoloSelect(i)))
            btnAnio.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoMes",Consulta.laConsultasSqlSoloSelect(i)))
            btnMes.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.fechaCompletaReclamo",Consulta.laConsultasSqlSoloSelect(i)))
            btnDia.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoDiaSemana",Consulta.laConsultasSqlSoloSelect(i)))
            btnDiaSemana.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.numeroHora",Consulta.laConsultasSqlSoloSelect(i)))
            btnHora.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("Tienecodigocliente",Consulta.laConsultasSqlSoloSelect(i)) )
            btnCliente.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("Tienecodigosucursal",Consulta.laConsultasSqlSoloSelect(i)) || modeloReclamos.retornarEstadoDeComparacionDeString("REC.nombreSucursal",Consulta.laConsultasSqlSoloSelect(i)))
            btnSucursal.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("TieneDecodigoReclamo",Consulta.laConsultasSqlSoloSelect(i)))
            btnNumeroReclamo.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoMarca",Consulta.laConsultasSqlSoloSelect(i)))
            btnMarca.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoModelo",Consulta.laConsultasSqlSoloSelect(i)))
            btnModelo.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.numeroSerie",Consulta.laConsultasSqlSoloSelect(i)))
            btnSerie.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoTecnicoResponsable",Consulta.laConsultasSqlSoloSelect(i)))
            btnTecnico.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoArea",Consulta.laConsultasSqlSoloSelect(i)))
            btnArea.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoTipoReclamo",Consulta.laConsultasSqlSoloSelect(i)))
            btnTipoReclamo.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("TienecodigodeTareas",Consulta.laConsultasSqlSoloSelect(i)))
            btnTarea.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoCausa",Consulta.laConsultasSqlSoloSelect(i)))
            btnCausa.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoDepartamento",Consulta.laConsultasSqlSoloSelect(i)))
            btnDepartamento.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoCoordinado",Consulta.laConsultasSqlSoloSelect(i)))
            btnCoordinado.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("TienecodigodeConceptos",Consulta.laConsultasSqlSoloSelect(i)))
            btnConceptos.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoCamino",Consulta.laConsultasSqlSoloSelect(i)))
            btnEntradaCamino.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoSintoma",Consulta.laConsultasSqlSoloSelect(i)))
            btnSintoma.setearEstadoBoton()

        if(modeloReclamos.retornarEstadoDeComparacionDeString("REC.codigoTipoReclamoCliente",Consulta.laConsultasSqlSoloSelect(i)))
            btnServicio.setearEstadoBoton()
    }



    ///////////////////////////////////////////////////////////////////////////////////
    ///// FUNCION PARA RESTAURAR TODOS LOS BOTONES DE LA BARRA DE HERRAMIENTAS  ///////
    //////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/////////
    function restaurarTodosLosBotones(){
        btnAnio.restaurarBoton()
        btnMes.restaurarBoton()
        btnDia.restaurarBoton()
        btnDiaSemana.restaurarBoton()
        btnHora.restaurarBoton()
        btnCliente.restaurarBoton()
        btnSucursal.restaurarBoton()
        btnNumeroReclamo.restaurarBoton()
        btnMarca.restaurarBoton()
        btnModelo.restaurarBoton()
        btnSerie.restaurarBoton()
        btnTecnico.restaurarBoton()
        btnArea.restaurarBoton()
        btnTipoReclamo.restaurarBoton()
        btnTarea.restaurarBoton()
        btnCausa.restaurarBoton()
        btnDepartamento.restaurarBoton()
        btnCoordinado.restaurarBoton()
        btnConceptos.restaurarBoton()
        btnEntradaCamino.restaurarBoton()
        btnSintoma.restaurarBoton()
        btnServicio.restaurarBoton()
        resetearValoresBarraInferior()

        ///////////////////////////////////////////////////////////////////////////////////
        ///// FIN DE FUNCION PARA RESTAURAR TODOS LOS BOTONES DE LA BARRA DE HERRAMIENTAS /
        //////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@//
    }

    function restaurarListaItemsTodosLosBotones(){
        modeloListaCoordinadoSeleccionados.clear()
        modeloListaAreaSeleccionados.clear()
        modeloListaAniosSeleccionados.clear()
        modeloListaMesesSeleccionados.clear()
        modeloListaDiaSeleccionados.clear()
        modeloListaDiaSemanaSeleccionados.clear()
        modeloListaHoraSeleccionados.clear()
        modeloListaDepartamentoSeleccionados.clear()
        modeloListaClientesSeleccionados.clear()
        modeloListaSucursalSeleccionados.clear()
        modeloListaCausaSeleccionados.clear()
        modeloListaMarcaSeleccionados.clear()
        modeloListaModeloSeleccionados.clear()
        modeloListaNumeroReclamoSeleccionados.clear()
        modeloListaSerieSeleccionados.clear()
        modeloListaTareaSeleccionados.clear()
        modeloListaTecnicoSeleccionados.clear()
        modeloListaTipoReclamoSeleccionados.clear()
        modeloListaConceptosSeleccionados.clear()
        modeloListaentradasCaminosSeleccionados.clear()
        modeloSintomasSeleccionados.clear()
        modeloServiciosSeleccionados.clear()
    }



    ///////////////////////////////////////////////////////////////////////////////////
    ///// FUNCION PARA RESETEAR LOS VALORES DE LA BARRA INFERIOR A LOS ORIGINALES /////
    //////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@//////
    function resetearValoresBarraInferior(){
        barraInferior.cantidadRegistrosSeleccionados="0"
        barraInferior.asistenciasSubTotal="0"
        barraInferior.tiempoPromedioMesaEntradaSubTotal="00:00"
        barraInferior.tiempoPromedioEstadoNuevoSubTotal="00:00"
        barraInferior.tiempoPromedioEstadoAsignadoSubTotal="00:00"
        barraInferior.tiempoPromedioEsperaRespuestaClienteSubTotal="00:00"
        barraInferior.tiempoPromedioEsperaRespuestaObjetosSubTotal="00:00"
        barraInferior.tiempoPromedioTareasSubTotal="00:00"
        barraInferior.tiempoPromedioResolucionSubTotal="00:00"

        barraInferior.asistenciasPorcentaje="0.00%"
        barraInferior.tiempoPromedioMesaEntradaPorcentaje="0.00%"
        barraInferior.tiempoPromedioEstadoNuevoPorcentaje="0.00%"
        barraInferior.tiempoPromedioEstadoAsignadoPorcentaje="0.00%"
        barraInferior.tiempoPromedioEsperaRespuestaClientePorcentaje="0.00%"
        barraInferior.tiempoPromedioEsperaRespuestaObjetosPorcentaje="0.00%"
        barraInferior.tiempoPromedioTareasPorcentaje="0.00%"
        barraInferior.tiempoPromedioResolucionPorcentaje="0.00%"

        barraInferior.asistenciasTotal="0"
        barraInferior.tiempoPromedioMesaEntradaTotal="00:00"
        barraInferior.tiempoPromedioEstadoNuevoTotal="00:00"
        barraInferior.tiempoPromedioEstadoAsignadoTotal="00:00"
        barraInferior.tiempoPromedioEsperaRespuestaClienteTotal="00:00"
        barraInferior.tiempoPromedioEsperaRespuestaObjetosTotal="00:00"
        barraInferior.tiempoPromedioTareasTotal="00:00"
        barraInferior.tiempoPromedioResolucionTotal="00:00"

        //////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////
        ///// FIN DE FUNCION PARA RESETEAR LOS VALORES DE LA BARRA INFERIOR A LOS ORIGINALES  ////
        //////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////
    }


    ///////////////////////////////////////////////////////////////////////////////////
    /// FUNCION PARA CARGAR LA LISTA DE LOS BOTONES ///////////////////////////////////
    ////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@///////////////////////////////////////
    function cargarListaBotones(){
        if(banderaPrimerFiltroListaBotones==false){
            var campoComodinItemBotones=Consulta.laConsultasCampoComodin(contadorReclamosIterados-1)
            var campoOpcionalItemBotones=Consulta.laConsultaCampoOpcionalArray(contadorReclamosIterados-1)
            var consultaSqlItemsBotones=""

            if(campoComodinItemBotones=="TAR.codigoTarea" && campoOpcionalItemBotones=="TAR.nombreTarea"){

                consultaSqlItemsBotones="SELECT  TAR.codigoTarea'campoComodin',sum(1)'asistencias', "
                consultaSqlItemsBotones+=cuerpoConsuta

                consultaSqlItemsBotones+="8888888888'primerFiltroControl', "
                consultaSqlItemsBotones+="8888888888'segundoFiltroControl', "

                consultaSqlItemsBotones+="TAR.nombreTarea'opcional',"
                        +"'TienecodigodeTareas' as 'opcional2',"
                        +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                        +"FROM Reclamos REC  "
                        +"join Tareas TAR on TAR.idReclamo=codigoReclamo  where 1=1 "+_whereHastaEsteMonento + "group by TAR.codigoTarea order by 1 "

            }else if(campoComodinItemBotones=="CON.codigoConcepto" && campoOpcionalItemBotones=="CON.nombreConcepto"){

                consultaSqlItemsBotones="SELECT  CON.codigoConcepto'campoComodin',sum(1)'asistencias', "
                consultaSqlItemsBotones+=cuerpoConsuta

                consultaSqlItemsBotones+="8888888888'primerFiltroControl', "
                consultaSqlItemsBotones+="8888888888'segundoFiltroControl', "

                consultaSqlItemsBotones+="CON.nombreConcepto'opcional',"
                        +"'TienecodigodeConceptos' as 'opcional2',"
                        +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                        +"FROM Reclamos REC  "
                        +"join Conceptos CON on CON.idReclamo=codigoReclamo  where 1=1 "+_whereHastaEsteMonento + "group by CON.codigoConcepto order by 1 "

            }else{
                if(contadorReclamosIterados!=1){
                    consultaSqlItemsBotones=Consulta.laConsultaconsultaSelectSinGroupBy(contadorReclamosIterados-1)
                }else{
                    consultaSqlItemsBotones=Consulta.laConsultaconsultaSelectSinGroupBy(contadorReclamosIterados-1)+" where 1=1 "
                }

                consultaSqlItemsBotones+=Consulta.laConsultawhereDinamicoArray(contadorReclamosIterados)
                consultaSqlItemsBotones+=Consulta.laConsultaGroupByArray(contadorReclamosIterados-1)+" 1 "
            }

            //console.log(_whereHastaEsteMonento)



            if(campoComodinItemBotones=="REC.codigoCoordinado"){    modeloListaCoordinadoSeleccionados.clear()  }
            else if(campoComodinItemBotones=="REC.codigoArea"){     modeloListaAreaSeleccionados.clear()        }
            else if(campoComodinItemBotones=="REC.codigoCamino"){     modeloListaentradasCaminosSeleccionados.clear()        }
            else if(campoComodinItemBotones=="REC.codigoSintoma"){     modeloSintomasSeleccionados.clear()        }
            else if(campoComodinItemBotones=="REC.codigoTipoReclamoCliente"){     modeloServiciosSeleccionados.clear()        }

            else if(campoComodinItemBotones=="REC.codigoAnio"){     modeloListaAniosSeleccionados.clear()       }
            else if(campoComodinItemBotones=="REC.codigoMes"){      modeloListaMesesSeleccionados.clear()       }
            else if(campoComodinItemBotones=="REC.fechaCompletaReclamo"){ modeloListaDiaSeleccionados.clear()   }
            else if(campoComodinItemBotones=="REC.codigoDiaSemana"){modeloListaDiaSemanaSeleccionados.clear()   }
            else if(campoComodinItemBotones=="REC.numeroHora"){     modeloListaHoraSeleccionados.clear()        }
            else if(campoComodinItemBotones=="REC.codigoDepartamento"){modeloListaDepartamentoSeleccionados.clear()        }
            else if(campoComodinItemBotones=="REC.codigoCliente" && campoOpcionalItemBotones=="9999999999"){   modeloListaClientesSeleccionados.clear()        }
            else if(campoComodinItemBotones=="REC.codigoCliente" && campoOpcionalItemBotones=="REC.codigoSucursal"){        modeloListaSucursalSeleccionados.clear()        }
            else if(campoComodinItemBotones=="REC.codigoCausa"){    modeloListaCausaSeleccionados.clear()       }
            else if(campoComodinItemBotones=="REC.codigoMarca"){    modeloListaMarcaSeleccionados.clear()       }
            else if(campoComodinItemBotones=="REC.codigoModelo"){   modeloListaModeloSeleccionados.clear()      }
            else if(campoComodinItemBotones=="codigoReclamo"){      modeloListaNumeroReclamoSeleccionados.clear()   }
            else if(campoComodinItemBotones=="REC.numeroSerie"){    modeloListaSerieSeleccionados.clear()       }
            else if(campoComodinItemBotones=="TAR.codigoTarea" && campoOpcionalItemBotones=="TAR.nombreTarea"){modeloListaTareaSeleccionados.clear()}
            else if(campoComodinItemBotones=="REC.codigoTecnicoResponsable"){ modeloListaTecnicoSeleccionados.clear()}
            else if(campoComodinItemBotones=="REC.codigoTipoReclamo"){ modeloListaTipoReclamoSeleccionados.clear()   }
            else if(campoComodinItemBotones=="CON.codigoConcepto" && campoOpcionalItemBotones=="CON.nombreConcepto"){modeloListaConceptosSeleccionados.clear()}




            //  console.log(consultaSqlItemsBotones)
            modeloReclamosItemsBotones.limpiarListaReclamos()
            if(modeloReclamosItemsBotones.buscarReclamos(consultaSqlItemsBotones)){

                for(var i=0; i<modeloReclamosItemsBotones.rowCount();i++){

                    if(campoComodinItemBotones=="REC.codigoCoordinado"){
                        modeloListaCoordinadoSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreCoordinado(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                      codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoCamino"){
                        modeloListaentradasCaminosSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreCamino(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                           codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoArea"){
                        modeloListaAreaSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreArea(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoAnio"){
                        modeloListaAniosSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarCampoComodin(i),
                                                                 codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoMes"){
                        modeloListaMesesSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreDelMes(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                 codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.fechaCompletaReclamo"){
                        modeloListaDiaSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarCampoComodin(i),
                                                               codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoDiaSemana"){
                        modeloListaDiaSemanaSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreDelDiaDeSemana(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                     codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.numeroHora"){
                        modeloListaHoraSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarCampoComodin(i),
                                                                codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoDepartamento"){
                        modeloListaDepartamentoSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreDepartamento(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                        codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoCliente" && campoOpcionalItemBotones=="9999999999"){
                        modeloListaClientesSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreCliente(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                    codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoCliente" && campoOpcionalItemBotones=="REC.codigoSucursal"){
                        modeloListaSucursalSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreCliente(modeloReclamosItemsBotones.retornarCampoComodin(i)).substring(0,18)+" - "+ modeloReclamosItemsBotones.retornarNombreSucursal(modeloReclamosItemsBotones.retornarCampoComodin(i),modeloReclamosItemsBotones.retornarOpcional(i)),
                                                                    codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoCausa"){
                        modeloListaCausaSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreCausa(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                 codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoMarca"){
                        modeloListaMarcaSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreMarca(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                 codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoModelo"){
                        modeloListaModeloSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreModelo(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                  codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="codigoReclamo"){
                        modeloListaNumeroReclamoSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarCampoComodin(i),
                                                                         codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.numeroSerie"){
                        modeloListaSerieSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarCampoComodin(i),
                                                                 codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="TAR.codigoTarea" && campoOpcionalItemBotones=="TAR.nombreTarea"){
                        modeloListaTareaSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreTareas(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                 codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoTecnicoResponsable"){
                        modeloListaTecnicoSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreTecnicoResponsable(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                   codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoTipoReclamo"){
                        modeloListaTipoReclamoSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreTipoReclamo(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                       codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="CON.codigoConcepto" && campoOpcionalItemBotones=="CON.nombreConcepto"){
                        modeloListaConceptosSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreConceptos(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                                     codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }else if(campoComodinItemBotones=="REC.codigoSintoma"){
                        modeloSintomasSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreSintoma(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                               codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }
                    else if(campoComodinItemBotones=="REC.codigoTipoReclamoCliente"){
                        modeloServiciosSeleccionados.append({   textoItem:modeloReclamosItemsBotones.retornarNombreTipoReclamoCliente(modeloReclamosItemsBotones.retornarCampoComodin(i)),
                                                               codigoDelItem:modeloReclamosItemsBotones.retornarCampoComodin(i)})
                    }



                }

            }else{
                /*   btnFiltroAnterior.setearInactivo()
                btnFiltroAnterior.opacidadRectPrincipal=0.3
                btnFiltroSiguiente.setearInactivo()
                btnFiltroSiguiente.opacidadRectPrincipal=0.3
                contadorReclamosIterados=-1
                borradoDeArrays()
                restaurarTodosLosBotones()
                banderaPrimerFiltro=true
                banderaPrimerFiltroListaBotones=true
                whereDinamico= ""
                txtFiltroSeleccionado.text=""
                modeloReclamos.limpiarListaReclamos()
                modeloListaDeReclamos.clear()
                restaurarListaItemsTodosLosBotones()*/
            }

        }
        ///////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////
        /// FIN CARGAR LA LISTA DE LOS BOTONES ////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////
    }




    ///////////////////////////////////////////////////////////////////////////////////
    /// FUNCION PARA CARGAR LA LISTA DE RECLAMOS //////////////////////////////////////
    ////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@///////////////////////////////////////
    function cargarReclamos(_consultaSql,descripcionCampoComodin,modoCargaReclamosConoSinControl){
        // la variable modoCargaReclamosConoSinControl es la que especifica si los reclamos se cargan precionando control o sin precionar control
        // con el valor "simple" se cargan los reclamos normalmente, con el valor "control" se cargan en modalidad control precionado
        //console.log(modoCargaReclamosConoSinControl)
        // modoCargaReclamosConoSinControl="control"

        //   console.log(_consultaSql)


        colorFila="#eef0f5";
        modeloReclamos.limpiarListaReclamos()
        modeloListaDeReclamos.clear()
        var cantidadAsistencias=0;
        /// Dejo a cero las variables para acumular los tiempos totales para la barra inferior
        totalMinutosEstadoNuevoTotal=0
        totalMinutosEstadoAsignadoTotal=0
        totalMinutosEsperaRespuestaClienteTotal=0
        totalMinutosEsperaRespuestaObjetosTotal=0
        totalMinutosTareasTotal=0
        totalMinutosResolucionTotal=0

        if(modeloReclamos.buscarReclamos(_consultaSql)){

            cargarListaBotones()
            banderaPrimerFiltroListaBotones=banderaPrimerFiltro

            for(var i=0; i<modeloReclamos.rowCount();i++){

                /// Alterna los colores entre filas
                if(colorFila=="#eef0f5"){
                    colorFila="#f1e9df"
                }else{
                    colorFila="#eef0f5"
                }

                cantidadAsistencias+= modeloReclamos.retornarAsistencias(i);

                if(modeloReclamos.accesoCompleto()){
                    /// Acumulo los tiempos totales para calculo de la barra inferior
                    totalMinutosEstadoNuevoTotal+=parseInt(modeloReclamos.retornarTiempoEstadoNuevoCrudo(i));
                    totalMinutosEstadoAsignadoTotal+=parseInt(modeloReclamos.retornarTiempoEstadoAsignadoCrudo(i));
                    totalMinutosEsperaRespuestaClienteTotal+=parseInt(modeloReclamos.retornarTiempoEsperaRespuestaClienteCrudo(i));
                    totalMinutosEsperaRespuestaObjetosTotal+=parseInt(modeloReclamos.retornarTiempoEsperaRespuestaObjetosCrudo(i));
                    totalMinutosTareasTotal+=parseInt(modeloReclamos.retornarTiempoTareasCrudo(i));
                    totalMinutosResolucionTotal+=parseInt(modeloReclamos.retornarTiempoResolucionCrudo(i));


                    modeloListaDeReclamos.append({
                                                     campoComodin:modeloReclamos.retornarCampoComodin(i),
                                                     asistencias:modeloReclamos.retornarAsistencias(i),
                                                     tiempoMesaEntrada:modeloReclamos.retornarTiempoMesaEntrada(i),
                                                     tiempoEstadoNuevo:modeloReclamos.retornarTiempoEstadoNuevo(i),
                                                     tiempoEstadoAsignado:modeloReclamos.retornarTiempoEstadoAsignado(i),
                                                     tiempoEsperaRespuestaCliente:modeloReclamos.retornarTiempoEsperaRespuestaCliente(i),
                                                     tiempoEsperaRespuestaObjetos:modeloReclamos.retornarTiempoEsperaRespuestaObjetos(i),
                                                     tiempoTareas:modeloReclamos.retornarTiempoTareas(i),
                                                     tiempoResolucion:modeloReclamos.retornarTiempoResolucion(i),
                                                     primerFiltroControl:modeloReclamos.retornarPrimerFiltroControl(i),
                                                     segundoFiltroControl:modeloReclamos.retornarSegundoFiltroControl(i),
                                                     campoOpcional:modeloReclamos.retornarOpcional(i),
                                                     campoOpcional2:modeloReclamos.retornarOpcional2(i),
                                                     seleccionado:false,
                                                     BanderaParaDeseleccionarRegistros:"9",
                                                     campoComodinNombre:descripcionCampoComodin,
                                                     colorFilaRectangulo:colorFila,
                                                     tiempoEstadoNuevoCrudo: modeloReclamos.retornarTiempoEstadoNuevoCrudo(i),
                                                     tiempoEstadoAsignadoCrudo: modeloReclamos.retornarTiempoEstadoAsignadoCrudo(i),
                                                     tiempoEsperaRespuestaObjetosCrudo: modeloReclamos.retornarTiempoEsperaRespuestaObjetosCrudo(i),
                                                     tiempoResolucionCrudo:modeloReclamos.retornarTiempoResolucionCrudo(i),
                                                     //tiempoResolucionCrudo:modeloReclamos.retornarTiempoResolucionTotalCrudo(i),
                                                     tiempoEsperaRespuestaClienteCrudo: modeloReclamos.retornarTiempoEsperaRespuestaClienteCrudo(i),
                                                     tiempoTareasCrudo:modeloReclamos.retornarTiempoTareasCrudo(i),
                                                     modoCargaReclamos:modoCargaReclamosConoSinControl
                                                 })

                }else{

                    /// Acumulo los tiempos totales para calculo de la barra inferior
                    totalMinutosEstadoNuevoTotal=0;
                    totalMinutosEstadoAsignadoTotal=0;
                    totalMinutosEsperaRespuestaClienteTotal=0;
                    totalMinutosEsperaRespuestaObjetosTotal=0;
                    totalMinutosTareasTotal=0;
                    totalMinutosResolucionTotal=0;

                    modeloListaDeReclamos.append({
                                                     campoComodin:modeloReclamos.retornarCampoComodin(i),
                                                     asistencias:modeloReclamos.retornarAsistencias(i),
                                                     tiempoMesaEntrada:0,
                                                     tiempoEstadoNuevo:0,
                                                     tiempoEstadoAsignado:0,
                                                     tiempoEsperaRespuestaCliente:0,
                                                     tiempoEsperaRespuestaObjetos:0,
                                                     tiempoTareas:0,
                                                     tiempoResolucion:0,
                                                     primerFiltroControl:modeloReclamos.retornarPrimerFiltroControl(i),
                                                     segundoFiltroControl:modeloReclamos.retornarSegundoFiltroControl(i),
                                                     campoOpcional:modeloReclamos.retornarOpcional(i),
                                                     campoOpcional2:modeloReclamos.retornarOpcional2(i),
                                                     seleccionado:false,
                                                     BanderaParaDeseleccionarRegistros:"9",
                                                     campoComodinNombre:descripcionCampoComodin,
                                                     colorFilaRectangulo:colorFila,
                                                     tiempoEstadoNuevoCrudo: 0,
                                                     tiempoEstadoAsignadoCrudo: 0,
                                                     tiempoEsperaRespuestaObjetosCrudo: 0,
                                                     tiempoResolucionCrudo:0,
                                                     tiempoEsperaRespuestaClienteCrudo: 0,
                                                     tiempoTareasCrudo:0,
                                                     modoCargaReclamos:modoCargaReclamosConoSinControl
                                                 })
                }







            }


            /// Calculo que setea la linea de totales en la barra inferior
            if(modeloReclamos.rowCount()!=0){
                listaRegistros.currentIndex=0
                barraInferior.asistenciasTotal=cantidadAsistencias
                cantidadAsistenciasTotales=cantidadAsistencias
                barraInferior.cantidadRegistrosSeleccionados=cantRegistrosSeleccionados()
                barraInferior.asistenciasPorcentaje=((cantAsistenciasSeleccionadas()/cantidadAsistenciasTotales)*100).toFixed(2)+"%"
                barraInferior.asistenciasSubTotal=0

                barraInferior.tiempoPromedioMesaEntradaSubTotal="00:00"
                barraInferior.tiempoPromedioEstadoNuevoSubTotal="00:00"
                barraInferior.tiempoPromedioEstadoAsignadoSubTotal="00:00"
                barraInferior.tiempoPromedioEsperaRespuestaClienteSubTotal="00:00"
                barraInferior.tiempoPromedioEsperaRespuestaObjetosSubTotal="00:00"
                barraInferior.tiempoPromedioTareasSubTotal="00:00"
                barraInferior.tiempoPromedioResolucionSubTotal="00:00"

                barraInferior.asistenciasPorcentaje="0.00%"
                barraInferior.tiempoPromedioMesaEntradaPorcentaje="0.00%"
                barraInferior.tiempoPromedioEstadoNuevoPorcentaje="0.00%"
                barraInferior.tiempoPromedioEstadoAsignadoPorcentaje="0.00%"
                barraInferior.tiempoPromedioEsperaRespuestaClientePorcentaje="0.00%"
                barraInferior.tiempoPromedioEsperaRespuestaObjetosPorcentaje="0.00%"
                barraInferior.tiempoPromedioTareasPorcentaje="0.00%"
                barraInferior.tiempoPromedioResolucionPorcentaje="0.00%"

                if(modeloReclamos.accesoCompleto()){

                    barraInferior.tiempoPromedioEstadoNuevoTotal=modeloReclamos.retornarTiempoTotal(totalMinutosEstadoNuevoTotal,cantidadAsistencias)
                    barraInferior.tiempoPromedioEstadoAsignadoTotal=modeloReclamos.retornarTiempoTotal(totalMinutosEstadoAsignadoTotal,cantidadAsistencias)
                    barraInferior.tiempoPromedioEsperaRespuestaClienteTotal=modeloReclamos.retornarTiempoTotal(totalMinutosEsperaRespuestaClienteTotal,cantidadAsistencias)
                    barraInferior.tiempoPromedioEsperaRespuestaObjetosTotal=modeloReclamos.retornarTiempoTotal(totalMinutosEsperaRespuestaObjetosTotal,cantidadAsistencias)
                    barraInferior.tiempoPromedioTareasTotal=modeloReclamos.retornarTiempoTotal(totalMinutosTareasTotal,cantidadAsistencias)
                    barraInferior.tiempoPromedioResolucionTotal=modeloReclamos.retornarTiempoTotal(totalMinutosResolucionTotal,cantidadAsistencias)

                }


            }
        }else{

            if(!modeloReclamos.estadoConexionLocal()){


                btnFiltroAnterior.opacidadRectPrincipal=0.3
                btnFiltroAnterior.setearInactivo()
                btnFiltroSiguiente.opacidadRectPrincipal=0.3
                btnFiltroSiguiente.setearInactivo()
                contadorReclamosIterados=-1
                borradoDeArrays()
                restaurarTodosLosBotones()
                banderaPrimerFiltro=true
                banderaPrimerFiltroListaBotones=true
                whereDinamico= ""
                txtFiltroSeleccionado.text=""
                modeloReclamos.limpiarListaReclamos()
                modeloListaDeReclamos.clear()
                restaurarListaItemsTodosLosBotones()
            }
        }
        ///////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////
        /// FIN CARGAR RECLAMOS ///////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////
    }

    //////////////////////////////////////////////////////////////////////////////////////
    // Funcion para marcar los registros a seleccionar y los que hay que deseleccionar  //
    ///@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@////
    function deseleccionar(indice){
        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(i==indice){
                modeloListaDeReclamos.setProperty(i,"BanderaParaDeseleccionarRegistros","0")
            }else{
                modeloListaDeReclamos.setProperty(i,"BanderaParaDeseleccionarRegistros","1")
            }
        }
        //////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////
        ////  FIN DE Funcion para marcar los registros a seleccionar  ////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////
    }

    //////////////////////////////////////////////////////////////////////////////////////
    //////////  FUNCION ṔARA DESELECCIONAR UN REGISTRO EN PARTICULAR  ////////////////////
    ////////////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@//////////////////////
    function deseleccionarUnRegistro(indice){
        modeloListaDeReclamos.setProperty(indice,"BanderaParaDeseleccionarRegistros","0")
        modeloListaDeReclamos.setProperty(indice,"BanderaParaDeseleccionarRegistros","1")

        //////////////////////////////////////////////////////////////////////////////////////
        /////////  FIN DE FUNCION ṔARA DESELECCIONAR UN REGISTRO EN PARTICULAR  //////////////
        //////////////////////////////////////////////////////////////////////////////////////
    }



    /////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////  FUNCION PARA MARCAR VARIOS REGISTROS COMO SELECCIONADOS USANDO TECLA SHIFT  //////////////
    ///////////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@////////////////
    function seleccionarVariosRegistrosConShift(indice){
        var _primerRegistro=0;
        var _ultimoRegistro=0;
        var _iterador=0;

        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){
                if(_iterador==0){
                    _primerRegistro=i;
                    _iterador=1;
                }
                _ultimoRegistro=i
            }
        }
        for(var i=_primerRegistro; i<modeloListaDeReclamos.count;i++){
            if(i<_ultimoRegistro){
                modeloListaDeReclamos.setProperty(i,"BanderaParaDeseleccionarRegistros","2")
                modeloListaDeReclamos.setProperty(i,"BanderaParaDeseleccionarRegistros","0")
            }
        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////  FIN DE FUNCION PARA MARCAR VARIOS REGISTROS COMO SELECCIONADOS USANDO TECLA SHIFT  ///////
        /////////////////////////////////////////////////////////////////////////////////////////////////////
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////  FUNCION PARA MARCAR TODOS LOS REGISTROS COMO SELECCIONADOS ///////////////////////////////
    ///////////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@////////////////////////////////
    function seleccionarTodosLosRegistros(){
        for(var i=0; i<modeloListaDeReclamos.count;i++){
            modeloListaDeReclamos.setProperty(i,"BanderaParaDeseleccionarRegistros","2")
            modeloListaDeReclamos.setProperty(i,"BanderaParaDeseleccionarRegistros","0")
        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////  FIN DE FUNCION PARA MARCAR TODOS LOS REGISTROS COMO SELECCIONADOS ////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////
    }



    // Funcion que retorna si existen registros seleccionados
    function hayRegistrosSeleccionados(){
        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){
                return true;
            }
        }
        return false;
    }

    // Funcion que cuenta los registros seleccionados
    function cantRegistrosSeleccionados(){
        var o=0;
        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0")
                o++
        }
        return o;
    }

    // Funcion que cuenta las asistencias seleccionadas
    function cantAsistenciasSeleccionadas(){
        var o=0;
        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){
                o+=modeloListaDeReclamos.get(i).asistencias
            }
        }
        return o;
    }

    // Funcion que cuenta tiempo segun seleccion
    function cantTiempoCrudoSeleccionado(tiempoFiltro){
        var o=0;
        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){

                if(tiempoFiltro=="tiempoEstadoNuevoCrudo"){
                    o+=parseInt(modeloListaDeReclamos.get(i).tiempoEstadoNuevoCrudo)
                }else if(tiempoFiltro=="tiempoEstadoAsignadoCrudo"){
                    o+=parseInt(modeloListaDeReclamos.get(i).tiempoEstadoAsignadoCrudo)
                }else if(tiempoFiltro=="tiempoEsperaRespuestaObjetosCrudo"){
                    o+=parseInt(modeloListaDeReclamos.get(i).tiempoEsperaRespuestaObjetosCrudo)
                }else if(tiempoFiltro=="tiempoEsperaRespuestaClienteCrudo"){
                    o+=parseInt(modeloListaDeReclamos.get(i).tiempoEsperaRespuestaClienteCrudo)
                }else if(tiempoFiltro=="tiempoTareasCrudo"){
                    o+=parseInt(modeloListaDeReclamos.get(i).tiempoTareasCrudo)
                }else if(tiempoFiltro=="tiempoResolucionCrudo"){
                    o+=parseInt(modeloListaDeReclamos.get(i).tiempoResolucionCrudo)
                }
            }
        }
        return o;
    }




    /////////////////////////////////////////////////////////
    ///Arma el where de las consultas dinamicamente
    function retornoWhereDinamico(){

        var _numerador=0;
        _whereHastaEsteMonento=whereDinamico

        if(campoComodin=="REC.codigoAnio" || campoComodin=="REC.codigoMes" || campoComodin=="REC.fechaCompletaReclamo"
                || campoComodin=="REC.codigoDiaSemana" || campoComodin=="REC.numeroHora" || (campoComodin=="REC.codigoCliente" && campoOpcional=="9999999999")  || campoComodin=="codigoReclamo"
                || campoComodin=="REC.codigoMarca" || campoComodin=="REC.codigoModelo" || campoComodin=="REC.numeroSerie" || campoComodin=="REC.codigoTecnicoResponsable"
                || campoComodin=="REC.codigoArea" || campoComodin=="REC.codigoTipoReclamo" || campoComodin=="REC.codigoCausa" || campoComodin=="REC.codigoSucursal"|| campoComodin=="REC.codigoDepartamento"
                || campoComodin=="REC.codigoCoordinado" || campoComodin=="REC.codigoCamino" || campoComodin=="REC.codigoSintoma" || campoComodin=="REC.codigoTipoReclamoCliente"){

            if(campoComodin=="REC.codigoAnio"){
                whereDinamico+=" and 'codigodeaños'='codigodeaños' "
            }else if(campoComodin=="codigoReclamo"){
                whereDinamico+=" and 'TieneDecodigoReclamo'='TieneDecodigoReclamo' "
            }else if(campoComodin=="REC.codigoCliente" && campoOpcional=="9999999999"){
                whereDinamico+=" and 'Tienecodigocliente'='Tienecodigocliente' "
            }else if(campoComodin=="REC.codigoSucursal"){
                whereDinamico+=" and 'Tienecodigosucursal'='Tienecodigosucursal' "
            }

            whereDinamico+=" and 1=1 and "+campoComodin +" in ( "

        }
        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){

                if(campoComodin=="REC.codigoAnio" || campoComodin=="REC.codigoMes" || campoComodin=="REC.fechaCompletaReclamo"
                        || campoComodin=="REC.codigoDiaSemana" || campoComodin=="REC.numeroHora" || (campoComodin=="REC.codigoCliente" && campoOpcional=="9999999999") || campoComodin=="codigoReclamo"
                        || campoComodin=="REC.codigoMarca" || campoComodin=="REC.codigoModelo" || campoComodin=="REC.numeroSerie" || campoComodin=="REC.codigoTecnicoResponsable"
                        || campoComodin=="REC.codigoArea" || campoComodin=="REC.codigoTipoReclamo" || campoComodin=="REC.codigoCausa" || campoComodin=="REC.codigoSucursal" || campoComodin=="REC.codigoDepartamento"
                        || campoComodin=="REC.codigoCoordinado" || campoComodin=="REC.codigoCamino" || campoComodin=="REC.codigoSintoma" || campoComodin=="REC.codigoTipoReclamoCliente"){
                    if(_numerador!=0){
                        whereDinamico+=" , "
                    }
                    whereDinamico+=" '"+modeloListaDeReclamos.get(i).campoComodin+"' "
                    _numerador++;
                }
            }
        }
        if(campoComodin=="REC.codigoAnio" || campoComodin=="REC.codigoMes" || campoComodin=="REC.fechaCompletaReclamo"
                || campoComodin=="REC.codigoDiaSemana" || campoComodin=="REC.numeroHora" || (campoComodin=="REC.codigoCliente" && campoOpcional=="9999999999") || campoComodin=="codigoReclamo"
                || campoComodin=="REC.codigoMarca" || campoComodin=="REC.codigoModelo" || campoComodin=="REC.numeroSerie" || campoComodin=="REC.codigoTecnicoResponsable"
                || campoComodin=="REC.codigoArea" || campoComodin=="REC.codigoTipoReclamo" || campoComodin=="REC.codigoCausa" || campoComodin=="REC.codigoSucursal" || campoComodin=="REC.codigoDepartamento"
                || campoComodin=="REC.codigoCoordinado" || campoComodin=="REC.codigoCamino" || campoComodin=="REC.codigoSintoma" || campoComodin=="REC.codigoTipoReclamoCliente"){
            if(whereDinamico!="")
                whereDinamico+=" ) "
        }




        if(campoComodin=="TAR.codigoTarea"){
            _whereHastaEsteMonento+=" and 'TienecodigodeTareas'='TienecodigodeTareas' and "+campoComodin +" in ( "


        }
        for(var i=0; i<modeloListaDeReclamos.count;i++){



            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){

                if(campoComodin=="TAR.codigoTarea"){






                    if(_numerador!=0){
                        _whereHastaEsteMonento+=" , "
                    }
                    _whereHastaEsteMonento+=" '"+modeloListaDeReclamos.get(i).campoComodin+"' "
                    _numerador++;
                }
            }
        }
        if(campoComodin=="TAR.codigoTarea"){
            if(_whereHastaEsteMonento!="")
                _whereHastaEsteMonento+=" ) "
        }







        if(campoComodin=="CON.codigoConcepto"){
            _whereHastaEsteMonento+=" and 'TienecodigodeConceptos'='TienecodigodeConceptos' and "+campoComodin +" in ( "
        }
        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){

                if(campoComodin=="CON.codigoConcepto"){
                    if(_numerador!=0){
                        _whereHastaEsteMonento+=" , "
                    }
                    _whereHastaEsteMonento+=" '"+modeloListaDeReclamos.get(i).campoComodin+"' "
                    _numerador++;
                }
            }
        }
        if(campoComodin=="CON.codigoConcepto"){
            if(_whereHastaEsteMonento!="")
                _whereHastaEsteMonento+=" ) "
        }









        if(campoOpcional!="9999999999"){
            _numerador=0;
            //Selecciono los numero de sucursal
            if(campoOpcional=="REC.codigoSucursal"){
                whereDinamico+=" and 'Tienecodigosucursal'='Tienecodigosucursal' and ( "
            }
            for(var i=0; i<modeloListaDeReclamos.count;i++){
                if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){

                    if(campoOpcional=="REC.codigoSucursal"){

                        if(_numerador!=0){
                            whereDinamico+=" or ("+campoOpcional+"='"+modeloListaDeReclamos.get(i).campoOpcional+"' and REC.codigoCliente='"+modeloListaDeReclamos.get(i).campoComodin+"')"
                        }else{
                            whereDinamico+=" ("+campoOpcional+"='"+modeloListaDeReclamos.get(i).campoOpcional+"' and REC.codigoCliente='"+modeloListaDeReclamos.get(i).campoComodin+"')"
                        }
                        _numerador++;


                    }
                }
            }
            if(campoOpcional=="REC.codigoSucursal"){
                if(whereDinamico!="")
                    whereDinamico+=" ) "
            }

        }

        _numerador=0;
        //Selecciono los numero reclamos de las tareas
        if(campoComodin=="TAR.codigoTarea"){

            whereDinamico+=" and 'TienecodigodeTareas'='TienecodigodeTareas' and codigoReclamo in ( "
        }

        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){

                if(campoComodin=="TAR.codigoTarea"){
                    if(_numerador!=0){
                        whereDinamico+=" , "
                    }



                    whereDinamico+= modeloReclamos.retornaReclamosDeTareas(_whereHastaEsteMonento)
                    _numerador++;
                    break; /// 0.53.3 - Se arregla una excepción al listar todas las tareas y luego elegir otro registro.
                }
            }
        }
        if(campoComodin=="TAR.codigoTarea"){
            if(whereDinamico!="")
                whereDinamico+=" ) "
        }

        _numerador=0;
        //Selecciono los numero de reclamos de los conceptos
        if(campoComodin=="CON.codigoConcepto"){
            whereDinamico+=" and 'TienecodigodeConceptos'='TienecodigodeConceptos' and codigoReclamo in ( "
        }
        for(var i=0; i<modeloListaDeReclamos.count;i++){
            if(modeloListaDeReclamos.get(i).BanderaParaDeseleccionarRegistros=="0"){

                if(campoComodin=="CON.codigoConcepto"){
                    if(_numerador!=0){
                        whereDinamico+=" , "
                    }
                    whereDinamico+= modeloReclamos.retornaReclamosDeConceptos(_whereHastaEsteMonento)
                    _numerador++;
                    break;
                }
            }
        }
        if(campoComodin=="CON.codigoConcepto"){
            if(whereDinamico!="")
                whereDinamico+=" ) "
        }


        if(whereDinamico==""){
            return " and 1=1 ";
        }else{


            return whereDinamico;
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    //////// Funcion para borrar información de arrays /////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    function borradoDeArrays(){
        for(var i=contadorReclamosIterados+1;i<Consulta.soloConsultaSelect.length;i++){
            Consulta.laBorrarConsultasSqlSoloSelect(i);
            Consulta.laBorrarwhereDinamicoArray(i);
            Consulta.laBorrarArraydeFiltrosTextoBoton(i);
            Consulta.laBorrarCampoComodinConsulta(i);
            Consulta.laBorrarConsultasSql(i);
            Consulta.laBorrarCampoOpcionalArray(i);
            Consulta.laBorrarGroupByArray(i);
            Consulta.laBorrarPrimerFiltroControlArray(i);
            Consulta.laBorrarSegundoFiltroControlArray(i);
            Consulta.laBorrarConsultaSelectSinGroupBy(i);
            Consulta.laBorrarTextoLabelCampoOpcional(i);
        }
    }

    function realizoChequeoDeArray(){
        if(banderaBotonAnterior){
            borradoDeArrays()
            banderaBotonAnterior=false
            btnFiltroSiguiente.setearInactivo()
            btnFiltroSiguiente.opacidadRectPrincipal=0.3
            contadorReclamosIterados++
        }else{
            contadorReclamosIterados++
        }
    }










































    //////////////////////// COMIENZA BOTONERA DEL SISTEMA SOBRE EL FLOW ///////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////// COMIENZA BOTONERA DEL SISTEMA SOBRE EL FLOW ///////////////////////////////////////////

    Flow {
        id: flowGrillaConBotonesFiltros
        height: flowGrillaConBotonesFiltros.implicitHeight
        z: 6
        anchors.top: btnResetearFiltro.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        smooth: true
        spacing: 10

        BotonIns {
            id: btnCoordinado
            estaPrecionado: false
            textoBoton: "Coordinado"
            z: 36
            utilizaListaDesplegable: true

            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnCoordinado.cerrarComboBox()
            }
            listviewModel: modeloListaCoordinadoSeleccionados


            onClicBoton: {
                //  orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoCoordinado'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCoordinado order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreCoordinado"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }





                    campoComodin="REC.codigoCoordinado"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> COORDINADO"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoCoordinado'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> COORDINADO"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> COORDINADO"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCoordinado order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.nombreCoordinado"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }



                    campoComodin="REC.codigoCoordinado"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text

            }



        }



        BotonIns {
            id: btnArea
            z: 35
            utilizaListaDesplegable: true
            textoBoton: "Área"
            onClicBotonLista: {

            }
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnArea.cerrarComboBox()
            }
            listviewModel: modeloListaAreaSeleccionados


            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoArea'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoArea order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.codigoArea"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }



                    campoComodin="REC.codigoArea"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> ÁREA"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoArea'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> ÁREA"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> ÁREA"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoArea order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.codigoArea"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoArea"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }


        BotonIns {
            id: btnAnio
            z: 34
            utilizaListaDesplegable: true
            textoBoton: "Año"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnAnio.cerrarComboBox()
            }
            listviewModel: modeloListaAniosSeleccionados

            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){

                    _armoConsultaSql+="SELECT  REC.codigoAnio'campoComodin',  sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "


                    _armoConsultaSql+=" where  'codigodeaños'='codigodeaños' "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql


                    _groupByFiltros=" group by REC.codigoAnio order by "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.codigoAnio"

                    //Guardo solo la consulta sql, sin el order by
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoAnio"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> AÑO"

                }else{
                    _armoConsultaSql+="SELECT  REC.codigoAnio'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC    "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> AÑO"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  'codigodeaños'='codigodeaños' "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> AÑO"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoAnio order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.codigoAnio"

                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoAnio"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }

                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }


            //Clic + control
            onClicMasControl: {


                /// Si la suma de los arrays es diferente de cero, continuo
                if(Consulta.campoComodinConsulta.length!=0){

                    /// Si la suma de los arrays -1, es diferente de cero, continuo
                    if((Consulta.campoComodinConsulta.length-1)!=0){



                    }
                }
            }
        }
        BotonIns {
            id: btnMes
            z: 33
            utilizaListaDesplegable: true
            textoBoton: "Mes"
            onClicBotonLista: {
            }
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnMes.cerrarComboBox()
            }
            listviewModel: modeloListaMesesSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){

                    _armoConsultaSql+="SELECT  REC.codigoMes'campoComodin',sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoMes order by "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.codigoMes"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoMes"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")
                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> MES"


                }else{
                    _armoConsultaSql+="SELECT  REC.codigoMes'campoComodin',sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> MES"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> MES"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoMes order by   "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.codigoMes"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoMes"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnDia
            z: 32
            utilizaListaDesplegable: true
            textoBoton: "Día"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnDia.cerrarComboBox()
            }
            listviewModel: modeloListaDiaSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.fechaCompletaReclamo'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.fechaCompletaReclamo order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.fechaCompletaReclamo"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.fechaCompletaReclamo"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")
                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> DÍA"


                }else{
                    _armoConsultaSql+="SELECT  REC.fechaCompletaReclamo'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> DÍA"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> DÍA"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.fechaCompletaReclamo order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql


                    orderBySql="REC.fechaCompletaReclamo"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.fechaCompletaReclamo"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnDiaSemana
            z: 31
            utilizaListaDesplegable: true
            textoBoton: "Día semana"
            onClicBotonLista: {

            }
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnDiaSemana.cerrarComboBox()

            }
            listviewModel: modeloListaDiaSemanaSeleccionados

            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoDiaSemana'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoDiaSemana order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.codigoDiaSemana"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoDiaSemana"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> DÍA DE SEMANA"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoDiaSemana'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> DÍA DE SEMANA"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> DÍA DE SEMANA"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoDiaSemana order by  "
                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.codigoDiaSemana"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoDiaSemana"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnHora
            z: 30
            utilizaListaDesplegable: true
            textoBoton: "Hora"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnHora.cerrarComboBox()
            }
            listviewModel: modeloListaHoraSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.numeroHora'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.numeroHora order by  "
                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros


                    orderBySql="REC.numeroHora"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.numeroHora"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> HORA"

                }else{
                    _armoConsultaSql+="SELECT  REC.numeroHora'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> HORA"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> HORA"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.numeroHora order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.numeroHora"
                    campoOpcional="9999999999"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.numeroHora"


                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnDepartamento
            z: 29
            utilizaListaDesplegable: true
            textoBoton: "Departamento"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnDepartamento.cerrarComboBox()
            }
            listviewModel: modeloListaDepartamentoSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoDepartamento'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoDepartamento order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreDepartamento"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoDepartamento"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> DEPARTAMENTO"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoDepartamento'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> DEPARTAMENTO"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> DEPARTAMENTO"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoDepartamento order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.nombreDepartamento"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoDepartamento"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }

        }
        BotonIns {
            id: btnCliente
            z: 28
            utilizaListaDesplegable: true
            textoBoton: "Cliente"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnCliente.cerrarComboBox()
            }
            listviewModel: modeloListaClientesSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoCliente'campoComodin', sum(1)'asistencias', "

                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"'Tienecodigocliente' as 'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  'Tienecodigocliente'='Tienecodigocliente' "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCliente order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.razonCliente, REC.codigoCliente"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                orderBySql=" REC.razonCliente desc, REC.codigoCliente "
                                _armoConsultaSql+= orderBySql
                            }else{
                                orderBySql=" REC.razonCliente asc, REC.codigoCliente "
                                _armoConsultaSql+= orderBySql
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            orderBySql=" REC.razonCliente desc, REC.codigoCliente "
                            _armoConsultaSql+= orderBySql
                        }else{
                            orderBySql=" REC.razonCliente asc, REC.codigoCliente "
                            _armoConsultaSql+= orderBySql
                        }
                    }



                    campoComodin="REC.codigoCliente"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> CLIENTE"

                }else{
                    _armoConsultaSql+=" SELECT  REC.codigoCliente'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"'Tienecodigocliente' as 'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> CLIENTE"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  'Tienecodigocliente'='Tienecodigocliente' "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> CLIENTE"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCliente order by   "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql=" REC.razonCliente,REC.codigoCliente"
                    campoOpcional="9999999999"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                orderBySql=" REC.razonCliente desc, REC.codigoCliente "
                                _armoConsultaSql+= orderBySql
                            }else{
                                orderBySql=" REC.razonCliente asc, REC.codigoCliente "
                                _armoConsultaSql+= orderBySql
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            orderBySql=" REC.razonCliente desc, REC.codigoCliente "
                            _armoConsultaSql+= orderBySql
                        }else{
                            orderBySql=" REC.razonCliente asc, REC.codigoCliente "
                            _armoConsultaSql+= orderBySql
                        }
                    }



                    campoComodin="REC.codigoCliente"
                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton

                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnSucursal
            z: 27
            utilizaListaDesplegable: true
            textoBoton: "Sucursal"

            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnSucursal.cerrarComboBox()
            }
            listviewModel: modeloListaSucursalSeleccionados

            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT REC.codigoCliente'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="REC.codigoSucursal'opcional',"
                            +"REC.nombreSucursal'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  'Tienecodigosucursal'='Tienecodigosucursal' "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCliente, REC.codigoSucursal order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.razonCliente,REC.codigoSucursal"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                orderBySql=" REC.razonCliente desc, REC.codigoSucursal desc "
                                _armoConsultaSql+= orderBySql
                            }else{
                                orderBySql=" REC.razonCliente asc, REC.codigoSucursal asc "
                                _armoConsultaSql+= orderBySql
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            orderBySql=" REC.razonCliente desc, REC.codigoSucursal desc "
                            _armoConsultaSql+= orderBySql
                        }else{
                            orderBySql=" REC.razonCliente asc, REC.codigoSucursal asc "
                            _armoConsultaSql+= orderBySql
                        }
                    }

                    campoComodin="REC.codigoCliente"
                    campoOpcional="REC.codigoSucursal"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")
                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> SUCURSAL"

                }else{
                    _armoConsultaSql+="SELECT  REC.codigoCliente'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="REC.codigoSucursal'opcional',"
                            +"REC.nombreSucursal'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> SUCURSAL"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  'Tienecodigosucursal'='Tienecodigosucursal' "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> SUCURSAL"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCliente,REC.codigoSucursal order by   "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.razonCliente,REC.codigoSucursal"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                orderBySql=" REC.razonCliente desc, REC.codigoSucursal desc "
                                _armoConsultaSql+= orderBySql
                            }else{
                                orderBySql=" REC.razonCliente asc, REC.codigoSucursal asc "
                                _armoConsultaSql+= orderBySql
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            orderBySql=" REC.razonCliente desc, REC.codigoSucursal desc "
                            _armoConsultaSql+= orderBySql
                        }else{
                            orderBySql=" REC.razonCliente asc, REC.codigoSucursal asc "
                            _armoConsultaSql+= orderBySql
                        }
                    }

                    campoComodin="REC.codigoCliente"
                    campoOpcional="REC.codigoSucursal"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton

                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }

        BotonIns {
            id: btnCausa
            z: 26
            utilizaListaDesplegable: true
            textoBoton: "Causa"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnCausa.cerrarComboBox()
            }
            listviewModel: modeloListaCausaSeleccionados

            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()

                if(hayRegistrosSeleccionados()){


                    _armoConsultaSql+="SELECT  REC.codigoCausa'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()


                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCausa order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreCausa"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }
                    campoComodin="REC.codigoCausa"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> CAUSA"
                }else{


                    _armoConsultaSql+="SELECT  REC.codigoCausa'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> CAUSA"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()

                        txtFiltroSeleccionado.text+=" >> CAUSA"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCausa order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.nombreCausa"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoCausa"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }

        BotonIns {
            id: btnMarca
            z: 25
            utilizaListaDesplegable: true
            textoBoton: "Marca"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnMarca.cerrarComboBox()
            }
            listviewModel: modeloListaMarcaSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoMarca'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoMarca order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreMarca"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoMarca"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> MARCA"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoMarca'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> MARCA"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()

                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> MARCA"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoMarca order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreMarca"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoMarca"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnModelo
            z: 24
            utilizaListaDesplegable: true
            textoBoton: "Modelo"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnModelo.cerrarComboBox()
            }
            listviewModel: modeloListaModeloSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){

                    _armoConsultaSql+="SELECT  REC.codigoModelo'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoModelo order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreModelo"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoModelo"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")



                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> MODELO"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoModelo'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> MODELO"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> MODELO"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoModelo order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreModelo"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoModelo"
                    campoOpcional="9999999999"


                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnNumeroReclamo
            z: 23
            utilizaListaDesplegable: true
            textoBoton: "Número reclamo"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnNumeroReclamo.cerrarComboBox()
            }
            listviewModel: modeloListaNumeroReclamoSeleccionados
            onClicBoton: {
                //orden="ascendente"
                listaRegistros.cacheBuffer=0
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT HIGH_PRIORITY SQL_BIG_RESULT SQL_CACHE REC.codigoReclamo'campoComodin', sum(1)'asistencias', "

                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  'TieneDecodigoReclamo'='TieneDecodigoReclamo'  "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by codigoReclamo order by   "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="codigoReclamo"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="codigoReclamo"
                    campoOpcional="9999999999"


                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")




                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> NÚMERO RECLAMO"

                }else{
                    _armoConsultaSql+="SELECT  HIGH_PRIORITY SQL_BIG_RESULT SQL_CACHE REC.codigoReclamo'campoComodin', sum(1)'asistencias', "

                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco','TieneDecodigoReclamo' "
                            +"FROM Reclamos REC   "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> NÚMERO RECLAMO"
                        whereDinamico= ""

                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  'TieneDecodigoReclamo'='TieneDecodigoReclamo' "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> NÚMERO RECLAMO"
                    }

                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by codigoReclamo order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="codigoReclamo"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="codigoReclamo"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnSerie
            z: 22
            utilizaListaDesplegable: true
            textoBoton: "Serie"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnSerie.cerrarComboBox()
            }
            listviewModel: modeloListaSerieSeleccionados

            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.numeroSerie'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.numeroSerie order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.numeroSerie"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.numeroSerie"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> SERIE"
                }else{
                    _armoConsultaSql+="SELECT  REC.numeroSerie'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> SERIE"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> SERIE"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.numeroSerie order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.numeroSerie"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.numeroSerie"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }



        }
        BotonIns {
            id: btnTarea
            z: 21
            utilizaListaDesplegable: true
            textoBoton: "Tarea"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnTarea.cerrarComboBox()
            }
            listviewModel: modeloListaTareaSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  TAR.codigoTarea'campoComodin',sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="TAR.nombreTarea'opcional',"
                            +"'TienecodigodeTareas' as 'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                            +"join Tareas TAR on TAR.idReclamo=codigoReclamo  "

                    _armoConsultaSql+=" where  'TienecodigodeTareas'='TienecodigodeTareas' "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by TAR.codigoTarea order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros


                    orderBySql="TAR.nombreTarea"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }
                    campoComodin="TAR.codigoTarea"
                    campoOpcional="TAR.nombreTarea"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico



                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> TAREA"
                }else{

                    _armoConsultaSql+="SELECT  TAR.codigoTarea'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="TAR.nombreTarea'opcional',"
                            +"'TienecodigodeTareas' as 'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                            +"join Tareas TAR on TAR.idReclamo=codigoReclamo  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> TAREA"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  'TienecodigodeTareas'='TienecodigodeTareas' "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> TAREA"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by TAR.codigoTarea order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="TAR.nombreTarea"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="TAR.codigoTarea"
                    campoOpcional="TAR.nombreTarea"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico



                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnTecnico
            z: 20
            visible: modeloReclamos.accesoCompleto()
            utilizaListaDesplegable: true
            textoBoton: "Técnico"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnTecnico.cerrarComboBox()
            }
            listviewModel: modeloListaTecnicoSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoTecnicoResponsable'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoTecnicoResponsable order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreTecnicoResponsable"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }
                    campoComodin="REC.codigoTecnicoResponsable"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> TECNICO"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoTecnicoResponsable'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> TECNICO"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> TECNICO"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoTecnicoResponsable order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.nombreTecnicoResponsable"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoTecnicoResponsable"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }
        BotonIns {
            id: btnTipoReclamo
            z: 19
            utilizaListaDesplegable: true
            textoBoton: "Tipo reclamo"
            listviewDelegate: Delegate_ListaItemsSeleccionados{
                onKeyEscapeCerrar: btnTipoReclamo.cerrarComboBox()
            }
            listviewModel: modeloListaTipoReclamoSeleccionados
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoTipoReclamo'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoTipoReclamo order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.codigoTipoReclamo"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }
                    campoComodin="REC.codigoTipoReclamo"
                    campoOpcional="9999999999"
                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> TIPO DE RECLAMO"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoTipoReclamo'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> TIPO DE RECLAMO"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> TIPO DE RECLAMO"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoTipoReclamo order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.codigoTipoReclamo"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoTipoReclamo"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }

        BotonIns {
            id: btnConceptos
            textoBoton: "Conceptos"
            listviewModel: modeloListaConceptosSeleccionados
            z: 18
            utilizaListaDesplegable: true
            listviewDelegate: Delegate_ListaItemsSeleccionados {

                onKeyEscapeCerrar: btnConceptos.cerrarComboBox()
            }
            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  CON.codigoConcepto'campoComodin',sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="CON.nombreConcepto'opcional',"
                            +"'TienecodigodeConceptos' as 'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                            +"join Conceptos CON on CON.idReclamo=codigoReclamo  "

                    _armoConsultaSql+=" where  'TienecodigodeConceptos'='TienecodigodeConceptos' "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by CON.codigoConcepto order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros


                    orderBySql="CON.nombreConcepto"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }
                    campoComodin="CON.codigoConcepto"
                    campoOpcional="CON.nombreConcepto"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> CONCEPTO"
                }else{

                    _armoConsultaSql+="SELECT  CON.codigoConcepto'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="CON.nombreConcepto'opcional',"
                            +"'TienecodigodeConceptos' as 'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                            +"join Conceptos CON on CON.idReclamo=codigoReclamo  "

                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> CONCEPTO"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  'TienecodigodeConceptos'='TienecodigodeConceptos' "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> CONCEPTO"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by CON.codigoConcepto order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="CON.nombreConcepto"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql

                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="CON.codigoConcepto"
                    campoOpcional="CON.nombreConcepto"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")


                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }
        }

        BotonIns {
            id: btnEntradaCamino
            textoBoton: "Entrada"
            listviewModel: modeloListaentradasCaminosSeleccionados
            z: 17
            utilizaListaDesplegable: true
            listviewDelegate: Delegate_ListaItemsSeleccionados {
                onKeyEscapeCerrar: btnEntradaCamino.cerrarComboBox()
            }

            onClicBoton: {
                //orden="ascendente"
                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoCamino'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCamino order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreCamino"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoCamino"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico

                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> ENTRADAS"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoCamino'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> ENTRADAS"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> ENTRADAS"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCamino order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.nombreCamino"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoCamino"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }

        }

        BotonIns {
            id: btnSintoma
            utilizaListaDesplegable: true
            listviewModel: modeloSintomasSeleccionados
            listviewDelegate: Delegate_ListaItemsSeleccionados {
                onKeyEscapeCerrar: btnSintoma.cerrarComboBox()
            }


            onClicBoton: {

                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoSintoma'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoSintoma order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreSintoma"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoSintoma"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico

                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> SINTOMAS"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoSintoma'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnServicio.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> SINTOMAS"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> SINTOMAS"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoSintoma order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.nombreSintoma"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoSintoma"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }


            textoBoton: "Sintoma"
            z: 17
        }

        BotonIns {
            id: btnServicio
            utilizaListaDesplegable: true
            listviewModel: modeloServiciosSeleccionados
            listviewDelegate: Delegate_ListaItemsSeleccionados {
                onKeyEscapeCerrar: btnServicio.cerrarComboBox()
            }


            onClicBoton: {

                _armoConsultaSql=""
                realizoChequeoDeArray()
                if(hayRegistrosSeleccionados()){
                    _armoConsultaSql+="SELECT  REC.codigoTipoReclamoCliente'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoTipoReclamoCliente order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreTipoReclamoCliente"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoTipoReclamoCliente"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico

                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                    txtFiltroSeleccionado.text+=" >> SERVICIO"
                }else{
                    _armoConsultaSql+="SELECT  REC.codigoTipoReclamoCliente'campoComodin', sum(1)'asistencias', "
                    _armoConsultaSql+=cuerpoConsuta

                    _primerFiltroControl="8888888888'primerFiltroControl', "
                    _segundoFiltroControl="8888888888'segundoFiltroControl', "
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "
                    /// Si es el primer filtro que toco, restauro todos los botones
                    if(banderaPrimerFiltro){
                        btnAnio.restaurarBoton()
                        btnMes.restaurarBoton()
                        btnDia.restaurarBoton()
                        btnDiaSemana.restaurarBoton()
                        btnHora.restaurarBoton()
                        btnCliente.restaurarBoton()
                        btnSucursal.restaurarBoton()
                        btnNumeroReclamo.restaurarBoton()
                        btnMarca.restaurarBoton()
                        btnModelo.restaurarBoton()
                        btnSerie.restaurarBoton()
                        btnTecnico.restaurarBoton()
                        btnArea.restaurarBoton()
                        btnTipoReclamo.restaurarBoton()
                        btnCausa.restaurarBoton()
                        btnDepartamento.restaurarBoton()
                        btnCoordinado.restaurarBoton()
                        btnConceptos.restaurarBoton()
                        btnTarea.restaurarBoton()
                        btnEntradaCamino.restaurarBoton()
                        btnSintoma.restaurarBoton()
                        banderaPrimerFiltro=false
                        txtFiltroSeleccionado.text=" >> SERVICIO"
                        whereDinamico= ""
                    }else{
                        seleccionarTodosLosRegistros()
                        _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                        txtFiltroSeleccionado.text+=" >> SERVICIO"
                    }
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoTipoReclamoCliente order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros
                    orderBySql="REC.nombreTipoReclamoCliente"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()!=""){
                        if(tipoDeOrden==1){
                            if(orden=="descendiente"){
                                _armoConsultaSql+= orderBySql+" desc "
                            }else{
                                _armoConsultaSql+= orderBySql+" asc "
                            }
                        }else{
                            _armoConsultaSql+= ordenAutomatico
                        }
                    }else{
                        if(orden=="descendiente"){
                            _armoConsultaSql+= orderBySql+" desc "
                        }else{
                            _armoConsultaSql+= orderBySql+" asc "
                        }
                    }

                    campoComodin="REC.codigoTipoReclamoCliente"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico
                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton
                }
                Consulta.arraydeFiltrosTextoBoton[contadorReclamosIterados]=txtFiltroSeleccionado.text
            }


            textoBoton: "Servicio"
            z: 17
        }


    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////// FIN BOTONERA DEL SISTEMA SOBRE EL FLOW ///////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////// FIN BOTONERA DEL SISTEMA SOBRE EL FLOW ///////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    BotonSimple {
        id: btnResetearFiltro
        z: 3
        modoBotonPrecionado: false
        anchors.top: parent.top
        anchors.topMargin: 18
        anchors.left: parent.left
        anchors.leftMargin: 10
        negrita: true
        estilo: 0
        colorTextoBoton: "#1a1362"
        textoBoton: "Restablecer filtro"
        onClicBoton: {
            btnFiltroAnterior.setearInactivo()
            btnFiltroAnterior.opacidadRectPrincipal=0.3
            btnFiltroSiguiente.setearInactivo()
            btnFiltroSiguiente.opacidadRectPrincipal=0.3
            contadorReclamosIterados=-1
            borradoDeArrays()
            restaurarTodosLosBotones()
            banderaPrimerFiltro=true
            banderaPrimerFiltroListaBotones=true
            whereDinamico= ""
            txtFiltroSeleccionado.text=""
            modeloReclamos.limpiarListaReclamos()
            modeloListaDeReclamos.clear()
            restaurarListaItemsTodosLosBotones()
            ordenAutomatico=""

            imgCampoComodin.visible=true
            imgCampoAsistencias.visible=false
            imgCampoEsperaCliente.visible=false
            imgCampoEsperaObjetos.visible=false
            imgCampoEstadoAsignado.visible=false
            imgCampoEstadoNuevo.visible=false
            imgCampoResolucion.visible=false
            imgCampoTareas.visible=false
            imgCampoComodin.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
        }
    }
    Rectangle {
        id: rectContenedorRegistros
        color: "#00000000"
        radius: 3
        border.width: 1
        border.color: "#d8d7ea"
        z: 4
        clip: false
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: rectangle2.top
        anchors.bottomMargin: 3
        smooth: true
        anchors.top: flowGrillaFiltros.bottom
        anchors.topMargin: 10
        ListView {
            id: listaRegistros
            cacheBuffer: 0
            clip: true
            highlightResizeSpeed: 20
            highlightMoveSpeed: 20
            highlightRangeMode: ListView.NoHighlightRange
            anchors.top: rectCabezalListaReclamos.bottom
            boundsBehavior: Flickable.DragAndOvershootBounds
            highlightFollowsCurrentItem: true
            anchors.right: parent.right
            delegate: Delegate_ListaReclamos{
                id:delegadas
                onClicSolo: {
                    deseleccionar(index)
                    barraInferior.cantidadRegistrosSeleccionados=cantRegistrosSeleccionados()
                    barraInferior.asistenciasPorcentaje=((cantAsistenciasSeleccionadas()/cantidadAsistenciasTotales)*100).toFixed(2)+"%"
                    barraInferior.asistenciasSubTotal=cantAsistenciasSeleccionadas()

                    if(totalMinutosEstadoNuevoTotal==0){
                        barraInferior.tiempoPromedioEstadoNuevoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoNuevoCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEstadoNuevoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoNuevoCrudo")/totalMinutosEstadoNuevoTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosEstadoAsignadoTotal==0){
                        barraInferior.tiempoPromedioEstadoAsignadoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoAsignadoCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEstadoAsignadoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoAsignadoCrudo")/totalMinutosEstadoAsignadoTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosEsperaRespuestaClienteTotal==0){
                        barraInferior.tiempoPromedioEsperaRespuestaClientePorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaClienteCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEsperaRespuestaClientePorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaClienteCrudo")/totalMinutosEsperaRespuestaClienteTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosEsperaRespuestaObjetosTotal==0){
                        barraInferior.tiempoPromedioEsperaRespuestaObjetosPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaObjetosCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEsperaRespuestaObjetosPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaObjetosCrudo")/totalMinutosEsperaRespuestaObjetosTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosTareasTotal==0){
                        barraInferior.tiempoPromedioTareasPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoTareasCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioTareasPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoTareasCrudo")/totalMinutosTareasTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosResolucionTotal==0){
                        barraInferior.tiempoPromedioResolucionPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoResolucionCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioResolucionPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoResolucionCrudo")/totalMinutosResolucionTotal))*100).toFixed(2)+"%"}



                    barraInferior.tiempoPromedioEstadoNuevoSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEstadoNuevoCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioEstadoAsignadoSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEstadoAsignadoCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioEsperaRespuestaClienteSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaClienteCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioEsperaRespuestaObjetosSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaObjetosCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioTareasSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoTareasCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioResolucionSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoResolucionCrudo"),cantAsistenciasSeleccionadas())



                }
                onClicMasControl: {

                    if(modeloListaDeReclamos.get(index).BanderaParaDeseleccionarRegistros=="0"){
                        deseleccionarUnRegistro(index)
                    }else{
                        modeloListaDeReclamos.setProperty(index,"BanderaParaDeseleccionarRegistros","0")
                    }
                    barraInferior.cantidadRegistrosSeleccionados=cantRegistrosSeleccionados()
                    barraInferior.asistenciasPorcentaje=((cantAsistenciasSeleccionadas()/cantidadAsistenciasTotales)*100).toFixed(2)+"%"
                    barraInferior.asistenciasSubTotal=cantAsistenciasSeleccionadas()

                    if(totalMinutosEstadoNuevoTotal==0){
                        barraInferior.tiempoPromedioEstadoNuevoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoNuevoCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEstadoNuevoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoNuevoCrudo")/totalMinutosEstadoNuevoTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosEstadoAsignadoTotal==0){
                        barraInferior.tiempoPromedioEstadoAsignadoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoAsignadoCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEstadoAsignadoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoAsignadoCrudo")/totalMinutosEstadoAsignadoTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosEsperaRespuestaClienteTotal==0){
                        barraInferior.tiempoPromedioEsperaRespuestaClientePorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaClienteCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEsperaRespuestaClientePorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaClienteCrudo")/totalMinutosEsperaRespuestaClienteTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosEsperaRespuestaObjetosTotal==0){
                        barraInferior.tiempoPromedioEsperaRespuestaObjetosPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaObjetosCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEsperaRespuestaObjetosPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaObjetosCrudo")/totalMinutosEsperaRespuestaObjetosTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosTareasTotal==0){
                        barraInferior.tiempoPromedioTareasPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoTareasCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioTareasPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoTareasCrudo")/totalMinutosTareasTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosResolucionTotal==0){
                        barraInferior.tiempoPromedioResolucionPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoResolucionCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioResolucionPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoResolucionCrudo")/totalMinutosResolucionTotal))*100).toFixed(2)+"%"}

                    if(cantRegistrosSeleccionados()!=0){
                        barraInferior.tiempoPromedioEstadoNuevoSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEstadoNuevoCrudo"),cantAsistenciasSeleccionadas())
                        barraInferior.tiempoPromedioEstadoAsignadoSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEstadoAsignadoCrudo"),cantAsistenciasSeleccionadas())
                        barraInferior.tiempoPromedioEsperaRespuestaClienteSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaClienteCrudo"),cantAsistenciasSeleccionadas())
                        barraInferior.tiempoPromedioEsperaRespuestaObjetosSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaObjetosCrudo"),cantAsistenciasSeleccionadas())
                        barraInferior.tiempoPromedioTareasSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoTareasCrudo"),cantAsistenciasSeleccionadas())
                        barraInferior.tiempoPromedioResolucionSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoResolucionCrudo"),cantAsistenciasSeleccionadas())
                    }



                }
                onClicMasShift: {
                    modeloListaDeReclamos.setProperty(index,"BanderaParaDeseleccionarRegistros","0")
                    seleccionarVariosRegistrosConShift(index)
                    barraInferior.cantidadRegistrosSeleccionados=cantRegistrosSeleccionados()
                    barraInferior.asistenciasPorcentaje=((cantAsistenciasSeleccionadas()/cantidadAsistenciasTotales)*100).toFixed(2)+"%"
                    barraInferior.asistenciasSubTotal=cantAsistenciasSeleccionadas()

                    if(totalMinutosEstadoNuevoTotal==0){
                        barraInferior.tiempoPromedioEstadoNuevoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoNuevoCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEstadoNuevoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoNuevoCrudo")/totalMinutosEstadoNuevoTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosEstadoAsignadoTotal==0){
                        barraInferior.tiempoPromedioEstadoAsignadoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoAsignadoCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEstadoAsignadoPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEstadoAsignadoCrudo")/totalMinutosEstadoAsignadoTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosEsperaRespuestaClienteTotal==0){
                        barraInferior.tiempoPromedioEsperaRespuestaClientePorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaClienteCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEsperaRespuestaClientePorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaClienteCrudo")/totalMinutosEsperaRespuestaClienteTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosEsperaRespuestaObjetosTotal==0){
                        barraInferior.tiempoPromedioEsperaRespuestaObjetosPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaObjetosCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioEsperaRespuestaObjetosPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaObjetosCrudo")/totalMinutosEsperaRespuestaObjetosTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosTareasTotal==0){
                        barraInferior.tiempoPromedioTareasPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoTareasCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioTareasPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoTareasCrudo")/totalMinutosTareasTotal))*100).toFixed(2)+"%"}

                    if(totalMinutosResolucionTotal==0){
                        barraInferior.tiempoPromedioResolucionPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoResolucionCrudo")/1))*100).toFixed(2)+"%"
                    }else{barraInferior.tiempoPromedioResolucionPorcentaje=(((cantTiempoCrudoSeleccionado("tiempoResolucionCrudo")/totalMinutosResolucionTotal))*100).toFixed(2)+"%"}


                    barraInferior.tiempoPromedioEstadoNuevoSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEstadoNuevoCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioEstadoAsignadoSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEstadoAsignadoCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioEsperaRespuestaClienteSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaClienteCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioEsperaRespuestaObjetosSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoEsperaRespuestaObjetosCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioTareasSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoTareasCrudo"),cantAsistenciasSeleccionadas())
                    barraInferior.tiempoPromedioResolucionSubTotal=modeloReclamos.retornarTiempoTotal(cantTiempoCrudoSeleccionado("tiempoResolucionCrudo"),cantAsistenciasSeleccionadas())

                }
            }
            snapMode: ListView.NoSnap
            anchors.bottomMargin: 3
            spacing: 1
            anchors.bottom: parent.bottom
            flickableDirection: Flickable.VerticalFlick
            anchors.leftMargin: 0
            keyNavigationWraps: true
            anchors.left: parent.left
            interactive: true
            smooth: true
            anchors.topMargin: 5
            anchors.rightMargin: 0
            model:modeloListaDeReclamos
        }
        Rectangle {
            id: rectCabezalListaReclamos
            height: 35
            radius: 0
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#807caf"
                }
                GradientStop {
                    position: 0.440
                    color: "#423c7a"
                }
            }
            smooth: true
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Text {
                id: lblTiempoPromedioResolucion
                width: 85
                visible: modeloReclamos.accesoCompleto()
                color: "#f9f9f9"
                text: "Resol."
                clip: false
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 1
                anchors.top: parent.top
                anchors.topMargin: 1
                anchors.right: parent.right
                anchors.rightMargin: 10
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignRight
                smooth: true
                font.pixelSize: 11
                style: Text.Sunken
                font.bold: true
                font.family: "Verdana"
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    id: mouse_areaTiempoPromedioResolucion
                    anchors.fill: parent
                    onClicked: {
                        if(listaRegistros.count!=0){
                            var consultaOrdenada=Consulta.laConsultasSqlSoloSelect(contadorReclamosIterados)
                            if(orden=="descendiente"){
                                consultaOrdenada+=" 9 asc "
                                ordenAutomatico=  " 9 asc "
                                orden="ascendente"
                                imgCampoResolucion.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                            }else{
                                consultaOrdenada+=" 9 desc "
                                ordenAutomatico=  " 9 desc "
                                orden="descendiente"
                                imgCampoResolucion.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_up.png"
                            }


                            imgCampoComodin.visible=false
                            imgCampoAsistencias.visible=false
                            imgCampoEsperaCliente.visible=false
                            imgCampoEsperaObjetos.visible=false
                            imgCampoEstadoAsignado.visible=false
                            imgCampoEstadoNuevo.visible=false
                            imgCampoResolucion.visible=true
                            imgCampoTareas.visible=false

                            cargarReclamos(consultaOrdenada,Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")
                            tipoDeOrden = 0
                        }
                    }
                }

                Image {
                    id: imgCampoResolucion
                    y: -1
                    width: 18
                    height: 18
                    clip: true
                    smooth: true
                    source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                    visible: false
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1
                    anchors.leftMargin: 24
                    anchors.left: parent.left
                }
            }

            Text {
                id: lblTiempoPromedioTareas
                x: 3
                visible: modeloReclamos.accesoCompleto()
                width: 59
                color: "#f9f9f9"
                text: "Tareas"
                clip: false
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 1
                anchors.top: parent.top
                anchors.topMargin: 1
                smooth: true
                font.pixelSize: 11
                style: Text.Sunken
                wrapMode: Text.WordWrap
                anchors.rightMargin: 100
                font.family: "Verdana"
                font.bold: true
                anchors.right: parent.right
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                MouseArea {
                    id: mouse_areaTiempoPromedioTareas
                    anchors.fill: parent
                    onClicked: {
                        var consultaOrdenada=Consulta.laConsultasSqlSoloSelect(contadorReclamosIterados)
                        if(orden=="descendiente"){
                            consultaOrdenada+=" 8 asc "
                            ordenAutomatico=  " 8 asc "
                            orden="ascendente"

                            imgCampoTareas.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                        }else{
                            consultaOrdenada+=" 8 desc "
                            ordenAutomatico=  " 8 desc "
                            orden="descendiente"

                            imgCampoTareas.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_up.png"
                        }


                        imgCampoComodin.visible=false
                        imgCampoAsistencias.visible=false
                        imgCampoEsperaCliente.visible=false
                        imgCampoEsperaObjetos.visible=false
                        imgCampoEstadoAsignado.visible=false
                        imgCampoEstadoNuevo.visible=false
                        imgCampoResolucion.visible=false
                        imgCampoTareas.visible=true

                        cargarReclamos(consultaOrdenada,Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")
                        tipoDeOrden = 0
                    }
                }

                Image {
                    id: imgCampoTareas
                    y: -1
                    width: 18
                    height: 18
                    anchors.left: parent.left
                    anchors.leftMargin: -6
                    smooth: true
                    clip: true
                    source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                    visible: false
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1
                }
            }

            Text {
                id: lblTiempoPromedioEsperaObjetos
                x: -3
                width: 68
                visible: modeloReclamos.accesoCompleto()
                color: "#f9f9f9"
                text: "Espera objetos"
                clip: false
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 1
                anchors.top: parent.top
                anchors.topMargin: 1
                smooth: true
                font.pixelSize: 11
                style: Text.Sunken
                wrapMode: Text.WordWrap
                anchors.rightMargin: 185
                font.family: "Verdana"
                font.bold: true
                anchors.right: parent.right
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter

                MouseArea {
                    id: mouse_areaEstadoEsperaRespuestaObjetos
                    anchors.fill: parent

                    onClicked: {


                        if(listaRegistros.count!=0){
                            var consultaOrdenada=Consulta.laConsultasSqlSoloSelect(contadorReclamosIterados)
                            if(orden=="descendiente"){
                                consultaOrdenada+=" 7 asc "
                                ordenAutomatico=  " 7 asc "
                                orden="ascendente"

                                imgCampoEsperaObjetos.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                            }else{
                                consultaOrdenada+=" 7 desc "
                                ordenAutomatico=  " 7 desc "
                                orden="descendiente"

                                imgCampoEsperaObjetos.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_up.png"
                            }

                            imgCampoComodin.visible=false
                            imgCampoAsistencias.visible=false
                            imgCampoEsperaCliente.visible=false
                            imgCampoEsperaObjetos.visible=true
                            imgCampoEstadoAsignado.visible=false
                            imgCampoEstadoNuevo.visible=false
                            imgCampoResolucion.visible=false
                            imgCampoTareas.visible=false

                            cargarReclamos(consultaOrdenada,Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")
                            tipoDeOrden = 0
                        }


                    }

                }

                Image {
                    id: imgCampoEsperaObjetos
                    y: -1
                    width: 18
                    height: 18
                    anchors.left: parent.left
                    anchors.leftMargin: -2
                    clip: true
                    smooth: true
                    source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                    visible: false
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1
                }
            }

            Text {
                id: lblTiempoPromedioEsperaRespuestaCliente
                x: -3
                y: 3
                visible: modeloReclamos.accesoCompleto()
                width: 81
                color: "#f9f9f9"
                text: "Espera cliente"
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottomMargin: 1
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                font.family: "Verdana"
                clip: false
                wrapMode: Text.WordWrap
                font.bold: true
                horizontalAlignment: Text.AlignRight
                style: Text.Sunken
                smooth: true
                anchors.topMargin: 1
                font.pixelSize: 11
                anchors.rightMargin: 280

                MouseArea {
                    id: mouse_areaEstadoEsperaRespuestaCliente
                    anchors.fill: parent

                    onClicked: {

                        if(listaRegistros.count!=0){
                            var consultaOrdenada=Consulta.laConsultasSqlSoloSelect(contadorReclamosIterados)
                            if(orden=="descendiente"){
                                consultaOrdenada+=" 6 asc "
                                ordenAutomatico=  " 6 asc "
                                orden="ascendente"
                                imgCampoEsperaCliente.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                            }else{
                                consultaOrdenada+=" 6 desc "
                                ordenAutomatico=  " 6 desc "
                                orden="descendiente"

                                imgCampoEsperaCliente.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_up.png"
                            }

                            imgCampoComodin.visible=false
                            imgCampoAsistencias.visible=false
                            imgCampoEsperaCliente.visible=true
                            imgCampoEsperaObjetos.visible=false
                            imgCampoEstadoAsignado.visible=false
                            imgCampoEstadoNuevo.visible=false
                            imgCampoResolucion.visible=false
                            imgCampoTareas.visible=false

                            cargarReclamos(consultaOrdenada,Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")
                            tipoDeOrden = 0
                        }
                    }
                }

                Image {
                    id: imgCampoEsperaCliente
                    y: -1
                    width: 18
                    height: 18
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    smooth: true
                    clip: true
                    source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                    visible: false
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1
                }
            }

            Text {
                id: lblTiempoPromedioEstadoAsignado
                x: -4
                y: 0
                visible: modeloReclamos.accesoCompleto()
                width: 85
                color: "#f9f9f9"
                text: "Estado asignado"
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottomMargin: 1
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                font.family: "Verdana"
                clip: false
                wrapMode: Text.WordWrap
                font.bold: true
                horizontalAlignment: Text.AlignRight
                style: Text.Sunken
                smooth: true
                anchors.topMargin: 1
                font.pixelSize: 11
                anchors.rightMargin: 390

                MouseArea {
                    id: mouse_areaEstadoAsignado
                    anchors.fill: parent

                    onClicked: {

                        if(listaRegistros.count!=0){
                            var consultaOrdenada=Consulta.laConsultasSqlSoloSelect(contadorReclamosIterados)
                            if(orden=="descendiente"){
                                consultaOrdenada+=" 5 asc "
                                ordenAutomatico=  " 5 asc "
                                orden="ascendente"

                                imgCampoEstadoAsignado.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                            }else{
                                consultaOrdenada+=" 5 desc "
                                ordenAutomatico=  " 5 desc "
                                orden="descendiente"

                                imgCampoEstadoAsignado.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_up.png"
                            }

                            imgCampoComodin.visible=false
                            imgCampoAsistencias.visible=false
                            imgCampoEsperaCliente.visible=false
                            imgCampoEsperaObjetos.visible=false
                            imgCampoEstadoAsignado.visible=true
                            imgCampoEstadoNuevo.visible=false
                            imgCampoResolucion.visible=false
                            imgCampoTareas.visible=false

                            cargarReclamos(consultaOrdenada,Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")
                            tipoDeOrden = 0
                        }
                    }

                }

                Image {
                    id: imgCampoEstadoAsignado
                    y: -1
                    width: 18
                    height: 18
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    clip: true
                    smooth: true
                    source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                    visible: false
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1
                }
            }

            Text {
                id: lblTiempoPromedioEstadoNuevo
                x: -11
                visible: modeloReclamos.accesoCompleto()
                y: 8
                width: 80
                color: "#f9f9f9"
                text: "Estado nuevo"
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottomMargin: 1
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                font.family: "Verdana"
                clip: false
                wrapMode: Text.WordWrap
                font.bold: true
                horizontalAlignment: Text.AlignRight
                style: Text.Sunken
                smooth: true
                anchors.topMargin: 1
                font.pixelSize: 11
                anchors.rightMargin: 500

                MouseArea {
                    id: mouse_areaEstadoNuevo
                    anchors.fill: parent

                    onClicked: {

                        if(listaRegistros.count!=0){
                            var consultaOrdenada=Consulta.laConsultasSqlSoloSelect(contadorReclamosIterados)


                            if(orden=="descendiente"){
                                consultaOrdenada+=" sum(REC.tiempoEstadoNuevo) asc "
                                ordenAutomatico=  " sum(REC.tiempoEstadoNuevo) asc "
                                orden="ascendente"

                                imgCampoEstadoNuevo.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                            }else{
                                consultaOrdenada+=" sum(REC.tiempoEstadoNuevo) desc "
                                ordenAutomatico=  " sum(REC.tiempoEstadoNuevo) desc "
                                orden="descendiente"

                                imgCampoEstadoNuevo.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_up.png"
                            }

                            imgCampoComodin.visible=false
                            imgCampoAsistencias.visible=false
                            imgCampoEsperaCliente.visible=false
                            imgCampoEsperaObjetos.visible=false
                            imgCampoEstadoAsignado.visible=false
                            imgCampoEstadoNuevo.visible=true
                            imgCampoResolucion.visible=false
                            imgCampoTareas.visible=false

                            cargarReclamos(consultaOrdenada,Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")
                            tipoDeOrden = 0
                        }
                    }
                }

                Image {
                    id: imgCampoEstadoNuevo
                    y: -1
                    width: 18
                    height: 18
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    smooth: true
                    clip: true
                    source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                    visible: false
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1
                }
            }

            Text {
                id: lblTiempoPromedioMesaEntrada
                x: -18
                y: 0
                width: 78
                color: "#f9f9f9"
                text: "Mesa entrada"
                visible: modeloReclamos.accesoCompleto()
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottomMargin: 1
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                font.family: "Verdana"
                clip: true
                wrapMode: Text.WordWrap
                font.bold: true
                horizontalAlignment: Text.AlignRight
                style: Text.Sunken
                smooth: true
                anchors.topMargin: 1
                font.pixelSize: 11
                anchors.rightMargin: 610
            }

            Text {
                id: lblAsistencias
                y: 5
                width: 85
                color: "#f9f9f9"
                text: "Asistencias"
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottomMargin: 1
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                font.family: "Verdana"
                clip: false
                wrapMode: Text.WordWrap
                font.bold: true
                horizontalAlignment: Text.AlignRight
                style: Text.Sunken
                smooth: true
                anchors.topMargin: 1
                font.pixelSize: 11
                anchors.rightMargin: 714

                MouseArea {
                    id: mouse_areaAsistencias
                    anchors.fill: parent
                    onClicked: {


                        /*
                    Consulta.primerFiltroControlArray[contadorReclamosIterados]=_primerFiltroControl
                    Consulta.segundoFiltroControlArray[contadorReclamosIterados]=_segundoFiltroControl
                    _armoConsultaSql+=_primerFiltroControl
                    _armoConsultaSql+=_segundoFiltroControl

                    _armoConsultaSql+="9999999999'opcional',"
                            +"9999999999'opcional2',"
                            +"sum(REC.tiempoEsperaRespuestaClienteHorarioSisteco)'tiempoEsperaRespuestaClienteHorarioSisteco' "
                            +"FROM Reclamos REC  "

                    _armoConsultaSql+=" where  1=1 "+ retornoWhereDinamico()
                    Consulta.consultaSelectSinGroupBy[contadorReclamosIterados]=_armoConsultaSql
                    _groupByFiltros=" group by REC.codigoCamino order by  "

                    _armoConsultaSql+=_groupByFiltros
                    Consulta.groupByArray[contadorReclamosIterados]=_groupByFiltros

                    orderBySql="REC.nombreCamino"
                    Consulta.soloConsultaSelect[contadorReclamosIterados]=_armoConsultaSql
                    if(ordenAutomatico.trim()==""){
                        _armoConsultaSql+= orderBySql
                    }else{
                        _armoConsultaSql+= ordenAutomatico
                    }

                    campoComodin="REC.codigoCamino"
                    campoOpcional="9999999999"

                    Consulta.campoOpcionalArray[contadorReclamosIterados]=campoOpcional
                    Consulta.campoComodinConsulta[contadorReclamosIterados]=campoComodin
                    Consulta.misConsultas[contadorReclamosIterados]=_armoConsultaSql
                    Consulta.whereDinamicoArray[contadorReclamosIterados]=whereDinamico

                    cargarReclamos(_armoConsultaSql,campoComodin,"simple")

                    lblCampoComodin.text=textoBoton
                    Consulta.textoLabelCampoOpcional[contadorReclamosIterados]=textoBoton


                          */

                        if(listaRegistros.count!=0){
                            var consultaOrdenada=Consulta.laConsultasSqlSoloSelect(contadorReclamosIterados)
                            if(orden=="descendiente"){
                                consultaOrdenada+=" 2 asc "
                                ordenAutomatico=  " 2 asc "
                                orden="ascendente"
                                imgCampoAsistencias.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                            }else{
                                consultaOrdenada+=" 2 desc "
                                ordenAutomatico=  " 2 desc "
                                orden="descendiente"
                                imgCampoAsistencias.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_up.png"
                            }


                            imgCampoComodin.visible=false
                            imgCampoAsistencias.visible=true
                            imgCampoEsperaCliente.visible=false
                            imgCampoEsperaObjetos.visible=false
                            imgCampoEstadoAsignado.visible=false
                            imgCampoEstadoNuevo.visible=false
                            imgCampoResolucion.visible=false
                            imgCampoTareas.visible=false

                            ///Ultimo cambio 30 diciembre 2013
                            /// tratando de resolver cuando van hacia atras y hacia adelante con las consultas sql
                            Consulta.misConsultas[contadorReclamosIterados]=consultaOrdenada

                            cargarReclamos(consultaOrdenada,Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")
                            tipoDeOrden = 0
                        }
                    }
                }

                Image {
                    id: imgCampoAsistencias
                    width: 18
                    height: 18
                    anchors.left: parent.left
                    anchors.leftMargin: -7
                    visible: false
                    anchors.verticalCenter: parent.verticalCenter
                    clip: true
                    smooth: true
                    source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                    z: 1
                }
            }

            Text {
                id: lblCampoComodin
                y: 5
                width: 190
                color: "#f9f9f9"
                text: "Año"
                clip: false
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                smooth: true
                font.pixelSize: 14
                style: Text.Sunken
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true
                font.family: "Verdana"
                anchors.leftMargin: 10
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left

                MouseArea {
                    id: mouse_areaCampoComodin
                    anchors.fill: parent
                    onClicked: {

                        if(listaRegistros.count!=0){




                            var consultaOrdenada=Consulta.laConsultasSqlSoloSelect(contadorReclamosIterados)
                            if(orden=="descendiente"){

                                if(orderBySql.trim()=="REC.razonCliente desc, REC.codigoCliente" || orderBySql.trim()=="REC.razonCliente,REC.codigoCliente"){
                                    consultaOrdenada+=" REC.razonCliente asc, REC.codigoCliente "
                                    ordenAutomatico= " REC.razonCliente asc, REC.codigoCliente "

                                }else if(orderBySql.trim()=="REC.razonCliente desc, REC.codigoSucursal desc"){
                                    consultaOrdenada+=" REC.razonCliente asc, REC.codigoSucursal asc "
                                    ordenAutomatico= " REC.razonCliente asc, REC.codigoSucursal asc "
                                    orderBySql="REC.razonCliente asc, REC.codigoSucursal asc"
                                }else{


                                    consultaOrdenada+=orderBySql+" asc "
                                    ordenAutomatico=  orderBySql+" asc "
                                }

                                orden="ascendente"

                                imgCampoComodin.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"

                            }else{
                                if(orderBySql.trim()=="REC.razonCliente asc, REC.codigoCliente" || orderBySql.trim()=="REC.razonCliente,REC.codigoCliente"){
                                    consultaOrdenada+=" REC.razonCliente desc, REC.codigoCliente "
                                    ordenAutomatico= " REC.razonCliente desc, REC.codigoCliente "

                                }else if(orderBySql.trim()=="REC.razonCliente asc, REC.codigoSucursal asc"){
                                    consultaOrdenada+=" REC.razonCliente desc, REC.codigoSucursal desc "
                                    ordenAutomatico= " REC.razonCliente desc, REC.codigoSucursal desc "
                                    orderBySql="REC.razonCliente desc, REC.codigoSucursal desc"

                                }else{
                                    consultaOrdenada+=orderBySql+" desc "
                                    ordenAutomatico=  orderBySql+" desc "
                                }




                                orden="descendiente"

                                imgCampoComodin.source = "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_up.png"
                            }



                            imgCampoComodin.visible=true
                            imgCampoAsistencias.visible=false
                            imgCampoEsperaCliente.visible=false
                            imgCampoEsperaObjetos.visible=false
                            imgCampoEstadoAsignado.visible=false
                            imgCampoEstadoNuevo.visible=false
                            imgCampoResolucion.visible=false
                            imgCampoTareas.visible=false


                            cargarReclamos(consultaOrdenada,Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")
                            tipoDeOrden = 1
                        }
                    }
                }

                Image {
                    id: imgCampoComodin
                    width: 18
                    height: 18
                    visible: true
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    z: 1
                    smooth: true
                    clip: true
                    source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/arrow_down.png"
                }
            }
        }

        Rectangle {
            id: rectangle4
            x: 504
            width: 14
            color: "#00000000"
            radius: 6
            smooth: true
            clip: true
            anchors.top: parent.top
            anchors.topMargin: 35
            Rectangle {
                id: scrollbar
                x: 2
                y: listaRegistros.visibleArea.yPosition * listaRegistros.height+3
                width: 10
                height: listaRegistros.visibleArea.heightRatio * listaRegistros.height
                color: "#000000"
                radius: 3
                smooth: true
                visible: true
                anchors.rightMargin: 2
                z: 2
                anchors.right: parent.right
                opacity: 0.450
            }
            anchors.bottom: parent.bottom
            visible: true
            anchors.rightMargin: -8
            anchors.bottomMargin: 10
            z: 6
            anchors.right: parent.right
            opacity: 1
        }
    }


    Flow {
        id: flowGrillaFiltros
        height: flowGrillaFiltros.implicitHeight
        spacing: 10
        z: 5
        smooth: true
        anchors.top: flowGrillaConBotonesFiltros.bottom
        anchors.topMargin: 15
        anchors.right: btnPrevisualizarReporte.left
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 25

        Text {
            id: lblFiltro
            x: 309
            y: 107
            text: qsTr("Filtro:")
            styleColor: "#cfcfcf"
            style: Text.Sunken
            font.family: "Verdana"
            verticalAlignment: Text.AlignVCenter
            opacity: 0.580
            font.bold: true
            smooth: true
            font.pixelSize: 11
        }

        Text {
            id: txtFiltroSeleccionado
            width: 750
            text: qsTr("")
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            smooth: true
            font.pixelSize: 11
            style: Text.Sunken
            styleColor: "#cfcfcf"
            font.bold: true
            font.family: "Verdana"
            opacity: 0.580
            verticalAlignment: Text.AlignVCenter
        }
    }
    Image {
        id: image1
        opacity: 0.012
        z: 0
        fillMode: Image.Tile
        anchors.fill: parent
        smooth: true
        source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/Fondo.png"
    }

    BotonFlecha {
        id: btnFiltroAnterior
        y: 20
        anchors.left: btnResetearFiltro.right
        anchors.leftMargin: 20
        opacidadRectPrincipal: 0.3
        anchors.top: parent.top
        border.color: "#b7b6b6"
        anchors.topMargin: 20
        rotation: 0
        scaleValorActual: 1
        source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaIzquierda.png"
        onClic: {
            banderaBotonAnterior=true
            contadorReclamosIterados--

            btnFiltroSiguiente.setearActivo()
            btnFiltroSiguiente.opacidadRectPrincipal=1

            restaurarTodosLosBotones()
            setearbotonesAlFiltrar(contadorReclamosIterados)

            _groupByFiltros=Consulta.laConsultaGroupByArray(contadorReclamosIterados)
            _primerFiltroControl=Consulta.laConsultaPrimerFiltroControlArray(contadorReclamosIterados)
            _segundoFiltroControl=Consulta.laConsultaSegundoFiltroControlArray(contadorReclamosIterados)

            campoOpcional=Consulta.laConsultaCampoOpcionalArray(contadorReclamosIterados)
            campoComodin=Consulta.laConsultasCampoComodin(contadorReclamosIterados)
            whereDinamico=Consulta.laConsultawhereDinamicoArray(contadorReclamosIterados)
            txtFiltroSeleccionado.text=Consulta.laConsultaArraydeFiltrosTextoBoton(contadorReclamosIterados)

            lblCampoComodin.text=Consulta.laConsultaTextoLabelCampoOpcional(contadorReclamosIterados)


            cargarReclamos(Consulta.laConsultasSql(contadorReclamosIterados),Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")


        }
    }
    BotonFlecha {
        id: btnFiltroSiguiente
        anchors.left: btnFiltroAnterior.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 20
        opacidadRectPrincipal: 0.3
        border.color: "#b7b6b6"
        rotation: 0
        scaleValorActual: 1
        onClic: {

            if(contadorReclamosIterados!=Consulta.soloConsultaSelect.length-1){

                contadorReclamosIterados++

                //Si llego al limite de los registros, desactivo el boton
                if(contadorReclamosIterados==Consulta.soloConsultaSelect.length-1){

                    btnFiltroSiguiente.setearInactivo()
                    btnFiltroSiguiente.opacidadRectPrincipal=0.3

                }

                restaurarTodosLosBotones()
                setearbotonesAlFiltrar(contadorReclamosIterados)


                _groupByFiltros=Consulta.laConsultaGroupByArray(contadorReclamosIterados)
                _primerFiltroControl=Consulta.laConsultaPrimerFiltroControlArray(contadorReclamosIterados)
                _segundoFiltroControl=Consulta.laConsultaSegundoFiltroControlArray(contadorReclamosIterados)

                campoOpcional=Consulta.laConsultaCampoOpcionalArray(contadorReclamosIterados)
                campoComodin=Consulta.laConsultasCampoComodin(contadorReclamosIterados)
                whereDinamico=Consulta.laConsultawhereDinamicoArray(contadorReclamosIterados)
                txtFiltroSeleccionado.text=Consulta.laConsultaArraydeFiltrosTextoBoton(contadorReclamosIterados)

                lblCampoComodin.text=Consulta.laConsultaTextoLabelCampoOpcional(contadorReclamosIterados)

                cargarReclamos(Consulta.laConsultasSql(contadorReclamosIterados),Consulta.laConsultasCampoComodin(contadorReclamosIterados),"simple")


            }
        }
    }

    Text {
        id: txtVersion
        x: 943
        y: 10
        color: "#c44e4e"
        text: qsTr("Ver.: "+_version)
        styleColor: "#e2dfdf"
        style: Text.Outline
        z: 1
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        smooth: true
        font.family: "Verdana"
        font.pixelSize: 12
    }

    Rectangle {
        id: rectangle2
        height: 80
        color: "#00000000"
        radius: 3
        z: 9
        border.color: "#d8d7ea"
        smooth: true
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5

        BarraInferior {
            id: barraInferior
            anchors.fill: parent
        }

        Image {
            id: imgFlecha
            x: 461
            width: 25
            height: 25
            opacity: 0.3
            anchors.top: parent.top
            anchors.topMargin: -15
            anchors.horizontalCenter: parent.horizontalCenter
            smooth: true
            source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaAbajo.png"

            MouseArea {
                id: mouse_area2
                hoverEnabled: true
                anchors.fill: parent
                onEntered: {
                    imgFlechaOpacidadOff.stop()
                    imgFlechaOpacidadOn.start()
                }
                onExited: {
                    imgFlechaOpacidadOn.stop()
                    imgFlechaOpacidadOff.start()
                }
                onClicked: {
                    if(rectangle2.anchors.bottomMargin==5){
                        rectangle2Aparecer.stop()
                        rectangle2Desaparecer.start()
                        imgFlecha.source="qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaArriba.png"
                    }else{
                        rectangle2Desaparecer.stop()
                        rectangle2Aparecer.start()
                        imgFlecha.source="qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaAbajo.png"
                    }
                }
            }
        }
        PropertyAnimation{
            id:imgFlechaOpacidadOn
            property: "opacity"
            target: imgFlecha
            from:0.3
            to:0.95
            duration: 300
        }
        PropertyAnimation{
            id:imgFlechaOpacidadOff
            property: "opacity"
            target: imgFlecha
            from:0.95
            to:0.3
            duration: 70
        }
        PropertyAnimation{
            id:rectangle2Desaparecer
            target: rectangle2
            property: "anchors.bottomMargin"
            duration: 200
            from:5
            to:-78
        }
        PropertyAnimation{
            id:rectangle2Aparecer
            target: rectangle2
            property: "anchors.bottomMargin"
            duration: 200
            to:5
            from:-78
        }
    }

    BotonSimple {
        id: btnPrevisualizarReporte
        x: 627
        y: 101
        modoBotonPrecionado: false
        textoBoton: "Previsualizar reporte"
        anchors.bottom: rectContenedorRegistros.top
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        z: 3
        onClicBoton: {

            if(!listaRegistros.count==0){

                configuracionTiempoResolucion.visible=true

            }
        }
    }

    function mostrarReportewww(){

        configuracionTiempoResolucion.visible=false
        var _whereParaReporte;
        if(hayRegistrosSeleccionados()){
            whereDinamico=Consulta.laConsultawhereDinamicoArray(contadorReclamosIterados)
            _whereParaReporte=retornoWhereDinamico()
            reportePrevisualizacion.cargarReporte(_whereParaReporte)
        }else{
            reportePrevisualizacion.cargarReporte(Consulta.laConsultawhereDinamicoArray(contadorReclamosIterados))
        }

        pause.start()

    }


    ParallelAnimation{
        id:pause
        PauseAnimation { duration: 500 }
        onCompleted: {
            reportePrevisualizacion.visible=true
        }
    }
    PreviewReporte {
        id: reportePrevisualizacion
        x: 40
        y: 35
        width: {
            if(_maximizado){
                rectPrincipal.width-80
            }else{
                960
            }
        }
        height: {
            if(_maximizado){
                rectPrincipal.height-70
            }else{
                680
            }
        }
        visible: false
        z: 11
        onClicCerrarReporte: {
            visible=false
        }
        onMaximizarRestaurar: {
            _maximizado=!_maximizado
            if(_maximizado){
                x=40
                y=35
            }
        }
        onDoubleClic: {
            _maximizado=true
            if(_maximizado){
                x=40
                y=35
            }
        }

    }
    PreviewReclamo{
        id:reclamosTareasPrevisualizacion
        x: 80
        y: 50
        visible: false
        width: 800
        height: 650
    }

    ConfiguracionTiempoResolucion{
        id: configuracionTiempoResolucion
        x: 80
        y: 50
        visible: false
        width: 900
        height: 600



    }



}
