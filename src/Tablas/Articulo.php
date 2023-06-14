<?php

namespace App\Tablas;

use PDO;

class Articulo extends Modelo
{
    protected static string $tabla = 'articulos';

    public $id;
    private $codigo;
    private $descripcion;
    private $precio;
    private $stock;

    public function __construct(array $campos)
    {
        $this->id = $campos['id'];
        $this->codigo = $campos['codigo'];
        $this->descripcion = $campos['descripcion'];
        $this->precio = $campos['precio'];
        $this->stock = $campos['stock'];
    }

    public static function existe(int $id, ?PDO $pdo = null): bool
    {
        return static::obtener($id, $pdo) !== null;
    }

    public function getCodigo()
    {
        return $this->codigo;
    }

    public function getDescripcion()
    {
        return $this->descripcion;
    }

    public function getPrecio()
    {
        return $this->precio;
    }

    public function getStock()
    {
        return $this->stock;
    }

    public function etiquetas()
    {
        $etique = [];

        $pdo = conectar();
        $sent =  $pdo->query("select nombre from etiquetas e join articulos_etiquetas ae on e.id = ae.id_etiqueta where ae.id_articulo = $this->id");

        $etiquetas = $sent->fetchAll(PDO::FETCH_ASSOC);
        
        foreach ($etiquetas as $etiqueta) {
            $etique[] = $etiqueta['nombre'];
        }
        return implode(', ', $etique);
    }
}
