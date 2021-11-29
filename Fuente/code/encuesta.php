<?php
    require_once('encuesta.class.php');
    require_once('sexo.class.php');
    require_once('edad.class.php');
    require_once('salario.class.php');
    require_once('provincia.class.php');
    $obj = new Encuesta();
    $data = $obj->GenerarPreguntas();
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Proyecto #1 | Encuesta</title>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="scripts/utilitario.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="container mt-5" style="font-family: 'Source Sans Pro',sans-serif;">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card" style="border-top: 3px solid #d2d6de;border-top-color: #3c8dbc;">
                        <div class="card-header bg-white" style="border-bottom: 1px solid #f4f4f4;display: inline-block; font-size: 18px;margin: 0;line-height: 1;">Encuesta</div>
                        <div class="card-body" style="font-family: 'Source Sans Pro','Helvetica Neue',Helvetica,Arial,sans-serif;font-weight: 400;">
                            <form id="frmEncuesta" action="procesar_encuesta.php" method="POST">
                                <div class="row">
                                    <input type="hidden" name="encuestaD" value="1">
                                    <div class="form-group required control-label col-md-4">
                                        <label for="nombre">Nombre</label>
                                        <input class="form-control" type="text" name="nombre" id="nombre" value="" placeholder="Ingrese su nombre aquí">
                                    </div>
                                    <div class="form-group required control-label col-md-4">
                                        <label for="apellido">Apellido</label>
                                        <input class="form-control" type="text" name="apellido" id="apellido" value="" placeholder="Ingrese su apellido aquí">
                                    </div>
                                    <div class="form-group required control-label col-md-4">
                                        <label for="sexo">Sexo</label>
                                        <select class="form-control" name="sexo" id="sexo">
                                            <option value="" selected disabled>Seleccione una opción</option>
                                            <?php
                                                $dbobj = new Sexo();
                                                $result = $dbobj->ListarSexos();
                                                while($item = $result->fetch_assoc()) {
                                                    echo "<option value='$item[id]'>$item[descripcion]</option>";
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div class="form-group required control-label col-md-4">
                                        <label for="edad">Rango de edad</label>
                                        <select class="form-control" name="edad" id="edad">
                                            <option value="" selected disabled>Seleccione una opción</option>
                                            <?php
                                                $dbobj = new Edad();
                                                $result = $dbobj->ListarEdades();
                                                while($item = $result->fetch_assoc()) {
                                                    echo "<option value='$item[id]'>$item[descripcion]</option>";
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div class="form-group required control-label col-md-4">
                                        <label for="salario">Rango de salario</label>
                                        <select class="form-control" name="salario" id="salario">
                                            <option value="" selected disabled>Seleccione una opción</option>
                                            <?php
                                                $dbobj = new Salario();
                                                $result = $dbobj->ListarSalarios();
                                                while($item = $result->fetch_assoc()) {
                                                    echo "<option value='$item[id]'>$item[descripcion]</option>";
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div class="form-group required control-label col-md-4">
                                        <label for="provincia">Provincia</label>
                                        <select class="form-control" name="provincia" id="provincia">
                                            <option value="" selected disabled>Seleccione una opción</option>
                                            <?php
                                                $dbobj = new Provincia();
                                                $result = $dbobj->ListarProvincias();
                                                while($item = $result->fetch_assoc()) {
                                                    echo "<option value='$item[id]'>$item[nombre]</option>";
                                                }
                                            ?>
                                       </select>
                                    </div>
                                    <div class="col-md-12">
                                        <h2>Preguntas</h2>
                                        <ol>
                                            <?php
                                                while($item = $data->fetch_assoc()) {
                                                    $respuestas = $obj->ObtenerRespuestas($item['id']);
                                                    echo "<li>" . html_entity_decode($item['pregunta']);
                                                    switch($item['tipo_pregunta']) {
                                                        case 'Binaria':
                                                        case 'Simple':
                                                           while($a = $respuestas->fetch_assoc()) {
                                                               echo "<br/><input class='form-check-input' type='radio' id='radio_$item[id]' name='radios[$item[id]]' value='$a[id]'><label class='form-check-label' for='radio_$item[id]'>$a[respuesta]</label>";
                                                           }
                                                           break;
                                                       case 'Multiple':
                                                           while($a = $respuestas->fetch_assoc()) {
                                                               echo "<br/><input class='form-check-input' type='checkbox' id='checkbox_$item[id]' name='checkboxes[$item[id]][$a[id]]' value='$a[id]'><label class='form-check-label' for='checkbox_$item[id]'>$a[respuesta]</label>";
                                                           }
                                                           break;
                                                       default:
                                                           # code...
                                                           break;
                                                   }
                                                   # Aquí debe ir un error invisible, para mostrarlo al hacer validar si se ha seleccionado
                                                   echo "<div id='error_$item[id]' name='errors' class='alert alert-danger' style='display:none' role='alert'></div>";
                                                   echo "</li>";
                                                }
                                            ?>
                                        </ol>
                                    </div>
                                    <div>
                                        <div>
                                            <button class="btn btn-primary" type="submit" onclick="return validar('frmEncuesta');">Guardar</button>
                                            <a class="btn btn-secondary" href="./">Cancelar</a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>