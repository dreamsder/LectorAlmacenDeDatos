/****************************************************************************
** Meta object code from reading C++ file 'moduloreportes.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.7)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "moduloreportes.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'moduloreportes.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.7. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ModuloReportes[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      24,   15,   16,   15, 0x02,
      54,   15,   16,   15, 0x02,
     101,   92,   16,   15, 0x02,
     176,   15,  171,   15, 0x02,
     206,   15,   16,   15, 0x02,
     239,   15,   15,   15, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ModuloReportes[] = {
    "ModuloReportes\0\0QString\0"
    "retornaDirectorioReporteWeb()\0"
    "retornaDirectorioReporteWebSinLinks()\0"
    ",,,,,,,,\0"
    "generarReporte(QString,bool,bool,bool,bool,bool,QString,bool,QString)\0"
    "bool\0imprimirReporteEnPDF(QString)\0"
    "retornaNombreReportePDF(QString)\0"
    "abrirNavegadorArchivos()\0"
};

void ModuloReportes::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ModuloReportes *_t = static_cast<ModuloReportes *>(_o);
        switch (_id) {
        case 0: { QString _r = _t->retornaDirectorioReporteWeb();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 1: { QString _r = _t->retornaDirectorioReporteWebSinLinks();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 2: { QString _r = _t->generarReporte((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3])),(*reinterpret_cast< bool(*)>(_a[4])),(*reinterpret_cast< bool(*)>(_a[5])),(*reinterpret_cast< bool(*)>(_a[6])),(*reinterpret_cast< QString(*)>(_a[7])),(*reinterpret_cast< bool(*)>(_a[8])),(*reinterpret_cast< QString(*)>(_a[9])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 3: { bool _r = _t->imprimirReporteEnPDF((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 4: { QString _r = _t->retornaNombreReportePDF((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 5: _t->abrirNavegadorArchivos(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ModuloReportes::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ModuloReportes::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ModuloReportes,
      qt_meta_data_ModuloReportes, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ModuloReportes::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ModuloReportes::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ModuloReportes::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ModuloReportes))
        return static_cast<void*>(const_cast< ModuloReportes*>(this));
    return QObject::qt_metacast(_clname);
}

int ModuloReportes::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
