/****************************************************************************
** Meta object code from reading C++ file 'moduloperfilestiemporesolucion.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.7)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "moduloperfilestiemporesolucion.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'moduloperfilestiemporesolucion.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.7. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ModuloPerfilesTiempoResolucion[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      57,   32,   31,   31, 0x02,
      91,   31,   31,   31, 0x02,
     117,  110,  106,   31, 0x02,
     139,   31,  106,   31, 0x22,
     170,  159,  150,   31, 0x02,
     198,  192,  150,   31, 0x22,
     216,   31,   31,   31, 0x02,
     240,  233,  225,   31, 0x02,
     284,  233,  225,   31, 0x02,
     395,  333,  328,   31, 0x02,
     426,   31,  225,   31, 0x02,
     446,  333,  328,   31, 0x02,
     510,  479,  328,   31, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ModuloPerfilesTiempoResolucion[] = {
    "ModuloPerfilesTiempoResolucion\0\0"
    "PerfilesTiempoResolucion\0"
    "agregar(PerfilesTiempoResolucion)\0"
    "limpiarLista()\0int\0parent\0"
    "rowCount(QModelIndex)\0rowCount()\0"
    "QVariant\0index,role\0data(QModelIndex,int)\0"
    "index\0data(QModelIndex)\0buscar()\0"
    "QString\0indice\0"
    "retornarCodigoPerfilesTiempoResolucion(int)\0"
    "retornarNombrePerfilesTiempoResolucion(int)\0"
    "bool\0codigoPerfilesTiempoResolucion,nombrePerfilesTiempoResolucion\0"
    "guardarFiltro(QString,QString)\0"
    "nuevoCodigoFiltro()\0"
    "mensajePregunta(QString,QString)\0"
    "codigoPerfilesTiempoResolucion\0"
    "eliminarFiltro(QString)\0"
};

void ModuloPerfilesTiempoResolucion::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ModuloPerfilesTiempoResolucion *_t = static_cast<ModuloPerfilesTiempoResolucion *>(_o);
        switch (_id) {
        case 0: _t->agregar((*reinterpret_cast< const PerfilesTiempoResolucion(*)>(_a[1]))); break;
        case 1: _t->limpiarLista(); break;
        case 2: { int _r = _t->rowCount((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 3: { int _r = _t->rowCount();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 4: { QVariant _r = _t->data((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 5: { QVariant _r = _t->data((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 6: _t->buscar(); break;
        case 7: { QString _r = _t->retornarCodigoPerfilesTiempoResolucion((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 8: { QString _r = _t->retornarNombrePerfilesTiempoResolucion((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 9: { bool _r = _t->guardarFiltro((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 10: { QString _r = _t->nuevoCodigoFiltro();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 11: { bool _r = _t->mensajePregunta((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 12: { bool _r = _t->eliminarFiltro((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ModuloPerfilesTiempoResolucion::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ModuloPerfilesTiempoResolucion::staticMetaObject = {
    { &QAbstractListModel::staticMetaObject, qt_meta_stringdata_ModuloPerfilesTiempoResolucion,
      qt_meta_data_ModuloPerfilesTiempoResolucion, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ModuloPerfilesTiempoResolucion::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ModuloPerfilesTiempoResolucion::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ModuloPerfilesTiempoResolucion::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ModuloPerfilesTiempoResolucion))
        return static_cast<void*>(const_cast< ModuloPerfilesTiempoResolucion*>(this));
    return QAbstractListModel::qt_metacast(_clname);
}

int ModuloPerfilesTiempoResolucion::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
