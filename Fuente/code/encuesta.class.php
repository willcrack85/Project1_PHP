<?php
    require_once('conexion_db.php');
    class Encuesta {
        protected $DB;
        protected $cantidad;
        public function __construct() {
            $this->DB = new Conexion_DB();
            $this->cantidad = 10;
        }
        
        public function GenerarPreguntas() {
            $consultaBase  = $this->DB->QuerySQL("call usp_rango_de_preguntas(?)", "s", 1);
            $resultado = $consultaBase->fetch_row();
            $min = $resultado[1];
            $max = $resultado[0];
            
            $rangos = range($min, $max);
            
            shuffle($rangos);
            $ids = array_slice($rangos, 0, 10);
            //para verlos todos comentar las dos líneas de arriba y descomentar esta de abajo
            //$ids = $rangos;
            
            $ValorIn = implode(',', $ids);
            $consulta  = $this->DB->QuerySQL("call usp_obtener_pregunta_por_id('$ValorIn')");
            return $consulta;
        }
        
        public function ObtenerRespuestas($id) {
            $consulta  = $this->DB->QuerySQL("call usp_obtener_respuesta_a_pregunta_por_id(?)", "s", $id);
            return $consulta;
        }
        
        public function GuardarEncuestado($nombre, $apellido, $sexo, $edad, $salario, $provincia) {
            try {
                //sql statement
                $insertSqlStmt = "call usp_insertar_encuestado(?,?,?,?,?,?)";
                //llamado a base de datos
                $consulta  = $this->DB->QuerySQL($insertSqlStmt, "ssiiii", $nombre, $apellido, $sexo, $edad, $salario, $provincia);
                //respuesta
                $result = $consulta->fetch_row()[0];
                return $result;
            } catch(Exception $e) {
                echo $e;
            }
        }
        
        public function SavePreguntas($pregunta_id, $respuesta_id, $encuestado_id, $texto_alternativo) {
            try {
                //sql statement
                $insertSqlStmt = "call usp_insertar_respuesta_encuestado(?,?,?,?)";
                //llamado a base de datos
                $consulta  = $this->DB->QuerySQL($insertSqlStmt, "iiis", $pregunta_id, $respuesta_id, $encuestado_id, $texto_alternativo);
                return $consulta;
            } catch(Exception $e) {
                echo $e; //    echo "<script> alert('Ha sucedido un error'); </script>";
            }
        }
        
        public function GenerarReporte($tipoReporte) {
            $consulta  = $this->DB->QuerySQL("call usp_cantidad_encuestados(?)", "s", $tipoReporte);
            return $consulta;
        }
        
        public function ObtenerEtiqueta($tabla, $id) {
            $consulta  = $this->DB->QuerySQL("call usp_obtener_etiqueta(?,?)", "si", $tabla, $id);
            return $consulta;
        }
}
