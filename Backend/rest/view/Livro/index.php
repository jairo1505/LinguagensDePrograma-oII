<?php
include '../../control/LivroControl.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $conteudoControl = new LivroControl();

    header('Content-Type: application/json');

    $array;
    foreach($conteudoControl->findAll() as $valor){
        $array[] = $valor;
    }
    echo json_encode($array);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = file_get_contents('php://input');
    $obj =  json_decode($data);
    
    if(!empty($data)){	
     $conteudoControl = new LivroControl();
     $conteudoControl->insert($obj);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    $data = file_get_contents('php://input');
    $obj =  json_decode($data);

    $id = $obj->id;

    if(!empty($data)){	
    $conteudoControl = new LivroControl();
    $conteudoControl->update($obj , $id);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $data = file_get_contents('php://input');
    $obj =  json_decode($data);

    $id = $obj->id;

    if(!empty($data)){	
    $conteudoControl = new LivroControl();
    $conteudoControl->delete($obj,$id);
    }
}
?>
