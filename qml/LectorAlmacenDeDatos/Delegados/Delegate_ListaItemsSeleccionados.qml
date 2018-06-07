import QtQuick 1.1
import "../Controles"

FocusScope {
    x: childrenRect.x
    y: childrenRect.y
    width: childrenRect.width
    height: childrenRect.height


    property string codigoItem

    signal senialAlAceptarOClick
    signal keyEscapeCerrar

    Rectangle {
        id: rect1
        width: rectPrincipalComboBox.width
        height: 19
        color: "#00000000"
        smooth: true
        visible: true
        Text {
            id: texto1
            color: "#000000"
            text: textoItem
            clip: false
            smooth: true

            /*onActiveFocusChanged: {

                if(activeFocus){
                    opacityOff.stop()
                    opacityIn.start()
                    texto1.color="white"
                    texto1.style= Text.Normal
                    texto1.font.bold= true

                }else{
                    opacityIn.stop()
                    opacityOff.start()
                    texto1.color="black"
                    texto1.style= Text.Raised
                    texto1.font.bold= false
                }

            }*/

            PropertyAnimation{
                id: opacityIn
                target: rectTextComboBox
                property: "opacity"
                from:0
                to: 0.60
                duration: 200
            }
            PropertyAnimation{
                id: opacityOff
                target: rectTextComboBox
                property: "opacity"
                from: 0.60
                to:0
                duration: 50
            }

            Rectangle {
                id: rectTextComboBox
                y: 12
                width: listview1.width+20
                height: 19
                color: "#5358be"
                radius: 1
                smooth: true
                visible: false
                anchors.top: parent.top
                border.color: "#000000"
                anchors.topMargin: -1
                anchors.bottom: parent.bottom
                border.width: 0
                anchors.bottomMargin: -3
                z: -50
                anchors.leftMargin: -10
                opacity: 0
                anchors.left: parent.left
            }

            PropertyAnimation {
                id: opacityIn1
                target: rectTextComboBox
                property: "opacity"
                to: 0.600
                from: 0
                duration: 200
            }

            PropertyAnimation {
                id: opacityOff1
                target: rectTextComboBox
                property: "opacity"
                to: 0
                from: 0.600
                duration: 50

            }

            MouseArea {
                id: mouseArea
                width: listview1.width
                height: 20
                hoverEnabled: false
                enabled: false
                onEntered: {
                    listview1.forceActiveFocus()
                    opacityOff.stop()
                    opacityIn.start()

                    texto1.color="white"
                    texto1.style= Text.Normal
                    texto1.font.bold= true
                }
                onExited:{
                    opacityIn.stop()
                    opacityOff.start()

                    texto1.color="black"
                    texto1.style= Text.Raised
                    texto1.font.bold= false
                }
                onClicked: {

                        codigoItem=codigoDelItem
                        senialAlAceptarOClick()

                }
            }

            Keys.onReturnPressed: {

                    codigoItem=codigoDelItem
                    senialAlAceptarOClick()

            }
            Keys.onEscapePressed: keyEscapeCerrar()

            style: Text.Raised
            styleColor: "#ffffff"
            font.pointSize: 10
            z: 100
            anchors.leftMargin: 10
            anchors.left: parent.left
            focus: true
        }
    }
}
