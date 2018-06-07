#ifndef MODULOTAREAS_H
#define MODULOTAREAS_H

#include <QAbstractListModel>


class Tareas
{
public:
   Q_INVOKABLE Tareas(const qlonglong &idReclamo, const qlonglong &codigoTarea
                        ,const QString &nombreTarea,const QString &fechaTarea,const QString &horaTarea,const QString &comentarioTarea
                        );

    qlonglong idReclamo() const;
    qlonglong codigoTarea() const;
    QString nombreTarea() const;
    QString fechaTarea() const;
    QString horaTarea() const;
    QString comentarioTarea() const;

private:
    qlonglong m_idReclamo ;
    qlonglong m_codigoTarea ;
    QString m_nombreTarea ;

    QString m_fechaTarea ;
    QString m_horaTarea ;
    QString m_comentarioTarea ;

};

class ModuloTareas : public QAbstractListModel
{
    Q_OBJECT
public:
    enum TareasRoles {
        idReclamoRole = Qt::UserRole + 1,
        codigoTareaRole,
        nombreTareaRole,
        fechaTareaRole,
        horaTareaRole,
        comentarioTareaRole
    };

    ModuloTareas(QObject *parent = 0);

    Q_INVOKABLE void agregarTareas(const Tareas &Tareas);

    Q_INVOKABLE void limpiarListaTareas();

    Q_INVOKABLE int rowCount(const QModelIndex & parent = QModelIndex()) const;

    Q_INVOKABLE QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    Q_INVOKABLE void buscarTareas(QString );

private:
    QList<Tareas> m_Tareas;
};

#endif // MODULOTAREAS_H
