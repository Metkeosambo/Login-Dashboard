<div class="col-lg-2 col-md-2 col-xs-2 col-sm-12" id="left-menu">
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
                                    <span style="color:#d42931;font-size:23px;" class="fas fa-bars icon-bar mr-3 align-items-center title-icon">
                                    </span><small id="menu-name" class="menu-collapsed" >MENU</small>
                                </li>

                            <!-- /END Separator -->
                            <!-- Menu with submenu -->
                            <?php
                                    if($_SESSION["depart_id"]=='8'){
                                        // $sql="select * from menu where status=1 order by id ASC";
                                        $stmt = $conn->prepare("select * from main_app_menu order by id ASC");
                                        $stmt->execute();
                                        while($row1=$stmt->fetch()){
                                        echo  "<a href='javascript:void(0);' onclick='get_content_view($row1[id])' data-val='$row1[title]' class='list-group-item list-group-item-action'>
                                        <div class='d-flex w-100 justify-content-start align-items-center'>
                                        <span class='$row1[icon]'></span>
                                        <span class='menu-collapsed'>$row1[title]</span>    
                                    </div>
                                </a>  
                                        "; 
                                        
                                            
                                }
                                    }else{
                                    $stmt = $conn->prepare("select * from main_app_menu where depertement_id=".$_SESSION['depart_id']." order by id ASC");
                                    $stmt->execute();
                                        while($row1=$stmt->fetch()){
                                    echo  "<a href='javascript:void(0);' onclick='get_content_view($row1[id])' class='list-group-item list-group-item-action'>
                                    <div class='d-flex w-100 justify-content-start align-items-center'>
                                    <span class='$row1[icon]'></span>
                                    <span class='menu-collapsed'>$row1[title]</span>    
                                </div>
                            </a>  
                                    ";                                    
                            }}
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
                            <!-- Suggestions -->
                            <li class="sidebar-separator menu-collapsed"></li>         
                            <?php 
                            if($_SESSION["depart_id"]=='8'){
                                echo "<a href='javascript:void(0);' onclick='get_admin_view()' class='list-group-item list-group-item-action d-flex'>";
                            }else{
                                echo "<a href='javascript:void(0);' onclick='suggestForm()' class='list-group-item list-group-item-action d-flex'>";
                            }
                            ?>   
                            
                                <div class="d-flex w-100 justify-content-start align-items-center">
                                    <span id="Expand-icon" class="far fa-sticky-note mr-3"></span>
                                    <span id="collapse-text" class="menu-collapsed">Suggestion</span>
                                </div>
                            </a>
                            <!-- Collape -->
                            <!-- <li class="list-group-item sidebar-separator menu-collapsed"></li>             -->
                            <a style="border-bottom-right-radius:0;border-bottom-left-radius:0;   " href="#" data-toggle="sidebar-colapse" class="list-group-item list-group-item-action d-flex">
                                <div class="d-flex w-100 justify-content-start align-items-center">
                                    <span id="collapse-icon" class="fa fa-2x fa-angle-double-left mr-3"></span>
                                    <span id="collapse-text" class="menu-collapsed">Collapse</span>
                                </div>
                            </a>
                            
                        </ul><!-- List Group END-->
                    </div><!-- sidebar-container END -->

                </div>