#include "moduloperfilestiemporesoluciondetalle.h"
#include <Utilidades/database.h>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlRecord>
#include <QSqlError>

ModuloPerfilesTiempoResolucionDetalle::ModuloPerfilesTiempoResolucionDetalle(QObject *parent)
    : QAbstractListModel(parent)
{

    QHash<int, QByteArray> roles;
    roles[codigoPerfilesTiempoResolucionRole] = "codigoPerfilesTiempoResolucion";
    roles[codigoItemTiempoResolucionRole] = "codigoItemTiempoResolucion";

    setRoleNames(roles);
}

PerfilesTiempoResolucionDetalle::PerfilesTiempoResolucionDetalle(
        const QString &codigoPerfilesTiempoResolucion
        ,const QString &codigoItemTiempoResolucion
        )
    :m_codigoPerfilesTiempoResolucion(codigoPerfilesTiempoResolucion)
    ,m_codigoItemTiempoResolucion(codigoItemTiempoResolucion)
{
}


QString PerfilesTiempoResolucionDetalle::codigoPerfilesTiempoResolucion() const
{
    return m_codigoPerfilesTiempoResolucion;
}
QString PerfilesTiempoResolucionDetalle::codigoItemTiempoResolucion() const
{
    return m_codigoItemTiempoResolucion;
}


void ModuloPerfilesTiempoResolucionDetalle::agregar(const PerfilesTiempoResolucionDetalle &perfilesTiempoResolucionDetalle)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_PerfilesTiempoResolucionDetalle << perfilesTiempoResolucionDetalle;
    endInsertRows();
}
void ModuloPerfilesTiempoResolucionDetalle::limpiarLista(){
    m_PerfilesTiempoResolucionDetalle.clear();
}

void ModuloPerfilesTiempoResolucionDetalle::buscar(QString codigoPerfilesTiempoResolucion ){
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }

    if(conexion){
        QSqlQuery q = Database::consultaSql("select * from PerfilesTiempoResolucionDetalle where codigoPerfilesTiempoResolucion='"+codigoPerfilesTiempoResolucion+"'  order by codigoItemTiempoResolucion","local");
        QSqlRecord rec = q.record();

        ModuloPerfilesTiempoResolucionDetalle::reset();
        if(q.record().count()>0){

            while (q.next()){
                ModuloPerfilesTiempoResolucionDetalle::agregar(PerfilesTiempoResolucionDetalle(
                                                                   q.value(rec.indexOf("codigoPerfilesTiempoResolucion")).toString(),
                                                                   q.value(rec.indexOf("codigoItemTiempoResolucion")).toString()
                                                                   ));
            }
        }
    }
}

int ModuloPerfilesTiempoResolucionDetalle::rowCount(const QModelIndex & parent) const {
    return m_PerfilesTiempoResolucionDetalle.count();
}

QVariant ModuloPerfilesTiempoResolucionDetalle::data(const QModelIndex & index, int role) const {

    if (index.row() < 0 || index.row() > m_PerfilesTiempoResolucionDetalle.count()){
        return QVariant();

    }

    const PerfilesTiempoResolucionDetalle &variable = m_PerfilesTiempoResolucionDetalle[index.row()];

    if (role == codigoPerfilesTiempoResolucionRole){
        return variable.codigoPerfilesTiempoResolucion();
    }
    else if (role == codigoItemTiempoResolucionRole){
        return variable.codigoItemTiempoResolucion();
    }
    return QVariant();
}


bool ModuloPerfilesTiempoResolucionDetalle::guardarFiltro(QString codigoPerfilesTiempoResolucion,QString codigoItemTiempoResolucion) const {

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

        if(query.exec("REPLACE INTO PerfilesTiempoResolucionDetalle (codigoPerfilesTiempoResolucion,codigoItemTiempoResolucion) VALUES('"+codigoPerfilesTiempoResolucion+"','"+codigoItemTiempoResolucion+"');")) {

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

bool ModuloPerfilesTiempoResolucionDetalle::eliminarFiltro(QString codigoPerfilesTiempoResolucion) const {

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

        if(query.exec("delete from PerfilesTiempoResolucionDetalle where codigoPerfilesTiempoResolucion='"+codigoPerfilesTiempoResolucion+"' ;")) {

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

QString ModuloPerfilesTiempoResolucionDetalle::retornarCodigoPerfilesTiempoResolucion(int indice) const{
    return m_PerfilesTiempoResolucionDetalle[indice].codigoPerfilesTiempoResolucion();
}
QString ModuloPerfilesTiempoResolucionDetalle::retornarCodigoItemTiempoResolucion(int indice) const{
    return m_PerfilesTiempoResolucionDetalle[indice].codigoItemTiempoResolucion();
}





