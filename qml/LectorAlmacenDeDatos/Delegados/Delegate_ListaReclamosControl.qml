import QtQuick 1.1
import "../Controles"

Rectangle{
    id: rectListaItem
    width: parent.width
    // width: 2024
    height: 20
    //color: "#f5f2f0"
    color:colorRectangulo
    radius: 1
    border.width: 1
    border.color: "#aaaaaa"
    smooth: true
    opacity: 1

    property string codigoReclamoMenor: primerFiltroControl
    property string codigoReclamoMayor: segundoFiltroControl
    property bool seleccionado: false
    property string descripcionCampoComodin: campoComodinNombre
    property string colorRectangulo: colorFilaRectangulo

    signal clicSolo
    signal clicMasControl
    signal clicMasShift
    signal dobleClic


    function reclamoSeleccionado(valor){
        if(valor==true){
            seleccionado=valor
            rectListaItem.color="#f79963"
            txtCampoComodin.color="#f79963"
            rectAyudaSeleccion.color="#f79963"
        }else{
            seleccionado=valor
            rectListaItem.color=colorRectangulo
            txtCampoComodin.color="#f9f9f9"
            if(descripcionCampoComodin=="REC.codigoCausa"){
                if(modeloReclamos.retornarSiCausaEsAtribuibleACliente(campoComodin)){
                    rectAyudaSeleccion.color="#8c3c7c"
                }else{
                    rectAyudaSeleccion.color="#423c7a"
                }
            }else{
                rectAyudaSeleccion.color="#423c7a"
            }

        }
    }

    MouseArea{
        id: mouseAreaItemReclamo
        z: 3
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if ((mouse.button == Qt.LeftButton) && (mouse.modifiers & Qt.ShiftModifier)){
                reclamoSeleccionado(true)
                clicMasShift()
            }else if ((mouse.button == Qt.LeftButton) && (mouse.modifiers & Qt.ControlModifier)){
                reclamoSeleccionado(true)
                clicMasControl()
            }else{
                if(seleccionado){
                    clicSolo()
                }else{
                    reclamoSeleccionado(true)
                    clicSolo()

                }
            }
        }
        onDoubleClicked: {
            dobleClic()
            if(descripcionCampoComodin=="codigoReclamo" || descripcionCampoComodin=="REC.codigoReclamo")
                reclamosTareasPrevisualizacion.cargarTareasDeReclamo(txtCampoComodin.text.trim())


        }
    }
    Rectangle {
        id: rectangle1
        width: 220
        color: "#423c7a"
        smooth: true
        anchors.left: parent.left
        anchors.leftMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0


        Text {
            id: txtCampoComodin
            color: "#f9f9f9"
            text: {
                if(descripcionCampoComodin=="codigoReclamo" || descripcionCampoComodin=="REC.codigoReclamo"){
                    campoComodin
                }else if(descripcionCampoComodin=="REC.codigoMes"){
                    campoComodin+" - "+modeloReclamos.retornarNombreDelMes(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoDiaSemana"){
                    campoComodin+" - "+modeloReclamos.retornarNombreDelDiaDeSemana(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoCliente"){
                    modeloReclamos.retornarNombreCliente(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoMarca"){
                    modeloReclamos.retornarNombreMarca(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoModelo"){
                    modeloReclamos.retornarNombreModelo(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoTecnicoResponsable"){
                    modeloReclamos.retornarNombreTecnicoResponsable(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoArea"){
                    modeloReclamos.retornarNombreArea(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoTipoReclamo"){
                    modeloReclamos.retornarNombreTipoReclamo(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoCausa"){
                    modeloReclamos.retornarNombreCausa(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoDepartamento"){
                    modeloReclamos.retornarNombreDepartamento(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoCoordinado"){
                    modeloReclamos.retornarNombreCoordinado(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoCamino"){
                    modeloReclamos.retornarNombreCamino(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoSintoma"){
                    modeloReclamos.retornarNombreSintoma(campoComodin)
                }else if(descripcionCampoComodin=="REC.codigoTipoReclamoCliente"){
                    modeloReclamos.retornarNombreTipoReclamoCliente(campoComodin)
                }else{
                    campoComodin
                }
            }
            anchors.top: parent.top
            anchors.topMargin: 1
            clip: true
            anchors.right: parent.right
            anchors.rightMargin: 10
            verticalAlignment: Text.AlignVCenter
            style: Text.Sunken
            font.bold: true
            font.family: "Verdana"
            anchors.left: parent.left
            anchors.leftMargin: 10
            smooth: true
            font.pixelSize: 14
            onTextChanged: {

                console.log("modalidad: "+modoDeCargarReclamos)

                if(descripcionCampoComodin=="REC.codigoCausa"){
                    if(modeloReclamos.retornarSiCausaEsAtribuibleACliente(campoComodin)){
                        rectangle1.color="#8c3c7c"
                        rectAyudaSeleccion.color="#8c3c7c"
                    }else{
                        rectangle1.color="#423c7a"
                    }
                }else{
                    rectangle1.color="#8c3c7c"
                    rectangle1.color="#423c7a"
                }
                if(campoOpcional!="9999999999"){
                    if(descripcionCampoComodin=="REC.codigoCliente"){
                        txtCampoComodin.font.pixelSize=14
                        rectListaItem.height=35
                        txtCampoOpcional.text=campoOpcional2

                    }else if(descripcionCampoComodin=="TAR.codigoTarea"){
                        txtCampoComodin.font.pixelSize=11
                        txtCampoComodin.text=campoOpcional

                    }else if(descripcionCampoComodin=="CON.codigoConcepto"){
                        txtCampoComodin.font.pixelSize=11
                        txtCampoComodin.text=campoOpcional
                    }
                }else{
                    txtCampoComodin.font.pixelSize=14
                    rectListaItem.height=20
                    txtCampoOpcional.text=""
                }




            }
        }
        Text {
            id: txtCampoOpcional
            x: 0
            color: "#d8d8db"
            text: ""
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            horizontalAlignment: Text.AlignLeft
            clip: true
            smooth: true
            font.pixelSize: 12
            style: Text.Normal
            anchors.rightMargin: 10
            font.bold: true
            font.family: "Verdana"
            anchors.right: parent.right
            anchors.leftMargin: 10
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
        }

        Rectangle {
            id: rectAyudaSeleccion
            width: 4
            color: "#423c7a"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            smooth: true
        }
    }

    Text {
        id: txtAsistencias
        x: 11
        color: "#3e3e3e"
        text: asistencias
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 715
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        smooth: true
        font.pixelSize: 14
        style: Text.Normal
        font.family: "Verdana"
        font.bold: false
    }

    Text {
        id: txtTiempoPromedioMesaEntrada
        x: 15
        color: "#3e3e3e"
        text: tiempoMesaEntrada
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 610
        smooth: true
        font.pixelSize: 14
        style: Text.Normal
        font.bold: false
        font.family: "Verdana"
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtTiempoPromedioEstadoNuevo
        x: 17
        color: "#3e3e3e"
        text: tiempoEstadoNuevo
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 500
        smooth: true
        font.pixelSize: 14
        style: Text.Normal
        font.family: "Verdana"
        font.bold: false
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtTiempoPromedioEstadoAsignado
        x: 26
        color: "#3e3e3e"
        text: tiempoEstadoAsignado
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 390
        smooth: true
        font.pixelSize: 14
        style: Text.Normal
        font.bold: false
        font.family: "Verdana"
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtTiempoPromedioEsperaRespuestaCliente
        x: 17
        color: "#3e3e3e"
        text: tiempoEsperaRespuestaCliente
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 280
        smooth: true
        font.pixelSize: 14
        style: Text.Normal
        font.family: "Verdana"
        font.bold: false
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtTiempoPromedioEsperaRespuestaObjetos
        x: 20
        color: "#3e3e3e"
        text: tiempoEsperaRespuestaObjetos
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 185
        smooth: true
        font.pixelSize: 14
        style: Text.Normal
        font.bold: false
        font.family: "Verdana"
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtTiempoPromedioTareas
        x: 13
        color: "#3e3e3e"
        text: tiempoTareas
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 100
        smooth: true
        font.pixelSize: 14
        style: Text.Normal
        font.family: "Verdana"
        font.bold: false
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: txtTiempoPromedioResolucion
        x: 22
        color: "#3e3e3e"
        text: tiempoResolucion
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 10
        smooth: true
        font.pixelSize: 14
        style: Text.Normal
        font.bold: false
        font.family: "Verdana"
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter

        onTextChanged: {         

            var totalDeTiempos=parseInt(tiempoEsperaRespuestaObjetosCrudo)+parseInt(tiempoEstadoAsignadoCrudo)+parseInt(tiempoEstadoNuevoCrudo);

            if(parseInt(totalDeTiempos)>parseInt(tiempoResolucionCrudo) ){

                if((totalDeTiempos-parseInt(tiempoResolucionCrudo))>=10){
                        color="red"
                        font.bold=true
                }


            }else if(parseInt(totalDeTiempos)<parseInt(tiempoResolucionCrudo)){

                if((parseInt(tiempoResolucionCrudo)-parseInt(totalDeTiempos))>=10){
                    color="blue"
                    font.bold=true
                }



            }else{
                color="#3e3e3e"
                font.bold=false
            }

        }

    }
    Text {
        id: txtBanderaParaDeseleccionarRegistros
        text: BanderaParaDeseleccionarRegistros
        visible: false
        onTextChanged: {
            if(BanderaParaDeseleccionarRegistros=="1"){
                reclamoSeleccionado(false)
            }else if(BanderaParaDeseleccionarRegistros=="2"){
                reclamoSeleccionado(true)
            }
        }
    }

    Text {
        id: marcaDistanciaAsistencia
        x: 17
        y: -5
        color: "#3e3e3e"
        visible: false
        smooth: false
        font.pixelSize: 14
        style: Text.Normal
        anchors.rightMargin: 715
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Verdana"
        font.bold: false
        anchors.right: parent.right
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
    }


}
