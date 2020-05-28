<?php
include("connection/connect.php");
$connection=new Database();
$conn=$connection->dbConnection();
	?>
<!DOCTYPE html>
<html lang="en">
<?php include ('header.php') ?>

<?php include ('leftsidemenu.php') ?>
    <!-- MAIN Contain -->
     <!-- MAIN Contain -->
    <div class="col-lg-10 col-md-10 col-xs-10 col-sm-12" id="main-con">
        <div class="row">
             <?php
                $stmt1 = $conn->prepare("select id from main_app_menu where depertement_id=".$_SESSION['depart_id']." AND status='t'");
                $stmt1->execute();
                while($row=$stmt1->fetch()){
                 $id = $row['id'];
                }
               $stmt = $conn->prepare("select * from main_app_content where id_menu=$id AND status='t'");
               $stmt->execute();
               while($row1=$stmt->fetch()){
                $link = $row1['link'];
               echo " 
               <div class='col-lg-3 col-md-3 col-xs-4  col-sm-4'>
               <div class='middle'>
               ";
             echo "<a class='btn-edit' target='_blank' id='achor' href='$link'> 
               <i class='$row1[icon]'></i>	
      </a>";
               echo "</div>";
               echo "<div class='text-center'>
                    $row1[title]
                    </div>
               ";
                 echo"</div>";
                     
    }
        ?>
  
</div><!-- Main Row END -->
    </div><!-- Main Col END -->
    
</div><!-- body-row END -->
  
  
</div><!-- container -->
<!--Section Footer -->
    <footer id="footer">
    <?php include ('footer.php') ?>
    </footer>  
<script>
</script>
<script src="storage/js/jquery-3.4.1.min.js"></script>
<script src="storage/js/bootstrap.min.js"></script>
<script src="storage/js/main.js"></script>
<script src="storage/js/all.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <!-- Datatable JS -->
  <script src="storage/DataTables/datatables.min.js"></script>
<!-- Scipt admin -->
<script>
  
</script>
</body>
</html>
