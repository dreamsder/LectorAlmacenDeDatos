#ifndef MODULOPERFILESTIEMPORESOLUCION_H
#define MODULOPERFILESTIEMPORESOLUCION_H

#include <QAbstractListModel>



class PerfilesTiempoResolucion
{
public:
   Q_INVOKABLE PerfilesTiempoResolucion(const QString &codigoPerfilesTiempoResolucion, const QString &nombrePerfilesTiempoResolucion);

    QString codigoPerfilesTiempoResolucion() const;
    QString nombrePerfilesTiempoResolucion() const;

private:
    QString m_codigoPerfilesTiempoResolucion ;
    QString m_nombrePerfilesTiempoResolucion ;


};

class ModuloPerfilesTiempoResolucion : public QAbstractListModel
{
    Q_OBJECT
public:
    enum PerfilesTiempoResolucionRoles {
        codigoPerfilesTiempoResolucionRole = Qt::UserRole + 1,
        nombrePerfilesTiempoResolucionRole
    };

    ModuloPerfilesTiempoResolucion(QObject *parent = 0);

    Q_INVOKABLE void agregar(const PerfilesTiempoResolucion &PerfilesTiempoResolucion);

    Q_INVOKABLE void limpiarLista();

    Q_INVOKABLE int rowCount(const QModelIndex & parent = QModelIndex()) const;

    Q_INVOKABLE QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    Q_INVOKABLE void buscar();

    Q_INVOKABLE QString retornarCodigoPerfilesTiempoResolucion(int indice) const;

    Q_INVOKABLE QString retornarNombrePerfilesTiempoResolucion(int indice) const;

    Q_INVOKABLE bool guardarFiltro(QString codigoPerfilesTiempoResolucion,QString nombrePerfilesTiempoResolucion) const;

    Q_INVOKABLE QString nuevoCodigoFiltro()const;

    Q_INVOKABLE bool mensajePregunta(QString codigoPerfilesTiempoResolucion,QString nombrePerfilesTiempoResolucion)const;

    Q_INVOKABLE bool eliminarFiltro(QString codigoPerfilesTiempoResolucion) const;

private:
    QList<PerfilesTiempoResolucion> m_PerfilesTiempoResolucion;
};




#endif // MODULOPERFILESTIEMPORESOLUCION_H
