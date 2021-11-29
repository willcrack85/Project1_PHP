<?php

require_once('conexion_db.php');

class Salario
{
    protected $DB;
    protected $cantidad;

    public function __construct()
    {
        $this->DB = new Conexion_DB();
        $this->cantidad = 10;
    }

    public function ListarSalarios()
    {
        $consulta = $this->DB->QuerySQL("call usp_listar_salarios()");
        return $consulta;
    }
}
