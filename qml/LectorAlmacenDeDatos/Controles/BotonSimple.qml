// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: rectangle1
    width: {
        if((txtTextoBoton.implicitWidth+40)<=80){

                60

        }else{

                txtTextoBoton.implicitWidth+30

        }
    }

    height: 33
    color: "#00000000"
    smooth: true

    property alias textoBoton: txtTextoBoton.text
    property alias colorTextoBoton: txtTextoBoton.color
    property alias estilo: txtTextoBoton.style
    property alias negrita: txtTextoBoton.font.bold
    property bool  modoBotonPrecionado: false
    property bool  estaPrecionado: false
    property alias opacidadTexto : txtTextoBoton.opacity

    property double opacidadRectangulo: 0

    signal clicBoton

    function setearEstadoBotonSimple(){
        if(modoBotonPrecionado){
            if(estaPrecionado){
                rectangle3.anchors.rightMargin=1
                rectangle3.anchors.leftMargin=1
                rectangle3.anchors.bottomMargin=1
                rectangle3.anchors.topMargin=2
                rectangle2.border.width=1
                rectangle3.border.width=1
                estaPrecionado=false

            }else{
                rectangle3.anchors.rightMargin=0
                rectangle3.anchors.leftMargin=3
                rectangle3.anchors.bottomMargin=0
                rectangle3.anchors.topMargin=3
                rectangle2.border.width=2
                rectangle3.border.width=3
                estaPrecionado=true               
                rectangle2.opacity=1             
            }
        }
    }

    function restaurarBoton(){
        rectangle3.anchors.rightMargin=1
        rectangle3.anchors.leftMargin=1
        rectangle3.anchors.bottomMargin=1
        rectangle3.anchors.topMargin=2
        rectangle2.border.width=1
        rectangle3.border.width=1
        estaPrecionado=false
        rectangle2.opacity=opacidadRectangulo
        mouseAreaBoton.enabled=true
    }

    Text {
        id: txtTextoBoton
        x: 76
        y: 34
        text: "test"
        anchors.horizontalCenterOffset: 0
        wrapMode: Text.WordWrap
        styleColor: "#2c3f7e"
        style: Text.Raised
        font.italic: false
        font.family: "Verdana"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        opacity: 0.670
        z: 1
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: false
        smooth: true
        font.pixelSize: 14
    }

    MouseArea {
        id: mouseAreaBoton
        hoverEnabled: true
        smooth: true
        anchors.fill: parent
        onEntered: {
            if(!estaPrecionado)
                rectangle2.opacity=1
        }
        onExited: {
            if(!estaPrecionado)
                rectangle2.opacity=opacidadRectangulo
        }
        onClicked: {
            setearEstadoBotonSimple()
            clicBoton()
        }
        onPressed: {
            if(!modoBotonPrecionado){
                scalaFin.stop()
                scalaComienzo.start()
            }
        }
        onReleased: {
            if(!modoBotonPrecionado){
                scalaComienzo.stop()
                scalaFin.start()
            }
        }
    }

    Rectangle {
        id: rectangle2
        color: "#f1f1f0"
        radius: 4
        smooth: true
        border.width: 1
        border.color: "#d1d0d0"
        opacity: opacidadRectangulo
        anchors.fill: parent

        Rectangle {
            id: rectangle3
            color: "#00000000"
            radius: 4
            border.width: 1
            opacity: 0.450
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 2
            border.color: "#ffffff"
            smooth: true
            anchors.fill: parent
        }
    }
    PropertyAnimation{
        id:scalaComienzo
        target: rectangle1
        property: "scale"
        from:1
        to:0.95
        duration: 100
    }
    PropertyAnimation{
        id:scalaFin
        target: rectangle1
        property: "scale"
        from:0.95
        to:1
        duration: 50
    }
}
