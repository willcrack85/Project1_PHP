<!DOCTYPE html>
<html lang="en-US">

<body>

  <?php
  require_once('encuesta.class.php');
  $title = '';
  $tabla = '';
  if (isset($_POST['tipoReporte'])) {
    switch ($_POST['tipoReporte']) {
      case 'sexo_id':
        $title = 'Sexo de los encuestados';
        $tabla = 'sexo';
        break;
      case 'rango_edad_id':
        $title = 'Rango de edades de los encuestados';
        $tabla = 'rango_edad';
        break;
      case 'rango_salarial_id':
        $title = 'Rango de salarial de los encuestados';
        $tabla = 'rango_salarial';
        break;
      case 'provincia_id':
        $title = 'Provincia de procedencia de los encuestados';
        $tabla = 'provincias';
        break;
      default:
        # code...
        break;
    }

  ?>

    <h1>Reporte por <?php echo $title ?></h1>

    <div id="piechart"></div>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
      // Load google charts
      google.charts.load('current', {
        'packages': ['corechart']
      });
      google.charts.setOnLoadCallback(drawChart);

      // Draw the chart and set the chart values
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Encuestados'],
          <?php

          $dbobj = new Encuesta();
          $result = $dbobj->GenerarReporte($_POST['tipoReporte']);
          $data = array();
          while ($item = $result->fetch_array()) {
            $r = $dbobj->ObtenerEtiqueta($tabla, $item[0]);
            $tag = $r->fetch_assoc();
            echo "['$tag[title]', $item[1]],";
          }
          ?>

        ]);
        //  ['Task', 'Hours per Day'],
        //           ['Work', 8],
        //           ['Eat', 2],
        //           ['TV', 4],
        //           ['Gym', 2],
        //           ['Sleep', 8]
        // Optional; add a title and set the width and height of the chart
        var options = {
          'title': '<?php echo $title ?>',
          'width': 550,
          'height': 600
        };

        // Display the chart inside the <div> element with id="piechart"
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
      }
    </script>
  <?php
  }
  ?>
</body>

</html>