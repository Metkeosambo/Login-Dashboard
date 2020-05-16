<?php
// include_once ("../connection/DB-connection.php");
// include_once ("../../controller/getvalues-sql.php");
class check_perm{
    private function conn(){
        $db = new Database();
        $con=$db->dbConnection();
        return $con;
    }
    public function permi_check($id){
        $sql="select s.position_id,s.company_dept_id,p.group_id from staff s join \"position\" p on p.id=s.position_id where s.id =$id";
        $con=$this->conn();
        $q=$con->prepare($sql);
        $q->execute();
        $r=$q->fetch(PDO::FETCH_ASSOC);

        $sql="select id,type,company_dept_id
        from company_dept_manager
        where position_id=".$r['position_id']." and group_id=".$r['group_id']." and company_dept_id=".$r['company_dept_id'];
        $q=$con->prepare($sql);
        $q->execute();
        $r=$q->fetch(PDO::FETCH_ASSOC);
        return $r;
    }
    public function permi_get($id){
        $con=$this->conn();
        $r=false;
        $r=$this->permi_check($id);
        if($r){
            $sql='';
            if($r['type']=='top'){
                $sql="SELECT er.ID,'top' as type
                ,s.NAME,er.create_date,erfd.e_request_form_id,erd.e_request_status,
                (select name from staff where id=erd.action_by) as action_by,
                erfd.form_table_row_id,erf.name_kh AS form_name,erf.file_name
                FROM e_request er
                LEFT JOIN e_request_detail erd ON er.id = e_request_id
                JOIN staff s ON er.create_by = s.ID
                JOIN e_request_form_detail erfd ON erfd.ID = er.e_request_form_detail_id
                JOIN e_request_form erf ON erf.ID = erfd.e_request_form_id
                WHERE 't'
                AND er.status = 't'
                and er.company_dept_manager_id=".$r['id']."
                and (erd.e_request_status='pending' or erd.e_request_status is null)
                or ((select count(id) from e_request_detail where e_request_id=er.id and (erd.e_request_status='pending' or erd.e_request_status is null) )=1)
                ORDER BY er.ID DESC";
            }else if($r['type']=='mid'){
                $sql="SELECT er.ID,'mid' as type,s.NAME,er.create_date,erfd.e_request_form_id,
                erfd.form_table_row_id,erf.name_kh AS form_name,erf.file_name
                FROM e_request er
                LEFT JOIN e_request_detail erd ON er.\"id\" = e_request_id
                JOIN staff s ON er.create_by = s.ID
                JOIN e_request_form_detail erfd ON erfd.ID = er.e_request_form_detail_id
                JOIN e_request_form erf ON erf.ID = erfd.e_request_form_id
                WHERE erd.e_request_id IS NULL
                AND er.status = 't'
                and er.company_dept_manager_id=".$r['id']."
                ORDER BY er.ID DESC";
            }
            $q=$con->prepare($sql);
            $q->execute();
            $r=$q->fetchAll(PDO::FETCH_ASSOC);
        }
        return $r;
    }
    public function get_view_val($s,$hr,$id){
        $con=$this->conn();
        // session_start();
        $wh="";
        $req="";
        if($hr){
            if($hr['type']=='top'){
                $wh=" and er.create_by=".$id;
                $req='(select name from staff where id=er.create_by) as request_by,';
            }else if(($hr['type']=='mid'&&$hr['company_dept_id']!=4)&&$id>0){//search for each dept
                $wh=" and er.company_dept_id=(select company_dept_id from staff where id=".$_SESSION['userid'].") and er.create_by=".$id;
                $req='(select name from staff where id=er.create_by) as request_by,';
            }
            else if($hr['type']=='normal'||($hr['type']=='mid'&&$hr['company_dept_id']==4)){//for hr search all
                if($id<=0){
                    $req='(select name from staff where id=er.create_by) as request_by,';
                }else{
                    $wh=" and er.create_by=".$id;
                    $req='(select name from staff where id=er.create_by) as request_by,';
                }
            }
        }else{
            $wh=" and er.create_by=".$_SESSION['userid'];
        }
        $sql="SELECT er.id,$req erf.name_kh as form_name,er.create_date,erf.file_name,erfd.e_request_form_id,
        (select e_request_status from e_request_detail where e_request_id=er.id ORDER BY id desc limit 1 offset 0),
        (select \"comment\" from e_request_detail where e_request_id=er.id ORDER BY id desc limit 1 offset 0),
        (select s.name from e_request_detail e join staff s on s.id=e.action_by where e.e_request_id=er.id ORDER BY e.id desc limit 1 offset 0) as action_by
        from e_request er
        join e_request_form_detail erfd on erfd.id=er.e_request_form_detail_id
        join e_request_form erf on erf.id=erfd.e_request_form_id
        where 't'$wh and er.status='t'
        ORDER BY er.id desc limit 1000 offset 0";
        switch($s){
            case 'reject':
                $sql="select * from ($sql) as foo where e_request_status='reject'";
            break;
            case 'approve':
                $sql="select * from ($sql) as foo where e_request_status='approve'";
            break;
            case 'pending':
                $sql="select * from ($sql) as foo where e_request_status='pending'";
            break;
            case 'wait':
                $sql="select * from ($sql) as foo where e_request_status is null";
            break;
        }
        $q=$con->prepare($sql);
        $q->execute();
        $r=$q->fetchAll(PDO::FETCH_ASSOC);
        return $r;
    }
}
?>