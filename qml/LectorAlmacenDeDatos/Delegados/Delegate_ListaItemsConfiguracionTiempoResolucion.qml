import QtQuick 1.1
import "../Controles"

Rectangle {
    id: rectangle1
    width: 300
    height: 100
    //width: 800
    //height: 570
    clip: true

    color: "#2385a6"
    radius: 10
    border.color: "#ffa549"
    border.width: 0

    property string _codigoPerfilesTiempoResolucion: codigoPerfilesTiempoResolucion
    property int _indice: indice


    property int _cantidadRegistrosFiltro: 0

    signal dobleClick

    Text {
        id: text1
        color: "#ffffff"
        text: nombrePerfilesTiempoResolucion
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        font.bold: true
        style: Text.Normal
        clip: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20

    }


    ParallelAnimation{
        id:expandirRectangulo

        PropertyAnimation{
            target: rectangle1
            property: "width"
            from:rectangle1.width
            to:rectangle1.parent.width
            duration: 300
        }
        PropertyAnimation{
            target: rectangle1
            property: "height"
            from:rectangle1.height
            to:330
            duration: 300
        }
        PropertyAnimation{
            target: rectangle1
            property: "border.width"
            from:rectangle1.border.width
            to:4
            duration: 300
        }

        onCompleted: {
            btnEditarConfiguraciontiempoResolucion.textoBoton="Guardar cambios"
            flow1.visible=true
            text1.visible=false
            textEdit1.visible=true
            imgEliminar.visible=true
            textEdit2.visible=true
        }
    }



    Text {
        id: lblCantidadRegistrosFiltro
        color: "#f0dcdc"
        text: "# Filtros: "+ _cantidadRegistrosFiltro
        font.bold: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 13
    }

    ParallelAnimation{
        id:contraerRectangulo

        PropertyAnimation{
            target: rectangle1
            property: "width"
            from:rectangle1.width
            to:300
            duration: 150
        }
        PropertyAnimation{
            target: rectangle1
            property: "height"
            from:rectangle1.height
            to:100
            duration: 150
        }
        PropertyAnimation{
            target: rectangle1
            property: "border.width"
            from:rectangle1.border.width
            to:0
            duration: 150

        }

        onCompleted: {

            btnEditarConfiguraciontiempoResolucion.textoBoton="Editar"
            flow1.visible=false
            text1.visible=true
            textEdit1.visible=false
            imgEliminar.visible=false            
            textEdit2.visible=false
        }
    }


    MouseArea {
        id: mouseArea1
        hoverEnabled: true
        anchors.fill: parent

        onDoubleClicked: {

            if(btnEditarConfiguraciontiempoResolucion.textoBoton=="Editar"){

                id_codigoPerfilesTiempoResolucion=codigoPerfilesTiempoResolucion

                modeloListaTipoDocumentosVirtual.setProperty(0,"checkBoxActivo",ckbHora1.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(1,"checkBoxActivo",ckbHora2.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(2,"checkBoxActivo",ckbHora3.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(3,"checkBoxActivo",ckbHora4.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(4,"checkBoxActivo",ckbHora5.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(5,"checkBoxActivo",ckbHora6.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(6,"checkBoxActivo",ckbHora7.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(7,"checkBoxActivo",ckbHora8.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(8,"checkBoxActivo",ckbHora9.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(9,"checkBoxActivo",ckbHora10.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(10,"checkBoxActivo",ckbHora11.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(11,"checkBoxActivo",ckbHora12.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(12,"checkBoxActivo",ckbHora13.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(13,"checkBoxActivo",ckbHora14.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(14,"checkBoxActivo",ckbHora15.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(15,"checkBoxActivo",ckbHora16.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(16,"checkBoxActivo",ckbHora17.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(17,"checkBoxActivo",ckbHora18.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(18,"checkBoxActivo",ckbHora19.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(19,"checkBoxActivo",ckbHora20.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(20,"checkBoxActivo",ckbHora21.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(21,"checkBoxActivo",ckbHora22.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(22,"checkBoxActivo",ckbHora23.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(23,"checkBoxActivo",ckbHora24.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(24,"checkBoxActivo",ckbHora25.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(25,"checkBoxActivo",ckbHora26.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(26,"checkBoxActivo",ckbHora27.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(27,"checkBoxActivo",ckbHora28.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(28,"checkBoxActivo",ckbHora29.chekActivo)

                modeloListaTipoDocumentosVirtual.setProperty(29,"checkBoxActivo",ckbHora30.chekActivo)




                dobleClick()


            }
        }

        Flow {
            id: flow2
            anchors.right: imgEliminar.left
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: textEdit1.bottom
            anchors.topMargin: 10
            visible: flow1.visible
            spacing: flow1.spacing

            CheckBox{
                id: ckbMostrarCoordinado
                colorTexto: "#ffffff"
                textoValor: "Identificar coordinados"                
            }CheckBox{
                id: ckbMostrarHoraFinalizado
                colorTexto: "#ffffff"
                textoValor: "Mostrar Fecha/hora fin"
            }CheckBox{
                id: ckbMostrarTextoTiempoClienteTerceros
                colorTexto: "#ffffff"
                textoValor: "Mostrar nota al pie"


                Component.onCompleted: {
                    ckbMostrarCoordinado.chekActivo=modeloPerfilesTiempoResolucion.retornarMostrarCoordinado(_indice)
                    ckbMostrarHoraFinalizado.chekActivo=modeloPerfilesTiempoResolucion.retornarMostrarHoraFinalizado(_indice)
                    ckbMostrarTextoTiempoClienteTerceros.chekActivo=modeloPerfilesTiempoResolucion.retornarMostrarTextoTiempoClienteTerceros(_indice)
                    ckbMostrarTiempoPromedioAsistencias.chekActivo=modeloPerfilesTiempoResolucion.retornarMostrarTiempoPromedioAsistencias(_indice)

                }

            }CheckBox{
                id: ckbMostrarTiempoPromedioAsistencias
                colorTexto: "#ffffff"
                textoValor: "Mostrar Tiempo promedio"
            }

        }




        Flow {
            id: flow1
            visible: false
            anchors.bottom: btnEditarConfiguraciontiempoResolucion.top
            anchors.bottomMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: textEdit2.bottom
            anchors.topMargin: 10
            spacing: 7

            CheckBox{
                id: ckbHora1
                colorTexto: "#ffffff"
                textoValor: "01 horas"
            }CheckBox{
                id: ckbHora2
                colorTexto: "#ffffff"
                textoValor: "02 horas"
            }CheckBox{
                id: ckbHora3
                colorTexto: "#ffffff"
                textoValor: "03 horas"
            }CheckBox{
                id: ckbHora4
                colorTexto: "#ffffff"
                textoValor: "04 horas"
            }CheckBox{
                id: ckbHora5
                colorTexto: "#ffffff"
                textoValor: "05 horas"
            }CheckBox{
                id: ckbHora6
                colorTexto: "#ffffff"
                textoValor: "06 horas"
            }CheckBox{
                id: ckbHora7
                colorTexto: "#ffffff"
                textoValor: "07 horas"
            }CheckBox{
                id: ckbHora8
                colorTexto: "#ffffff"
                textoValor: "08 horas"
            }CheckBox{
                id: ckbHora9
                colorTexto: "#ffffff"
                textoValor: "09 horas"
            }CheckBox{
                id: ckbHora10
                colorTexto: "#ffffff"
                textoValor: "10 horas"
            }CheckBox{
                id: ckbHora11
                colorTexto: "#ffffff"
                textoValor: "11 horas"
            }CheckBox{
                id: ckbHora12
                colorTexto: "#ffffff"
                textoValor: "12 horas"
            }CheckBox{
                id: ckbHora13
                colorTexto: "#ffffff"
                textoValor: "13 horas"
            }CheckBox{
                id: ckbHora14
                colorTexto: "#ffffff"
                textoValor: "14 horas"
            }CheckBox{
                id: ckbHora15
                colorTexto: "#ffffff"
                textoValor: "15 horas"
            }CheckBox{
                id: ckbHora16
                colorTexto: "#ffffff"
                textoValor: "16 horas"
            }CheckBox{
                id: ckbHora17
                colorTexto: "#ffffff"
                textoValor: "17 horas"
            }CheckBox{
                id: ckbHora18
                colorTexto: "#ffffff"
                textoValor: "18 horas"
            }CheckBox{
                id: ckbHora19
                colorTexto: "#ffffff"
                textoValor: "19 horas"
            }CheckBox{
                id: ckbHora20
                colorTexto: "#ffffff"
                textoValor: "20 horas"
            }CheckBox{
                id: ckbHora21
                colorTexto: "#ffffff"
                textoValor: "21 horas"
            }CheckBox{
                id: ckbHora22
                colorTexto: "#ffffff"
                textoValor: "22 horas"
            }CheckBox{
                id: ckbHora23
                colorTexto: "#ffffff"
                textoValor: "23 horas"
            }CheckBox{
                id: ckbHora24
                colorTexto: "#ffffff"
                textoValor: "24 horas"
            }CheckBox{
                id: ckbHora25
                colorTexto: "#ffffff"
                textoValor: "25 horas"
            }CheckBox{
                id: ckbHora26
                colorTexto: "#ffffff"
                textoValor: "26 horas"
            }CheckBox{
                id: ckbHora27
                colorTexto: "#ffffff"
                textoValor: "27 horas"
            }CheckBox{
                id: ckbHora28
                colorTexto: "#ffffff"
                textoValor: "28 horas"
            }CheckBox{
                id: ckbHora29
                colorTexto: "#ffffff"
                textoValor: "29 horas"
            }CheckBox{
                id: ckbHora30
                colorTexto: "#ffffff"
                textoValor: "30 horas"


                Component.onCompleted: {

                    modeloPerfilesTiempoResolucionDetalle.limpiarLista()
                    modeloPerfilesTiempoResolucionDetalle.buscar(codigoPerfilesTiempoResolucion)

                    if(modeloPerfilesTiempoResolucionDetalle.rowCount()!==0){

                        _cantidadRegistrosFiltro=modeloPerfilesTiempoResolucionDetalle.rowCount()

                        for(var i=0; i < modeloPerfilesTiempoResolucionDetalle.rowCount();i++){

                            if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="1"){
                                ckbHora1.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="2"){
                                ckbHora2.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="3"){
                                ckbHora3.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="4"){
                                ckbHora4.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="5"){
                                ckbHora5.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="6"){
                                ckbHora6.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="7"){
                                ckbHora7.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="8"){
                                ckbHora8.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="9"){
                                ckbHora9.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="10"){
                                ckbHora10.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="11"){
                                ckbHora11.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="12"){
                                ckbHora12.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="13"){
                                ckbHora13.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="14"){
                                ckbHora14.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="15"){
                                ckbHora15.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="16"){
                                ckbHora16.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="17"){
                                ckbHora17.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="18"){
                                ckbHora18.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="19"){
                                ckbHora19.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="20"){
                                ckbHora20.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="21"){
                                ckbHora21.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="22"){
                                ckbHora22.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="23"){
                                ckbHora23.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="24"){
                                ckbHora24.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="25"){
                                ckbHora25.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="26"){
                                ckbHora26.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="27"){
                                ckbHora27.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="28"){
                                ckbHora28.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="29"){
                                ckbHora29.chekActivo=true
                            }else if(modeloPerfilesTiempoResolucionDetalle.retornarCodigoItemTiempoResolucion(i)==="30"){
                                ckbHora30.chekActivo=true
                            }
                        }
                    }
                }
            }
        }

        TextInput {
            id: textEdit1
            color: "#ffffff"
            text: nombrePerfilesTiempoResolucion
            clip: true
            anchors.right: parent.right
            anchors.rightMargin: 0
            visible: false
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 20
            maximumLength: 40
            //   textFormat: Text.PlainText
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.family: "Arial"

            font.pixelSize: 20

            Rectangle {
                id: rectangle2
                color: "#e15e5e"
                radius: 10
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                z: -1
                anchors.fill: parent
            }
        }

        BotonSimple {
            id: btnEditarConfiguraciontiempoResolucion
            x: 214
            y: 59
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.right: parent.right
            anchors.rightMargin: 8
            opacidadRectangulo: 0.100
            opacidadTexto: 1
            colorTextoBoton: "#f79963"
            estaPrecionado: false
            estilo: 0
            textoBoton: "Editar"
            negrita: true
            visible: modeloReclamos.accesoCompleto()
            modoBotonPrecionado: false
            z: 7
            onClicBoton: {

                if(textoBoton=="Editar"){

                    contraerRectangulo.stop()
                    expandirRectangulo.start()

                }else{

                    var codigoNuevo="1"

                    modeloPerfilesTiempoResolucionVirtual.setProperty(index,"nombrePerfilesTiempoResolucion",textEdit1.text.trim())
                    modeloPerfilesTiempoResolucionVirtual.setProperty(index,"textoTiempoClienteTerceros",textEdit2.text.trim())

                    if(codigoPerfilesTiempoResolucion=="999999999"){

                        codigoNuevo=modeloPerfilesTiempoResolucion.nuevoCodigoFiltro()
                        modeloPerfilesTiempoResolucionVirtual.setProperty(index,"codigoPerfilesTiempoResolucion",codigoNuevo)

                    }else{
                        codigoNuevo=codigoPerfilesTiempoResolucion
                    }

                    if(modeloPerfilesTiempoResolucion.guardarFiltro(codigoNuevo,nombrePerfilesTiempoResolucion,textoTiempoClienteTerceros,
                                                                    ckbMostrarCoordinado.chekActivo, ckbMostrarHoraFinalizado.chekActivo,
                                                                    ckbMostrarTextoTiempoClienteTerceros.chekActivo,ckbMostrarTiempoPromedioAsistencias.chekActivo)){

                        if(modeloPerfilesTiempoResolucionDetalle.eliminarFiltro(codigoNuevo)){

                            if(ckbHora1.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"1")

                            if(ckbHora2.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"2")

                            if(ckbHora3.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"3")

                            if(ckbHora4.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"4")

                            if(ckbHora5.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"5")

                            if(ckbHora6.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"6")

                            if(ckbHora7.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"7")

                            if(ckbHora8.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"8")

                            if(ckbHora9.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"9")

                            if(ckbHora10.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"10")

                            if(ckbHora11.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"11")

                            if(ckbHora12.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"12")

                            if(ckbHora13.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"13")

                            if(ckbHora14.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"14")

                            if(ckbHora15.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"15")

                            if(ckbHora16.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"16")

                            if(ckbHora17.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"17")

                            if(ckbHora18.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"18")

                            if(ckbHora19.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"19")

                            if(ckbHora20.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"20")

                            if(ckbHora21.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"21")

                            if(ckbHora22.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"22")

                            if(ckbHora23.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"23")

                            if(ckbHora24.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"24")

                            if(ckbHora25.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"25")

                            if(ckbHora26.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"26")

                            if(ckbHora27.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"27")

                            if(ckbHora28.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"28")

                            if(ckbHora29.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"29")

                            if(ckbHora30.chekActivo)
                                modeloPerfilesTiempoResolucionDetalle.guardarFiltro(codigoNuevo,"30")


                            modeloPerfilesTiempoResolucionDetalle.limpiarLista()
                            modeloPerfilesTiempoResolucionDetalle.buscar(codigoNuevo)

                            _cantidadRegistrosFiltro=modeloPerfilesTiempoResolucionDetalle.rowCount()

                        }
                    }else{
                        console.log("fallo algo")
                    }

                    expandirRectangulo.stop()
                    contraerRectangulo.start()
                }


            }
        }

        Image {
            id: imgEliminar
            width: 32
            height: 32
            opacity: 0.6
            fillMode: Image.PreserveAspectFit
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: textEdit1.bottom
            smooth: true
            visible: false
            anchors.topMargin: 20
            source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/Eliminar.png"

            MouseArea {
                id: mouseArea2
                hoverEnabled: true
                anchors.fill: parent
                onEntered: {
                    imgEliminar.opacity=1.0
                }
                onExited: {
                    imgEliminar.opacity=0.6
                }
                onClicked: {

                    if(modeloPerfilesTiempoResolucion.mensajePregunta(codigoPerfilesTiempoResolucion,nombrePerfilesTiempoResolucion)){
                        modeloPerfilesTiempoResolucionVirtual.remove(index)
                    }

                }
            }
        }

        TextInput {
            id: textEdit2
            x: 0
            y: 7
            color: "#ffffff"
            text: textoTiempoClienteTerceros
            anchors.rightMargin: 0
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: 0
            maximumLength: 400
            font.family: "Arial"
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            font.pixelSize: 12
            Rectangle {
                id: rectangle3
                color: "#e15e5e"
                radius: 10
                anchors.rightMargin: 20
                anchors.fill: parent
                z: -1
                anchors.leftMargin: 20
            }
            anchors.topMargin: 10
            visible: false
            anchors.top: flow2.bottom
            clip: true
        }

        Text {
            id: text2
            color: "#ffffff"
            text: textoTiempoClienteTerceros
            anchors.top: flow2.bottom
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.left: parent.left
            font.bold: true
            style: Text.Normal
            clip: true
            visible: false
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20

        }

    }



}

