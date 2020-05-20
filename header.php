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
    <title>DashBoard</title>
</head>
<body>
<section>
<div class="fixed-top">
<div class="container-fluid "> 
<div class="row">
<div class="col-md-2 col-sm-5 col-lg-2 col-xs-2 image-head">
 <img src="storage/images/turbotech.png" style="text-align:center;" id="head-image"class="img-fluid ${3|rounded-top,rounded-right,rounded-bottom,rounded-left,rounded-circle,|}" alt="">
</div> <!-- End Logo -->
<div id="header" class="col-md-6 col-sm-6 col-lg-6 col-xs-6">
   <div class="row">
       <div class="fk col-md-12 col-sm-12 col-lg-12 col-xs-12">
       <h6 class=" widget-title">IMPROVE</h6>
       </div>
   </div>
   <div class="row">
       <div class="col-md-5 col-sm-5 col-lg-5 col-xs-5 main-improve">
       <ul class="improve">
       <li><i class="fas fa-user-graduate" style="color:#1fa8e0;"></i>    Intelligence</li>
       <li><i class="fas fa-handshake" style="color:#1fa8e0;"></i>Morality</li>
       <li><i class="fas fa-user-tie" style="color:#1fa8e0;"></i> Professional & Accountability</li>
      </ul>  
       </div>
       <div class="col-md-3 col-sm-4 col-lg-4 col-xs-4">
       <ul  class="improve">
       <li><i class="fas fa-user-clock" style="color:#1fa8e0;"></i> Responsibility</li>
       <li><i class="fas fa-people-carry" style="color:#1fa8e0;"></i> Optimistic</li>
       
      </ul>  
       </div>
       <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
       <ul  class="improve">
       <li><i class="fas fa-user-shield" style="color:#1fa8e0;"></i> Vigilant</li>
       <li><i class="fas fa-user-check"  style="color:#1fa8e0;"></i> Efficience</li>
      </ul>  
       </div>
   </div>
</div>
<div class="col-md-2 col-sm-5 col-lg-2 col-xs-2 search">
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
                            <img alt="" src="storage/images/download.png">
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
<div id="line" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">

</div>
</div> <!-- End row --> 
</div><!-- End container-->
</div>
</section>
<div id="line" class="col-md-12 col-sm-12 col-lg-12 col-xs-12">

</div>