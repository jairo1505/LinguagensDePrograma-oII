<?php
include '../../conexao/Conexao.php';

class Livro extends Conexao{
	private $id;
    private $ano;
    private $editora;
    private $autor;
    private $titulo;

    function getTitulo() {
        return $this->titulo;
    }

    function getAno() {
        return $this->ano;
    }

    function getId() {
        return $this->id;
    }

    function getEditora() {
        return $this->editora;
    }

    function getAutor() {
        return $this->autor;
    }

    function setPeriodo_id($titulo) {
        $this->titulo = $titulo;
    }

    function setAno($ano) {
        $this->ano = $ano;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setEditora($editora) {
        $this->editora = $editora;
    }

    function setAutor($autor) {
        $this->autor = $autor;
    }

    public function insert($obj){
        $sql = "INSERT INTO livro(titulo,editora,autor,ano) VALUES (:titulo,:editora,:autor,:ano)";
        error_log($sql);
    	$consulta = Conexao::prepare($sql);
        $consulta->bindValue('titulo',  $obj->titulo);
        $consulta->bindValue('editora', $obj->editora);
        $consulta->bindValue('autor' , $obj->autor);
        $consulta->bindValue('ano' , $obj->ano);
    	return $consulta->execute();
	}

	public function update($obj,$id = null){
		$sql = "UPDATE livro SET titulo = :titulo, editora = :editora,autor = :autor, ano = :ano WHERE id = :id ";
		$consulta = Conexao::prepare($sql);
		$consulta->bindValue('titulo',  $obj->titulo);
        $consulta->bindValue('editora', $obj->editora);
        $consulta->bindValue('autor' , $obj->autor);
        $consulta->bindValue('ano' , $obj->ano);
		$consulta->bindValue('id', $id);
		return $consulta->execute();
	}

	public function delete($obj,$id = null){
		$sql =  "DELETE FROM livro WHERE id = :id";
		$consulta = Conexao::prepare($sql);
		$consulta->bindValue('id',$id);
		$consulta->execute();
	}

	public function find($id = null){

	}

	public function findAll(){
		$sql = "SELECT * FROM livro";
		$consulta = Conexao::prepare($sql);
		$consulta->execute();
		return $consulta->fetchAll();
	}

}

?>