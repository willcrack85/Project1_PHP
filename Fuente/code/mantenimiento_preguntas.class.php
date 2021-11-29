<?php
require_once("./conexion_db.php");
require_once('encuesta.class.php');

class Preguntas
{
    private $DB;

    public function __construct()
    {
        $this->DB =  new Conexion_DB();
    }
    public function showAll()
    {
        try {
            $consulta  = $this->DB->QuerySQL("call usp_listar_preguntas(?)", "i", 1);
            return $consulta;
        } catch (Exception $e) {
            echo $e;
        }
    }

    public function ObtenerRespuestas($pregunta_id)
    {
        $obj = new Encuesta();
        return $obj->ObtenerRespuestas($pregunta_id);
    }

    //Para obtener las respuestas que no estén seleccionadas en una pregunta
    public function ObtenerRespuestasSinSeleccionar($pregunta_id)
    {
        try {
            $consulta  = $this->DB->QuerySQL("call usp_listar_respuestas_no_pregunta_por_id(?)", "i", $pregunta_id);
            return $consulta;
        } catch (Exception $e) {
            echo $e;
        }
    }

    public function find($id)
    {
        try {
            $consulta  = $this->DB->QuerySQL("call usp_obtener_pregunta_por_id(?)", "s", $id);
            return $consulta;
        } catch (Exception $e) {
            echo $e;
        }
    }
    public function CreateOrUpdate($id, $pregunta, $tipo_pregunta)
    {
        if ($id != 0) {
            return $this->Update($id, $pregunta, $tipo_pregunta);
        } else {
            $consulta = $this->Create($pregunta, $tipo_pregunta);
            return $consulta->fetch_row()[0];
        }
    }
    public function Create($pregunta, $tipo_pregunta)
    {
        # 
        try {
            $consulta  = $this->DB->QuerySQL("call usp_insertar_pregunta(?,?,?)", "iss", 1, $pregunta, $tipo_pregunta);
            return $consulta;
        } catch (Exception $e) {
            echo $e;
        }
    }
    public function Update($id, $pregunta, $tipo_pregunta)
    {
        # 
        try {
            $consulta  = $this->DB->QuerySQL("call usp_actualizar_pregunta(?,?,?)", "iss", $id, $pregunta, $tipo_pregunta);
            return $consulta;
        } catch (Exception $e) {
            echo $e;
        }
    }
    public function delete($id)
    {
        try {
            $consulta  = $this->DB->QuerySQL("call usp_eliminar_pregunta(?)", "i", $id);
            return $consulta;
        } catch (Exception $e) {
            echo $e;
        }
    }

    public function insertarRespuestaAPregunta($pregunta_id, $respuesta_id)
    {
        # 
        try {
            $consulta  = $this->DB->QuerySQL("call usp_insertar_respuesta_a_pregunta(?,?)", "ii", $pregunta_id, $respuesta_id);
            return $consulta;
        } catch (Exception $e) {
            echo $e;
        }
    }
    public function removerRespuestaAPregunta($pregunta_id, $respuesta_id)
    {
        # 
        try {
            $consulta  = $this->DB->QuerySQL("call usp_remover_respuesta_a_pregunta(?,?)", "ii", $pregunta_id, $respuesta_id);
            return $consulta;
        } catch (Exception $e) {
            echo $e;
        }
    }
}
