
      <div class='container' style="margin-top:15px">
      <div class="col-lg-12 col-md-12 col-xs-12  col-sm-12" >
      <h3 class="text-center" style="font-family:Times New Roman;font-weight:bold;"> Suggestion Form </h3>
      <hr class="text-center" style="border:2px solid #d42931;width:230px;">
      </div>
      <div class="col-lg-12 col-md-12 col-xs-12  col-sm-12" >
      <?php 
       include_once ("../connection/connect.php");
       $connection=new Database();
       $conn=$connection->dbConnection();
       session_start();
       $stmt = $conn->prepare("SELECT id,question,id_type FROM hr_suggestion_question order by id Limit 10  "); 
       $stmt->execute();
       $i =1;
          ?>
          <form action="controller/submit_suggestion.php" method="post">
          <div class="card">
          <?php 
           while($row=$stmt->fetch()){ 
            $ns=$row['id'];
            $q_type= $row['id_type'];
          ?>
          <div class="card-header"><?php echo "Question"." ".$i."/:"."   ".$row['question'] ; ?></div>
          <div class="card-body">
              <?php  
              
              if($q_type==2){
                echo "<input type='hidden' name='qestion_text[]' value='$ns'/>";
              echo "<textarea class='form-control' required name='answer_text[]' id='answer' rows='4'></textarea>"; 
              }else if($q_type==1){
                echo "<input type='hidden' name='qestion_radio[]' value='$ns'/>";
              $stmt1 = $conn->prepare("SELECT id,answer,question_id FROM hr_suggestion_answer where question_id=$ns and status='t'"); 
              $stmt1->execute();
              while($row1=$stmt1->fetch()){ 
                  $id_ans= $row1['id'];
                  $ans= $row1['answer'] ;
                  
              ?>
              <?php  echo'<input required type="radio" style="margin-left:15px" name="radio_ans'.$ns.'" value="'.$id_ans.'">&nbsp;'.$ans.' '?> 
            <!--  <label for="qestion"></label> </br> </br> -->
            <?php
              }}
            ?>
         </div>
      <?php  
      $i++;  
       } 
      ?>
      <?php
      $stmt1 = $conn->prepare("SELECT id,question,id_type FROM hr_suggestion_question where id_type=4 Limit 1  "); 
      $stmt1->execute(); 
      while($row1=$stmt1->fetch()){ 
        $ns1=$row1['id'];
      ?>
      <div class="card-header"><?php echo "Question"." 11/:"."   ".$row1['question'] ; ?></div>
          <div class="card-body">
              <input type='hidden' name='qestion_text[]' value='<?=$ns1?>'/>
              <textarea class='form-control' required name='answer_text[]' id='answer' rows='4'></textarea>
          </div>
      <?php }?>
      <div class="card-footer">
        <button class="btn btn-primary text-center" type="submit">Submit</button>
      </form>
      </div>
      </div> <!-- End Card -->     
       </div><!-- Main Row END -->

