import QtQuick 1.1
import "../Controles"

Rectangle{
    id: rectListaItem
   width: parent.width
//     width: 1024
    height: {
        if(txtTextoCausa.text.trim()==""){
            txtTextoCausa.implicitHeight+30
        }else{
            txtTextoCausa.implicitHeight+30+checkbox1.height
        }
    }

    radius: 1
    border.width: 1
    border.color: "#aaaaaa"
    smooth: true
    opacity: 1

    TextEdit {
        id: txtTextoCausa
        text: comentarioTarea
        font.family: "Arial"
        anchors.bottom: checkbox1.top
        anchors.bottomMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 21
        anchors.left: parent.left
        anchors.leftMargin: 20
        smooth: true
        readOnly: true
        selectByMouse: false

        textFormat: TextEdit.PlainText
        wrapMode: TextEdit.WrapAnywhere
        font.pixelSize: 13
    }

    Text {
        id: txtNombreReclamo
        text: nombreTarea
        font.family: "Arial"
        opacity: 0.650
        font.bold: true
        font.underline: true
        smooth: true
        anchors.right: parent.right
        anchors.rightMargin: 200
        anchors.top: parent.top
        anchors.topMargin: 3
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.pixelSize: 13
    }

    Text {
        id: txtFechaHoraTarea
        x: -8
        y: 2
        text: fechaTarea+" "+horaTarea
        font.family: "Arial"
        horizontalAlignment: Text.AlignRight
        smooth: true
        font.pixelSize: 13
        anchors.top: parent.top
        anchors.topMargin: 3
        font.underline: false
        anchors.rightMargin: 20
        font.bold: true
        anchors.right: parent.right
        opacity: 0.650
    }

    CheckBox {
        id: checkbox1
        y: 29
        height: 35
        opacidadPorDefecto: 0.200
        tamanioLetra: 11
        opacidadTexto: 0.200
        anchors.left: parent.left
        anchors.leftMargin: 20
        textoValor: "Hacer texto seleccionable"
        chekActivo: false
        visible: {
            if(txtTextoCausa.text.trim()==""){
                false
            }else{
                true
            }
        }
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        opacity: 1
        onChekActivoChanged: {
            if(chekActivo){
                txtTextoCausa.selectByMouse=true
            }else{
                txtTextoCausa.selectByMouse=false
            }
        }
    }


}
