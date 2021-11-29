<?php
    require_once("mantenimiento_preguntas.class.php");
    $obj = new Preguntas();
    $consulta = $obj->showAll();
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <!-- <link rel="stylesheet" href="./css/bootstrap.css"> -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <title>Proyecto #1 | Mantenimiento</title>
     </head>
     <body class="bg-light">
         <br/>
         <div class="container">
             <div class="row mb-4">
                 <div class="col">
                     <a class="btn btn-secondary" href="./">Regresar</a>
                     <a href="mantenimiento_preguntas.php" role="button" class="btn btn-primary">Crear Pregunta</a>
                 </div>
                 <div class="accordion accordion-flush" id="accordionExample">
                     <!-- <div class="row justify-content-center "> -->
                     <table class="table">
                         <thead>
                             <tr>
                                 <th scope="col">#</th>
                                 <th scope="col">Enunciado</th>
                                 <th scope="col">Editar</th>
                                 <th scope="col">Eliminar</th>
                             </tr>
                        </thead>
                    <tbody>
                        <?php
                            $x = 1;
                            echo "";
                            while($item = $consulta->fetch_assoc()) {
                                echo "<tr>";
                                echo "<th scope='row'>$x</th>";
                                echo "<td>";
                                echo "<div class='accordion-item'><h2 class='accordion-header' id='panelsStayOpen-heading-$item[id]'>"
                                        . "<button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-"
                                        . "target='#panelsStayOpen-collapse-$item[id]' aria-expanded='true' aria-controls='panelsStayOpen-"
                                        . "collapse-$item[id]'>$item[pregunta]<span class='badge bg-secondary'>$item[tipo_pregunta]</span>
                            </button>
                        </h2>
                  <div id='panelsStayOpen-collapse-$item[id]' class='accordion-collapse collapse' aria-labelledby='panelsStayOpen-heading-$item[id]'>
                    <div class='accordion-body'>";
                            $respuestas = $obj->ObtenerRespuestas($item['id']);
                            switch ($item['tipo_pregunta']) {
                                case 'Binaria':
                                case 'Simple':
                                    while ($a = $respuestas->fetch_assoc()) {
                                        echo "<br/><input class='form-check-input' type='radio' id='radio_$item[id]' disabled>
                    <label class='form-check-label' for='radio_$item[id]'>$a[respuesta]</label>";
                                    }
                                    break;
                                case 'Multiple':
                                    while ($a = $respuestas->fetch_assoc()) {
                                        echo "<br/><input class='form-check-input' type='checkbox' id='checkbox_$item[id]' disabled>
                    <label class='form-check-label' for='checkbox_$item[id]'>$a[respuesta]</label>";
                                    }
                                    break;
                                default:
                                    # code...
                                    break;
                            }
                            echo "</div>
                      </div>
                    </div>
                    </td>";
                        ?>
                            <td>
                                <a href="mantenimiento_preguntas.php?id=<?php echo "$item[id]"; ?>" class="btn btn-outline-primary">Editar</a>
                            </td>
                            <td>
                                <form id="form<?php echo "$item[id]"; ?>" action="mantenimiento_preguntas.php?id=<?php echo "$item[id]"; ?>" method="POST">
                                    <input type="hidden" name="delete" value="<?php echo "$item[id]"; ?>" />
                                    <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#my_modal" data-id="<?php echo "$item[id]"; ?>">Eliminar</button>
                                </form>
                            </td>
                            </tr>
                        <?php $x++;
                        }
                        ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="my_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="my_modalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="my_modalLabel">¿Seguro quiere borrar el registro?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Se va a eliminar el registro seleccionado.
                        <input type="hidden" name="hiddenValue" id="hiddenValue" value="" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-danger" id="confirmarBorrar">Continuar</button>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(function() {
                $(".btn.btn-outline-danger").click(function() {
                    var parentFormId = $(this).parents('form')[0].id;
                    $(".modal-body #hiddenValue").val(parentFormId);
                });
                $("#confirmarBorrar").click(function(e) {
                    $("#my_modal").modal('hide');
                    $("#" + $(".modal-body #hiddenValue").val()).submit();
                })
            });
        </script>
</body>

</html>