#include "database.h"
#include "QSqlQuery"
#include "QSqlRecord"
#include <Utilidades/configuracionxml.h>
#include <QSqlError>
#include <QDebug>

static QSqlDatabase dbconLocal= QSqlDatabase::addDatabase("QMYSQL","Local");
static QSqlDatabase dbcon= QSqlDatabase::addDatabase("QMYSQL","Remota");
static QSqlQuery resultadoConsulta;
static QSqlRecord rec;

Database::Database()
{}

QSqlDatabase Database::connect(QString _instancia) {

    if(_instancia=="local"){
        dbconLocal.setPort(ConfiguracionXml::getPuertoLocal());
        dbconLocal.setHostName(ConfiguracionXml::getHostLocal());
        dbconLocal.setDatabaseName(ConfiguracionXml::getBaseLocal());
        dbconLocal.setUserName(ConfiguracionXml::getUsuarioLocal());
        dbconLocal.setPassword(ConfiguracionXml::getClaveLocal());
        return dbconLocal;
    }else{
        dbcon.setPort(ConfiguracionXml::getPuertoRemoto());
        dbcon.setHostName(ConfiguracionXml::getHostRemoto());
        dbcon.setDatabaseName(ConfiguracionXml::getBaseRemoto());
        dbcon.setUserName(ConfiguracionXml::getUsuarioRemoto());
        dbcon.setPassword(ConfiguracionXml::getClaveRemoto());
        return dbcon;
    }


}

bool Database::cehqueStatusAccesoMysql(QString _tipoConexion) {

    if(!Database::connect(_tipoConexion).isOpen()){
        if(!Database::connect(_tipoConexion).open()){
            Database::connect(_tipoConexion).close();
            return false;
        }else{
            //"SET GLOBAL sql_mode = ''"
            //QSqlQuery query = Database::consultaSql("SET GLOBAL sql_mode = ''",_tipoConexion);
            QSqlQuery query = Database::consultaSql("select 1",_tipoConexion);
            if(query.first()) {
                return true;
            }else{
                Database::connect(_tipoConexion).close();
                return false;
            }
        }
    }else{
        //QSqlQuery query = Database::consultaSql("SET GLOBAL sql_mode = ''",_tipoConexion);
        QSqlQuery query = Database::consultaSql("select 1;",_tipoConexion);
        if(query.first()) {
            return true;
        }else{
            Database::connect(_tipoConexion).close();
            return false;
        }
    }
}


void Database::closeDb() {
    QSqlDatabase::removeDatabase("QMYSQL");
}

QSqlQuery Database::consultaSql(QString _consulta,QString _instancia){

    if(_instancia=="local"){
        resultadoConsulta = dbconLocal.exec(_consulta);
    }else{
        resultadoConsulta = dbcon.exec(_consulta);
    }
    rec = resultadoConsulta.record();
    return resultadoConsulta;
}
