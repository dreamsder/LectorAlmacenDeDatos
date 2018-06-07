#include <QApplication>
#include "qmlapplicationviewer.h"
#include <QTextCodec>
#include <moduloreclamos.h>
#include <modulotareas.h>
#include "QDeclarativeContext"
#include <Utilidades/configuracionxml.h>
#include <QMessageBox>
#include <QSqlDatabase>
#include <QTime>
#include <QDebug>
#include <QFile>
#include <QIcon>
#include <moduloreportes.h>
#include <moduloperfilestiemporesolucion.h>
#include <moduloperfilestiemporesoluciondetalle.h>
#include <Utilidades/database.h>
#include <QSqlQuery>


Q_DECL_EXPORT int main(int argc, char *argv[])
{

    QApplication::setGraphicsSystem("raster");

    ////Codificacion del sistema para aceptar tildes y ñ
    QTextCodec *linuxCodec=QTextCodec::codecForName("UTF-8");
    QTextCodec::setCodecForTr(linuxCodec);
    QTextCodec::setCodecForCStrings(linuxCodec);
    QTextCodec::setCodecForLocale(linuxCodec);

    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QmlApplicationViewer viewer;

    viewer.setMinimumWidth(1024);
    viewer.setMinimumHeight(720);

    viewer.setWindowIcon(QIcon("icono.png"));

    ModuloReclamos moduloReclamos;
    ModuloReclamos moduloListaItemsBotones;

    ModuloTareas moduloTareas;
    ModuloReportes moduloReportes;    

    ModuloPerfilesTiempoResolucion moduloPerfilesTiempoResolucion;

    ModuloPerfilesTiempoResolucionDetalle moduloPerfilesTiempoResolucionDetalle;


    if (QSqlDatabase::isDriverAvailable("QMYSQL")==false) {
        QMessageBox men;
        men.setText("No se encontro el driver QMYSQL (libqt4-sql-mysql)\nLa aplicación se cerrara.");
        men.exec();
        exit(0);
    }else{
        if(!ConfiguracionXml::leerConfiguracionXml()){
            QMessageBox men;
            men.setText("No se puede leer la configuración de acceso a la base de datos.\nVerifique la instalación");
            men.exec();
            exit(0);
        }else{

            if(!Database::connect("local").isOpen()){
                if(!Database::connect("local").open()){
                    qDebug() << "No conecto";
                }
            }
            Database::consultaSql("SET GLOBAL sql_mode = ''","local");
        }
    }


    viewer.rootContext()->setContextProperty("modeloReclamosItemsBotones", &moduloListaItemsBotones);
    viewer.rootContext()->setContextProperty("modeloReclamos", &moduloReclamos);
    viewer.rootContext()->setContextProperty("modeloTareas", &moduloTareas);
    viewer.rootContext()->setContextProperty("modeloReportes", &moduloReportes);
    viewer.rootContext()->setContextProperty("modeloPerfilesTiempoResolucion", &moduloPerfilesTiempoResolucion);

    viewer.rootContext()->setContextProperty("modeloPerfilesTiempoResolucionDetalle", &moduloPerfilesTiempoResolucionDetalle);



    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setSource(QUrl("qrc:/qml/LectorAlmacenDeDatos/main.qml"));
    //viewer.showMaximized();
    viewer.showNormal();
    viewer.setWindowTitle("Lector de almacén de datos");


    return app->exec();
}
