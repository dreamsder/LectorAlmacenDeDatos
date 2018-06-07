#include "modulotareas.h"
#include <Utilidades/database.h>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlRecord>

ModuloTareas::ModuloTareas(QObject *parent)
    : QAbstractListModel(parent)
{

    QHash<int, QByteArray> roles;
    roles[idReclamoRole] = "idReclamo";
    roles[codigoTareaRole] = "codigoTarea";
    roles[nombreTareaRole] = "nombreTarea";
    roles[fechaTareaRole] = "fechaTarea";
    roles[horaTareaRole] = "horaTarea";
    roles[comentarioTareaRole] = "comentarioTarea";

    setRoleNames(roles);
}

Tareas::Tareas(const qlonglong &idReclamo
               ,const qlonglong &codigoTarea
               ,const QString &nombreTarea
               ,const QString &fechaTarea
               ,const QString &horaTarea
               ,const QString &comentarioTarea
               )
    : m_idReclamo(idReclamo)
    ,m_codigoTarea(codigoTarea)
    ,m_nombreTarea(nombreTarea)
    ,m_fechaTarea(fechaTarea)
    ,m_horaTarea(horaTarea)
    ,m_comentarioTarea(comentarioTarea)
{
}

qlonglong Tareas::idReclamo() const
{
    return m_idReclamo;
}
qlonglong Tareas::codigoTarea() const
{
    return m_codigoTarea;
}
QString Tareas::nombreTarea() const
{
    return m_nombreTarea;
}
QString Tareas::fechaTarea() const
{
    return m_fechaTarea;
}
QString Tareas::horaTarea() const
{
    return m_horaTarea;
}
QString Tareas::comentarioTarea() const
{
    return m_comentarioTarea;
}


void ModuloTareas::agregarTareas(const Tareas &tareas)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_Tareas << tareas;
    endInsertRows();
}
void ModuloTareas::limpiarListaTareas(){
    m_Tareas.clear();
}

void ModuloTareas::buscarTareas(QString _codigoReclamo){
    bool conexion=true;
    Database::cehqueStatusAccesoMysql("local");
    if(!Database::connect("local").isOpen()){
        if(!Database::connect("local").open()){
            qDebug() << "No conecto";
            conexion=false;
        }
    }

    if(conexion){
        QSqlQuery q = Database::consultaSql("select * from Tareas where idReclamo='"+_codigoReclamo+"' order by fechaTarea,horaTarea","local");
        QSqlRecord rec = q.record();

        ModuloTareas::reset();
        if(q.record().count()>0){

            while (q.next()){
                ModuloTareas::agregarTareas(Tareas(
                                                q.value(rec.indexOf("idReclamo")).toLongLong(),
                                                q.value(rec.indexOf("codigoTarea")).toLongLong(),
                                                q.value(rec.indexOf("nombreTarea")).toString(),
                                                q.value(rec.indexOf("fechaTarea")).toString(),
                                                q.value(rec.indexOf("horaTarea")).toString(),
                                                q.value(rec.indexOf("comentarioTarea")).toString()
                                                ));
            }
        }
    }
}

int ModuloTareas::rowCount(const QModelIndex & parent) const {
    return m_Tareas.count();
}

QVariant ModuloTareas::data(const QModelIndex & index, int role) const {

    if (index.row() < 0 || index.row() > m_Tareas.count()){
        return QVariant();

    }

    const Tareas &tareas = m_Tareas[index.row()];

    if (role == idReclamoRole){
        return tareas.idReclamo();
    }
    else if (role == codigoTareaRole){
        return tareas.codigoTarea();
    }
    else if (role == nombreTareaRole){
        return tareas.nombreTarea();
    }
    else if (role == fechaTareaRole){
        return tareas.fechaTarea();
    }
    else if (role == horaTareaRole){
        return tareas.horaTarea();
    }
    else if (role == comentarioTareaRole){
        return tareas.comentarioTarea();
    }
    return QVariant();
}







