// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: rectPrincipal
    width: 950
    height: 81
    color: "#00000000"
    radius: 3
    smooth: true

    property string cantidadRegistrosSeleccionados: "0"

    property string asistenciasSubTotal:"0"
    property string tiempoPromedioMesaEntradaSubTotal:"00:00"
    property string tiempoPromedioEstadoNuevoSubTotal:"00:00"
    property string tiempoPromedioEstadoAsignadoSubTotal:"00:00"
    property string tiempoPromedioEsperaRespuestaClienteSubTotal:"00:00"
    property string tiempoPromedioEsperaRespuestaObjetosSubTotal:"00:00"
    property string tiempoPromedioTareasSubTotal:"00:00"
    property string tiempoPromedioResolucionSubTotal:"00:00"


    property string asistenciasPorcentaje:"0.00%"
    property string tiempoPromedioMesaEntradaPorcentaje:"0.00%"
    property string tiempoPromedioEstadoNuevoPorcentaje:"0.00%"
    property string tiempoPromedioEstadoAsignadoPorcentaje:"0.00%"
    property string tiempoPromedioEsperaRespuestaClientePorcentaje:"0.00%"
    property string tiempoPromedioEsperaRespuestaObjetosPorcentaje:"0.00%"
    property string tiempoPromedioTareasPorcentaje:"0.00%"
    property string tiempoPromedioResolucionPorcentaje:"0.00%"


    property string asistenciasTotal:"0"
    property string tiempoPromedioMesaEntradaTotal:"00:00"
    property string tiempoPromedioEstadoNuevoTotal:"00:00"
    property string tiempoPromedioEstadoAsignadoTotal:"00:00"
    property string tiempoPromedioEsperaRespuestaClienteTotal:"00:00"
    property string tiempoPromedioEsperaRespuestaObjetosTotal:"00:00"
    property string tiempoPromedioTareasTotal:"00:00"
    property string tiempoPromedioResolucionTotal:"00:00"







    Rectangle {
        id: rectRegistrosSelecionados
        height: 19
        color: "#423c7a"
        smooth: true
        anchors.right: parent.right
        anchors.rightMargin: 1
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: parent.left
        anchors.leftMargin: 1

        Text {
            id: lblCantidadSeleccionados
            x: 20
            y: 4
            color: "#959595"
            text: qsTr("Cantidad seleccionados:")
            anchors.right: rectMarca.left
            anchors.rightMargin: 10
            horizontalAlignment: Text.AlignRight
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            style: Text.Normal
            font.bold: true
            font.family: "Verdana"
            font.pixelSize: 14
        }

        Rectangle {
            id: rectMarca
            width: 1
            color: "#ffffff"
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            visible: false
        }

        Text {
            id: txtCantidadRegistrosSeleccionados
            y: 1
            color: "#959595"
            text: cantidadRegistrosSeleccionados
            anchors.left: rectMarca.right
            anchors.leftMargin: 10
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: rectSubTotal
        x: -7
        y: -6
        height: 19
        color: "#c8423c7a"
        smooth: true
        anchors.top: rectRegistrosSelecionados.bottom
        anchors.topMargin: 1
        anchors.rightMargin: 1
        anchors.right: parent.right
        anchors.leftMargin: 1
        anchors.left: parent.left

        Text {
            id: lblSubTotal
            y: 4
            color: "#fafafa"
            text: qsTr("Sub total:")
            anchors.right: rectMarca1.left
            anchors.rightMargin: 10
            font.pixelSize: 14
            style: Text.Sunken
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: true
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: rectMarca1
            width: 1
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            visible: false
            anchors.bottomMargin: 0
            anchors.leftMargin: 220
            anchors.left: parent.left
        }

        Text {
            id: txtTiempoPromedioResolucionSubTotal
            y: 8
            visible: modeloReclamos.accesoCompleto()
            color: "#f9f9f9"
            text: tiempoPromedioResolucionSubTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioTareasSubTotal
            y: 8
            visible: modeloReclamos.accesoCompleto()
            color: "#f9f9f9"
            text: tiempoPromedioTareasSubTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 100
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtAsistenciasSubTotal
            x: 11
            y: 1
            color: "#f9f9f9"
            text: asistenciasSubTotal
            smooth: true
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

        Text {
            id: txtTiempoPromedioMesaEntradaSubTotal
            x: 15
            visible: modeloReclamos.accesoCompleto()
            y: 2
            color: "#f9f9f9"
            text: tiempoPromedioMesaEntradaSubTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 610
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioEstadoNuevoSubTotal
            x: 17
            visible: modeloReclamos.accesoCompleto()
            y: 0
            color: "#f9f9f9"
            text: tiempoPromedioEstadoNuevoSubTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 500
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioEstadoAsignadoSubTotal
            x: 26
            visible: modeloReclamos.accesoCompleto()
            y: 5
            color: "#f9f9f9"
            text: tiempoPromedioEstadoAsignadoSubTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 390
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioEsperaRespuestaClienteSubTotal
            y: -4
            visible: modeloReclamos.accesoCompleto()
            color: "#f9f9f9"
            text: tiempoPromedioEsperaRespuestaClienteSubTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 280
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioEsperaRespuestaObjetosSubTotal
            y: 2
            visible: modeloReclamos.accesoCompleto()
            color: "#f9f9f9"
            text: tiempoPromedioEsperaRespuestaObjetosSubTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 185
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: rectPorcentaje
        x: -6
        y: -14
        height: 19
        color: "#423c7a"
        smooth: true
        anchors.top: rectSubTotal.bottom
        anchors.topMargin: 1
        anchors.rightMargin: 1
        anchors.right: parent.right
        anchors.leftMargin: 1
        anchors.left: parent.left

        Rectangle {
            id: rectMarca2
            width: 1
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            visible: false
            anchors.bottomMargin: 0
            anchors.leftMargin: 220
            anchors.left: parent.left
        }

        Text {
            id: lblPromedioPorcentaje
            y: 4
            color: "#f9f9f9"
            text: qsTr("Porcentaje %:")
            smooth: true
            font.pixelSize: 14
            style: Text.Sunken
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.family: "Verdana"
            anchors.right: rectMarca2.left
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioResolucionPorcentaje
            y: 8
            visible: modeloReclamos.accesoCompleto()
            color: "#f9f9f9"
            text: tiempoPromedioResolucionPorcentaje
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioTareasPorcentaje
            x: 0
            y: 8
            visible: modeloReclamos.accesoCompleto()
            color: "#f9f9f9"
            text: tiempoPromedioTareasPorcentaje
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 100
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtAsistenciasPorcentaje
            x: 11
            y: 1
            color: "#f9f9f9"
            text: asistenciasPorcentaje
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 715
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioMesaEntradaPorcentaje
            x: 15
            visible: modeloReclamos.accesoCompleto()
            y: 2
            color: "#f9f9f9"
            text: tiempoPromedioMesaEntradaPorcentaje
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 610
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioEstadoNuevoPorcentaje
            x: 17
            visible: modeloReclamos.accesoCompleto()
            y: 0
            color: "#f9f9f9"
            text: tiempoPromedioEstadoNuevoPorcentaje
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 500
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioEstadoAsignadoPorcentaje
            x: 26
            visible: modeloReclamos.accesoCompleto()
            y: 5
            color: "#f9f9f9"
            text: tiempoPromedioEstadoAsignadoPorcentaje
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 390
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioEsperaRespuestaClientePorcentaje
            y: -4
            visible: modeloReclamos.accesoCompleto()
            color: "#f9f9f9"
            text: tiempoPromedioEsperaRespuestaClientePorcentaje
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 280
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioEsperaRespuestaObjetosPorcentaje
            y: 2
            visible: modeloReclamos.accesoCompleto()
            color: "#f9f9f9"
            text: tiempoPromedioEsperaRespuestaObjetosPorcentaje
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 185
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: rectTotal
        x: 3
        y: -18
        height: 19
        color: "#c8423c7a"
        smooth: true
        anchors.top: rectPorcentaje.bottom
        anchors.topMargin: 1
        anchors.rightMargin: 1
        anchors.right: parent.right
        anchors.leftMargin: 1
        anchors.left: parent.left

        Rectangle {
            id: rectMarca3
            width: 1
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            visible: false
            anchors.bottomMargin: 0
            anchors.leftMargin: 220
            anchors.left: parent.left
        }

        Text {
            id: lblTotal
            y: 4
            color: "#f9f9f9"
            text: qsTr("Total:")
            smooth: true
            font.pixelSize: 14
            style: Text.Sunken
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: true
            anchors.right: rectMarca3.left
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioResolucionTotal
            y: 8
            color: "#f9f9f9"
            text: tiempoPromedioResolucionTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            visible: modeloReclamos.accesoCompleto()
        }

        Text {
            id: txtTiempoPromedioTareasTotal
            x: -4
            y: 4
            color: "#f9f9f9"
            text: tiempoPromedioTareasTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 100
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            visible: modeloReclamos.accesoCompleto()
        }

        Text {
            id: txtAsistenciasTotal
            x: 11
            y: 1
            color: "#f9f9f9"
            text: asistenciasTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 715
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: txtTiempoPromedioMesaEntradaTotal
            x: 15
            y: 2
            color: "#f9f9f9"
            text: tiempoPromedioMesaEntradaTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 610
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            visible: modeloReclamos.accesoCompleto()
        }

        Text {
            id: txtTiempoPromedioEstadoNuevoTotal
            x: 17
            y: 0
            color: "#f9f9f9"
            text: tiempoPromedioEstadoNuevoTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 500
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            visible: modeloReclamos.accesoCompleto()
        }

        Text {
            id: txtTiempoPromedioEstadoAsignadoTotal
            x: 26
            y: 5
            color: "#f9f9f9"
            text: tiempoPromedioEstadoAsignadoTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 390
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            visible: modeloReclamos.accesoCompleto()
        }

        Text {
            id: txtTiempoPromedioEsperaRespuestaClienteTotal
            y: -4
            color: "#f9f9f9"
            text: tiempoPromedioEsperaRespuestaClienteTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 280
            anchors.verticalCenter: parent.verticalCenter
            font.bold: false
            font.family: "Verdana"
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            visible: modeloReclamos.accesoCompleto()
        }

        Text {
            id: txtTiempoPromedioEsperaRespuestaObjetosTotal
            y: 2
            color: "#f9f9f9"
            text: tiempoPromedioEsperaRespuestaObjetosTotal
            smooth: true
            font.pixelSize: 14
            style: Text.Normal
            anchors.rightMargin: 185
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Verdana"
            font.bold: false
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            visible: modeloReclamos.accesoCompleto()
        }
    }
}
