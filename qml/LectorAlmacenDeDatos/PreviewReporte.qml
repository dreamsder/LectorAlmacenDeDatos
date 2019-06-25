// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtWebKit 1.1
import "Controles"


Rectangle {
    id: rectPreviewReporte
    width: 900
    height: 500
    radius: 5
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#535151"
        }

        GradientStop {
            position: 0.360
            color: "#e6e6e6"
        }
    }
    opacity: {
        if(_maximizado){
            1
        }else{
            mouse_area1.pressed ? "0.5" : "1"
        }
    }
    border.width: 3
    border.color: "#c6c6c6"
    clip: true
    smooth: true

    signal clicCerrarReporte
    signal maximizarRestaurar
    signal doubleClic


    property string _filtroConsultaRespaldo: ""
    property bool _maximizado: true

    function cargarReporte(_filtroWhereDeConsulta,links){

        cbxListaHorasTiempoResolucion.setearMensajeDeCantidad()

        var _resultadoHorasSeleccionadas="SELECT sum(1), case ";
        var _minutos=60;
        var _minutoInicial=0;
        var _minutoFinal=0;
        var _mensajeHoras="";

        var _ultimoCodigoHora=0;

        if(cbxListaHorasTiempoResolucion.textoComboBox!="0 seleccionados"){
            for(var i=0; i<modeloListaTipoDocumentosVirtual.count;i++){

                /// Si el item esta activo
                if(modeloListaTipoDocumentosVirtual.get(i).checkBoxActivo==true){
                    _ultimoCodigoHora=modeloListaTipoDocumentosVirtual.get(i).codigoItem;

                   // if(modeloListaTipoDocumentosVirtual.get(i).codigoItem!=30){
                       _minutoFinal+=_minutos;
                        if(modeloListaTipoDocumentosVirtual.get(i).codigoItem==1){
                            _resultadoHorasSeleccionadas+="  when tiempoResolucion>="+_minutoInicial.toString()+" and tiempoResolucion<"+(_minutoInicial+60*modeloListaTipoDocumentosVirtual.get(i).codigoItem).toString()+" then 'Entre "+(_minutoInicial/60).toString() +" y "+modeloListaTipoDocumentosVirtual.get(i).codigoItem+" hora'";
                        }else{
                            _resultadoHorasSeleccionadas+="  when tiempoResolucion>="+_minutoInicial.toString()+" and tiempoResolucion<"+(_minutoFinal).toString()+" then 'Entre "+(_minutoInicial/60).toString() +" y "+modeloListaTipoDocumentosVirtual.get(i).codigoItem+" horas'";

                        }
                        _minutoInicial=_minutoFinal;


                    //}//else if(modeloListaTipoDocumentosVirtual.get(i).codigoItem==9){

                     //   _resultadoHorasSeleccionadas+="  when tiempoResolucion>=1440 then 'La incidencia reportada necesitó análisis de desarrollo' ";
                    //}
                }else{
                    _minutoFinal+=_minutos;
                }

            }

            //Modificación en versión 1.15.0, se camia el texto del mensaje
            //_resultadoHorasSeleccionadas+="  when tiempoResolucion>="+_minutoInicial+" then 'La incidencia reportada necesitó análisis de desarrollo' ";
            _resultadoHorasSeleccionadas+="  when tiempoResolucion>="+_minutoInicial+" then 'Investigación de la causa raíz de la incidencia reportada' ";

            _resultadoHorasSeleccionadas+=" else 'Otro' end ,tiempoResolucion, sum(tiempoResolucion), sum(tiempoResolucion)/sum(1)   FROM Reclamos REC  where 1=1 "

            //console.log(_resultadoHorasSeleccionadas)


        }else{
            _resultadoHorasSeleccionadas="";
        }


        _filtroConsultaRespaldo=_filtroWhereDeConsulta



        var estadoGeneracionReporte=modeloReportes.generarReporte(_filtroWhereDeConsulta,cxbSoloCuadroReclamos.chekActivo,cxbExcluirCausasExternas.chekActivo,links,cxbOcultarReclamosSinCausaExterna.chekActivo,cxbCuadroAsistencias.chekActivo,_resultadoHorasSeleccionadas,cxbFusionarCausasExternas.chekActivo,id_codigoPerfilesTiempoResolucion);

        if(estadoGeneracionReporte=="1"){


            web_view1.url="file://"+modeloReportes.retornaDirectorioReporteWeb();
            web_view1.reload.trigger()


        }else if(estadoGeneracionReporte=="0"){


        }else if(estadoGeneracionReporte=="-1"){

        }
    }
    MouseArea {
        id: mouseAreaProtectorClicReporte
        clip: true
        anchors.topMargin: 120
        anchors.bottomMargin: 2
        anchors.rightMargin: 2
        anchors.leftMargin: 2
        anchors.fill: parent

        onWidthChanged: {

            web_view1.preferredWidth=mouseAreaProtectorClicReporte.width
            flickable.contentWidth=web_view1.implicitWidth

        }
        onHeightChanged: {


            web_view1.preferredHeight=mouseAreaProtectorClicReporte.height
            flickable.contentHeight=web_view1.implicitHeight

        }

        Flickable {
            id: flickable
            x: 0
            y: 70
            boundsBehavior: Flickable.DragAndOvershootBounds
            flickableDirection: Flickable.VerticalFlick
            anchors.topMargin: 0
            clip: false
            interactive: true
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: web_view1.preferredHeight
            WebView {
                id: web_view1
                settings.minimumFontSize: 13
                smooth: true
                back.enabled: true
                back.visible: false
                forward.visible: false
                forward.enabled: true
                reload.visible: false

                settings.javascriptEnabled: true
                anchors.fill: parent
                settings.defaultFontSize: 13
                settings.defaultFixedFontSize: 13
                visible: true
                settings.javaEnabled: true
                settings.localContentCanAccessRemoteUrls: true
                settings.linksIncludedInFocusChain: true
                settings.javascriptCanOpenWindows: true
                settings.javascriptCanAccessClipboard: true
                enabled: true
                z: 1
                focus: false
                settings.standardFontFamily: "Arial"
                preferredHeight: mouseAreaProtectorClicReporte.height
                preferredWidth: mouseAreaProtectorClicReporte.width
                reload.onTriggered: {
                    web_view1.preferredWidth=mouseAreaProtectorClicReporte.width
                    web_view1.preferredHeight=mouseAreaProtectorClicReporte.height
                    flickable.contentWidth=web_view1.implicitWidth
                    flickable.contentHeight=web_view1.implicitHeight

                }


                onLoadFinished: {

                    web_view1.preferredWidth=mouseAreaProtectorClicReporte.width
                    web_view1.preferredHeight=mouseAreaProtectorClicReporte.height
                    flickable.contentWidth=web_view1.implicitWidth
                    flickable.contentHeight=web_view1.implicitHeight

                }
            }
            focus: true
        }


        Rectangle {
            id: scrollbar
            x: 2
            y: flickable.visibleArea.yPosition * flickable.height+3
            width: 10
            height: flickable.visibleArea.heightRatio * flickable.height
            color: "#000000"
            radius: 3
            smooth: true
            visible: true
            anchors.rightMargin: 2
            z: 2
            anchors.right: parent.right
            opacity: 0.450
        }

        Rectangle {
            id: rectangle1
            height: lblInformacionDeGeneracion.implicitHeight
            color: "#6e1c3f8f"
            anchors.left: parent.left
            anchors.leftMargin: -10
            anchors.right: parent.right
            anchors.rightMargin: -10
            opacity: 0
            smooth: true
            anchors.verticalCenter: parent.verticalCenter
            z: 3

            Text {
                id: lblInformacionDeGeneracion
                x: -90
                y: 79
                color: "#f98a0a"
                text: qsTr("Reporte PDF generado correctamente")
                anchors.verticalCenter: parent.verticalCenter
                rotation: 0
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                styleColor: "#3a3e44"
                opacity: 1
                style: Text.Sunken
                smooth: true
                font.italic: false
                font.family: "Arial"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                z: 1
                font.pixelSize: 36
            }
        }
    }

    MouseArea {
        id: mouse_area1
        anchors.bottom: mouseAreaProtectorClicReporte.top
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        onDoubleClicked: doubleClic()

        /// Esto controla que si se maximizo la ventana, no se pueda mover
        //drag.target: _maximizado ? null : rectPreviewReporte
        drag.target: rectPreviewReporte

        BotonSimple {
            id: btnCerrarReporte
            x: 10
            y: 10
            opacidadRectangulo: 0.100
            anchors.left: parent.left
            anchors.top: parent.top
            textoBoton: "Cerrar"
            estaPrecionado: false
            anchors.topMargin: 10
            negrita: true
            opacidadTexto: 1
            estilo: 0
            z: 2
            anchors.leftMargin: 10
            colorTextoBoton: "#f79963"
            modoBotonPrecionado: false
            onClicBoton: {
                clicCerrarReporte()
            }
        }


        BotonSimple {
            id: btnGenerarPDF
            y: 0
            opacidadRectangulo: 0.100
            anchors.right: parent.right
            anchors.rightMargin: 50
            textoBoton: "Generar  PDF"
            estaPrecionado: false
            anchors.top: parent.top
            anchors.topMargin: 10
            negrita: true
            opacidadTexto: 1
            estilo: 0
            z: 2
            colorTextoBoton: "#f79963"
            modoBotonPrecionado: false
            onClicBoton: {

                cargarReporte(_filtroConsultaRespaldo,true)
                if(modeloReportes.imprimirReporteEnPDF(_filtroConsultaRespaldo)){
                    lblInformacionDeGeneracion.color="#f98a0a"
                    lblInformacionDeGeneracion.text="Reporte PDF generado correctamente"
                    lblInformacionDeGeneracionOpacidadOff.stop()
                    lblInformacionDeGeneracionOpacidadIn.stop()
                    txtMensajeInformacionTimer.stop()
                    lblInformacionDeGeneracionOpacidadIn.start()
                    txtMensajeInformacionTimer.start()
                }else{
                    lblInformacionDeGeneracion.color="#f31818"
                    lblInformacionDeGeneracion.text="Error al generar el reporte PDF"
                    lblInformacionDeGeneracionOpacidadOff.stop()
                    lblInformacionDeGeneracionOpacidadIn.stop()
                    txtMensajeInformacionTimer.stop()
                    lblInformacionDeGeneracionOpacidadIn.start()
                    txtMensajeInformacionTimer.start()
                }
            }
        }

        BotonSimple {
            id: btnAbrirCarpeta
            y: 10
            opacidadRectangulo: 0.100
            anchors.right: parent.right
            anchors.rightMargin: 50
            textoBoton: "Abrir carpeta"
            estaPrecionado: false
            anchors.top: btnGenerarPDF.bottom
            anchors.topMargin: 10
            negrita: true
            opacidadTexto: 1
            estilo: 0
            z: 2
            colorTextoBoton: "#f79963"
            modoBotonPrecionado: false
            onClicBoton: modeloReportes.abrirNavegadorArchivos()
        }

        BotonFlecha {
            id: btnWebIzquierdaBack
            x: 44
            y: 46
            opacidadRectPrincipal: 0.500
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaIzquierda.png"
            border.color: "#ffffff"
            z: 12
            enabled: true
            onClic: web_view1.back.trigger()
        }

        BotonFlecha {
            id: btnWebDerechaFoward
            x: 81
            y: 302
            opacidadRectPrincipal: 0.500
            anchors.left: btnWebIzquierdaBack.right
            anchors.leftMargin: 15
            border.color: "#ffffff"
            source: "qrc:/qml/LectorAlmacenDeDatos/Imagenes/FlechaDerecha.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            enabled: true
            z: 11
            onClic: web_view1.forward.trigger()
        }

        BotonBarraDeHerramientas {
            id: btnMaximizarRestaurar
            x: 863
            width: 32
            height: 32
            opacidad: 0.8
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            smooth: true
            anchors.topMargin: 10
            z: 2
            onClic: maximizarRestaurar()
            source: {
                if(_maximizado){
                    "qrc:/qml/LectorAlmacenDeDatos/Imagenes/Restaurar.png"
                }else{
                    "qrc:/qml/LectorAlmacenDeDatos/Imagenes/Maximizar.png"
                }
            }
        }

        Flow {
            id: flow2
            z: 14
            spacing: 10
            anchors.right: btnAbrirCarpeta.left
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 105
            anchors.top: parent.top
            anchors.topMargin: 5
            flow: Flow.TopToBottom

            ComboBoxCheckBox {
                id: cbxListaHorasTiempoResolucion
                width: 160
                z: 2
                textoTitulo: "Tiempo de resolucion:"
                botonBuscarTextoVisible: false
                modeloItems:    modeloListaTipoDocumentosVirtual
                textoComboBox: "0 seleccionados"

                onCloseComboBox: {
                    cargarReporte(_filtroConsultaRespaldo,false)
                }
            }


            CheckBox {
                id: cxbSoloCuadroReclamos
                colorTexto: "#e2e1e1"
                textoValor: "Ocultar reclamos"
                chekActivo: false
                onChekActivoChanged: {

                    cargarReporte(_filtroConsultaRespaldo,false)

                }
            }

            CheckBox {
                id: cxbOcultarReclamosSinCausaExterna
                textoValor: "Ocultar reclamos sin causa externa"
                chekActivo: true
                colorTexto: "#e2e1e1"
                onChekActivoChanged: {
                    cargarReporte(_filtroConsultaRespaldo,false)
                }
            }
            CheckBox {
                id: cxbExcluirCausasExternas
                textoValor: "Excluir cuadro causas externas"
                chekActivo: false
                colorTexto: "#e2e1e1"
                onChekActivoChanged: {

                    cargarReporte(_filtroConsultaRespaldo,false)

                }
            }



            CheckBox {
                id: cxbCuadroAsistencias
                textoValor: "Ocultar cuadro de tiempos"
                chekActivo: false
                colorTexto: "#e2e1e1"
                onChekActivoChanged: {
                    cargarReporte(_filtroConsultaRespaldo,false)
                }
            }

            CheckBox {
                id: cxbFusionarCausasExternas
                chekActivo: true
                textoValor: "Fusionar causas externas"
                colorTexto: "#e2e1e1"
                onChekActivoChanged: {
                    cargarReporte(_filtroConsultaRespaldo,false)
                }
            }




        }

        Flow {
            id: flow1
            x: 200
            y: 104
            visible: true
            z: 0
            spacing: {

                if(rectPreviewReporte.width>=900 && rectPreviewReporte.width<=1000){
                    rectPreviewReporte.width/28
                }else{
                    rectPreviewReporte.width/18
                }


            }
            anchors.bottom: mouseAreaProtectorClicReporte.top
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 104
            anchors.right: parent.right
            anchors.rightMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: {

                if(rectPreviewReporte.width>=900 && rectPreviewReporte.width<=1000){
                    200
                }else{
                    rectPreviewReporte.width/3.7
                }



            }


            Text {
                id: lblSucursal
                x: 66
                y: 12
                color: "#ffffff"
                text: qsTr("SUCURSAL")
                styleColor: "#9e9d9d"
                style: Text.Sunken
                font.bold: true
                font.family: "Verdana"
                smooth: true
                font.pixelSize: 13
            }

            Text {
                id: lblAsistencias
                x: 64
                y: 16
                color: "#ffffff"
                text: qsTr("ASISTENCIAS")
                smooth: true
                font.pixelSize: 13
                style: Text.Sunken
                styleColor: "#9e9d9d"
                font.family: "Verdana"
                font.bold: true
            }

            Text {
                id: lblHardware
                x: 67
                y: 20
                color: "#ffffff"
                text: qsTr("HARDWARE")
                smooth: true
                font.pixelSize: 13
                style: Text.Sunken
                styleColor: "#9e9d9d"
                font.bold: true
                font.family: "Verdana"
            }

            Text {
                id: lblSistemas
                x: 72
                y: 16
                color: "#ffffff"
                text: qsTr("SISTEMAS")
                smooth: true
                font.pixelSize: 13
                style: Text.Sunken
                styleColor: "#9e9d9d"
                font.family: "Verdana"
                font.bold: true
            }

            Text {
                id: lblFueraHorario
                x: 80
                y: 22
                color: "#ffffff"
                text: qsTr("GUARDIA")
                smooth: true
                font.pixelSize: 13
                style: Text.Sunken
                styleColor: "#9e9d9d"
                font.bold: true
                font.family: "Verdana"
            }

            Text {
                id: lblCoordinado
                x: 77
                y: 12
                color: "#ffffff"
                text: qsTr("COORDINADO")
                smooth: true
                font.pixelSize: 13
                style: Text.Sunken
                styleColor: "#9e9d9d"
                font.family: "Verdana"
                font.bold: true
            }
        }

    }
    Timer{
        id:txtMensajeInformacionTimer
        repeat: false
        interval: 2000
        onTriggered: {
            lblInformacionDeGeneracionOpacidadIn.stop()
            lblInformacionDeGeneracionOpacidadOff.start()
        }
    }
    PropertyAnimation{
        id:lblInformacionDeGeneracionOpacidadIn
        target: rectangle1
        property: "opacity"
        from:0
        to:1
        duration: 200
    }
    PropertyAnimation{
        id:lblInformacionDeGeneracionOpacidadOff
        target: rectangle1
        property: "opacity"
        from:1
        to:0
        duration: 2000
    }
}
