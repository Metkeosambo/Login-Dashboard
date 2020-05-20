<?php
$id = $_POST['id'];
include_once ("../connection/connect.php");
include_once ("../controller/util.php");
$connection=new Database();
$conn=$connection->dbConnection();
session_start();
  
     $statement = $conn->prepare("SELECT s.*,a.answer,q.question from hr_suggestion_submited s 
	 left join hr_suggestion_answer a on s.answer_id=a.id
	 left join hr_suggestion_question q on s.question_id = q.id
	 where s.question_id=$id"); 
	 $statement->execute(); 
	 $rows=$statement->fetchAll(PDO::FETCH_ASSOC);
	 if($rows==null){
		?>	
		 <div class="container">
<div id="adminModal" class="modal fade col-lg-12 col-md-12 col-xs-12 col-sm-12">
	<div class="modal-dialog modal-lg" style="width:1200px;"> 
			<div class="modal-content">
				<div class="modal-header">
                    <h4 class="modal-title text-center"></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body" id="modaldetail_admin"> 
			     <span> Data No record</span>
				<div class="modal-footer">
					<input type="hidden" name="user_id" id="user_id" />
					<input type="hidden" name="operation" id="operation" />
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
	</div>
</div>
</div>
	<?php }else{
     ?>	
	 
<div class="container">
<div id="adminModal" class="modal fade col-lg-12 col-md-12 col-xs-12 col-sm-12">
	<div class="modal-dialog modal-lg" style="width:1200px;"> 
			<div class="modal-content">
				<div class="modal-header">
                    <h4 class="modal-title text-center"><?php echo $rows[0]["question"] ; ?></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body" id="modaldetail_admin"> 
				<div class="table-responsive">  
							 <table class="table table-bordered">  
							 <?php  	
							 if($rows[0]["answer_id"]==null){
								foreach($rows as $row )  
								{ 
							
							?> 
								  <tr>  
									   <td width="30%"><label>ចម្លើយសរសេរដៃ</label></td>  
									   <td width="70%"><?php echo $row["answer_text"] ;?></td>  
								  </tr>  
							<?php }}else{
								 foreach($rows as $row )  
								 {  
									 $count_id[]=$row["answer"] ;	 
								 ?> 
								 <?php  }?> 
								 <tr>  
									   <td width="30%"><label>ចម្លើយជ្រើសរើស</label></td>  
									   <td width="70%"><?php /* echo $row["answer"]." = " ; */
									   // count array as the same string 
                                         $c= array_count_values($count_id);
										foreach ($c as $key => $value) {
										  echo $key.' = '.$value.'<br />';
										}
									  
									   /* print_r(array_count_values($count_id)); */?></td>  
								  </tr>  
						<?php } ?>
					
						
					
						</table></div> 
				</div>
				<div class="modal-footer">
					<input type="hidden" name="user_id" id="user_id" />
					<input type="hidden" name="operation" id="operation" />
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
	</div>
</div>
</div>
<?php } ?> <!-- End Else No record -->