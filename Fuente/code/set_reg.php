<?php

session_start();
$regValue = "fraud";
$_SESSION['regName'] = $regValue;

?>

<form method="get" action="get_reg.php">
    <input type="hidden" name="regName" value="sad">
    <input type="submit">
</form>