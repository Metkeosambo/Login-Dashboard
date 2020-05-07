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
                     if($_SESSION['role']=='Admin'){
                        // $sql="select * from menu where status=1 order by id ASC";
                        $stmt = $con->prepare("select * from menu where status=1 order by id ASC");
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
                     $stmt = $con->prepare("select * from menu where title='$_SESSION[role]' AND status=1");
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