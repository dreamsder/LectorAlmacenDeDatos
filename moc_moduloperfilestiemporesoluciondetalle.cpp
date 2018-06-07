/****************************************************************************
** Meta object code from reading C++ file 'moduloperfilestiemporesoluciondetalle.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.7)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "moduloperfilestiemporesoluciondetalle.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'moduloperfilestiemporesoluciondetalle.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.7. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ModuloPerfilesTiempoResolucionDetalle[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      71,   39,   38,   38, 0x02,
     112,   38,   38,   38, 0x02,
     138,  131,  127,   38, 0x02,
     160,   38,  127,   38, 0x22,
     191,  180,  171,   38, 0x02,
     219,  213,  171,   38, 0x22,
     268,  237,   38,   38, 0x02,
     347,  289,  284,   38, 0x02,
     378,  237,  284,   38, 0x02,
     417,  410,  402,   38, 0x02,
     461,  410,  402,   38, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ModuloPerfilesTiempoResolucionDetalle[] = {
    "ModuloPerfilesTiempoResolucionDetalle\0"
    "\0PerfilesTiempoResolucionDetalle\0"
    "agregar(PerfilesTiempoResolucionDetalle)\0"
    "limpiarLista()\0int\0parent\0"
    "rowCount(QModelIndex)\0rowCount()\0"
    "QVariant\0index,role\0data(QModelIndex,int)\0"
    "index\0data(QModelIndex)\0"
    "codigoPerfilesTiempoResolucion\0"
    "buscar(QString)\0bool\0"
    "codigoPerfilesTiempoResolucion,codigoItemTiempoResolucion\0"
    "guardarFiltro(QString,QString)\0"
    "eliminarFiltro(QString)\0QString\0indice\0"
    "retornarCodigoPerfilesTiempoResolucion(int)\0"
    "retornarCodigoItemTiempoResolucion(int)\0"
};

void ModuloPerfilesTiempoResolucionDetalle::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ModuloPerfilesTiempoResolucionDetalle *_t = static_cast<ModuloPerfilesTiempoResolucionDetalle *>(_o);
        switch (_id) {
        case 0: _t->agregar((*reinterpret_cast< const PerfilesTiempoResolucionDetalle(*)>(_a[1]))); break;
        case 1: _t->limpiarLista(); break;
        case 2: { int _r = _t->rowCount((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 3: { int _r = _t->rowCount();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 4: { QVariant _r = _t->data((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 5: { QVariant _r = _t->data((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 6: _t->buscar((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: { bool _r = _t->guardarFiltro((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 8: { bool _r = _t->eliminarFiltro((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 9: { QString _r = _t->retornarCodigoPerfilesTiempoResolucion((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 10: { QString _r = _t->retornarCodigoItemTiempoResolucion((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ModuloPerfilesTiempoResolucionDetalle::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ModuloPerfilesTiempoResolucionDetalle::staticMetaObject = {
    { &QAbstractListModel::staticMetaObject, qt_meta_stringdata_ModuloPerfilesTiempoResolucionDetalle,
      qt_meta_data_ModuloPerfilesTiempoResolucionDetalle, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ModuloPerfilesTiempoResolucionDetalle::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ModuloPerfilesTiempoResolucionDetalle::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ModuloPerfilesTiempoResolucionDetalle::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ModuloPerfilesTiempoResolucionDetalle))
        return static_cast<void*>(const_cast< ModuloPerfilesTiempoResolucionDetalle*>(this));
    return QAbstractListModel::qt_metacast(_clname);
}

int ModuloPerfilesTiempoResolucionDetalle::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
