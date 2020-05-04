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
<div class="container-fluid"> 
<div class="row">
<div class="col-md-2 col-sm-2 col-lg-2 col-xs-2">
 <img src="images/turbotech.png" class="img-fluid ${3|rounded-top,rounded-right,rounded-bottom,rounded-left,rounded-circle,|}" alt="">
</div> <!-- End Logo -->
<div id="header" class="col-md-7 col-sm-7 col-lg-7 col-xs-7">
</div>
<div class="col-md-3 col-sm-3 col-lg-3 col-xs-3 search">
   <form class="form-inline my-3 my-lg-0 ">
            <input class="form-control mr-sm-3 my-sm-0 " type="text" placeholder="ស្វែងរក" id="search">
   </form>
</div>
</div> <!-- End row --> 
</div><!-- End container-->
</section>
<div id="line" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">

</div>
<section>
<div class="container-fluid p-0">
  
<!-- Bootstrap row -->
<div class="row" id="body-row">
    <div class="col-lg-3 col-md-3 col-xs-12  col-sm-12" id="left-menu">
    <!-- Sidebar -->
    <div id="sidebar-container" class=" sidebar-expanded d-md-block"><!-- d-* hiddens the Sidebar in smaller devices. Its itens can be kept on the Navbar 'Menu' -->
        <!-- Bootstrap List Group -->
        <ul class="list-group">
            <!-- Separator with title -->
            <li class="list-group-item sidebar-separator-title text-muted d-flex align-items-center menu-collapsed">
                <small id="menu-name">MAIN MENU</small>
            </li>
            <!-- /END Separator -->
            <!-- Menu with submenu -->
            <a href="#submenu1" data-toggle="collapse" aria-expanded="false" class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-dashboard fa-fw mr-3"></span> 
                    <span class="menu-collapsed">Operation</span>
                    <span class="submenu-icon ml-auto"></span>
                </div>
            </a>
            <!-- Submenu content -->
            <div id='submenu1' class="collapse sidebar-submenu">
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
            <a href="#submenu2" data-toggle="collapse" aria-expanded="false" class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-user fa-fw mr-3"></span>
                    <span class="menu-collapsed">Finance</span>
                    <span class="submenu-icon ml-auto"></span>
                </div>
            </a>
            <!-- Submenu content -->
            <div id='submenu2' class="collapse sidebar-submenu">
                <a href="#" class="list-group-item list-group-item-action bg-dark sub-name">
                    <span class="menu-collapsed">Settings</span>
                </a>
                <a href="#" class="list-group-item list-group-item-action bg-dark sub-name">
                    <span class="menu-collapsed">Password</span>
                </a>
            </div>            
            <a href="#submenu3" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-tasks fa-fw mr-3"></span>
                    <span class="menu-collapsed">ITC</span>    
                </div>
            </a>
            <!-- Submenu content -->
            <div id='submenu3' class="collapse sidebar-submenu">
                <a href="#" class="list-group-item list-group-item-action bg-dark sub-name">
                    <span class="menu-collapsed">Settings</span>
                </a>
                <a href="#" class="list-group-item list-group-item-action bg-dark sub-name">
                    <span class="menu-collapsed">Password</span>
                </a>
            </div>      
             <!-- Menu with submenu -->
             <a href="#submenu4" data-toggle="collapse" aria-expanded="false" class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-dashboard fa-fw mr-3"></span> 
                    <span class="menu-collapsed">Bussiness</span>
                    <span class="submenu-icon ml-auto"></span>
                </div>
            </a>
            <!-- Submenu content -->
            <div id='submenu4' class="collapse sidebar-submenu">
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
             <!-- Menu with submenu -->
             <a href="#submenu5" data-toggle="collapse" aria-expanded="false" class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-dashboard fa-fw mr-3"></span> 
                    <span class="menu-collapsed">Audit</span>
                    <span class="submenu-icon ml-auto"></span>
                </div>
            </a>
            <!-- Submenu content -->
            <div id='submenu5' class="collapse sidebar-submenu">
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
             <!-- Menu with submenu -->
             <a href="#submenu6" data-toggle="collapse" aria-expanded="false" class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-dashboard fa-fw mr-3"></span> 
                    <span class="menu-collapsed">Admin</span>
                    <span class="submenu-icon ml-auto"></span>
                </div>
            </a>
            <!-- Submenu content -->
            <div id='submenu6' class="collapse sidebar-submenu">
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
    <div class="col-lg-9 col-md-9 col-xs-12  col-sm-12">
        <div class="row">
         <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
         <div class="middle">
	     <a class="btn-edit" href="#">
        	<i class="fab fa-facebook-f icon"></i>	
	    </a>
         </div>
         </div>
         <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" href="#">
         <i class="fab fa-youtube icon"></i>	
	    </a>
         </div>
        </div>
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" href="#">
         <i class="fab fa-google icon"></i>	
	    </a>
         </div>
        </div>
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" href="#">
         <i class="far fa-file-word icon"></i>	
	    </a>
         </div>
        </div>
       </div> <!--End Row -->
        <div class="row">
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
         <div class="middle">
	     <a class="btn-edit" href="#">
         <i class="far fa-file-excel icon"></i>	
	    </a>
         </div>
         </div>
         <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" href="#">
         <i class="fab fa-telegram-plane icon"></i>	
	    </a>
         </div>
        </div>
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" href="#">
         <i class="far fa-folder icon"></i>
	    </a>
         </div>
        </div>
        <div class="col-lg-3 col-md-3 col-xs-4  col-sm-4">
    <div class="middle">
	     <a class="btn-edit" href="#">
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
<section>
    <div class="container-fluid">
        <div class="row">
          <div id="footer" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">
              <div class="row">
                  <div class="col-md-12 col-sm-12 col-lg-12 col-xs-12" id="contain-footer">
                    <div class="row">
                        <div class="col-md-4 col-sm-4 col-lg-4 col-xs-4">

                        </div>
                        <div class="col-md-4 col-sm-4 col-lg-4 col-xs-4">

                        </div>
                        <div class="col-md-4 col-sm-4 col-lg-4 col-xs-4">

                        </div>

                    </div><!-- End Row -->
                  </div><!-- End Col -->
              <div class=" col-md-12 col-sm-12 col-lg-12 col-xs-12 text-center" id="reserve" style="background: #0b78a5;padding:10px;text-align:center;width:100% !important">
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