// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "Controles"
import "Delegados"

Rectangle {
    id: rectContenedorConfiguracionTiemposRespuesta
    width: 900
    height: 600
    opacity: mouse_area3.pressed ? "0.5" : "1"
    radius: 5
  /*
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#535151"
        }

        GradientStop {
            position: 1
            color: "#959595"
        }
    }

*/
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#535151"
        }

        GradientStop {
            position: 1
            color: "#959595"
        }
    }

    clip: true
    smooth: true
    visible: true
    z: 10


    function cargarPerfiles(){

        modeloPerfilesTiempoResolucion.limpiarLista()
        modeloPerfilesTiempoResolucion.buscar()

        if(modeloPerfilesTiempoResolucion.rowCount()!==0){

            modeloPerfilesTiempoResolucionVirtual.clear()

            for(var i=0; i < modeloPerfilesTiempoResolucion.rowCount();i++){

                modeloPerfilesTiempoResolucionVirtual.append({codigoPerfilesTiempoResolucion:modeloPerfilesTiempoResolucion.retornarCodigoPerfilesTiempoResolucion(i),
                                                              nombrePerfilesTiempoResolucion:modeloPerfilesTiempoResolucion.retornarNombrePerfilesTiempoResolucion(i),
                                                              textoTiempoClienteTerceros: modeloPerfilesTiempoResolucion.retornarTextoTiempoClienteTerceros(i),
                                                              indice: i
                                                             })

            }
        }

    }

    MouseArea {
        id: mouse_area1
        x: 0
        y: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        clip: false
        anchors.fill: parent
    }


    BotonSimple {
        id: btnCerrarVentanaConfiguracionTiempos
        opacidadRectangulo: 0.100
        opacidadTexto: 1
        colorTextoBoton: "#f79963"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        estaPrecionado: false
        estilo: 0
        textoBoton: "Cerrar"
        negrita: true
        modoBotonPrecionado: false
        z: 7
        onClicBoton: {
            rectContenedorConfiguracionTiemposRespuesta.visible=false
        }
    }

    Rectangle {
        id: rectContenedorRegistros
        x: -8
        color: "#00000000"
        radius: 0
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottomMargin: 18
        anchors.bottom: parent.bottom
        z: 5
        clip: false
        anchors.leftMargin: 10
        ListView {
            id: listaFiltros
            orientation: ListView.Vertical
            layoutDirection: Qt.LeftToRight
            anchors.fill: parent
            highlightRangeMode: ListView.NoHighlightRange
            boundsBehavior: Flickable.DragOverBounds
            highlightFollowsCurrentItem: true
            highlightMoveSpeed: 20
            delegate: Delegate_ListaItemsConfiguracionTiempoResolucion {


                onDobleClick: {



                    mostrarReportewww()

                }

            }
            snapMode: ListView.SnapToItem
            highlightResizeSpeed: 20
            spacing: 5
            clip: true
            flickableDirection: Flickable.VerticalFlick
            keyNavigationWraps: true
            interactive: true
            smooth: true
            model: modeloPerfilesTiempoResolucionVirtual
            //modeloPerfilesTiempoResolucion

            Component.onCompleted: {

                cargarPerfiles()

            }

        }




        ListModel{
            id:modeloPerfilesTiempoResolucionVirtual
        }




        Rectangle {
            id: rectScrollbar
            width: 14
            color: "#00ffffff"
            radius: 6
            anchors.left: parent.left
            anchors.leftMargin: -15
            smooth: true
            clip: true
            anchors.top: parent.top
            anchors.topMargin: 0
            Rectangle {
                id: scrollbarFiltros
                x: 2
                y: listaFiltros.visibleArea.yPosition * listaFiltros.height+3
                width: 5
                height: listaFiltros.visibleArea.heightRatio * listaFiltros.height-30
                color: "#ffffff"
                radius: 3
                smooth: true
                visible: true
                anchors.rightMargin: 2
                z: 2
                anchors.right: parent.right
                opacity: 0.500
            }
            anchors.bottom: parent.bottom
            visible: true
            anchors.bottomMargin: 20
            z: 6
            opacity: 1
        }
        anchors.left: parent.left
        smooth: true
        anchors.topMargin: 115
        anchors.rightMargin: 10
    }

    MouseArea {
        id: mouse_area3
        z: 6
        anchors.bottom: rectContenedorRegistros.top
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        drag.target: rectContenedorConfiguracionTiemposRespuesta
    }

    BotonSimple {
        id: btnNuevoFiltroConfiguracionTiempoResolucion
        x: 6
        y: 9
        anchors.left: parent.left
        anchors.topMargin: 15
        colorTextoBoton: "#f79963"
        negrita: true
        opacidadRectangulo: 0.1
        anchors.leftMargin: 10
        estilo: 0
        opacidadTexto: 1
        z: 7
        textoBoton: "Nuevo filtro"
        estaPrecionado: false
        visible: modeloReclamos.accesoCompleto()
        modoBotonPrecionado: false
        anchors.top: btnCerrarVentanaConfiguracionTiempos.bottom
        onClicBoton: {

            modeloPerfilesTiempoResolucionVirtual.insert(0, {"codigoPerfilesTiempoResolucion": "999999999","nombrePerfilesTiempoResolucion":"nuevo filtro"})

        }
    }

    Image {
        id: image1
        opacity: 1
        anchors.leftMargin: 200
        anchors.topMargin: 200
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        smooth: true
        asynchronous: true
        source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FondoFiltro2.png"

        Text {
            id: lblTextoInformativofiltro
            color: "#75e0ef"
            text: qsTr("* Desde aquí puede seleccionar el filtro que luego se aplicará en el reporte, para definir las horas del tiempo de resolución.\n\n* Dando doble clic sobre el filtro, el reporte será cargado con dichos seteos.\n\n* Si es un usuario con permisos podrá modificar estos filtro o agregar nuevos para adaptarlo a sus necesidades.")
            styleColor: "#000000"
            verticalAlignment: Text.AlignTop
            style: Text.Outline
            wrapMode: Text.WordWrap
            clip: true
            anchors.left: parent.left
            anchors.leftMargin: 200
            font.family: "Arial"
            font.bold: true
            horizontalAlignment: Text.AlignRight
            anchors.top: parent.top
            smooth: true
            anchors.topMargin: -150
            anchors.right: parent.right
            anchors.rightMargin: 50
            font.pixelSize: 23
        }
    }

    Rectangle {
        id: rectangle1
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: btnNuevoFiltroConfiguracionTiempoResolucion.bottom
        anchors.topMargin: 5
        anchors.bottom: rectContenedorRegistros.top
        anchors.bottomMargin: 5
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }
            GradientStop {
                position: 0.440
                color: "#423c7a"
            }
        }
        smooth: true
    }
}


