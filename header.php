<?php 
  session_start();
  if(!isset($_SESSION['userid'])){
      header('location: index.php');
  }
?>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="storage/css/style.css?ver=<?= rand() ?>">
    <link rel="stylesheet" href="storage/css/bootstrap.min.css">
    <link rel="stylesheet" href="storage/css/all.css">
    <link rel="stylesheet" href="storage/css/font-awesome.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
     <!-- Datatable CSS -->
     <link href='storage/DataTables/datatables.min.css' rel='stylesheet' type='text/css'>
    <title>TurboTect System</title>
</head>
<body>
<section>
<div class="fixed-top">
<div class="container-fluid "> 
    <div class="row">
       <div class="col-12 header-top">
            <div class="row">
                <div class="col-6" style="padding: 0px;">
                   <div class="row">
                    <div class="language_option">
                        <ul>
                            <li class="" dir="ltr" id="1" onclick="change_language(this.id)">
                                <a href="" style="color:#fff;">
                                    <img src="https://turbotech.com/storages/assets/img/system/km.gif" style="width:24px;" title="ភាសាខ្មែរ" /> <span class='myMenuStyle'></span> <!-- /*my edit kosal================================*/ -->
                                     
                                </a>
                            </li>
                            <li dir="ltr" id="2" onclick="change_language(this.id)">
                                <a href=" " style="color:#fff">
                                    <img src="https://turbotech.com/storages/assets/img/system/en.gif" style="width:24px;" title="English"/> <span></span> 
                                </a>
                            </li>
                        </ul>
                    </div>
                   </div>
                </div>
                <div class="col-6">
                 <div class="row">
                 <div class="col-8" style="padding: 3px; text-align:right;">
                   <ul class="header-social-links" style="margin-top: 0px;list-style:none">
                    <li><a href="https://wwww.facebook.com/turbotechsolutions"><img src="https://turbotech.com//storages/assets/img/system/facebook.png" style=" height:20px"  class="img-circle"/></a></li>
                    <li><a href="https://www.linkedin.com/company/turbotechsolutions"><img src="https://turbotech.com//storages/assets/img/system/linkedin.png" style=" height:20px"  class="img-circle"/></a></li>
                    <li><a href="https://www.youtube.com/channel/UCXQY_el_0Plytr_3umiDwOA"><img src="https://turbotech.com//storages/assets/img/system/youtube.gif" style=" height:20px"  class="img-circle"/></a></li>
                    </ul>
                </div>
                <div class="col-4" style="padding: 0px;text-align:right;">
                   <ul class="header-user " style="margin-top:-3px; margin-right:0px;list-style:none">
                    <li class="dropdown">
                         <a class="btn account dropdown-toggle" data-toggle="dropdown" href="#">
                            <img alt="" src="storage/images/download.png" style="height:20px;"  class="img-circle">
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
                                    <a href="controller/logout.php">
                                        <i class="fa fa-sign-out"></i> Logout
                                    </a>
                                </li>
                            </ul>
                    </li>

                </ul>
            </div>

                 </div>
                </div>

         </div><!-- End ROW -->
       </div> <!-- End COL -->
    </div> <!-- End ROW -->
<div class="row" style="height:100px;">
<div class="col-md-2 col-sm-5 col-lg-2 col-xs-2 image-head" style="height:100%">
 <img src="storage/images/turbotech.png" style="text-align:center;height:100%" id="head-image"class="img-fluid ${3|rounded-top,rounded-right,rounded-bottom,rounded-left,rounded-circle,|}" alt="">
</div> <!-- End Logo -->
<div id="header" class="col-sm-12 col-xs-1 col-md-8 col-lg-8 pull-right">
   <div class="row" style="height:40px;">
        <div class="col-sm-4 col-xs-4 col-md-4 col-lg-4">
            <div class="main-improve">
                <ul class="improve">
                 <li><i class="fas fa-user-graduate" style="color:#1fa8e0;font-size: 20px"></i> <a  href="#" class="post-badge btn_six"><span>I</span>ntelligence</a></li> 
                </ul>  
            </div>
        </div>
        <div class="col-sm-3 col-xs-3 col-md-3 col-lg-3">
            <div class="main-improve">
                <ul class="improve">
                <li><i class="fas fa-handshake" style="color:#1fa8e0;font-size: 20px"></i> <a  href="#" class="post-badge btn_six"><span>M</span>orality</a></li>
                </ul>  
            </div>
        </div>  
        <div class="col-sm-5 col-xs-5 col-md-5 col-lg-5">
            <div class="main-improve">
                <ul class="improve">
                <li><i class="fas fa-user-tie" style="color:#1fa8e0;font-size: 20px"></i> <a  href="#" class="post-badge btn_six"><span>P</span>rofessional & Accountability</a></li>
                </ul>  
            </div>
        </div>    
   </div>
  <div class="row" style="height:40px;">
    <div class="col-sm-3 col-xs-3 col-md-3 col-lg-3">
            <div class="main-improve">
                <ul class="improve">
                <li><i class="fas fa-user-clock" style="color:#1fa8e0;font-size: 20px"></i> <a  href="#" class="post-badge btn_six"><span>R</span>esponsibility</a></li>
                </ul>  
            </div>
        </div>
        <div class="col-sm-3 col-xs-3 col-md-3 col-lg-3">
            <div class="main-improve">
                <ul class="improve">
                <li><i class="fas fa-people-carry" style="color:#1fa8e0;font-size: 20px"></i> <a href="#" class="post-badge btn_six"><span>O</span>ptimistic</a></li>
                </ul>  
            </div>
        </div>  
        <div class="col-sm-3 col-xs-3 col-md-3 col-lg-3">
            <div class="main-improve">
                <ul class="improve">
                <li><i class="fas fa-user-shield" style="color:#1fa8e0;font-size: 20px"></i> <a  href="#" class="post-badge btn_six"><span>V</span>igilant</a></li>
                </ul>  
            </div>
        </div>    
        <div class="col-sm-3 col-xs-3 col-md-3 col-lg-3">
            <div class="main-improve">
                <ul class="improve">
                <li><i class="fas fa-user-check"  style="color:#1fa8e0;font-size: 20px"></i> <a  href="#" class="post-badge btn_six"><span>E</span>fficience</a></li>
                </ul>  
            </div>
        </div>    
   </div>
   </div>
<div class="col-md-2 col-sm-5 col-lg-2 col-xs-2 search" >
   <form class="form-inline my-2 my-lg-0 ">
            <input class="form-control mr-sm-2 my-sm-0 " type="text" placeholder="ស្វែងរក" id="search">
   </form>
</div>
<div id="line" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">
</div>
</div> <!-- End row --> 
</div><!-- End container-->
</div>
</section>
