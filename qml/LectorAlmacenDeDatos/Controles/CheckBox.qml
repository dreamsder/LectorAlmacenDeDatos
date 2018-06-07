import QtQuick 1.1
Rectangle{
    id:rectPrincipal
    width: text1.implicitWidth + 5 + image1.width
    height: 35
    color: "#00000000"


    property bool chekActivo: false

    property alias colorTexto: text1.color
    property alias textoValor: text1.text
    property alias tamanioLetra : text1.font.pixelSize
    property alias  opacidadTexto: text1.opacity


    property double opacidadPorDefecto: 0.8


    function setActivo(atributo){
        chekActivo=atributo
        image1.visible=chekActivo
    }

Rectangle {
    id: rectangle1

    color: "#00000000"
    anchors.topMargin: 16
    anchors.fill: parent
    smooth: true



    Rectangle {
        id: rectangle2
        width: 18
        height: 19
        color: "#ffffff"
        smooth: true
        radius: 2
        border.color: "#686b71"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        border.width: 1
        opacity: {

            if(chekActivo){
                1
            }else{
                opacidadPorDefecto
            }
        }

        Image {
            id: image1
            visible: chekActivo
            smooth: true
            anchors.rightMargin: -6
            anchors.leftMargin: 2
            anchors.bottomMargin: 2
            anchors.topMargin: -4
            anchors.fill: parent
            source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/VistoOk.png"
        }
    }

    Text {
        id: text1
        color: "#333333"
        text: qsTr("checkbox")
        font.family: "Verdana"
        smooth: true
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        font.bold: false
        verticalAlignment: Text.AlignVCenter
        anchors.left: rectangle2.right
        anchors.leftMargin: 10
        font.pixelSize: 13
    }

    MouseArea {
        id: mouse_area1
        anchors.fill: parent

        onClicked: {

            if(chekActivo){
                setActivo(false)
                opacityIn.stop()
                opacityOff.start()
            }else{
                setActivo(true)
                opacityOff.stop()
                opacityIn.start()
            }

        }


    }

    PropertyAnimation{
        id: opacityIn
        targets: [rectangle2,text1]
        property: "opacity"
        from:opacidadPorDefecto
        to: 1
        duration: 200
    }
    PropertyAnimation{
        id: opacityOff
        //target: rectangle2
        targets: [rectangle2,text1]
        property: "opacity"
        from: 1
        to:opacidadPorDefecto
        duration: 200
    }




}
}
