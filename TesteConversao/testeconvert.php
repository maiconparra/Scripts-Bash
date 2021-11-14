<?php

$pathAquivos = 'arquivos/';

$completePathAquivos = 'arquivos/';

$diretorio = dir($pathAquivos);
$imageswebp =  'arquivos/imageswebp/';

var_dump($diretorio);
echo '<br/>';

while($arquivo = $diretorio -> read()){

    list($name, $extension) = explode('.', $arquivo);

    echo $name;
    echo PHP_EOL;
    echo $extension;
    echo PHP_EOL;

    if($extension == 'jpeg' || $extension == 'jpg') {
        $image = imagecreatefromjpeg($completePathAquivos.$name.'.'.$extension);

        imagewebp($image, $imageswebp.$name.'.'.'webp', 100);
    }else if($extension == 'png') {
        $image = imagecreatefrompng($completePathAquivos.$name.'.'.$extension);

        imagewebp($image, $imageswebp.$name.'.'.'webp', 100);
    }
}

echo PHP_EOL;