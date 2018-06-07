/****************************************************************************
** Meta object code from reading C++ file 'moduloanios.h'
**
** Created: Wed Aug 21 13:42:57 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "moduloanios.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'moduloanios.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ModuloAnios[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      19,   13,   12,   12, 0x02,
      38,   12,   12,   12, 0x02,
      69,   62,   58,   12, 0x02,
      91,   12,   58,   12, 0x22,
     122,  111,  102,   12, 0x02,
     150,  144,  102,   12, 0x22,
     168,   12,   12,   12, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ModuloAnios[] = {
    "ModuloAnios\0\0Anios\0agregarAnio(Anios)\0"
    "limpiarListaAnios()\0int\0parent\0"
    "rowCount(QModelIndex)\0rowCount()\0"
    "QVariant\0index,role\0data(QModelIndex,int)\0"
    "index\0data(QModelIndex)\0buscarAnios()\0"
};

void ModuloAnios::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ModuloAnios *_t = static_cast<ModuloAnios *>(_o);
        switch (_id) {
        case 0: _t->agregarAnio((*reinterpret_cast< const Anios(*)>(_a[1]))); break;
        case 1: _t->limpiarListaAnios(); break;
        case 2: { int _r = _t->rowCount((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 3: { int _r = _t->rowCount();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 4: { QVariant _r = _t->data((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 5: { QVariant _r = _t->data((*reinterpret_cast< const QModelIndex(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 6: _t->buscarAnios(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ModuloAnios::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ModuloAnios::staticMetaObject = {
    { &QAbstractListModel::staticMetaObject, qt_meta_stringdata_ModuloAnios,
      qt_meta_data_ModuloAnios, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ModuloAnios::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ModuloAnios::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ModuloAnios::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ModuloAnios))
        return static_cast<void*>(const_cast< ModuloAnios*>(this));
    return QAbstractListModel::qt_metacast(_clname);
}

int ModuloAnios::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
