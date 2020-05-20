<?php
session_start();
  if(isset($_POST['radio_ans']) || isset($_POST['answer_text'])){
        include ("../connection/connect.php");
        include ("../controller/util.php");
        $connection=new Database();
        $conn=$connection->dbConnection();
        $question=$_POST['qestion_text'];
        $question_radio=$_POST['qestion_radio'];
        /* $anw_id=(isset($_POST['radio_ans']))?$_POST['radio_ans']:null; */
        $anw_text=$_POST['answer_text'];
        foreach($question as $key=>$value){
          
          $sql = "SELECT public.insert_hr_suggestion_submit(
            $value, 
            null, 
            '".$anw_text[$key]."'
          )";
          $q=$conn->prepare($sql);
          $q->execute(); 
          /*  echo $value.$anw_text[$key].'<br>'; */
        }
        foreach($question_radio as $key=>$value){
          
           /* if(!empty($anw_id[$key])){  */
         echo  $sql = "SELECT public.insert_hr_suggestion_submit(
              $value, 
              ".$_POST['radio_ans'.$value].", 
              null
            )";
            $q=$conn->prepare($sql);
            $q->execute();
           /* }  */
          /*  echo $value.$_POST['radio_ans'.$value].'<br>';  */ 
        }
        
        // $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // <== add this line
        // $sql = "SELECT public.insert_hr_suggestion_submit(
        //   $question, 
        //   $anw_id, 
        //   $anw_text
        // )";
        // $q=$conn->prepare($sql);
        // $q->execute();
        if($q->rowCount()>0){
          header("Location: ../Dashboard.php");
      }
		/* if ($conn->query($sql)) {
            echo "<script type= 'text/javascript'>alert('New Record Inserted Successfully');</script>";
            header("location: dashboard.php");
            }
            else{
            echo "<script type= 'text/javascript'>alert('Data not successfully Inserted.');</script>";
            header("location: dashboard.php");
            }		*/
        } 
              
?>