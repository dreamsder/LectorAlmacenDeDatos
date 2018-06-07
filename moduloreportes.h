#ifndef MODULOREPORTES_H
#define MODULOREPORTES_H

#include <QObject>

class ModuloReportes : public QObject
{
    Q_OBJECT
public:
    explicit ModuloReportes(QObject *parent = 0);

    Q_INVOKABLE QString retornaDirectorioReporteWeb() const;
    Q_INVOKABLE QString retornaDirectorioReporteWebSinLinks() const;

    Q_INVOKABLE QString generarReporte(QString, bool, bool, bool, bool, bool, QString, bool ) const;

    QString retornaDirectorioPDF() const;
    QString retornaDirectorioBanner() const;



    QString retornaDirectorioEstiloCssPDF() const;
    QString retornaDirectorioEstiloCssHTML() const;

    Q_INVOKABLE bool imprimirReporteEnPDF(QString)const;
    Q_INVOKABLE QString retornaNombreReportePDF(QString ) const;



    Q_INVOKABLE void abrirNavegadorArchivos()const;



signals:
    
public slots:
    
};

#endif // MODULOREPORTES_H
