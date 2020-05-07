<script>
<?php
include "connect.php";
session_start();
	?>
</script>
<!DOCTYPE html>
<html lang="en">
<<<<<<< HEAD
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css?ver=<?= rand() ?>">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/all.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <script src="js/popper.min.js"></script>
    <title>DashBoard</title>
</head>
<body>
<section>
<div class="fixed-top">
<div class="container-fluid "> 
<div class="row">
<div class="col-md-2 col-sm-2 col-lg-2 col-xs-2 image-head">
 <img src="images/turbotech.png" style="text-align:center;" id="head-image"class="img-fluid ${3|rounded-top,rounded-right,rounded-bottom,rounded-left,rounded-circle,|}" alt="">
</div> <!-- End Logo -->
<div id="header" class="col-md-6 col-sm-6 col-lg-6 col-xs-6">
   <div class="row">
       <div class="fk col-md-12 col-sm-12 col-lg-12 col-xs-12">
       <h6 class=" widget-title">IMPROVE</h6>
       </div>
   </div>
   <div class="row">
       <div class="col-md-5 col-sm-5 col-lg-5 col-xs-5">
       <ul>
       <li><i class="fas fa-user-graduate" style="color:#1fa8e0;"></i>    Intelligence</li>
       <li><i class="fas fa-handshake" style="color:#1fa8e0;"></i>Morality</li>
       <li><i class="fas fa-user-tie" style="color:#1fa8e0;"></i> Professional & Accountability</li>
      </ul>  
       </div>
       <div class="col-md-3 col-sm-4 col-lg-4 col-xs-4">
       <ul>
       <li><i class="fas fa-user-clock" style="color:#1fa8e0;"></i> Responsibility</li>
       <li><i class="fas fa-people-carry" style="color:#1fa8e0;"></i> Optimistic</li>
       
      </ul>  
       </div>
       <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
       <ul>
       <li><i class="fas fa-user-shield" style="color:#1fa8e0;"></i> Vigilant</li>
       <li><i class="fas fa-user-check"  style="color:#1fa8e0;"></i> Efficience</li>
      </ul>  
       </div>
   </div>
</div>
<div class="col-md-2 col-sm-2 col-lg-2 col-xs-2 search">
   <form class="form-inline my-2 my-lg-0 ">
            <input class="form-control mr-sm-2 my-sm-0 " type="text" placeholder="ស្វែងរក" id="search">
   </form>
</div>
<div class="col-md-2 col-sm-2 col-lg-2 col-xs-2">
<div class='user_pro'>
            <!-- <div style="padding-top:1%;">
                <a href="my-profile.php"><img src="images/download.png" alt="" class="img-circle"></a>
            </div>
         -->
        <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a class="btn account dropdown-toggle" data-toggle="dropdown" href="#">
                            <img alt="" src="images/download.png">
                        </a>
                        <ul class="dropdown-menu pull-right">
                            <li>
                                <a href="#">
                                    <i class="fa fa-user"></i> Profile
                                </a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-key"></i> Change Password
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="logout.php">
                                    <i class="fa fa-sign-out"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
</div>
</div>
<div id="line" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">
=======
<?php include ('header.php') ?>
>>>>>>> 7df285b6919e6f1b1a273fa04a3104fedd4794c1

<section class="menu">
<<<<<<< HEAD
<div class="container-fluid p-0">
  
<!-- Bootstrap row -->
<div class="row" id="body-row">
    <div class="col-lg-3 col-md-3 col-xs-12  col-sm-12" id="left-menu"  >
    <!-- Sidebar -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidebar-container" aria-controls="sidebar-container" aria-expanded="false" aria-label="Toggle navigation">
    <span style="color:black;" class="icon-bar">
    <i style="color:black;font-size:30px;" class="fas fa-bars"></i>
   </span>
  </button>
    <div id="sidebar-container" class=" sidebar-expanded d-md-block collapse navbar-collapse"><!-- d-* hiddens the Sidebar in smaller devices. Its itens can be kept on the Navbar 'Menu' -->
        <!-- Bootstrap List Group -->
        <ul class="list-group">
            <!-- Separator with title -->
            <li class="list-group-item sidebar-separator-title text-muted d-flex align-items-center menu-collapsed">
                <small id="menu-name">MAIN MENU</small>
            </li>
            <!-- /END Separator -->
            <!-- Menu with submenu -->
            <?php
                     if($_SESSION['department']=='Admin'){
                        // $sql="select * from menu where status=1 order by id ASC";
                        $stmt = $con->prepare("SELECT * from menu where status=1 order by id ASC");
                        $stmt->execute();
                        while($row1=$stmt->fetch()){
                         echo  "<a href='$row1[link]' class='bg-dark list-group-item list-group-item-action'>
                         <div class='d-flex w-100 justify-content-start align-items-center'>
                         <span class='$row1[icon]'></span>
                         <span class='menu-collapsed'>$row1[title]</span>    
                     </div>
                 </a>  
                         "; 
                          
                               
                }
                     }else{
                     $stmt = $con->prepare("SELECT * from menu where title='$_SESSION[department]' AND status=1");
                     $stmt->execute();
                        while($row1=$stmt->fetch()){
                      echo  "<a href='$row1[link]' class='bg-dark list-group-item list-group-item-action'>
                      <div class='d-flex w-100 justify-content-start align-items-center'>
                      <span class='$row1[icon]'></span>
                      <span class='menu-collapsed'>$row1[title]</span>    
                  </div>
              </a>  
                      "; 
                       
                            
             }}
    //         $sql="select * from menu where status=1";
    //         $rs=pg_query($sql);
    //         while($row = pg_fetch_assoc($rs)){
    //          echo  "<a href='$row[link]' class='bg-dark list-group-item list-group-item-action'>
    //          <div class='d-flex w-100 justify-content-start align-items-center'>
    //          <span class='$row[icon]'></span>
    //          <span class='menu-collapsed'>$row[Title]</span>    
    //      </div>
    //  </a>  
    //          "; 
               
    //         }
            ?>
            <!-- <a href="#submenu1" data-toggle="collapse" aria-expanded="false" class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-dashboard fa-fw mr-3"></span> 
                    <span class="menu-collapsed">Operation</span>
                    <span class="submenu-icon ml-auto"></span>
                </div>
            </a> -->
            <!-- Submenu content -->
            <!-- <div id='submenu1' class="collapse sidebar-submenu">
                <a href="#" class="list-group-item list-group-item-action bg-dark sub-name">
                    <span class="menu-collapsed">Charts</span>
                </a>
                <a href="#" class="list-group-item list-group-item-action bg-dark sub-name">
                    <span class="menu-collapsed">Reports</span>
                </a>
                <a href="#" class="list-group-item list-group-item-action bg-dark sub-name">
                    <span class="menu-collapsed">Tables</span>
                </a>
            </div>
            <a href="#submenu3" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-tasks fa-fw mr-3"></span>
                    <span class="menu-collapsed">ITC</span>    
                </div>
            </a> -->
            <!-- Submenu content -->
            <!-- <div id='submenu3' class="collapse sidebar-submenu">
                <a href="#" class="list-group-item list-group-item-action bg-dark sub-name">
                    <span class="menu-collapsed">Settings</span>
                </a>
                <a href="#" class="list-group-item list-group-item-action bg-dark sub-name">
                    <span class="menu-collapsed">Password</span>
                </a>
            </div>       -->
            <!-- Collape -->
            <li class="list-group-item sidebar-separator menu-collapsed"></li>            
            <a href="#" data-toggle="sidebar-colapse" class="bg-dark list-group-item list-group-item-action d-flex align-items-center">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span id="collapse-icon" class="fa fa-2x mr-3"></span>
                    <span id="collapse-text" class="menu-collapsed">Collapse</span>
                </div>
            </a>

        </ul><!-- List Group END-->
    </div><!-- sidebar-container END -->
</div><!-- END Col  -->
    <!-- MAIN -->
=======
<?php include ('leftsidemenu.php') ?>
    <!-- MAIN Contain -->
>>>>>>> 7df285b6919e6f1b1a273fa04a3104fedd4794c1
    <div class="col-lg-9 col-md-9 col-xs-12  col-sm-12" id="main-con">
        <div class="row">
             <?php
<<<<<<< HEAD
             $sql="SELECT * from content where ";
	     echo "<a class='btn-edit' target='_blank' href='#'>
         <i class='fab fa-facebook icon'></i>	
=======
               $stmt1 = $con->prepare("select id from menu where title='$_SESSION[role]' AND status=1");
               $stmt1->execute();
               while($row=$stmt1->fetch()){
                $id = $row['id'];
               }
              $stmt = $con->prepare("select * from content where id_menu='$id' AND status=1");
              $stmt->execute();
              while($row1=$stmt->fetch()){
              echo "
              
              <div class='col-lg-3 col-md-3 col-xs-4  col-sm-4'>
              <div class='middle'>
              ";
	          echo "<a class='btn-edit' target='_blank' href='$row1[link]'>
              <i class='$row1[icon]'></i>	
>>>>>>> 7df285b6919e6f1b1a273fa04a3104fedd4794c1
     </a>";
              echo "</div>
                    </div>";           
    }
        ?>
<<<<<<< HEAD
        </div>
        </div>
         <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" target="_blank" href="https://www.youtube.com/channel/UCXQY_el_0Plytr_3umiDwOA">
         <i class="fab fa-youtube icon"></i>	
	    </a>
         </div>
        </div>
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" target="_blank" href="https://www.google.com/">
         <i class="fab fa-google icon"></i>	
	    </a>
         </div>
        </div>
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" target="_blank" type="application/octet-stream" href="C:\Program Files\Microsoft Office\Office15\WINWORD.EXE">
         <i class="far fa-file-word icon"></i>	
	    </a>
         </div>
        </div>
       </div> <!--End Row -->
        <div class="row">
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
         <div class="middle">
	     <a class="btn-edit" target="_blank" href="//file://c|\windows\System32\calc.exe">
         <i class="far fa-file-excel icon"></i>	
	    </a>
         </div>
         </div>
         <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" href="<?php // exec('"E:\Program Files (X86)\Telegram Desktop\Telegram.exe"'); ?>"> 
         <i class="fab fa-telegram-plane icon"></i>	
	    </a>
         </div>
        </div>
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" target="_blank" href="#">
         <i class="far fa-folder icon"></i>
	    </a>
         </div>
        </div>
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" target="_blank" href="https://www.linkedin.com/company/turbotechsolutions">
         <i class="fab fa-linkedin icon"></i>	
	    </a>
         </div>
        </div>
=======
>>>>>>> 7df285b6919e6f1b1a273fa04a3104fedd4794c1
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