function validar() {
    var radioArray = [];
    var checkBoxArray = [];
    var isOK = true;
    clearErrors();
    try {
        //Validar entradas de Nombre, Apellido, Sexo, Rango de edad, Rango salarial y provincia
        validateField('nombre');
        validateField('apellido');
        validateField('sexo');
        validateField('edad');
        validateField('salario');
        validateField('provincia');
        //Obtener todos los radios y checkboxes del formulario
        document.querySelectorAll('input[type="radio"],input[type="checkbox"]').forEach(function (element) {
            if (element.type === "radio" && element.name.startsWith('radios') && !radioArray.includes(element.name))
                radioArray.push(element.name);
            if (element.type === "checkbox" && element.id.startsWith('check') && !checkBoxArray.includes(element.id))
                checkBoxArray.push(element.id);
        });

        //Validar Radios Groups
        radioArray.forEach(function(name){
            if(document.querySelectorAll('input[name="' + name + '"]:checked').length == 0)
            {
                //Mostrar mensaje de error en grupo de radios
                var value = name.substring(name.indexOf('[') + 1, name.indexOf(']'));
                var div = document.getElementById("error_" + value);
                div.style.display = 'block';
                div.innerText = 'Debe seleccionar una opción.';
                isOK = false;
            }
        });

        //Validar CheckBoxes Groups
        checkBoxArray.forEach(function(id){
            if(document.querySelectorAll('input[id="' + id + '"]:checked').length == 0)
            {
                //Mostrar mensaje de error en grupo de radios
                var value = id.substring(id.indexOf('_') + 1);
                var div = document.getElementById("error_" + value);
                div.style.display = 'block';
                div.innerText = 'Debe seleccionar al menos una opción.';
                isOK = false;
            }
        });

    } catch (error) {
        console.error(error);
        return false;
    }

    //console.log(); 
    return isOK;
}

function validateField(fieldName) {
    var field = document.getElementById(fieldName);
    field.style = "border-color:#ced4da;";
    if (field.value === '') {
        field.style = "border-color:rgb(255, 0, 0);color:#333";
    }
}

function clearErrors(){
    document.querySelectorAll('div[name="errors"]').forEach(function (div) {
        div.style.display = 'none';
    });
}

