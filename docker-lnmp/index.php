<?
    $link_id=mysql_connect('127.0.0.1','marksugar','marksugar') or mysql_error();
    if($link_id){
        echo "mysql successful by LinuxEA!";
    }else{
        echo mysql_error();
    }

?>
<?php

// Show all information, defaults to INFO_ALL
phpinfo();

// Show just the module information.
// phpinfo(8) yields identical results.
phpinfo(INFO_MODULES);

?>