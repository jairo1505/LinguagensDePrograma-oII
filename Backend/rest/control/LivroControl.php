<?php
include '../../model/Livro.php';

class LivroControl{
	function insert($obj){
		$conteudo = new Livro();
		return $conteudo->insert($obj);
	}

	function update($obj,$id){
		$conteudo = new Livro();
		return $conteudo->update($obj,$id);
	}

	function delete($obj,$id){
		$conteudo = new Livro();
		return $conteudo->delete($obj,$id);
	}

	function findAll(){
		$conteudo = new Livro();
		return $conteudo->findAll();
	}
}

?>
