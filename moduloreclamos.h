#ifndef MODULORECLAMOS_H
#define MODULORECLAMOS_H

#include <QAbstractListModel>

class Reclamos
{
public:
    Q_INVOKABLE Reclamos(const QString &campoComodin, const int &asistencias
                         ,const QString &tiempoMesaEntrada,const QString &tiempoEstadoNuevo
                         ,const QString &tiempoEstadoAsignado,const QString &tiempoEsperaRespuestaCliente
                         ,const QString &tiempoEsperaRespuestaObjetos,const QString &tiempoTareas
                         ,const QString &tiempoResolucion ,const QString &primerFiltroControl
                         ,const QString &segundoFiltroControl,const QString &opcional,const QString &opcional2
                         ,const QString &tiempoEsperaRespuestaClienteHorarioSisteco


                         ,const QString &tiempoMesaEntradaCrudo
                         ,const QString &tiempoEstadoNuevoCrudo
                         ,const QString &tiempoEstadoAsignadoCrudo
                         ,const QString &tiempoEsperaRespuestaClienteCrudo
                         ,const QString &tiempoEsperaRespuestaObjetosCrudo
                         ,const QString &tiempoTareasCrudo
                         ,const QString &tiempoResolucionCrudo

                         );

    QString campoComodin() const;
    int asistencias() const;
    QString tiempoMesaEntrada() const;
    QString tiempoEstadoNuevo() const;
    QString tiempoEstadoAsignado() const;
    QString tiempoEsperaRespuestaCliente() const;
    QString tiempoEsperaRespuestaObjetos() const;
    QString tiempoTareas() const;
    QString tiempoResolucion() const;
    QString primerFiltroControl()const;
    QString segundoFiltroControl()const;
    QString opcional() const;
    QString opcional2() const;
    QString tiempoEsperaRespuestaClienteHorarioSisteco() const;

    QString tiempoMesaEntradaCrudo() const;
    QString tiempoEstadoNuevoCrudo() const;
    QString tiempoEstadoAsignadoCrudo() const;
    QString tiempoEsperaRespuestaClienteCrudo() const;
    QString tiempoEsperaRespuestaObjetosCrudo() const;
    QString tiempoTareasCrudo() const;
    QString tiempoResolucionCrudo() const;


private:

    QString m_campoComodin ;
    int m_asistencias ;
    QString m_tiempoMesaEntrada ;
    QString m_tiempoEstadoNuevo ;
    QString m_tiempoEstadoAsignado;
    QString m_tiempoEsperaRespuestaCliente;
    QString m_tiempoEsperaRespuestaObjetos;
    QString m_tiempoTareas;
    QString m_tiempoResolucion;
    QString m_primerFiltroControl;
    QString m_segundoFiltroControl;
    QString m_opcional;
    QString m_opcional2;
    QString m_tiempoEsperaRespuestaClienteHorarioSisteco;

    QString m_tiempoMesaEntradaCrudo ;
    QString m_tiempoEstadoNuevoCrudo ;
    QString m_tiempoEstadoAsignadoCrudo ;
    QString m_tiempoEsperaRespuestaClienteCrudo ;
    QString m_tiempoEsperaRespuestaObjetosCrudo ;
    QString m_tiempoTareasCrudo ;
    QString m_tiempoResolucionCrudo ;
};

class ModuloReclamos : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ReclamosRoles {
        CampoComodinRole = Qt::UserRole + 1,
        AsistenciasRole,
        TiempoMesaEntradaRole,
        TiempoEstadoNuevoRole,
        TiempoEstadoAsignadoRole,
        TiempoEsperaRespuestaClienteRole,
        TiempoEsperaRespuestaObjetosRole,
        TiempoTareasRole,
        TiempoResolucionRole,
        primerFiltroControlRole,
        segundoFiltroControlRole,
        OpcionalRole,
        Opcional2Role,
        TiempoEsperaRespuestaClienteHorarioSistecoRole
    //    TiempoEstadoNuevoCrudoRole

    };

    ModuloReclamos(QObject *parent = 0);

    Q_INVOKABLE void agregarReclamo(const Reclamos &Reclamos);

    Q_INVOKABLE void limpiarListaReclamos();

    Q_INVOKABLE int rowCount(const QModelIndex & parent = QModelIndex()) const;

    Q_INVOKABLE QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    Q_INVOKABLE bool buscarReclamos(QString);

    Q_INVOKABLE bool retornarEstadoDeComparacionDeString(QString,QString) const;


    Q_INVOKABLE QString retornarNombreDelMes(int) const;
    Q_INVOKABLE QString retornarNombreDelDiaDeSemana(int) const;

    Q_INVOKABLE bool retornarSiCausaEsAtribuibleACliente(QString)const;

    Q_INVOKABLE QString retornaTituloReclamo(QString )const;
    Q_INVOKABLE QString retornaTecnicoReclamo(QString )const;
    Q_INVOKABLE QString retornaClienteSucursalReclamo(QString )const;
    Q_INVOKABLE QString retornaMarcaTipoModeloReclamo(QString )const;


    Q_INVOKABLE QString retornarNombreCliente(QString) const;
    Q_INVOKABLE QString retornarNombreMarca(QString) const;
    Q_INVOKABLE QString retornarNombreModelo(QString) const;
    Q_INVOKABLE QString retornarNombreTecnicoResponsable(QString) const;
    Q_INVOKABLE QString retornarNombreArea(QString) const;
    Q_INVOKABLE QString retornarNombreTipoReclamo(QString) const;
    Q_INVOKABLE QString retornarNombreTareas(QString)const;
    Q_INVOKABLE QString retornarNombreConceptos(QString)const;


    Q_INVOKABLE QString retornarNombreCausa(QString) const;
    Q_INVOKABLE QString retornarNombreDepartamento(QString) const;

    Q_INVOKABLE QString retornarNombreCoordinado(QString)const;
    Q_INVOKABLE QString retornarNombreCamino(QString)const;
    Q_INVOKABLE QString retornarNombreSintoma(QString)const;

    Q_INVOKABLE QString retornarNombreTipoReclamoCliente(QString)const;






    Q_INVOKABLE QString retornarNombreSucursal(QString, QString) const;

    Q_INVOKABLE QString retornaReclamosDeTareas(QString) const;
    Q_INVOKABLE QString retornaReclamosDeConceptos(QString)const;


    Q_INVOKABLE QString retornarCampoComodin(int) const;
    Q_INVOKABLE int retornarAsistencias(int) const;
    Q_INVOKABLE QString retornarTiempoMesaEntrada(int) const;
    Q_INVOKABLE QString retornarTiempoEstadoNuevo(int) const;
    Q_INVOKABLE QString retornarTiempoEstadoAsignado(int) const;
    Q_INVOKABLE QString retornarTiempoEsperaRespuestaCliente(int) const;
    Q_INVOKABLE QString retornarTiempoEsperaRespuestaObjetos(int) const;
    Q_INVOKABLE QString retornarOpcional(int) const;
    Q_INVOKABLE QString retornarOpcional2(int) const;
    Q_INVOKABLE QString retornarTiempoEsperaRespuestaClienteHorarioSisteco(int) const;

    Q_INVOKABLE QString retornarTiempoTareas(int) const;
    Q_INVOKABLE QString retornarTiempoResolucion(int) const;
    Q_INVOKABLE QString retornarPrimerFiltroControl(int) const;
    Q_INVOKABLE QString retornarSegundoFiltroControl(int) const;

    Q_INVOKABLE QString retornarTiempoEstadoNuevoCrudo(int) const;
    Q_INVOKABLE QString retornarTiempoEstadoAsignadoCrudo(int) const;
    Q_INVOKABLE QString retornarTiempoEsperaRespuestaClienteCrudo(int) const;
    Q_INVOKABLE QString retornarTiempoEsperaRespuestaObjetosCrudo(int) const;

    Q_INVOKABLE QString retornarTiempoTareasCrudo(int) const;
    Q_INVOKABLE QString retornarTiempoResolucionCrudo(int) const;
    Q_INVOKABLE QString retornarTiempoResolucionTotalCrudo(int) const;


   Q_INVOKABLE QString retornarTiempoTotal(int ,int ) const;


    Q_INVOKABLE bool estadoConexionLocal();



   Q_INVOKABLE void abrirPaginaWeb(QString)const;


   Q_INVOKABLE bool accesoCompleto()const;




private:
    QList<Reclamos> m_Reclamos;
};


#endif // MODULORECLAMOS_H
