<?php include "header.php" ?>
              <!-- Start Left Menu --->
            <div class="row" id="body-row">  
            <?php include "leftsidemenu.php" ?>
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
                            echo "<a class='btn-edit' id='achor' href='$link'> 
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
                </div>
            </div>
           <?php include "footer.php" ?>