<?php
namespace forum;

use PDO;
use PDOException;

class Database {
    private $host = "localhost";
    private $db = "forum";
    private $var = "charset=utf8";
    private $user = "hcairo";
    private $pass = "2807";
    private $cnx;

    public function __construct() {
        try {
            $this->cnx = new PDO("mysql:host={$this->host};dbname={$this->db};{$this->var}", $this->user, $this->pass);
            $this->cnx->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            throw new PDOException("Connexion impossible : " . $e->getMessage());
        }
    }

    public function getCnx() {
        return $this->cnx;
    }
}

?>