<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>Proyecto #1</title>
</head>

<body class="bg-light">
    <div class="container">
        <div class="row">
            <div class="col"><a class="btn btn-secondary" href="./"> Regresar</a> </div>
        </div>
        <div class="row align-items-center">

            <div class="col-md-4 align-items-center align-items-center">

                <h1>Reporte </h1>

                <form action="reporte_grafica.php" target="reporte_grafica" method="post">
                    <div class="col">
                        <div class="form-floating">
                            <select class="form-select" id="tipoReporte" name="tipoReporte" aria-label="Mostrar Reporte" onchange="this.form.submit()">
                                <option selected disabled>Seleccione una opción</option>
                                <option value="sexo_id">Reporte por sexo</option>
                                <option value="rango_edad_id">Reporte por rango de edades</option>
                                <option value="rango_salarial_id">Reporte por rango salarial</option>
                                <option value="provincia_id">Reporte por provincias</option>
                            </select>
                            <label for="tipoReporte">Tipo de Reporte</label>
                        </div>
                    </div>
                    <noscript><button type="submit" name="mostrar" class="btn btn-info">Mostrar</button></noscript>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <iframe name="reporte_grafica" src="reporte_grafica.php" style="position:fixed; top:0; left:0; bottom:0; right:0; width:100%; height:100%; border:none; margin:150px; padding:0; "></iframe>
            </div>
        </div>

</body>

</html>