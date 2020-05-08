<script>
<?php
include "connect.php";
session_start();
$r=session_id();
	?>
</script>
<!DOCTYPE html>
<html lang="en">
<?php include ('header.php') ?>

<section class="menu">
<?php include ('leftsidemenu.php') ?>
    <!-- MAIN Contain -->
     <!-- MAIN Contain -->
      <!-- MAIN Contain -->
    <div class="col-lg-9 col-md-9 col-xs-12  col-sm-12" id="main-con">
        <div class="row">
             <?php
             
              
              
                $stmt1 = $con->prepare("select id from menu where title='$_SESSION[role]' AND status=1");
                $stmt1->execute();
                while($row=$stmt1->fetch()){
                 $id = $row['id'];
                }
               $stmt = $con->prepare("select * from content where id_menu='$id' AND status=1");
               $stmt->execute();
               while($row1=$stmt->fetch()){
                
                if (session_id()==$r)
                {
                  $link = $row1['link'];
                }else{$link = exec("$row1[link]");}
               echo " 
               <div class='col-lg-3 col-md-3 col-xs-4  col-sm-4'>
               <div class='middle'>
               ";
             echo "<a class='btn-edit' target='_blank' href='$link'> 
               <i class='$row1[icon]'></i>	
      </a>";
               echo "</div>
                     </div>";
    }
        ?>
</div><!-- Main Row END -->
    </div><!-- Main Col END -->
    
</div><!-- body-row END -->
  
  
</div><!-- container -->
</section>
<!--Section Footer -->
<section >
    <footer id="footer">
    <?php include ('footer.php') ?>
    </footer>
    
</section>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
<script src="js/all.js"></script>

</body>
</html>