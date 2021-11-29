<?php

require_once('conexion_db.php');

class Sexo
{
    protected $DB;
    protected $cantidad;

    public function __construct()
    {
        $this->DB = new Conexion_DB();
        $this->cantidad = 10;
    }

    public function ListarSexos()
    {
        $consulta = $this->DB->QuerySQL("call usp_listar_sexos()");
        return $consulta;
    }
}
