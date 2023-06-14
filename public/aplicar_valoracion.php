<?php

use App\Tablas\Articulo;

session_start();

require '../vendor/autoload.php';

if (!($usuario = \App\Tablas\Usuario::logueado())) {
    return volver();
}
$pdo = conectar();

$valoracion = obtener_get('valoracion');
$articulo_id = obtener_get('articulo_id');
$usuario_id = obtener_get('usuario_id');

try {
    $in = $pdo->query("INSERT INTO valoraciones VALUES($articulo_id, $usuario_id, $valoracion)");
} catch (\Throwable $th) {
    $up = $pdo->query("UPDATE valoraciones
                        SET valoracion = $valoracion
                        WHERE id_articulo = $articulo_id
                        AND id_usuario = $usuario_id");
};


// if (!isset($res)) {
// };


volver();
