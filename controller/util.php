<?php

function conv_kh($str){
        $s=array();
        $st="";
        for($i=0;$i<strlen($str); $i++){
            $s[]=substr($str,$i,1);
        }
        foreach($s as $ss){
            switch($ss){
                case 1:
                    $st.='១';
                    break;
                case 2:
                    $st.='២';
                    break;
                case 3:
                    $st.='៣';
                    break;
                case 4:
                    $st.='៤';
                    break;
                case 5:
                    $st.='៥';
                    break;
                case 6:
                    $st.='៦';
                    break;
                case 7:
                    $st.='៧';
                    break;
                case 8:
                    $st.='៨';
                    break;
                case 9:
                    $st.='៩';
                    break;
                case 0:
                    $st.='០';
                    break;
            }
        }
        return $st;
    }
function conv_sex($st){
    $s="";
    switch($st){
        case 'male':
            $s='ប្រុស';
            break;
        case 'female':
            $s='ស្រី';
            break;
    }
    return $s;
}


function conv_month($m){
    switch($m){
        case 1:
            $m='មករា';
        break;
        case 2:
            $m='កុម្ភៈ';
        break;
        case 3:
            $m='មិនា';
        break;
        case 4:
            $m='មេសា';
        break;
        case 5:
            $m='ឧសភា';
        break;
        case 6:
            $m='មិថុនា';
        break;
        case 7:
            $m='កក្កដា';
        break;
        case 8:
            $m='សីហា';
        break;
        case 9:
            $m='កញ្ញា';
        break;
        case 10:
            $m='តុលា';
        break;
        case 11:
            $m='វិច្ឆិកា';
        break;
        case 12:
            $m='ធ្នូ';
        break;
    }
    return $m;
}
function conv_datetime($s){
    //2020-04-25 09:38:16.976336
   if(!empty($s)){ 
       $d=explode(' ',$s);
        $y=explode('-',$d[0]);
        $h=explode(':',$d[1]);
        $yy=conv_kh($y[2]).' '.conv_month($y[1]).' '.conv_kh($y[0]);
        if($h[0]>=12){
            $a='ល្ងាច';
            $h[0]=$h[0]-12;
        }else{
            $a='ព្រឹក';
        }
        $hh=conv_kh($h[0]).":".conv_kh($h[1]).":".conv_kh(ceil($h[2]))." $a";
        return $yy.' '.$hh;
    }else{
        return '';
    }
}
function conv_date($s){
    //2020-04-25 09:38:16.976336
    if(!empty($s)){
        $d=explode(' ',$s);
        $y=explode('-',$d[0]);
        $yy=conv_kh($y[2]).' '.conv_month($y[1]).' '.conv_kh($y[0]);
        return $yy;
    }else{
        return '';
    }
}
function conv_time($s){
    //2020-04-25 09:38:16.976336
    if(!empty($s)){
        $d=explode(' ',$s);
        $h=explode(':',$d[1]);
        if($h[0]>=12){
            $a='ល្ងាច';
            $h[0]=$h[0]-12;
        }else{
            $a='ព្រឹក';
        }
        $hh=conv_kh($h[0]).":".conv_kh($h[1]).":".conv_kh(ceil($h[2]))." $a";
        return $hh;
    }else{
        return '';
    }
}
function conn(){
    include_once ("../connection/DB-connection.php");
    $db = new Database();
    $con=$db->dbConnection();
    return $con;
}
function conv_stat($st){
    switch($st){
        case 'approve':
            $st='បានអនុម័ត';
        break;
        case 'pending':
            $st='កំពុងរង់ចាំ';
        break;
        case 'reject':
            $st='បានបដិសេធ';
        break;
        case '':
            $st='សំណើថ្មី';
    }
    return $st;
}
function conv_ty($st){
    switch($st){
        case 'approve':
            $st='បានអនុម័ត';
        break;
        case 'pending':
            $st='កំពុងរង់ចាំ';
        break;
        case 'reject':
            $st='បានបដិសេធ';
        break;
        case 'wait':
            $st='សំណើថ្មី';
        break;
        default:
            $st='All';
        break;
    }
    return $st;
}
function en($st){
    $r="";
    for($i=0;$i<strlen($st);$i++){
        $r.=ord(substr($st,$i,1));
    }
    $rr=md5($r);
    return $rr;
}
// function get_list(){
//     session_start();
//     $conn=conn();
//     $sql="select id,name_kh,file_name from e_request_form where status='t'";
//     $q=$conn->prepare($sql);
//     $q->execute();
//     if($q->rowCount()>0){
//         $r=$q->fetchAll(PDO::FETCH_ASSOC);
//         $s='<select name="" class="form-control" onchange="ShowForm(this.value,0)">
//             <option value="-1" disabled hidden selected></option>
//         ';
//         foreach($r as $row){
//             $s.='<option value="'.$row["id"].','.$row["file_name"].'">'.$row["name_kh"].'</option>';
//             // echo '<a href="#" class="list-group-item-action" onClick="ShowFormView('.$row["id"].','.$fname.',0)">'.$row["name_kh"].'</a>';
//         }
//         $s.='</select>';
//         echo $s;
//     }
// }
// function get_list_view(){
//     session_start();
//     $conn=conn();
//     $sql="select id,name_kh,file_name from e_request_form where status='t'";
//     $q=$conn->prepare($sql);
//     $q->execute();
//     if($q->rowCount()>0){
//         $r=$q->fetchAll(PDO::FETCH_ASSOC);
//         $s='<select name="" class="form-control" onchange="ShowFormView(this.value,0)">
//             <option value="-1" disabled hidden selected></option>
//         ';
//         foreach($r as $row){
//             $s.='<option value="'.$row["id"].','.$row["file_name"].'">'.$row["name_kh"].'</option>';
//             // echo '<a href="#" class="list-group-item-action" onClick="ShowFormView('.$row["id"].','.$fname.',0)">'.$row["name_kh"].'</a>';
//         }
//         $s.='</select>';
//         echo $s;
//     }
// }
// if(isset($_POST['_list'])){
//     if($_POST['_list']=='list'){
//         get_list();
//     }else if($_POST['_list']=='view'){
//         get_list_view();
//     }
// }
// function pagi($current_row,$total_row,$fid){
//     $db = new Database();
//     $con=$db->dbConnection();
//     $q=$con->prepare("select file_name from e_request_form where id=$fid");
//     $q->execute();
//     $r=$q->fetch(PDO::FETCH_ASSOC);
//     $file=$r['file_name'];
// $pagi='<div class="row "><div class="col-9"></div>';
// if($current_row>0){
//     $pagi.='<a href="#" class="col-1 btn btn-danger" onclick="ShowFormView(\''.$fid.','.$file.'\','.($current_row-1).')">PREV</a>';
// }
// if($total_row>0){
//     $pagi.="<input type='text' class='col-1 form-control text-center' disabled value='".($current_row+1)."/$total_row'>";
// }
// if($current_row<$total_row-1){
//     $pagi.='<a href="#" class="col-1 btn btn-danger" onclick="ShowFormView(\''.$fid.','.$file.'\','.($current_row+1).')">NEXT</a>';
// }
// $pagi.='</div>';
// return $pagi;
// }
?>