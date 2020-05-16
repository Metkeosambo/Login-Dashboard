<?php
 class Database{

    private $db_host = '172.17.168.27';
    private $db_name = 'stockdev';
    private $db_username = 'sros';
    private $db_password = 'Sros123';

    public function dbConnection(){

        try{
            $conn = new PDO('pgsql:host='.$this->db_host.';dbname='.$this->db_name,$this->db_username,$this->db_password);

         //    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $conn;
        }
        catch(PDOException $e){
            echo "Connection error ".$e->getMessage();
            exit;
        }


    }
}
?>