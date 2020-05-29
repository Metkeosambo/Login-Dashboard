
      <div class='container'>
      <div class="col-lg-12 col-md-12 col-xs-12  col-sm-12" >
      <h3 class="text-center"> Suggestion Form </h3>
      </div>
      <div class="col-lg-12 col-md-12 col-xs-12  col-sm-12" >
      <?php 
       include_once ("../connection/connect.php");
       $connection=new Database();
       $conn=$connection->dbConnection();
       session_start();
       $stmt = $conn->prepare("SELECT id,question,id_type FROM hr_suggestion_question Limit 10"); 
       $stmt->execute();
       $i =1;
       
       while($row=$stmt->fetch()){ 
        $ns=$row['id'];
        $q_type= $row['id_type'];
          ?>
          <form action="controller/submit_suggestion.php" method="post">
          <div class="card">
          <div class="card-header"><?php echo "Question"." ".$i."::"."   ".$row['question'] ; ?></div>
          <?php  
          
          if($q_type==2){
            echo "<input type='hidden' name='qestion_text[]' value='$ns'/>";
           echo "<textarea class='form-control' required name='answer_text[]' id='answer' rows='4'></textarea>"; 
          }else if($q_type==1){
            echo "<input type='hidden' name='qestion_radio[]' value='$ns'/>";
          $stmt1 = $conn->prepare("SELECT id,answer,question_id FROM hr_suggestion_answer where question_id=$ns"); 
          $stmt1->execute();
          while($row1=$stmt1->fetch()){ 
              $id_ans= $row1['id'];
              $ans= $row1['answer'] ;
              
          ?>
          <div class="card-body"><?php  echo'<input required type="radio" name="radio_ans'.$ns.'" value="'.$id_ans.'">&nbsp;'.$ans.'<br /><br /> '?>
          </div> 
          
        <!--  <label for="qestion"></label> </br> </br> -->
        <?php
          }}
        ?>
      <?php  
      $i++;  
       } 
      ?>
      </div> <!-- End Card header -->
      <div class="card-footer">
        <button class="btn btn-primary text-center" type="submit">Submit</button>
      </form>
      </div>
      </div> <!-- End Card -->     
       </div><!-- Main Row END -->

