.pragma library

var misConsultas = new Array();
var soloConsultaSelect = new Array();
var campoComodinConsulta = new Array();
var whereDinamicoArray = new Array();
var arraydeFiltrosTextoBoton = new Array();
var campoOpcionalArray = new Array();
var groupByArray = new Array();
var primerFiltroControlArray = new Array();
var segundoFiltroControlArray = new Array();
var consultaSelectSinGroupBy = new Array();
var textoLabelCampoOpcional = new Array();




//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
////////  RETORNA INFO DE ARRAY SEGUN LA POCISION  ///////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
function laConsultasSql(_posicion) {
    return misConsultas[_posicion];
}
function laConsultasSqlSoloSelect(_posicion) {
    return soloConsultaSelect[_posicion];
}

function laConsultasCampoComodin(_posicion) {
    return campoComodinConsulta[_posicion];
}

function laConsultawhereDinamicoArray(_posicion) {
    return whereDinamicoArray[_posicion];
}
function laConsultaArraydeFiltrosTextoBoton(_posicion) {
    return arraydeFiltrosTextoBoton[_posicion];
}
function laConsultaCampoOpcionalArray(_posicion) {
    return campoOpcionalArray[_posicion];
}
function laConsultaGroupByArray(_posicion) {
    return groupByArray[_posicion];
}
function laConsultaPrimerFiltroControlArray(_posicion) {
    return primerFiltroControlArray[_posicion];
}
function laConsultaSegundoFiltroControlArray(_posicion) {
    return segundoFiltroControlArray[_posicion];
}
function laConsultaconsultaSelectSinGroupBy(_posicion) {
    return consultaSelectSinGroupBy[_posicion];
}
function laConsultaTextoLabelCampoOpcional(_posicion) {
    return textoLabelCampoOpcional[_posicion];
}


//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
////////  BORRAR LOS REGISTROS RESTANTES DEL ARRAY  //////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
function laBorrarConsultasSqlSoloSelect(_posicion) {
    delete soloConsultaSelect[_posicion];
    soloConsultaSelect.splice(_posicion,1)
}
function laBorrarConsultasSql(_posicion) {
    delete misConsultas[_posicion];
    misConsultas.splice(_posicion,1)
}
function laBorrarCampoComodinConsulta(_posicion) {
    delete campoComodinConsulta[_posicion];
    campoComodinConsulta.splice(_posicion,1)
}
function laBorrarwhereDinamicoArray(_posicion) {
    delete whereDinamicoArray[_posicion];
    whereDinamicoArray.splice(_posicion,1)
}
function laBorrarArraydeFiltrosTextoBoton(_posicion) {
    delete arraydeFiltrosTextoBoton[_posicion];
    arraydeFiltrosTextoBoton.splice(_posicion,1)
}
function laBorrarCampoOpcionalArray(_posicion) {
    delete campoOpcionalArray[_posicion];
    campoOpcionalArray.splice(_posicion,1)
}
function laBorrarGroupByArray(_posicion) {
    delete groupByArray[_posicion];
    groupByArray.splice(_posicion,1)
}
function laBorrarPrimerFiltroControlArray(_posicion) {
    delete primerFiltroControlArray[_posicion];
    primerFiltroControlArray.splice(_posicion,1)
}
function laBorrarSegundoFiltroControlArray(_posicion) {
    delete segundoFiltroControlArray[_posicion];
    segundoFiltroControlArray.splice(_posicion,1)
}
function laBorrarConsultaSelectSinGroupBy(_posicion) {
    delete consultaSelectSinGroupBy[_posicion];
    consultaSelectSinGroupBy.splice(_posicion,1)
}
function laBorrarTextoLabelCampoOpcional(_posicion) {
    delete textoLabelCampoOpcional[_posicion];
    textoLabelCampoOpcional.splice(_posicion,1)
}

