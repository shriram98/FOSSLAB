<?php

define('DB_SERVER', 'localhost:3306');
define('DB_USERNAME', 'newuser');
define('DB_PASSWORD', 'password');
define('DB_DATABASE', 'login_details');
$db = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_DATABASE);

?>
