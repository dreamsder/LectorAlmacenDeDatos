import QtQuick 1.1

Rectangle {
    id: rectPrincipalBotonFlechaSiguiente
    width: 30
    height: 30
    color: "#00030202"
    radius: 100
    opacity: opacidadRectPrincipal
    smooth: true
    border.width: 2
    enabled: false
    border.color: "#fffdfd"

    signal clic
    property double scaleValorActual: 1
    property alias colorBorder: rectPrincipalBotonFlechaSiguiente.border
    property double opacidadRectPrincipal: 0.3

    property alias source : image1.source

    property alias toolTip: toolTipText.text


    function setearInactivo(){
        mouse_area1.enabled=false
        rectPrincipalBotonFlechaSiguienteOpacityOff.stop()
        rectPrincipalBotonFlechaSiguienteOpacityIn.to=0.3
        rectPrincipalBotonFlechaSiguienteOpacityIn.start()
        rectPrincipalBotonFlechaSiguienteScaleIn.stop()
        rectPrincipalBotonFlechaSiguienteScaleAlEntrar.stop()
        rectPrincipalBotonFlechaSiguienteScaleAlSalir.start()
        rectPrincipalBotonFlechaSiguiente.enabled=false
    }
    function setearActivo(){
        rectPrincipalBotonFlechaSiguiente.enabled=true
        mouse_area1.enabled=true
        rectPrincipalBotonFlechaSiguienteOpacityIn.to=1
        rectPrincipalBotonFlechaSiguienteOpacityIn.start()
    }

    MouseArea {
        id: mouse_area1
        hoverEnabled: true
        anchors.fill: parent

        onEntered: {

            timer1.start()

            rectPrincipalBotonFlechaSiguienteScaleAlSalir.stop()
            rectPrincipalBotonFlechaSiguienteOpacityOff.stop()

            rectPrincipalBotonFlechaSiguienteScaleAlEntrar.start()
            scaleValorActual=rectPrincipalBotonFlechaSiguienteScaleAlEntrar.to
            rectPrincipalBotonFlechaSiguienteOpacityIn.start()
        }
        onExited: {

            timer1.stop()
            rectToolTipText.visible=false

            rectPrincipalBotonFlechaSiguienteScaleAlEntrar.stop()
            rectPrincipalBotonFlechaSiguienteOpacityIn.stop()

            rectPrincipalBotonFlechaSiguienteScaleAlSalir.start()
            scaleValorActual=rectPrincipalBotonFlechaSiguienteScaleAlSalir.to
            rectPrincipalBotonFlechaSiguienteOpacityOff.start()
        }

        onPressed: {
            timer1.stop()
            rectToolTipText.visible=false
            rectPrincipalBotonFlechaSiguienteScaleOff.stop()
            rectPrincipalBotonFlechaSiguienteScaleIn.start()
        }

        onReleased: {
            timer1.stop()
            rectPrincipalBotonFlechaSiguienteScaleIn.stop()
            rectPrincipalBotonFlechaSiguienteScaleOff.start()
        }

        onClicked: clic()
    }


    PropertyAnimation{
        id:rectPrincipalBotonFlechaSiguienteScaleIn
        target: rectPrincipalBotonFlechaSiguiente
        property: "scale"
        from:scaleValorActual
        to:1
        duration:100
    }

    PropertyAnimation{
        id:rectPrincipalBotonFlechaSiguienteScaleOff
        target: rectPrincipalBotonFlechaSiguiente
        property: "scale"
        from:1
        to:scaleValorActual
        duration:40
    }


    PropertyAnimation{
        id:rectPrincipalBotonFlechaSiguienteScaleAlEntrar
        target: rectPrincipalBotonFlechaSiguiente
        property: "scale"
        from:scaleValorActual
        to:1.15
        duration:40
    }

    PropertyAnimation{
        id:rectPrincipalBotonFlechaSiguienteScaleAlSalir
        target: rectPrincipalBotonFlechaSiguiente
        property: "scale"
        from:scaleValorActual
        to:1
        duration:40
    }

    PropertyAnimation{
        id:rectPrincipalBotonFlechaSiguienteOpacityIn
        target: rectPrincipalBotonFlechaSiguiente
        property: "opacity"
        from:opacidadRectPrincipal
        to:1
        duration:100
    }

    PropertyAnimation{
        id:rectPrincipalBotonFlechaSiguienteOpacityOff
        target: rectPrincipalBotonFlechaSiguiente
        property: "opacity"
        from:1
        to:opacidadRectPrincipal
        duration:40
    }
    Rectangle{
        id:rectToolTipText
        visible: false
        width: toolTipText.implicitWidth+20
        height: toolTipText.implicitHeight
        color: "#4d7dc0"
        radius: 6
        z: 1
        smooth: true
        Text {
            id: toolTipText
            color: "#fdfbfb"
            text: ""
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.fill: parent
            smooth: true
            visible: true
        }
    }
    Timer {
        id:timer1
        interval: 1500;
        running: false;
        repeat: false;

        onTriggered: {
            if(toolTipText.text!=""){
                rectToolTipText.scale=0.85
                rectToolTipText.x=rectPrincipalBotonFlechaSiguiente.width+10
                rectToolTipText.y=rectPrincipalBotonFlechaSiguiente.height/4
                rectToolTipText.visible=true
            }
        }
    }
    Image {
        id: image1
        clip: true
        smooth: true
        anchors.fill: parent
        source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaDerecha.png"
    }
}
