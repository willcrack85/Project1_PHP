<?php
require_once('encuesta.class.php');

$obj = new Encuesta();
if (isset($_POST['encuestaD'])) {
    $nombre = getValue('nombre');
    $apellido = getValue('apellido');
    $sexo = getValue('sexo');
    $edad = getValue('edad');
    $salario = getValue('salario');
    $provincia = getValue('provincia');

    $id = $obj->GuardarEncuestado($nombre, $apellido, $sexo, $edad, $salario, $provincia);

    $respuestas = [];
    $controles = $_POST['radios'] + $_POST['checkboxes'];
    foreach ($controles as $pregunta_id => $respuesta_id) {
        if (is_array($respuesta_id)) {
            foreach ($respuesta_id as $pregunta_id_ck => $respuesta_id_ck) {
                //Guardar respuesta a pregunta de checkbox ** Multiple respuesta ** 
                $obj->SavePreguntas($pregunta_id, $respuesta_id_ck, $id, '');
            }
        } else {
            //Guardar respuesta simple o binaria
            $obj->SavePreguntas($pregunta_id, $respuesta_id, $id, '');
        }
    }
    //echo "<script> alert('Se ha guardado el registro'); </script>";

    echo "Completado satisfactoriamente <br/> <a href='./' >Volver al menú principal</a>";
    if (DEBUG) {
        foreach ($_POST as $key => $value) {
            echo "key: $key value: $value<br/>";
        }
    }
} else {
    echo "No hay datos que procesar";
    exit();
}

function getValue($key)
{
    return isset($_POST[$key]) ? $_POST[$key] : null;
}
