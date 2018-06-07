// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: rectangle1
    width: {
        if((txtTextoBoton.implicitWidth+40)<=80){
            if(imgMostrarLista.visible){
                txtTextoBoton.implicitWidth+60
            }else{
                60
            }
        }else{
            if(imgMostrarLista.visible){
                txtTextoBoton.implicitWidth+60
            }else{
                txtTextoBoton.implicitWidth+30
            }
        }
    }

    height: 33
    color: "#00000000"
    smooth: true


    property alias textoBoton: txtTextoBoton.text
    property alias utilizaListaDesplegable: imgMostrarLista.visible
    property alias colorTextoBoton: txtTextoBoton.color
    property alias estilo: txtTextoBoton.style
    property alias negrita: txtTextoBoton.font.bold
    property bool  modoBotonPrecionado: true
    property bool  estaPrecionado: false
    property alias listviewDelegate: listview1.delegate
    property alias listviewModel: listview1.model
    property alias opacidadTexto : txtTextoBoton.opacity

    signal clicBotonLista
    signal clicBoton
    signal clicMasControl

    function setearEstadoBoton(){
        if(modoBotonPrecionado){
            if(estaPrecionado){
          /*      rectangle3.anchors.rightMargin=1
                rectangle3.anchors.leftMargin=1
                rectangle3.anchors.bottomMargin=1
                rectangle3.anchors.topMargin=2
                rectangle2.border.width=1
                rectangle3.border.width=1
                estaPrecionado=false
                rectangle2.color="#f1f1f0"*/
                cerrarComboBox()
            }else{
                rectangle3.anchors.rightMargin=0
                rectangle3.anchors.leftMargin=3
                rectangle3.anchors.bottomMargin=0
                rectangle3.anchors.topMargin=3
                rectangle2.border.width=2
                rectangle3.border.width=3
                estaPrecionado=true
                rectangle2.color="#f1f1f0"
                cerrarComboBox()
                rectangle2.opacity=1
            }
        }
    }


    function setearEstadoBotonControl(){
        if(modoBotonPrecionado){
            if(estaPrecionado){
                rectangle3.anchors.rightMargin=1
                rectangle3.anchors.leftMargin=1
                rectangle3.anchors.bottomMargin=1
                rectangle3.anchors.topMargin=2
                rectangle2.border.width=1
                rectangle3.border.width=1
                estaPrecionado=false
                rectangle2.color="#f1f1f0"
                cerrarComboBox()
            }else{
                rectangle3.anchors.rightMargin=0
                rectangle3.anchors.leftMargin=3
                rectangle3.anchors.bottomMargin=0
                rectangle3.anchors.topMargin=3
                rectangle2.border.width=2
                rectangle3.border.width=3
                estaPrecionado=true
                rectangle2.color="#dfedf3"
                cerrarComboBox()
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
        rectangle2.color="#f1f1f0"
        rectangle2.opacity=0
        cerrarComboBox()
        mouseAreaBoton.enabled=true
    }

    function cerrarComboBox(){
        rectPrincipalComboBoxAparecerYIn.stop()
        rectPrincipalComboBox.visible=false
    }

    Text {
        id: txtTextoBoton
        x: 76
        y: 34
        text: "test"
        anchors.horizontalCenterOffset: {
            if(imgMostrarLista.visible){
                -9
            }else{
                0
            }
        }

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
                    rectangle2.opacity=0

        }
        onClicked: {

            if ((mouse.button == Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier)){
                setearEstadoBotonControl()
                clicMasControl()
            }else{
                setearEstadoBoton()
                clicBoton()
            }

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
        opacity: 0
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

    Image {
        id: imgMostrarLista
        x: 80
        y: 5
        width: 17
        opacity: 0.05
        anchors.left: rectLineaDivisoria.right
        anchors.leftMargin: 6
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        smooth: true
        visible: false
        source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaAbajo.png"

        MouseArea {
            id: mouseAreaBotonListaDesplegable
            anchors.rightMargin: -10
            anchors.leftMargin: -6
            anchors.bottomMargin: -9
            anchors.topMargin: -9
            hoverEnabled: true
            smooth: true
            visible: true
            anchors.fill: parent
            onEntered: {
                rectangle2.opacity=1
                imgMostrarListaOpacidadOff.stop()
                imgMostrarListaOpacidadIn.start()
            }
            onExited: {
                imgMostrarListaOpacidadIn.stop()
                imgMostrarListaOpacidadOff.start()

                if(modoBotonPrecionado)
                    if(!estaPrecionado)
                        rectangle2.opacity=0

            }

            onClicked: {
                if(!rectPrincipalComboBox.visible){
                    rectPrincipalComboBox.visible=true
                    rectPrincipalComboBoxAparecerYIn.start()
                    listview1.focus=true
                }
                clicBotonLista()}
        }
    }
    Rectangle {
        id: rectLineaDivisoria
        width: 0.500
        color: "#000000"
        anchors.left: txtTextoBoton.right
        anchors.leftMargin: 5
        opacity: 0.05
        smooth: true
        visible: imgMostrarLista.visible
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
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
    PropertyAnimation{
        id:imgMostrarListaOpacidadIn
        targets: [imgMostrarLista,rectLineaDivisoria]
        property: "opacity"
        from:0.05
        to:1
        duration: 300
    }
    PropertyAnimation{
        id:imgMostrarListaOpacidadOff
        targets: [imgMostrarLista,rectLineaDivisoria]
        property: "opacity"
        from:1
        to:0.05
        duration: 100
    }

    Rectangle {
        id: rectPrincipalComboBox
        x: 0
        y: 39
        //height: listview1.contentHeight+columnaBotones.implicitHeight+70
        height: {
         //   if(listview1.count==0){
          //      columnaBotones.implicitHeight+50
        //    }else{
                columnaBotones.implicitHeight+400
        //    }



        }
        color: "#d2d3d3"
        radius: 3
        smooth: true
        border.color: "#a8a0a0"

        Keys.onEscapePressed: {
            cerrarComboBox()
        }

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
            clip: false
            anchors.fill: parent

            Rectangle {
                id: rectangle4
                x: 23
                y: -6
                width: 25
                height: 25
                color: rectPrincipalComboBox.color
                anchors.top: parent.top
                anchors.topMargin: -6
                rotation: 45
                z: 1
            }

            Rectangle {
                id: rectLineaSuperior
                y: 5
                height: 2
                color: "#201c1c"
                radius: 1
                opacity: 0.620
                smooth: true
                anchors.bottom: parent.bottom
                visible: true
                anchors.rightMargin: 1
                anchors.bottomMargin: 0
                z: 4
                anchors.right: parent.right
                anchors.leftMargin: 1
                anchors.left: parent.left
            }

            Rectangle {
                id: rectangle5
                color: "#d2d3d3"
                anchors.top: columnaBotones.bottom
                anchors.topMargin: 20
                smooth: true
                clip: true
                ListView {
                    id: listview1
                    keyNavigationWraps: true
                    highlightRangeMode: ListView.NoHighlightRange
                    snapMode: ListView.NoSnap
                    boundsBehavior: Flickable.DragAndOvershootBounds
                    interactive: true
                    anchors.topMargin: 0
                    spacing: 10
                    anchors.fill: parent
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    z: 1
                    focus: false                    

                }
                anchors.bottom: parent.bottom
                visible: true
                anchors.rightMargin: 0
                anchors.bottomMargin: 10
                anchors.right: parent.right
                anchors.leftMargin: 1
                anchors.left: parent.left

                Rectangle {
                    id: rectScrollbar
                    width: 14
                    color: "#00ffffff"
                    radius: 6
                    anchors.right: parent.right
                    anchors.rightMargin: 2
                    smooth: true
                    clip: true
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    Rectangle {
                        id: scrollbarItems
                        y: listview1.visibleArea.yPosition * listview1.height+3
                        height: listview1.visibleArea.heightRatio * listview1.height
                        color: "#ffffff"
                        radius: 3
                        anchors.left: parent.left
                        anchors.leftMargin: 2
                        smooth: true
                        visible: true
                        anchors.rightMargin: 2
                        z: 2
                        anchors.right: parent.right
                        opacity: 0.800
                    }
                    anchors.bottom: parent.bottom
                    visible: {
                        if(listview1.count==0){
                            false
                        }else{
                            true
                        }
                    }
                    anchors.bottomMargin: 0
                    z: 6
                    opacity: 1
                }
            }

            Column {
                id: columnaBotones
                visible: true
                spacing: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 30

                BotonSimple {
                    id: btnFiltroMasControl
                    estilo: 0
                    visible: true
                    textoBoton: "Filtro + Ctrl"
                    width: columnaBotones.width                    
                    onClicBoton: {
                        //setearEstadoBotonControl()
                       // clicMasControl()
                       // cerrarComboBox()


                    }
                }

                Text {
                    id: lblCantidadRegistros
                    color: "#64ffffff"
                    text: "Cantidad items: "+listview1.count
                    horizontalAlignment: Text.AlignLeft
                    styleColor: "#3b3b77"
                    font.bold: true
                    visible: {
                        if(listview1.count==0){
                            false
                        }else{
                            true
                        }
                    }

                    smooth: true
                    style: Text.Raised
                    font.family: "Verdana"
                    font.pixelSize: 12
                }
            }

            BotonBarraDeHerramientas {
                id: botonCerrarLista
                x: 456
                width: 18
                height: 18
                anchors.top: parent.top
                anchors.right: parent.right
                smooth: true
                anchors.topMargin: 5
                source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/CerrarLista.png"
                visible: true
                anchors.rightMargin: 5
                onClic: {

                    rectPrincipalComboBoxAparecerYIn.stop()
                    rectPrincipalComboBox.visible=false


                }
            }

            Rectangle {
                id: rectLineaSuperior1
                x: 7
                y: -2
                height: 2
                radius: 1
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#ffffff"
                    }

                    GradientStop {
                        position: 1
                        color: "#9e9898"
                    }
                }
                smooth: true
                anchors.bottom: rectangle5.top
                visible: true
                anchors.rightMargin: 1
                anchors.bottomMargin: 5
                z: 4
                anchors.right: parent.right
                anchors.leftMargin: 1
                opacity: 0.620
                anchors.left: parent.left
            }
        }
        anchors.rightMargin: -200
        visible: false
        border.width: 1
        z: 2001
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.left: parent.left
    }
    PropertyAnimation{
        id:rectPrincipalComboBoxAparecerYIn
        target: rectPrincipalComboBox
        property: "y"
        from:39
        to: 50
        duration: 200
    }
}
