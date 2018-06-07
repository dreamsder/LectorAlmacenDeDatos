#include "moduloreclamos.h"
#include <Utilidades/database.h>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlRecord>
#include <QSplitter>
#include <QVariant>
#include <QDesktopServices>
#include <QUrl>
#include <Utilidades/configuracionxml.h>


QString _tiempo="";

ModuloReclamos::ModuloReclamos(QObject *parent)
    : QAbstractListModel(parent)
{

    QHash<int, QByteArray> roles;
    roles[CampoComodinRole] = "campoComodin";
    roles[AsistenciasRole] = "asistencias";
    roles[TiempoMesaEntradaRole] = "tiempoMesaEntrada";
    roles[TiempoEstadoNuevoRole] = "tiempoEstadoNuevo";
    roles[TiempoEstadoAsignadoRole] = "tiempoEstadoAsignado";
    roles[TiempoEsperaRespuestaClienteRole] = "tiempoEsperaRespuestaCliente";
    roles[TiempoEsperaRespuestaObjetosRole] = "tiempoEsperaRespuestaObjetos";
    roles[TiempoTareasRole] = "tiempoTareas";
    roles[TiempoResolucionRole] = "tiempoResolucion";
    roles[primerFiltroControlRole] = "primerFiltroControl";
    roles[segundoFiltroControlRole] = "segundoFiltroControl";
    roles[OpcionalRole] = "opcional";
    roles[Opcional2Role] = "opcional2";
    roles[TiempoEsperaRespuestaClienteHorarioSistecoRole] = "tiempoEsperaRespuestaClienteHorarioSisteco";

    setRoleNames(roles);
}

Reclamos::Reclamos(const QString &campoComodin
                   ,const int &asistencias
                   ,const QString &tiempoMesaEntrada
                   ,const QString &tiempoEstadoNuevo
                   ,const QString &tiempoEstadoAsignado
                   ,const QString &tiempoEsperaRespuestaCliente
                   ,const QString &tiempoEsperaRespuestaObjetos
                   ,const QString &tiempoTareas
                   ,const QString &tiempoResolucion
                   ,const QString &primerFiltroControl
                   ,const QString &segundoFiltroControl
                   ,const QString &opcional
                   ,const QString &opcional2
                   ,const QString &tiempoEsperaRespuestaClienteHorarioSisteco

                   ,const QString &tiempoMesaEntradaCrudo
                   ,const QString &tiempoEstadoNuevoCrudo
                   ,const QString &tiempoEstadoAsignadoCrudo
                   ,const QString &tiempoEsperaRespuestaClienteCrudo
                   ,const QString &tiempoEsperaRespuestaObjetosCrudo
                   ,const QString &tiempoTareasCrudo
                   ,const QString &tiempoResolucionCrudo
                   )
    : m_campoComodin(campoComodin)
    ,m_asistencias(asistencias)
    ,m_tiempoMesaEntrada(tiempoMesaEntrada)
    ,m_tiempoEstadoNuevo(tiempoEstadoNuevo)
    ,m_tiempoEstadoAsignado(tiempoEstadoAsignado)
    ,m_tiempoEsperaRespuestaCliente(tiempoEsperaRespuestaCliente)
    ,m_tiempoEsperaRespuestaObjetos(tiempoEsperaRespuestaObjetos)
    ,m_tiempoTareas(tiempoTareas)
    ,m_tiempoResolucion(tiempoResolucion)
    ,m_primerFiltroControl(primerFiltroControl)
    ,m_segundoFiltroControl(segundoFiltroControl)
    ,m_opcional(opcional)
    ,m_opcional2(opcional2)
    ,m_tiempoEsperaRespuestaClienteHorarioSisteco(tiempoEsperaRespuestaClienteHorarioSisteco)

    ,m_tiempoMesaEntradaCrudo(tiempoMesaEntradaCrudo)
    ,m_tiempoEstadoNuevoCrudo(tiempoEstadoNuevoCrudo)
    ,m_tiempoEstadoAsignadoCrudo(tiempoEstadoAsignadoCrudo)
    ,m_tiempoEsperaRespuestaClienteCrudo(tiempoEsperaRespuestaClienteCrudo)
    ,m_tiempoEsperaRespuestaObjetosCrudo(tiempoEsperaRespuestaObjetosCrudo)
    ,m_tiempoTareasCrudo(tiempoTareasCrudo)
    ,m_tiempoResolucionCrudo(tiempoResolucionCrudo)
{
}

QString Reclamos::campoComodin() const
{
    return m_campoComodin;
}
int Reclamos::asistencias() const
{
    return m_asistencias;
}
QString Reclamos::tiempoMesaEntrada() const
{
    return m_tiempoMesaEntrada;
}
QString Reclamos::tiempoEstadoNuevo() const
{
    return m_tiempoEstadoNuevo;
}


QString Reclamos::tiempoEstadoAsignado() const
{
    return m_tiempoEstadoAsignado;
}
QString Reclamos::tiempoEsperaRespuestaCliente() const
{
    return m_tiempoEsperaRespuestaCliente;
}
QString Reclamos::tiempoEsperaRespuestaObjetos() const
{
    return m_tiempoEsperaRespuestaObjetos;
}
QString Reclamos::tiempoTareas() const
{
    return m_tiempoTareas;
}
QString Reclamos::tiempoResolucion() const
{
    return m_tiempoResolucion;
}
QString Reclamos::primerFiltroControl() const
{
    return m_primerFiltroControl;
}
QString Reclamos::segundoFiltroControl() const
{
    return m_segundoFiltroControl;
}
QString Reclamos::opcional() const
{
    return m_opcional;
}
QString Reclamos::opcional2() const
{
    return m_opcional2;
}
QString Reclamos::tiempoEsperaRespuestaClienteHorarioSisteco() const
{
    return m_tiempoEsperaRespuestaClienteHorarioSisteco;
}
QString Reclamos::tiempoMesaEntradaCrudo() const
{
    return m_tiempoMesaEntradaCrudo;
}
QString Reclamos::tiempoEstadoNuevoCrudo() const
{
    return m_tiempoEstadoNuevoCrudo;
}
QString Reclamos::tiempoEstadoAsignadoCrudo() const
{
    return m_tiempoEstadoAsignadoCrudo;
}
QString Reclamos::tiempoEsperaRespuestaClienteCrudo() const
{
    return m_tiempoEsperaRespuestaClienteCrudo;
}
QString Reclamos::tiempoEsperaRespuestaObjetosCrudo() const
{
    return m_tiempoEsperaRespuestaObjetosCrudo;
}
QString Reclamos::tiempoTareasCrudo() const
{
    return m_tiempoTareasCrudo;
}
QString Reclamos::tiempoResolucionCrudo() const
{
    return m_tiempoResolucionCrudo;
}
void ModuloReclamos::agregarReclamo(const Reclamos &reclamos)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_Reclamos << reclamos;
    endInsertRows();
}

void ModuloReclamos::limpiarListaReclamos(){
    m_Reclamos.clear();
}

bool ModuloReclamos::buscarReclamos(QString _consultaSql){


    qDebug()<<_consultaSql;


    bool conexion=true;

    Database::cehqueStatusAccesoMysql("local");

    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
            return false;
        }
    }

    if(conexion){

        QSqlQuery q = Database::consultaSql(_consultaSql,"local");
        QSqlRecord rec = q.record();

        ModuloReclamos::reset();


        if(q.first()){
            q.previous();
            if(q.record().count()>0){

                while (q.next()){

                    ModuloReclamos::agregarReclamo(Reclamos(
                                                       q.value(rec.indexOf("campoComodin")).toString(),
                                                       q.value(rec.indexOf("asistencias")).toInt(),
                                                       QString::number((q.value(rec.indexOf("tiempoMesaEntrada")).toInt()/q.value(rec.indexOf("asistencias")).toInt())/60)+":"+QString::number((q.value(rec.indexOf("tiempoMesaEntrada")).toInt()/q.value(rec.indexOf("asistencias")).toInt())%60),
                                                       QString::number((q.value(rec.indexOf("tiempoEstadoNuevo")).toInt()/q.value(rec.indexOf("asistencias")).toInt())/60)+":"+QString::number((q.value(rec.indexOf("tiempoEstadoNuevo")).toInt()/q.value(rec.indexOf("asistencias")).toInt())%60),
                                                       QString::number((q.value(rec.indexOf("tiempoEstadoAsignado")).toInt()/q.value(rec.indexOf("asistencias")).toInt())/60)+":"+QString::number((q.value(rec.indexOf("tiempoEstadoAsignado")).toInt()/q.value(rec.indexOf("asistencias")).toInt())%60),
                                                       QString::number((q.value(rec.indexOf("tiempoEsperaRespuestaCliente")).toInt()/q.value(rec.indexOf("asistencias")).toInt())/60)+":"+QString::number((q.value(rec.indexOf("tiempoEsperaRespuestaCliente")).toInt()/q.value(rec.indexOf("asistencias")).toInt())%60),
                                                       QString::number((q.value(rec.indexOf("tiempoEsperaRespuestaObjetos")).toInt()/q.value(rec.indexOf("asistencias")).toInt())/60)+":"+QString::number((q.value(rec.indexOf("tiempoEsperaRespuestaObjetos")).toInt()/q.value(rec.indexOf("asistencias")).toInt())%60),
                                                       QString::number((q.value(rec.indexOf("tiempoTareas")).toInt()/q.value(rec.indexOf("asistencias")).toInt())/60)+":"+QString::number((q.value(rec.indexOf("tiempoTareas")).toInt()/q.value(rec.indexOf("asistencias")).toInt())%60),
                                                       QString::number((q.value(rec.indexOf("tiempoResolucion")).toInt()/q.value(rec.indexOf("asistencias")).toInt())/60)+":"+QString::number((q.value(rec.indexOf("tiempoResolucion")).toInt()/q.value(rec.indexOf("asistencias")).toInt())%60),
                                                       q.value(rec.indexOf("primerFiltroControl")).toString(),
                                                       q.value(rec.indexOf("segundoFiltroControl")).toString(),
                                                       q.value(rec.indexOf("opcional")).toString(),
                                                       q.value(rec.indexOf("opcional2")).toString(),
                                                       QString::number((q.value(rec.indexOf("tiempoEsperaRespuestaClienteHorarioSisteco")).toInt()/q.value(rec.indexOf("asistencias")).toInt())/60)+":"+QString::number((q.value(rec.indexOf("tiempoEsperaRespuestaClienteHorarioSisteco")).toInt()/q.value(rec.indexOf("asistencias")).toInt())%60),
                                                       q.value(rec.indexOf("tiempoMesaEntrada")).toString(),
                                                       q.value(rec.indexOf("tiempoEstadoNuevo")).toString(),
                                                       q.value(rec.indexOf("tiempoEstadoAsignado")).toString(),
                                                       q.value(rec.indexOf("tiempoEsperaRespuestaCliente")).toString(),
                                                       q.value(rec.indexOf("tiempoEsperaRespuestaObjetos")).toString(),
                                                       q.value(rec.indexOf("tiempoTareas")).toString(),
                                                       q.value(rec.indexOf("tiempoResolucion")).toString()

                                                       ));
                }
                return true;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }else{
        return false;
    }
}

int ModuloReclamos::rowCount(const QModelIndex & parent) const {
    return m_Reclamos.count();
}

QVariant ModuloReclamos::data(const QModelIndex & index, int role) const {

    if (index.row() < 0 || index.row() > m_Reclamos.count()){
        return QVariant();

    }
    const Reclamos &reclamos = m_Reclamos[index.row()];

    if (role == CampoComodinRole){
        return reclamos.campoComodin();
    }
    else if (role == AsistenciasRole){
        return reclamos.asistencias();
    }
    else if (role == TiempoMesaEntradaRole){
        return reclamos.tiempoMesaEntrada();
    }
    else if (role == TiempoEstadoNuevoRole){
        return reclamos.tiempoEstadoNuevo();
    }
    else if (role == TiempoEstadoAsignadoRole){
        return reclamos.tiempoEstadoAsignado();
    }
    else if (role == TiempoEsperaRespuestaClienteRole){
        return reclamos.tiempoEsperaRespuestaCliente();
    }
    else if (role == TiempoEsperaRespuestaObjetosRole){
        return reclamos.tiempoEsperaRespuestaObjetos();
    }
    else if (role == TiempoTareasRole){
        return reclamos.tiempoTareas();
    }
    else if (role == TiempoResolucionRole){
        return reclamos.tiempoResolucion();
    }
    else if (role == primerFiltroControlRole){
        return reclamos.primerFiltroControl();
    }
    else if (role == segundoFiltroControlRole){
        return reclamos.segundoFiltroControl();
    }
    else if (role == OpcionalRole){
        return reclamos.opcional();
    }else if (role == Opcional2Role){
        return reclamos.opcional2();
    }else if (role == TiempoEsperaRespuestaClienteHorarioSistecoRole){
        return reclamos.tiempoEsperaRespuestaClienteHorarioSisteco();
    }
    return QVariant();
}

QString ModuloReclamos::retornarCampoComodin(int indice) const{
    return m_Reclamos[indice].campoComodin();
}
int ModuloReclamos::retornarAsistencias(int indice) const{

    return m_Reclamos[indice].asistencias();
}
QString ModuloReclamos::retornarTiempoMesaEntrada(int indice) const{
    _tiempo="";
    _tiempo=m_Reclamos[indice].tiempoMesaEntrada();
    QStringList list;
    list= _tiempo.split(":");
    if(list.at(0).length()==1){
        _tiempo=_tiempo.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempo=_tiempo.insert(_tiempo.indexOf(":")+1,"0");
    }
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoEstadoNuevo(int indice) const{
    _tiempo="";
    _tiempo=m_Reclamos[indice].tiempoEstadoNuevo();
    QStringList list;
    list= _tiempo.split(":");
    if(list.at(0).length()==1){
        _tiempo=_tiempo.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempo=_tiempo.insert(_tiempo.indexOf(":")+1,"0");
    }
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoEstadoAsignado(int indice) const{
    _tiempo="";
    _tiempo=m_Reclamos[indice].tiempoEstadoAsignado();
    QStringList list;
    list= _tiempo.split(":");
    if(list.at(0).length()==1){
        _tiempo=_tiempo.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempo=_tiempo.insert(_tiempo.indexOf(":")+1,"0");
    }
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoEsperaRespuestaCliente(int indice) const{
    _tiempo="";
    _tiempo=m_Reclamos[indice].tiempoEsperaRespuestaCliente();
    QStringList list;
    list= _tiempo.split(":");
    if(list.at(0).length()==1){
        _tiempo=_tiempo.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempo=_tiempo.insert(_tiempo.indexOf(":")+1,"0");
    }
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoEsperaRespuestaObjetos(int indice) const{
    _tiempo="";
    _tiempo=m_Reclamos[indice].tiempoEsperaRespuestaObjetos();
    QStringList list;
    list= _tiempo.split(":");
    if(list.at(0).length()==1){
        _tiempo=_tiempo.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempo=_tiempo.insert(_tiempo.indexOf(":")+1,"0");
    }
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoTareas(int indice) const{
    _tiempo="";
    _tiempo=m_Reclamos[indice].tiempoTareas();
    QStringList list;
    list= _tiempo.split(":");
    if(list.at(0).length()==1){
        _tiempo=_tiempo.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempo=_tiempo.insert(_tiempo.indexOf(":")+1,"0");
    }
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoResolucion(int indice) const{


    _tiempo="";
    _tiempo=m_Reclamos[indice].tiempoResolucion();
    QStringList list;
    list= _tiempo.split(":");
    if(list.at(0).length()==1){
        _tiempo=_tiempo.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempo=_tiempo.insert(_tiempo.indexOf(":")+1,"0");
    }
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoEsperaRespuestaClienteHorarioSisteco(int indice) const{
    _tiempo="";
    _tiempo=m_Reclamos[indice].tiempoEsperaRespuestaClienteHorarioSisteco();
    QStringList list;
    list= _tiempo.split(":");
    if(list.at(0).length()==1){
        _tiempo=_tiempo.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempo=_tiempo.insert(_tiempo.indexOf(":")+1,"0");
    }
    return _tiempo;
}
QString ModuloReclamos::retornarPrimerFiltroControl(int indice) const{
    return m_Reclamos[indice].primerFiltroControl();
}
QString ModuloReclamos::retornarSegundoFiltroControl(int indice) const{
    return m_Reclamos[indice].segundoFiltroControl();
}
QString ModuloReclamos::retornarOpcional(int indice) const{
    return m_Reclamos[indice].opcional();
}
QString ModuloReclamos::retornarOpcional2(int indice) const{
    return m_Reclamos[indice].opcional2();
}

/// Retorna el nombre del mes, segun el codigo de mes que se le pasa
QString ModuloReclamos::retornarNombreDelMes(int _codigoMes) const{

    switch (_codigoMes) {
    case 1:
        return "Enero";
    case 2:
        return "Febrero";
    case 3:
        return "Marzo";
    case 4:
        return "Abril";
    case 5:
        return "Mayo";
    case 6:
        return "Junio";
    case 7:
        return "Julio";
    case 8:
        return "Agosto";
    case 9:
        return "Setiembre";
    case 10:
        return "Octubre";
    case 11:
        return "Noviembre";
    case 12:
        return "Diciembre";
    default:
        return "Error";
        break;
    }
}
/// Retorna el nombre del dia se la semana, segun el codigo de dia que se le pasa
QString ModuloReclamos::retornarNombreDelDiaDeSemana(int _codigoDiaSemana) const{

    switch (_codigoDiaSemana) {
    case 1:
        return "Domingo";
    case 2:
        return "Lunes";
    case 3:
        return "Martes";
    case 4:
        return "Miercoles";
    case 5:
        return "Jueves";
    case 6:
        return "Viernes";
    case 7:
        return "Sabado";
    default:
        return "Error";
        break;
    }
}
QString ModuloReclamos::retornarNombreCliente(QString _codigoCliente)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT razonCliente FROM Reclamos where codigoCliente="+_codigoCliente+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}

QString ModuloReclamos::retornarNombreMarca(QString _codigoMarca)const{

    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){

        QSqlQuery query(Database::connect("local"));

        if(query.exec("SELECT nombreMarca FROM Reclamos where codigoMarca="+_codigoMarca+"  limit 1")) {
            query.next();

            if(query.value(0).toString()!=""){

                return query.value(0).toString();

            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornarNombreModelo(QString _codigoModelo)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreModelo FROM Reclamos where codigoModelo="+_codigoModelo+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornarNombreTecnicoResponsable(QString _codigoTecnico)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreTecnicoResponsable FROM Reclamos where codigoTecnicoResponsable="+_codigoTecnico+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornarNombreArea(QString _codigoArea)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreArea FROM Reclamos where codigoArea="+_codigoArea+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornarNombreCamino(QString _codigoCamino)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreCamino FROM Reclamos where codigoCamino="+_codigoCamino+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornarNombreSintoma(QString _codigoSintoma)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreSintoma FROM Reclamos where codigoSintoma="+_codigoSintoma+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornarNombreTipoReclamo(QString _codigoTipoReclamo)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreTipoReclamo FROM Reclamos where codigoTipoReclamo="+_codigoTipoReclamo+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}

QString ModuloReclamos::retornarNombreCausa(QString _codigoCausa)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreCausa FROM Reclamos where codigoCausa="+_codigoCausa+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}

QString ModuloReclamos::retornarNombreTipoReclamoCliente(QString _codigoTipoReclamoCliente)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreTipoReclamoCliente FROM Reclamos where codigoTipoReclamoCliente="+_codigoTipoReclamoCliente+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}

bool ModuloReclamos::retornarEstadoDeComparacionDeString(QString _campo, QString _consulta) const{
    if(_consulta.contains(_campo))
    {
        return true;
    }else{
        return false;
    }
}

bool ModuloReclamos::retornarSiCausaEsAtribuibleACliente(QString _codigoCausa)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT causaAtribuida FROM Reclamos where codigoCausa="+_codigoCausa+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                if(query.value(0).toString()=="Cliente/Tercero"){
                    return true;
                }else{return false;}
            }else{
                return false;
            }
        }else{
            return false;
        }
    }else{
        return false;
    }
}

QString ModuloReclamos::retornarNombreSucursal(QString _codigoCliente,QString _codigoSucursal)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreSucursal FROM Reclamos where codigoCliente="+_codigoCliente+" and codigoSucursal='"+_codigoSucursal+"'  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}


QString ModuloReclamos::retornarNombreTareas(QString _codigoTarea)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));

        if(query.exec("SELECT nombreTarea from Tareas  where  codigoTarea='"+_codigoTarea+"' limit 1 ")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}


QString ModuloReclamos::retornarNombreConceptos(QString _codigoConcepto)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));

        if(query.exec("SELECT nombreConcepto from Conceptos  where  codigoConcepto='"+_codigoConcepto+"' limit 1 ")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}



QString ModuloReclamos::retornaReclamosDeTareas(QString _whereHastaElmomento)const{
    bool conexion=true;
    QString consultaWhere="";
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));

        if(query.exec("SELECT REC.codigoReclamo FROM Reclamos REC join Tareas TAR on TAR.idReclamo=REC.codigoReclamo where 1=1 "+_whereHastaElmomento+" group by REC.codigoReclamo ")) {

            while(query.next()){
                consultaWhere.append("'"+query.value(0).toString()+"',");
            }

            return consultaWhere.left(consultaWhere.length()-1);
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornaReclamosDeConceptos(QString _whereHastaElmomento)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    QString consultaWhere="";
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));

        if(query.exec("SELECT REC.codigoReclamo FROM Reclamos REC join Conceptos CON on CON.idReclamo=REC.codigoReclamo where 1=1 "+_whereHastaElmomento+" group by REC.codigoReclamo ")) {

            while(query.next()){
                consultaWhere.append("'"+query.value(0).toString()+"',");
            }            
            return consultaWhere.left(consultaWhere.length()-1);
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}

QString ModuloReclamos::retornaTituloReclamo(QString _codigoReclamo)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT tituloReclamo FROM Reclamos where codigoReclamo='"+_codigoReclamo+"'")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornaTecnicoReclamo(QString _codigoReclamo)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreTecnicoResponsable FROM Reclamos where codigoReclamo='"+_codigoReclamo+"'")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornaClienteSucursalReclamo(QString _codigoReclamo)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT concat(razonCliente,'  *',nombreSucursal) FROM Reclamos where codigoReclamo='"+_codigoReclamo+"'")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornaMarcaTipoModeloReclamo(QString _codigoReclamo)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT concat(nombreMarca,' - ',nombreTipo,' - ',nombreModelo) FROM Reclamos where codigoReclamo='"+_codigoReclamo+"'")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornarNombreDepartamento(QString _codigoDepartamento)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreDepartamento FROM Reclamos where codigoDepartamento="+_codigoDepartamento+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}
QString ModuloReclamos::retornarNombreCoordinado(QString _codigoCoordinado)const{
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }
    if(conexion){
        QSqlQuery query(Database::connect("local"));
        if(query.exec("SELECT nombreCoordinado FROM Reclamos where codigoCoordinado="+_codigoCoordinado+"  limit 1")) {
            query.next();
            if(query.value(0).toString()!=""){
                return query.value(0).toString();
            }else{
                return "";
            }
        }else{
            return "Error BD";
        }
    }else{
        return "Error BD";
    }
}



QString ModuloReclamos::retornarTiempoEstadoNuevoCrudo(int indice) const{

    _tiempo=m_Reclamos[indice].tiempoEstadoNuevoCrudo();
    return _tiempo;

}
QString ModuloReclamos::retornarTiempoEstadoAsignadoCrudo(int indice) const{
    _tiempo=m_Reclamos[indice].tiempoEstadoAsignadoCrudo();
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoEsperaRespuestaClienteCrudo(int indice) const{
    _tiempo=m_Reclamos[indice].tiempoEsperaRespuestaClienteCrudo();
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoEsperaRespuestaObjetosCrudo(int indice) const{
    _tiempo=m_Reclamos[indice].tiempoEsperaRespuestaObjetosCrudo();
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoTareasCrudo(int indice) const{
    _tiempo=m_Reclamos[indice].tiempoTareasCrudo();
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoResolucionCrudo(int indice) const{
    _tiempo=m_Reclamos[indice].tiempoResolucionCrudo();
    return _tiempo;
}
QString ModuloReclamos::retornarTiempoResolucionTotalCrudo(int indice) const{

    _tiempo=QString::number(m_Reclamos[indice].tiempoMesaEntradaCrudo().toInt()+m_Reclamos[indice].tiempoEstadoAsignadoCrudo().toInt()+m_Reclamos[indice].tiempoEstadoNuevoCrudo().toInt()+m_Reclamos[indice].tiempoEsperaRespuestaObjetosCrudo().toInt());
    return _tiempo;

}
QString ModuloReclamos::retornarTiempoTotal(int _tiempoTotal,int _asistencias) const{

    _tiempo= QString::number((_tiempoTotal/_asistencias)/60)+":"+QString::number((_tiempoTotal/_asistencias)%60);

    QStringList list;
    list= _tiempo.split(":");
    if(list.at(0).length()==1){
        _tiempo=_tiempo.insert(0,"0");
    }
    if(list.at(1).length()==1){
        _tiempo=_tiempo.insert(_tiempo.indexOf(":")+1,"0");
    }
    return _tiempo;
}

void ModuloReclamos::abrirPaginaWeb(QString _paginaWeb)const{

        QDesktopServices::openUrl(QUrl(_paginaWeb));

}

bool ModuloReclamos::estadoConexionLocal(){

    return Database::cehqueStatusAccesoMysql("local");

}
bool ModuloReclamos::accesoCompleto()const{




    if(ConfiguracionXml::getPerfil()=="toor"){
        return true;
    }else{
        return false;
    }
}
