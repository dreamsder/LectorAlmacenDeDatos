#include "moduloperfilestiemporesolucion.h"
#include <Utilidades/database.h>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlRecord>
#include <QSqlError>
#include <QMessageBox>
#include <moduloperfilestiemporesoluciondetalle.h>

ModuloPerfilesTiempoResolucionDetalle moduloPerfilesTiempoResolucionDetalle;

ModuloPerfilesTiempoResolucion::ModuloPerfilesTiempoResolucion(QObject *parent)
    : QAbstractListModel(parent)
{

    QHash<int, QByteArray> roles;
    roles[codigoPerfilesTiempoResolucionRole] = "codigoPerfilesTiempoResolucion";
    roles[nombrePerfilesTiempoResolucionRole] = "nombrePerfilesTiempoResolucion";

    roles[textoTiempoClienteTercerosRole] = "textoTiempoClienteTerceros";
    roles[mostrarCoordinadoRole] = "mostrarCoordinado";
    roles[mostrarHoraFinalizadoRole] = "mostrarHoraFinalizado";
    roles[mostrarTextoTiempoClienteTercerosRole] = "mostrarTextoTiempoClienteTerceros";
    roles[mostrarTiempoPromedioAsistenciasRole] = "mostrarTiempoPromedioAsistencias";


    setRoleNames(roles);


}

PerfilesTiempoResolucion::PerfilesTiempoResolucion(
        const QString &codigoPerfilesTiempoResolucion
        ,const QString &nombrePerfilesTiempoResolucion,

        const QString &textoTiempoClienteTerceros,
        const int &mostrarCoordinado,
        const int &mostrarHoraFinalizado,
        const int &mostrarTextoTiempoClienteTerceros,
        const int &mostrarTiempoPromedioAsistencias




        )
    :m_codigoPerfilesTiempoResolucion(codigoPerfilesTiempoResolucion)
    ,m_nombrePerfilesTiempoResolucion(nombrePerfilesTiempoResolucion)

    ,m_textoTiempoClienteTerceros(textoTiempoClienteTerceros)
    ,m_mostrarCoordinado(mostrarCoordinado)
    ,m_mostrarHoraFinalizado(mostrarHoraFinalizado)
    ,m_mostrarTextoTiempoClienteTerceros(mostrarTextoTiempoClienteTerceros)
    ,m_mostrarTiempoPromedioAsistencias(mostrarTiempoPromedioAsistencias)


{
}


QString PerfilesTiempoResolucion::codigoPerfilesTiempoResolucion() const
{
    return m_codigoPerfilesTiempoResolucion;
}
QString PerfilesTiempoResolucion::nombrePerfilesTiempoResolucion() const
{
    return m_nombrePerfilesTiempoResolucion;
}


QString PerfilesTiempoResolucion::textoTiempoClienteTerceros() const
{
    return m_textoTiempoClienteTerceros;
}
int PerfilesTiempoResolucion::mostrarCoordinado() const
{
    return m_mostrarCoordinado;
}
int PerfilesTiempoResolucion::mostrarHoraFinalizado() const
{
    return m_mostrarHoraFinalizado;
}
int PerfilesTiempoResolucion::mostrarTextoTiempoClienteTerceros() const
{
    return m_mostrarTextoTiempoClienteTerceros;
}

int PerfilesTiempoResolucion::mostrarTiempoPromedioAsistencias() const
{
    return m_mostrarTiempoPromedioAsistencias;
}




void ModuloPerfilesTiempoResolucion::agregar(const PerfilesTiempoResolucion &perfilesTiempoResolucion)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_PerfilesTiempoResolucion << perfilesTiempoResolucion;
    endInsertRows();
}
void ModuloPerfilesTiempoResolucion::limpiarLista(){
    m_PerfilesTiempoResolucion.clear();
}

void ModuloPerfilesTiempoResolucion::buscar(){
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }

    if(conexion){
        QSqlQuery q = Database::consultaSql("select * from PerfilesTiempoResolucion order by nombrePerfilesTiempoResolucion","local");
        QSqlRecord rec = q.record();

        ModuloPerfilesTiempoResolucion::reset();
        if(q.record().count()>0){

            while (q.next()){
                ModuloPerfilesTiempoResolucion::agregar(PerfilesTiempoResolucion(
                                                            q.value(rec.indexOf("codigoPerfilesTiempoResolucion")).toString(),
                                                            q.value(rec.indexOf("nombrePerfilesTiempoResolucion")).toString(),

                                                            q.value(rec.indexOf("textoTiempoClienteTerceros")).toString(),
                                                            q.value(rec.indexOf("mostrarCoordinado")).toInt(),
                                                            q.value(rec.indexOf("mostrarHoraFinalizado")).toInt(),
                                                            q.value(rec.indexOf("mostrarTextoTiempoClienteTerceros")).toInt(),
                                                            q.value(rec.indexOf("mostrarTiempoPromedioAsistencias")).toInt()



                                                            ));
            }
        }
    }
}

int ModuloPerfilesTiempoResolucion::rowCount(const QModelIndex & parent) const {
    return m_PerfilesTiempoResolucion.count();
}

QVariant ModuloPerfilesTiempoResolucion::data(const QModelIndex & index, int role) const {

    if (index.row() < 0 || index.row() > m_PerfilesTiempoResolucion.count()){
        return QVariant();

    }

    const PerfilesTiempoResolucion &variable = m_PerfilesTiempoResolucion[index.row()];

    if (role == codigoPerfilesTiempoResolucionRole){
        return variable.codigoPerfilesTiempoResolucion();
    }
    else if (role == nombrePerfilesTiempoResolucionRole){
        return variable.nombrePerfilesTiempoResolucion();
    }


    else if (role == textoTiempoClienteTercerosRole){
        return variable.textoTiempoClienteTerceros();
    }
    else if (role == mostrarCoordinadoRole){
        return variable.mostrarCoordinado();
    }
    else if (role == mostrarHoraFinalizadoRole){
        return variable.mostrarHoraFinalizado();
    }
    else if (role == mostrarTextoTiempoClienteTercerosRole){
        return variable.mostrarTextoTiempoClienteTerceros();
    }
    else if (role == mostrarTiempoPromedioAsistenciasRole){
        return variable.mostrarTiempoPromedioAsistencias();
    }



    return QVariant();
}

QString ModuloPerfilesTiempoResolucion::retornarCodigoPerfilesTiempoResolucion(int indice) const{
    return m_PerfilesTiempoResolucion[indice].codigoPerfilesTiempoResolucion();
}
QString ModuloPerfilesTiempoResolucion::retornarNombrePerfilesTiempoResolucion(int indice) const{
    return m_PerfilesTiempoResolucion[indice].nombrePerfilesTiempoResolucion();
}


QString ModuloPerfilesTiempoResolucion::retornarTextoTiempoClienteTerceros(int indice) const{

    return m_PerfilesTiempoResolucion[indice].textoTiempoClienteTerceros();
}
bool ModuloPerfilesTiempoResolucion::retornarMostrarCoordinado(int indice) const{
    if(m_PerfilesTiempoResolucion[indice].mostrarCoordinado()==1){
        return true;
    }else{
        return false;
    }
}
bool ModuloPerfilesTiempoResolucion::retornarMostrarHoraFinalizado(int indice) const{
    if(m_PerfilesTiempoResolucion[indice].mostrarHoraFinalizado()==1){
        return true;
    }else{
        return false;
    }
}
bool ModuloPerfilesTiempoResolucion::retornarMostrarTextoTiempoClienteTerceros(int indice) const{

    if(m_PerfilesTiempoResolucion[indice].mostrarTextoTiempoClienteTerceros()==1){
        return true;
    }else{
        return false;
    }
}
bool ModuloPerfilesTiempoResolucion::retornarMostrarTiempoPromedioAsistencias(int indice) const{

    if(m_PerfilesTiempoResolucion[indice].mostrarTiempoPromedioAsistencias()==1){
        return true;
    }else{
        return false;
    }
}



bool ModuloPerfilesTiempoResolucion::guardarFiltro(QString codigoPerfilesTiempoResolucion,QString nombrePerfilesTiempoResolucion, QString textoTiempoClienteTerceros,
                                                   bool mostrarCoordinado, bool mostrarHoraFinalizado, bool mostrarTextoTiempoClienteTerceros, bool mostrarTiempoPromedioAsistencias) const {





    QString mostrarCoordinadoINT ="0";
    QString mostrarHoraFinalizadoINT="0";
    QString mostrarTextoTiempoClienteTercerosINT="0";
    QString mostrarTiempoPromedioAsistenciasINT="0";



    if(mostrarCoordinado)
        mostrarCoordinadoINT="1";

    if(mostrarHoraFinalizado)
        mostrarHoraFinalizadoINT="1";

    if(mostrarTextoTiempoClienteTerceros)
        mostrarTextoTiempoClienteTercerosINT="1";

    if(mostrarTiempoPromedioAsistencias)
        mostrarTiempoPromedioAsistenciasINT="1";




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

        if(query.exec("select * from PerfilesTiempoResolucion where codigoPerfilesTiempoResolucion='"+codigoPerfilesTiempoResolucion+"';")) {

            if(query.first()){
                if(query.exec("UPDATE PerfilesTiempoResolucion SET nombrePerfilesTiempoResolucion='"+nombrePerfilesTiempoResolucion+"',textoTiempoClienteTerceros='"+textoTiempoClienteTerceros+"',mostrarCoordinado='"+mostrarCoordinadoINT+"',mostrarHoraFinalizado='"+mostrarHoraFinalizadoINT+"',mostrarTextoTiempoClienteTerceros='"+mostrarTextoTiempoClienteTercerosINT+"',mostrarTiempoPromedioAsistencias='"+mostrarTiempoPromedioAsistenciasINT+"'    where codigoPerfilesTiempoResolucion='"+codigoPerfilesTiempoResolucion+"';")) {
                    return true;
                }else{
                    qDebug()<< query.lastError();
                    qDebug()<< query.lastQuery();
                    return false;
                }
            }else{
                if(query.exec("REPLACE INTO PerfilesTiempoResolucion (codigoPerfilesTiempoResolucion,nombrePerfilesTiempoResolucion,textoTiempoClienteTerceros,mostrarCoordinado,mostrarHoraFinalizado,mostrarTextoTiempoClienteTerceros,mostrarTiempoPromedioAsistencias) VALUES('"+codigoPerfilesTiempoResolucion+"','"+nombrePerfilesTiempoResolucion+"','"+textoTiempoClienteTerceros+"','"+mostrarCoordinadoINT+"','"+mostrarHoraFinalizadoINT+"','"+mostrarTextoTiempoClienteTercerosINT+"','"+mostrarTiempoPromedioAsistenciasINT+"');")) {
                    return true;
                }else{
                    qDebug()<< query.lastError();
                    qDebug()<< query.lastQuery();
                    return false;
                }
            }
        }else{
            return false;
        }
    }else{

        return false;
    }
}

QString ModuloPerfilesTiempoResolucion::nuevoCodigoFiltro()const {

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

        if(query.exec("select codigoPerfilesTiempoResolucion from PerfilesTiempoResolucion  order by cast(codigoPerfilesTiempoResolucion as unsigned) desc limit 1")) {

            if(query.first()){
                if(query.value(0).toString()!=""){

                    return QString::number(query.value(0).toInt()+1);

                }else{
                    return "1";
                }
            }else {return "1";}
        }else{
            return "1";
        }
    }
}



bool ModuloPerfilesTiempoResolucion::eliminarFiltro(QString codigoPerfilesTiempoResolucion) const {

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

        if(query.exec("delete from PerfilesTiempoResolucion where codigoPerfilesTiempoResolucion='"+codigoPerfilesTiempoResolucion+"' ;")) {

            return true;

        }else{
            qDebug()<< query.lastError();
            qDebug()<< query.lastQuery();
            return false;
        }
    }else{

        return false;
    }
}

bool ModuloPerfilesTiempoResolucion::mensajePregunta(QString codigoPerfilesTiempoResolucion,QString nombrePerfilesTiempoResolucion)const {

    QMessageBox msgBox;
    msgBox.setWindowTitle("Eliminar perfil ");
    msgBox.setText("Se está por eliminar el perfil <b>"+nombrePerfilesTiempoResolucion+"</b>.");
    msgBox.setInformativeText("Desea continuar de todas formas?");
    msgBox.setStandardButtons(QMessageBox::Cancel | QMessageBox::Yes);
    msgBox.setDefaultButton(QMessageBox::Cancel);
    int ret = msgBox.exec();


    switch (ret) {
    case QMessageBox::Yes:

        if(moduloPerfilesTiempoResolucionDetalle.eliminarFiltro(codigoPerfilesTiempoResolucion)){

            if(eliminarFiltro(codigoPerfilesTiempoResolucion)){
                return true;
            }else{
                return false;
            }

        }else{
            return false;
        }

        break;
    case QMessageBox::Cancel:
        return false;
        break;
    default:
        return false;
        break;
    }
}






