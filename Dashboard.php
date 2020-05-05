<?php
include "connect.php";
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css?ver=<?= rand() ?>">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/all.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <title>DashBoard</title>
</head>
<body>
<section>
<div class="fixed-top">
<div class="container-fluid "> 
<div class="row">
<div class="col-md-2 col-sm-2 col-lg-2 col-xs-2">
 <img src="images/turbotech.png" style="text-align:center;" class="img-fluid ${3|rounded-top,rounded-right,rounded-bottom,rounded-left,rounded-circle,|}" alt="">
</div> <!-- End Logo -->
<div id="header" class="col-md-5 col-sm-5 col-lg-5 col-xs-5">
</div>

<div class="col-md-3 col-sm-3 col-lg-3 col-xs-3 search">
   <form class="form-inline my-3 my-lg-0 ">
            <input class="form-control mr-sm-3 my-sm-0 " type="text" placeholder="ស្វែងរក" id="search">
   </form>
</div>
<div class="col-md-2 col-sm-2 col-lg-2 col-xs-2">
<div class='user_pro'>
            <div style="padding-top:1%;">
                <a href="my-profile.php"><img src="images/download.png" alt="" class="img-circle"></a>
            </div>
        </div>
</div>
<div id="line" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">

</div>
</div> <!-- End row --> 
</div><!-- End container-->
</div>
</section>
<div id="line" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">

</div>
<section class="menu">
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
            //     if($_SESSION['position']=='Admin'){
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
            // }else($SESSION['position']=='')

            $sql="select * from menu where status=1";
            $rs=pg_query($sql);
            while($row = pg_fetch_assoc($rs)){
             echo  "<a href='$row[link]' class='bg-dark list-group-item list-group-item-action'>
             <div class='d-flex w-100 justify-content-start align-items-center'>
             <span class='$row[icon]'></span>
             <span class='menu-collapsed'>$row[Title]</span>    
         </div>
     </a>  
             "; 
               
            }
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
    <div class="col-lg-9 col-md-9 col-xs-12  col-sm-12" id="main-con">
        <div class="row">
         <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
         <div class="middle">
	     <a class="btn-edit" target="_blank" href="https://www.facebook.com/turbotechsolutions/">
        	<i class="fab fa-facebook-f icon"></i>	
	    </a>
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
	     <a class="btn-edit" target="_blank" href="file:///c|\windows\System32\calc.exe">
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
</div><!-- Main Row END -->
    </div><!-- Main Col END -->
    
</div><!-- body-row END -->
  
  
</div><!-- container -->
</section>
<!--Section Footer -->
<section >
    <div class="container-fluid">
        <div class="row">
          <!-- <div id="footer" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">
              <div class="row">
                  <div class="col-md-12 col-sm-12 col-lg-12 col-xs-12" id="contain-footer">
                    <div class="row">
                        <div class="col-md-4 col-sm-4 col-lg-4 col-xs-4">

                        </div>
                        <div class="col-md-4 col-sm-4 col-lg-4 col-xs-4">

                        </div>
                        <div class="col-md-4 col-sm-4 col-lg-4 col-xs-4">

                        </div> -->

                    </div><!-- End Row -->
                  </div><!-- End Col -->

              <div id="footer" class=" col-md-12 col-sm-12 col-lg-12 col-xs-12 text-center" id="reserve" style="background: #d42931;padding:10px;text-align:center;width:100%; !important">
            <div style="padding-bottom:0px;margin-bottom: 0;color:white;">© រក្សា&#8203;សិទ្ធិ&#8203;គ្រប់&#8203;យ៉ាង&#8203;ដោយ ក្រុមហ៊ុន ធើបូថេក&#8203; ឯ.ក &#8203;ឆ្នាំ&#8203; 2020</div> 
            </div>
            </div>
            </div><!-- End Row -->
              </div> <!-- End Col -->
        </div> <!-- End Row -->
    </div><!-- End Contain -->
</section>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
<script src="js/all.js"></script>
</body>
</html>