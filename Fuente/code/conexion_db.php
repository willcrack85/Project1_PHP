<?php
require_once('config.php');
class Conexion_DB {
    protected $conexion;
    public $insert_id;
    public function __construct()
    {
        $this->conexion =  new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
        if ($this->conexion->connect_error) {
            die('Error de Conexión (' . $this->conexion->connect_errno . ') '
                    . $this->conexion->connect_error);
        }
        if (!$this->conexion->set_charset("utf8")) {
          printf("Error cargando el conjunto de caracteres utf8: %s\n", $this->conexion->error);
          exit();
        }
    }
    public function QuerySQL($String, $type = null, ...$parameters){
        //$res = $this->conexion->query($String) or die($this->conexion->error);
        //return $res;
        $stmt = $this->conexion->prepare($String);
        if (isset($type)) {
            $stmt->bind_param($type, ...$parameters);
        }
        
        $stmt->execute();
        return $stmt->get_result();
        $stmt->close();
    }
    public function close(){
        $this->conexion->close();
    }
}