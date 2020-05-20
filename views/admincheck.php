<div class="col-lg-10 col-md-10 col-xs-12  col-sm-12" id="main-con">
      <div class='row'>  
       <div class="col-lg-12 col-md-12 col-xs-12  col-sm-12">   
       <!-- Table -->
       <?php
       include_once ("../connection/connect.php");
       $connection=new Database();
       $conn=$connection->dbConnection();
       session_start();
       $stmt = $conn->prepare("SELECT q.*,tt.name from hr_suggestion_question q join hr_suggestion_question_type tt on q.id_type=tt.id");
       $stmt->execute(); 
       ?>
       <table id='tableadmin' class='display dataTable table table-striped table-bordered '>
                <thead style="background-color:#1fa8e0;">
                <tr>
                    <th class='table-header' width='10%'>លេខរៀង</th>
                    <th class='table-header' width='30%'>ប្រភេទសំណួរ</th>
                    <th class='table-header' width='50%'>សំណួរ</th>
                    <th class='table-header' width='10%'>Action</th>
                </tr>
                </thead>
                <tbody>
                <?php
                while($row=$stmt->fetch()){  
                ?>
              
                    <tr>
                        <td><?php echo $row['id']; ?></td>
                        <td><?php echo $row['name']; ?></td>
                        <td><?php echo $row['question']; ?></td>
                        <!-- echo id to funcion for get id of row table -->
                        <td><button onclick="view_detail(<?php echo $row['id']; ?>)" class="btn btn-primary text-center btn btn-info ac view_detail" type="button" name="view_detail" value="view_detail">Action</button></td>     
                    </tr>
                <?php } ?>
                </tbody>
            </table>
        </div>  <!-- END DIV Table -->
       </div><!-- Main Row END -->
    </div><!-- Main Col END -->
    <!-- id model that mean we create div for call modal view and it call it JS file  -->
    <div id="detail_modal">
    </div>