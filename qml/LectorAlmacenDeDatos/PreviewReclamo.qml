// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtWebKit 1.1
import "Controles"
import "Delegados"

Rectangle {
    id: rectContenedorTareas
    width: 900
    height: 650
    opacity: mouse_area3.pressed ? "0.5" : "1"
    radius: 5
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
    visible: false
    z: 10

    function cargarWeb(){

            web_viewReclamoWeb.url="http://www.sistecoonline.com/madai/recXPerfilModificar.php?idReclamo="+txtCodigoReclamoSeleccionado.text.trim();
    }


    function cargarTareasDeReclamo(codigoDeReclamoParaTareas){
        txtCodigoReclamoSeleccionado.text=codigoDeReclamoParaTareas
        txtTituloReclamoSeleccionado.text=modeloReclamos.retornaTituloReclamo(codigoDeReclamoParaTareas)
        txtTecnicoSeleccionado.text=modeloReclamos.retornaTecnicoReclamo(codigoDeReclamoParaTareas)
        txtClienteSucursalSeleccionado.text=modeloReclamos.retornaClienteSucursalReclamo(codigoDeReclamoParaTareas)
        txtMarcaTipoModeloSeleccionado.text=modeloReclamos.retornaMarcaTipoModeloReclamo(codigoDeReclamoParaTareas)
        modeloTareas.limpiarListaTareas()
        modeloTareas.buscarTareas(codigoDeReclamoParaTareas)
        rectContenedorTareas.visible=true
        cargarWeb()
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
/*
    Rectangle {
        id: rectangle1
        color: "#00000000"
        radius: 5
        clip: true
        border.width: 4
        border.color: "#eae7e7"
        anchors.bottomMargin: 0
        anchors.leftMargin: -1
        anchors.topMargin: -1
        z: -1
        anchors.fill: parent
        opacity: 1
        smooth: true
    }*/

    BotonSimple {
        id: btnCerrarListaDeTareas
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
            rectContenedorTareas.visible=false
        }
    }

    Rectangle {
        id: rectContenedorRegistrosTareas
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
            id: listaTareas
            anchors.fill: parent
            highlightRangeMode: ListView.NoHighlightRange
            boundsBehavior: Flickable.DragAndOvershootBounds
            highlightFollowsCurrentItem: true
            highlightMoveSpeed: 20
            delegate: Delegate_ListaTareas {}
            snapMode: ListView.NoSnap
            highlightResizeSpeed: 20
            spacing: 1
            clip: true
            flickableDirection: Flickable.VerticalFlick
            keyNavigationWraps: true
            interactive: true
            smooth: true
            model: modeloTareas
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
                id: scrollbarTareas
                x: 2
                y: listaTareas.visibleArea.yPosition * listaTareas.height+3
                width: 5
                height: listaTareas.visibleArea.heightRatio * listaTareas.height-30
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

    Text {
        id: lblCodigoReclamo
        color: "#ffffff"
        text: qsTr("Código de reclamo:")
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: btnCerrarListaDeTareas.right
        anchors.leftMargin: 20
        font.family: "Verdana"
        font.bold: false
        smooth: true
        font.pixelSize: 14
    }

    Text {
        id: lblDescripcionReclamo
        x: 1
        y: -7
        color: "#ffffff"
        text: qsTr("Título reclamo:")
        horizontalAlignment: Text.AlignLeft
        smooth: true
        font.pixelSize: 14
        anchors.top: lblCodigoReclamo.bottom
        anchors.topMargin: 4
        font.bold: false
        font.family: "Verdana"
        anchors.leftMargin: 20
        anchors.left: btnCerrarListaDeTareas.right
    }

    Text {
        id: txtCodigoReclamoSeleccionado
        color: "#ffffff"
        text: qsTr("")
        z: 8
        smooth: true
        font.pixelSize: 14
        font.underline: true
        anchors.top: parent.top
        anchors.topMargin: 5
        font.bold: true
        font.family: "Verdana"
        anchors.leftMargin: 12
        anchors.left: lblCodigoReclamo.right

        MouseArea{
            id:mouse_areaLinkCodigoReclamo
            hoverEnabled: true
            anchors.fill: parent
            onEntered: {
                   txtCodigoReclamoSeleccionado.color="cyan"
            }
            onExited: {
                txtCodigoReclamoSeleccionado.color="#ffffff"
            }
            onClicked: {
                modeloReclamos.abrirPaginaWeb("http://www.sistecoonline.com/madai/recXPerfilModificar.php?idReclamo="+txtCodigoReclamoSeleccionado.text.trim())
            }

        }
    }

    Text {
        id: txtTituloReclamoSeleccionado
        x: 8
        y: -15
        color: "#ffffff"
        text: qsTr("")
        clip: true
        anchors.right: parent.right
        anchors.rightMargin: 10
        smooth: true
        font.pixelSize: 14
        anchors.top: lblCodigoReclamo.bottom
        anchors.topMargin: 4
        font.family: "Verdana"
        font.bold: false
        anchors.leftMargin: 12
        horizontalAlignment: Text.AlignLeft
        anchors.left: lblCodigoReclamo.right
    }

    Text {
        id: lblNombreTecnico
        x: 10
        y: 0
        color: "#ffffff"
        text: qsTr("Tecnico responsable:")
        smooth: true
        font.pixelSize: 14
        anchors.top: txtTituloReclamoSeleccionado.bottom
        anchors.topMargin: 4
        font.bold: false
        font.family: "Verdana"
        horizontalAlignment: Text.AlignLeft
        anchors.leftMargin: 20
        anchors.left: btnCerrarListaDeTareas.right
    }

    Text {
        id: txtTecnicoSeleccionado
        x: 11
        y: -20
        color: "#ffffff"
        text: qsTr("")
        smooth: true
        font.pixelSize: 14
        anchors.top: lblDescripcionReclamo.bottom
        anchors.topMargin: 4
        font.family: "Verdana"
        font.bold: false
        anchors.leftMargin: 12
        horizontalAlignment: Text.AlignLeft
        anchors.left: lblCodigoReclamo.right
    }

    Text {
        id: lblCliente
        x: 19
        y: 0
        color: "#ffffff"
        text: qsTr("Cliente/Sucursal:")
        smooth: true
        font.pixelSize: 14
        anchors.top: lblNombreTecnico.bottom
        anchors.topMargin: 4
        font.family: "Verdana"
        font.bold: false
        anchors.leftMargin: 20
        horizontalAlignment: Text.AlignLeft
        anchors.left: btnCerrarListaDeTareas.right
    }

    Text {
        id: txtClienteSucursalSeleccionado
        x: 2
        y: -14
        color: "#ffffff"
        text: qsTr("")
        smooth: true
        font.pixelSize: 14
        anchors.top: txtTecnicoSeleccionado.bottom
        anchors.topMargin: 4
        font.bold: false
        font.family: "Verdana"
        horizontalAlignment: Text.AlignLeft
        anchors.leftMargin: 12
        anchors.left: lblCodigoReclamo.right
    }

    Text {
        id: lblMarcaModeloTipo
        x: 13
        y: 7
        color: "#ffffff"
        text: qsTr("Marca/Tipo/Modelo:")
        smooth: true
        font.pixelSize: 14
        anchors.top: lblCliente.bottom
        anchors.topMargin: 4
        font.bold: false
        font.family: "Verdana"
        horizontalAlignment: Text.AlignLeft
        anchors.leftMargin: 20
        anchors.left: btnCerrarListaDeTareas.right
    }

    Text {
        id: txtMarcaTipoModeloSeleccionado
        x: 7
        y: -20
        color: "#ffffff"
        text: qsTr("")
        smooth: true
        font.pixelSize: 14
        anchors.top: txtClienteSucursalSeleccionado.bottom
        anchors.topMargin: 4
        font.family: "Verdana"
        font.bold: false
        anchors.leftMargin: 12
        horizontalAlignment: Text.AlignLeft
        anchors.left: lblCodigoReclamo.right
    }

    MouseArea {
        id: mouse_area3
        z: 6
        anchors.bottom: rectContenedorRegistrosTareas.top
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        drag.target: rectContenedorTareas
    }

    Rectangle {
        id: rectangle3
        x: 5
        y: 225
        height: 12
        color: "#7d96c1"
        radius: 2
        visible: true
        rotation: 0
        opacity: 1
        clip: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        smooth: true
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.left: parent.left
        anchors.leftMargin: 2
        z: 10

        MouseArea {
            id: mouseAreaProtectorClicReporte
            visible: true
            anchors.fill: parent
            clip: true
            anchors.topMargin: 30
            anchors.rightMargin: 2
            anchors.bottomMargin: 2
            anchors.leftMargin: 2

            onWidthChanged: {

                web_viewReclamoWeb.preferredWidth=mouseAreaProtectorClicReporte.width
                flickableReclamosTareas.contentWidth=web_viewReclamoWeb.implicitWidth

            }
            onHeightChanged: {

                web_viewReclamoWeb.preferredHeight=mouseAreaProtectorClicReporte.height
                flickableReclamosTareas.contentHeight=web_viewReclamoWeb.implicitHeight

            }

            Flickable {               
                id: flickableReclamosTareas
                contentHeight: web_viewReclamoWeb.preferredHeight
                x: 0
                y: 70
                boundsBehavior: Flickable.DragAndOvershootBounds
                flickableDirection: Flickable.VerticalFlick
                anchors.topMargin: 0
                clip: false
                interactive: true
                anchors.fill: parent
                contentWidth: parent.width

                WebView {
                    id: web_viewReclamoWeb
                    settings.minimumFontSize: 13
                    smooth: true
                    settings.javascriptEnabled: true
                    anchors.fill: parent
                    settings.defaultFontSize: 13
                    settings.defaultFixedFontSize: 13
                    visible: true
                    settings.javaEnabled: true
                    enabled: false
                    z: 1
                    focus: false
                    settings.standardFontFamily: "Arial"
                    preferredHeight: mouseAreaProtectorClicReporte.height
                    preferredWidth: 796//mouseAreaProtectorClicReporte.width

                   reload.onTriggered: {
                        web_viewReclamoWeb.preferredWidth=mouseAreaProtectorClicReporte.width
                        web_viewReclamoWeb.preferredHeight=mouseAreaProtectorClicReporte.height
                        flickableReclamosTareas.contentWidth=web_viewReclamoWeb.implicitWidth
                        flickableReclamosTareas.contentHeight=web_viewReclamoWeb.implicitHeight
                    }
                    onLoadFinished: {
                        web_viewReclamoWeb.preferredWidth=mouseAreaProtectorClicReporte.width
                        web_viewReclamoWeb.preferredHeight=mouseAreaProtectorClicReporte.height
                        flickableReclamosTareas.contentWidth=web_viewReclamoWeb.implicitWidth
                        flickableReclamosTareas.contentHeight=web_viewReclamoWeb.implicitHeight
                    }                   
                }
            }

            Rectangle {
                id: scrollbarWebReclamo
                x: 2
                y: flickableReclamosTareas.visibleArea.yPosition * flickableReclamosTareas.height+3
                width: 10
                height: flickableReclamosTareas.visibleArea.heightRatio * flickableReclamosTareas.height
                color: "#000000"
                radius: 3
                smooth: true
                anchors.rightMargin: 2
                visible: true
                z: 2
                anchors.right: parent.right
                opacity: 0.450
            }
        }

        Image {
            id: imgFlecha1
            width: 25
            height: 25
            anchors.left: parent.left
            anchors.leftMargin: 40
            smooth: true
            anchors.top: parent.top
            anchors.topMargin: -15
            source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaArriba.png"
            opacity: 0.300
            MouseArea {
                id: mouse_area4
                hoverEnabled: true
                anchors.fill: parent
                onEntered: {
                    imgFlecha1OpacidadOff.stop()
                    imgFlecha1OpacidadOn.start()
                }
                onExited: {
                    imgFlecha1OpacidadOn.stop()
                    imgFlecha1OpacidadOff.start()
                }
                onClicked: {
                    if(rectangle3.height==530){
                        rectangle3Aparecer.stop()
                        rectangle3Desaparecer.start()
                            scrollbarWebReclamo.visible=false
                            mouseAreaProtectorClicReporte.visible=false
                        imgFlecha1.source="qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaArriba.png"
                    }else{

                        rectangle3Desaparecer.stop()
                        rectangle3Aparecer.start()
                            scrollbarWebReclamo.visible=true
                            mouseAreaProtectorClicReporte.visible=true
                        imgFlecha1.source="qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaAbajo.png"
                     //   cargarWeb()
                    }
                }
            }
        }
        PropertyAnimation{
            id:imgFlecha1OpacidadOn
            property: "opacity"
            target: imgFlecha1
            from:0.3
            to:0.95
            duration: 300
        }
        PropertyAnimation{
            id:imgFlecha1OpacidadOff
            property: "opacity"
            target: imgFlecha1
            from:0.95
            to:0.3
            duration: 70
        }
        PropertyAnimation{
            id:rectangle3Desaparecer
            target: rectangle3
            property: "height"
            duration: 200
            from:530
            to:12
        }
        PropertyAnimation{
            id:rectangle3Aparecer
            target: rectangle3
            property: "height"
            duration: 200
            to:530
            from:12
        }




    }
}


