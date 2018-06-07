#ifndef MODULOPERFILESTIEMPORESOLUCIONDETALLE_H
#define MODULOPERFILESTIEMPORESOLUCIONDETALLE_H

#include <QAbstractListModel>





class PerfilesTiempoResolucionDetalle
{
public:
   Q_INVOKABLE PerfilesTiempoResolucionDetalle(const QString &codigoPerfilesTiempoResolucion, const QString &codigoItemTiempoResolucion);

    QString codigoPerfilesTiempoResolucion() const;
    QString codigoItemTiempoResolucion() const;

private:
    QString m_codigoPerfilesTiempoResolucion ;
    QString m_codigoItemTiempoResolucion ;


};

class ModuloPerfilesTiempoResolucionDetalle : public QAbstractListModel
{
    Q_OBJECT
public:
    enum PerfilesTiempoResolucionDetalleRoles {
        codigoPerfilesTiempoResolucionRole = Qt::UserRole + 1,
        codigoItemTiempoResolucionRole
    };

    ModuloPerfilesTiempoResolucionDetalle(QObject *parent = 0);

    Q_INVOKABLE void agregar(const PerfilesTiempoResolucionDetalle &PerfilesTiempoResolucionDetalle);

    Q_INVOKABLE void limpiarLista();

    Q_INVOKABLE int rowCount(const QModelIndex & parent = QModelIndex()) const;

    Q_INVOKABLE QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    Q_INVOKABLE void buscar(QString codigoPerfilesTiempoResolucion);

    Q_INVOKABLE bool guardarFiltro(QString codigoPerfilesTiempoResolucion,QString codigoItemTiempoResolucion) const;

    Q_INVOKABLE bool eliminarFiltro(QString codigoPerfilesTiempoResolucion) const;


    Q_INVOKABLE QString retornarCodigoPerfilesTiempoResolucion(int indice) const;
    Q_INVOKABLE QString retornarCodigoItemTiempoResolucion(int indice) const;




private:
    QList<PerfilesTiempoResolucionDetalle> m_PerfilesTiempoResolucionDetalle;
};






#endif // MODULOPERFILESTIEMPORESOLUCIONDETALLE_H
