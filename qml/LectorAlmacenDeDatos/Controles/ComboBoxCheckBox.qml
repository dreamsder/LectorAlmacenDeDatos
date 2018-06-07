import QtQuick 1.1

Rectangle {
    id: rectangle2
    width: 500
    height: 35
    color: "#00000000"


    property alias botonBuscarTextoVisible : imageBuscar.visible
    property alias textoTitulo: txtTitulo.text
    property alias textoComboBox: txtTextoSeleccionado.text
    property string codigoValorSeleccion
    property double opacidadPorDefecto: 0.8
    property alias colorTitulo: txtTitulo.color
    property alias modeloItems: listview1.model
    property alias colorRectangulo: rectPrincipalComboBox.color


    signal clicEnBusqueda
    signal tabulacion
    signal enter
    signal senialAlAceptarOClick
    signal focoActivado
    signal closeComboBox


    function retornaDescripcion(_indice){

        return modeloItems.get(_indice).descripcionItem;

    }


    function setearMensajeDeCantidad(){
        txtTextoSeleccionado.text=retornaCantidadItemSeleccionados()+" seleccionados"
    }

    function retornaCantidadItemSeleccionados(){
        var _contador=0;
        for(var i=0; i < listview1.count;i++ ){
            if(modeloItems.get(i).checkBoxActivo)
                _contador++;
        }
        return _contador;
    }



    function tomarElFoco(){
        focoActivado()

        if(listview1.count>=15){
            rectPrincipalComboBox.height=400
            txtItemsCb.text="Items: "+listview1.count
            txtItemsCb.visible=true
            listview1.interactive=true

        }else{
            rectPrincipalComboBox.height=listview1.contentHeight+40
            txtItemsCb.visible=false
            listview1.interactive=false
        }
        if(txtTextoSeleccionado.enabled)
            txtTextoSeleccionado.focus=true

    }
    function activo(valor){
        cerrarComboBox()
        mouse_area1.enabled=valor
        mouse_area2.enabled=valor
        mouse_area3.enabled=valor
        rectangle2.enabled=valor
        txtTextoSeleccionado.enabled=valor

    }

    function cerrarComboBox(){
        rectPrincipalComboBoxAparecerYIn.stop()
        mouse_area1.enabled=true
        rectPrincipalComboBox.visible=false
        txtTextoSeleccionado.enabled=true

    }

    Keys.onEscapePressed: {

        cerrarComboBox()
    }

    Rectangle {
        id: rectPrincipalComboBox
        x: 0
        y: 39
        radius: 3
        border.width: 1
        border.color: "#a8a0a0"
        color:"#eceeee"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: -20
        smooth: true
        height: listview1.contentHeight+40

        visible: false
        z:2000

        Rectangle {
            id: rectSombra
            x: -5
            y: -34
            color: "#1e646262"
            radius: 6
            smooth: true
            anchors.fill: parent
            anchors.topMargin: 5
            visible: true
            anchors.rightMargin: -5
            anchors.bottomMargin: -5
            z: -4
            anchors.leftMargin: -5
        }

        MouseArea {
            id: mouse_area4
            clip: true
            anchors.topMargin: 30
            anchors.fill: parent

            ListView {
                id:listview1
                x: 0
                y: 30
                interactive: false
                z: 1
                spacing: 10
                anchors.bottomMargin: 10
                anchors.rightMargin: 20
                anchors.leftMargin: 0
                anchors.topMargin: 2
                anchors.fill: parent
                focus: true
                model:modeloGenericoCombobox
                delegate:


                    FocusScope {
                    width: childrenRect.width; height: childrenRect.height
                    x:childrenRect.x; y: childrenRect.y
                    Rectangle{
                        id:rect1
                        height: texto1.implicitHeight
                        width: rectPrincipalComboBox.width
                        color: "transparent"


                        CheckBox{
                            id:checkbox1
                            chekActivo: checkBoxActivo                            
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter:  parent.verticalCenter
                            height: 20
                            textoValor: ""
                            z:200
                            enabled: false
                        }


                        Text {
                            id: texto1
                            focus: true
                            text: descripcionItem
                            font.family: "Arial"
                            smooth: true
                            font.pointSize: 10
                            color:"black"
                            styleColor: "white"
                            style: Text.Raised
                            z: 150
                            anchors.left: checkbox1.right
                            anchors.leftMargin: 13
                            onActiveFocusChanged: {

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



                            }

                            Rectangle {
                                id: rectTextComboBox
                                y: 12
                                height: 19
                                color: "#5358be"
                                //width: listview1.width-5
                                radius: 1
                                smooth: true
                                opacity: 0
                                border.width: 0
                                border.color: "#000000"
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: -3
                                anchors.left: parent.left
                                anchors.leftMargin: -300
                                anchors.right: parent.right
                                anchors.rightMargin: -300
                                anchors.top: parent.top
                                anchors.topMargin: -3
                                z:-50



                            }
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

                            Keys.onReturnPressed: {

                             //   rectPrincipalComboBox.visible=false
                             //   txtTextoSeleccionado.text=descripcionItem
                             //   txtTextoSeleccionado.enabled=true
                             //   codigoValorSeleccion=codigoItem
                               // senialAlAceptarOClick()
                               // enter()

                            }
                            MouseArea{
                                id:mouseArea
                                height: texto1.height
                                anchors.left: parent.left
                                anchors.leftMargin: -300
                                anchors.right: rectTextComboBox.right
                                anchors.rightMargin: -300
                                hoverEnabled: true
                                onClicked: {


                                    modeloItems.setProperty(index,"checkBoxActivo",!checkbox1.chekActivo)

                                //    listview1.forceActiveFocus()
                                //    rectPrincipalComboBox.visible=false
                                    //txtTextoSeleccionado.text=descripcionItem
                                    setearMensajeDeCantidad()
                                //    txtTextoSeleccionado.enabled=true
                                 //   codigoValorSeleccion=codigoItem
                                 //   senialAlAceptarOClick()
                                }

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
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: rectLineaSuperior
                y: 5
                height: 2
                color: "#201c1c"
                radius: 1
                smooth: true
                anchors.bottom: parent.bottom
                visible: true
                anchors.rightMargin: 1
                anchors.bottomMargin: 0
                z: 3
                anchors.right: parent.right
                anchors.leftMargin: 1
                anchors.left: parent.left
            }
        }

        Text {
            id: txtItemsCb
            x: 5
            y: 40
            text: qsTr("Items:")
            font.family: "Arial"
            visible: false
            font.bold: false
            z: 2
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
            smooth: true
            font.pixelSize: 9
        }

        Rectangle {
            id: rectangle3
            y: 24
            width: 25
            height: 25
            color: rectPrincipalComboBox.color
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.top: parent.top
            anchors.topMargin: -6
            rotation: 45
            z: 1
        }

        BotonBarraDeHerramientas {
            id: botonCerrarLista
            x: 497
            y: 35
            width: 18
            height: 18
            smooth: true
            anchors.top: parent.top
            anchors.topMargin: 5            
            source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/CerrarLista.png"
            visible: true
            anchors.rightMargin: 5
            anchors.right: parent.right

            onClic: {

                closeComboBox()
                rectPrincipalComboBoxAparecerYIn.stop()
                mouse_area1.enabled=true
                rectPrincipalComboBox.visible=false
                txtTextoSeleccionado.enabled=true



            }
        }
    }

    Rectangle {
        id: rectTextComboBox2
        x: 0
        y: -19
        height: 19
        color: "#ffffff"
        radius: 2
        border.color: "#686b71"
        TextInput {
            id: txtTextoSeleccionado
            color: "#000000"
            text: qsTr("")
            font.family: "Arial"
            smooth: true
            anchors.topMargin: 1
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 2
            font.bold: false
            font.pointSize: 10
            z: 1
            anchors.right: imageBotonComboBoxAbajo.left
            horizontalAlignment: TextInput.AlignHCenter
            anchors.left: parent.left

            onActiveFocusChanged: {

                if(txtTextoSeleccionado.activeFocus==true){
                    colorIn2.start()
                    opacityIn2.start()


                    if(rectPrincipalComboBox.visible==false){
                        tomarElFoco()
                        listview1.forceActiveFocus()
                        rectPrincipalComboBox.visible=true
                        rectPrincipalComboBoxAparecerYIn.start();
                        txtTextoSeleccionado.enabled=false
                    }


                }
                if(txtTextoSeleccionado.activeFocus==false){
                    colorOff2.start()
                    opacityOff2.start()

                }
            }

        }
        MouseArea {
            id: mouse_area1
            visible: false
            anchors.fill: parent
            onClicked: {
                mouse_area1.enabled=false
            }
        }
        Image {
            id: imageBotonComboBoxAbajo
            x: 425
            y: 56
            width: 16
            height: 16
            smooth: true
            z: 2            
            source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaAbajo16x16.png"
            anchors.rightMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right

            MouseArea {
                id: mouse_area3
                anchors.fill: parent
                onClicked: tomarElFoco()
            }
        }
        anchors.bottom: parent.bottom
        anchors.rightMargin: 21
        border.width: 1
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.leftMargin: 0
        opacity: opacidadPorDefecto
        anchors.left: parent.left
    }

    Text {
        id: txtTitulo
        x: 0
        y: -34
        height: 15
        width: txtTitulo.implicitWidth
        color: "#dbd8d8"
        text: qsTr("Titulo:")
        font.family: "Arial"
        smooth: true
        verticalAlignment: Text.AlignBottom
        font.pixelSize: 11
        anchors.top: parent.top
        anchors.topMargin: 0
        font.bold: true
        anchors.leftMargin: 5
        anchors.left: parent.left
    }

    PropertyAnimation{
        id:rectPrincipalComboBoxAparecerYIn
        target: rectPrincipalComboBox
        property: "y"
        from:39
        to: 48
        duration: 200
    }

    PropertyAnimation{
        id: colorIn2
        target: rectTextComboBox2
        property: "border.color"
        from:"#686b71"
        to: "#0470fd"
        duration: 500
    }
    PropertyAnimation{
        id: colorOff2
        target: rectTextComboBox2
        property: "border.color"
        from: "#0470fd"
        to:"#686b71"
        duration: 500
    }

    PropertyAnimation{
        id: opacityIn2
        target: rectTextComboBox2
        property: "opacity"
        from:opacidadPorDefecto
        to: 1
        duration: 200
    }
    PropertyAnimation{
        id: opacityOff2
        target: rectTextComboBox2
        property: "opacity"
        from: 1
        to:opacidadPorDefecto
        duration: 200
    }

    Image {
        id: imageBuscar
        y: 16
        height: 20
        anchors.left: rectTextComboBox2.right
        anchors.right: parent.right
        anchors.rightMargin: 0
        smooth: true
        MouseArea {
            id: mouse_area2
            hoverEnabled: true
            anchors.fill: parent
            anchors.leftMargin: 1

            onPressed: {
                imageBuscarScaleOff.stop()
                imageBuscarScaleIn.start()
            }
            onReleased:  {
                imageBuscarScaleIn.stop()
                imageBuscarScaleOff.start()

            }
            onEntered: {
                imageBuscarOpacidadOut.stop()
                imageBuscarOpacidadIn.start()
            }
            onExited: {
                imageBuscarOpacidadIn.stop()
                imageBuscarOpacidadOut.start()

            }
            onClicked: clicEnBusqueda()

        }        
        source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaAbajo16x16.png"
        anchors.bottom: parent.bottom
        visible: false
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        opacity: 0.500
    }
    PropertyAnimation{
        id:imageBuscarScaleIn
        target: imageBuscar
        property: "scale"
        from:1
        to:0.93
        duration: 70
    }

    PropertyAnimation{
        id:imageBuscarScaleOff
        target: imageBuscar
        property: "scale"
        to:1
        from:0.93
        duration: 50
    }



    PropertyAnimation{
        id:imageBuscarOpacidadIn
        target: imageBuscar
        property: "opacity"
        from:0.5
        to:1
        duration: 70
    }

    PropertyAnimation{
        id:imageBuscarOpacidadOut
        target: imageBuscar
        property: "opacity"
        from:1
        to:0.5
        duration: 50
    }
}