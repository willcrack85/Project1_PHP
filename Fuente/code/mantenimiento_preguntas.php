<?php
require_once("mantenimiento_preguntas.class.php");
$id = isset($_GET['id']) ? $_GET['id'] : 0;

$obj = new Preguntas();
$buttonText = "Guardar";

//Remover alguna respuesta a la pregunta
if (isset($_POST['remover'])) {
    $obj->removerRespuestaAPregunta($id, $_POST['respuesta_id'] ?? 0);
}

//Agregar alguna respuesta a la pregunta
if (isset($_POST['agregar'])) {
    $obj->insertarRespuestaAPregunta($id, $_POST['respuesta_id'] ?? 0);
}

//TODO
if ($id != 0 && isset($_POST['delete'])) {
    $obj->delete($_GET['id']);
    header('Location: mantenimiento.php');
}

//Actualizar enunciado o tipo de pregunta
if (isset($_POST['actualizarCrear'])) {
    # Actualizar O Crear
    $result_id = $obj->CreateOrUpdate($_GET["id"] ?? 0, $_POST['pregunta'], $_POST['tipoPregunta']);
    if (!isset($_GET['id'])) {
        header('Location: mantenimiento_preguntas.php?id=' . $result_id);
    }
}

//Mostrar datos
if ($id != 0) {
    $respuesta = $obj->find($_GET['id']);
    $data = $respuesta->fetch_assoc();
    $buttonText = "Editar";
}

?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <title>Proyecto #1 | Mantenimiento</title>
</head>

<body>
    <br />
    <div class="container">
        <form action="" method="POST">
            <div class="row mb-4">
            <div class="col">
                    <a href="index.php" class="btn btn-info" role="button">Regresar a Inicio</a>
                </div>
                <div class="col">
                    <a href="mantenimiento.php" class="btn btn-info" role="button">Regresar a mantenimiento</a>
                </div>
                <div class="col"></div>
                <div class="col"></div>
            </div>
            <div class="row mb-3">
                <div class="col">
                    <div class="form-floating">
                        <input type="text" class="form-control" name="pregunta" value="<?php echo $data['pregunta'] ?? '' ?>" id="pregunta">
                        <label for="pregunta">Enunciado de la pregunta</label>
                    </div>
                </div>
                <div class="col">
                    <div class="form-floating">
                        <select class="form-select" id="tipoPregunta" name="tipoPregunta" aria-label="Tipo de Pregunta">
                            <option <?php echo ($data['tipo_pregunta'] ?? '') ? '' : 'selected' ?> disabled>Seleccione una opción</option>
                            <option <?php echo ($data['tipo_pregunta'] ?? '') === 'Binaria' ? 'selected' : "" ?> value="Binaria">Binaria (Si o No)</option>
                            <option <?php echo ($data['tipo_pregunta'] ?? '') === 'Simple' ? 'selected' : "" ?> value="Simple">Selección Simple (Una sola respuesta)</option>
                            <option <?php echo ($data['tipo_pregunta'] ?? '') === 'Multiple' ? 'selected' : "" ?> value="Multiple">Selección Múltiple (Una o más)</option>
                        </select>
                        <label for="tipoPregunta">Tipo de Pregunta</label>
                    </div>
                </div>
                <div class="col">
                    <button type="submit" name="actualizarCrear" class="btn btn-info"><?php echo $buttonText; ?></button>
                </div>
            </div>
        </form>
        <div class="row mb-3" <?php echo isset($_GET['id']) ? '' : ' style="display:none"' ?>>
            <div class="col">

                <div class="table-responsive">
                    <table class="table table-striped table-hover table-condensed">
                        <thead>
                            <strong>Respuestas</strong>
                            <tr>
                                <th width="75%">Posible Respuesta</th>
                                <th width="25%">.</th>
                            </tr>
                        </thead>
                    </table>
                    <div class="bodycontainer scrollable">
                        <table class="table table-hover table-striped table-condensed table-scrollable">
                            <tbody>
                                <!-- add rows here, specifying same widths as in header, at least on one row -->
                                <?php
                                $respuestas = $obj->ObtenerRespuestas($id);

                                while ($a = $respuestas->fetch_assoc()) {
                                ?>
                                    <tr>
                                        <td width="75%">
                                            <?php echo "$a[respuesta]"; ?>
                                        </td>
                                        <td width="25%">
                                            <form action="" method="POST">
                                                <input type="hidden" name="respuesta_id" value="<?php echo "$a[respuesta_id]"; ?>" />
                                                <button type="submit" name="remover" class="btn-clear">&#10060;</button>
                                            </form>
                                        </td>
                                    </tr>
                                <?php
                                }
                                ?>
                            </tbody>
                        </table>
                    </div>
                    <table class="table table-hover table-striped table-condensed">
                        <tfoot>
                            Haz clic en el botón &#10060; para remover respuesta a pregunta...
                        </tfoot>
                    </table>
                </div>

            </div>
            <div class="col">
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-condensed">
                        <thead>
                            <strong>Todas las posibles respuestas</strong>
                            <tr>
                                <th width="25%">.</th>
                                <th width="75%">Posible Respuesta</th>
                            </tr>
                        </thead>
                    </table>
                    <div class="bodycontainer scrollable">
                        <table class="table table-hover table-striped table-condensed table-scrollable">
                            <tbody>
                                <!-- add rows here, specifying same widths as in header, at least on one row -->
                                <?php
                                $respuestas = $obj->ObtenerRespuestasSinSeleccionar($id);

                                while ($a = $respuestas->fetch_assoc()) {
                                ?>
                                    <tr>
                                        <td width="25%">
                                            <form action="" method="POST">
                                                <input type="hidden" name="respuesta_id" value="<?php echo "$a[id]"; ?>" />
                                                <button type="submit" name="agregar" class="btn-clear">&#9664;</button>
                                            </form>
                                        </td>
                                        <td width="75%">
                                            <?php echo "$a[respuesta]"; ?>
                                        </td>
                                    </tr>
                                <?php
                                }
                                ?>
                            </tbody>
                        </table>
                    </div>
                    <table class="table table-hover table-striped table-condensed">
                        <tfoot>
                            Haz clic en el botón &#9664; para agregar respuesta a pregunta...
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

    </div>
</body>

</html>