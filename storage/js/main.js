// Collapse click
$('[data-toggle=sidebar-colapse]').click(function() {
    SidebarCollapse();
});

function SidebarCollapse () {
    $('.menu-collapsed').toggleClass('d-none');
    $('.sidebar-submenu').toggleClass('d-none');
    $('.submenu-icon').toggleClass('d-none');
    $('#sidebar-container').toggleClass('sidebar-expanded sidebar-collapsed');
    
    // Treating d-flex/d-none on separators with title
    // var SeparatorTitle = $('.sidebar-separator-title');
    // if ( SeparatorTitle.hasClass('d-flex') ) {
    //     SeparatorTitle.removeClass('d-flex');
    // } else {
    //     SeparatorTitle.addClass('d-flex');
    // }
    
    // Collapse/Expand icon
    $('#collapse-icon').toggleClass('fa-angle-double-left fa-angle-double-right');
}
//End side bar

//Start Sugesstion query
function suggestForm(){
    if(check_session()){
    return;
}
spin('main-con');
// var xmlhttp = new XMLHttpRequest();
// xmlhttp.onreadystatechange = function() {
//     if (this.readyState == 4 && this.status == 200) {
//         document.getElementById("main-con").innerHTML = this.responseText;
//     }
// }
// xmlhttp.open("GET", "views/suggestion.php", true);
// xmlhttp.send();
$.ajax({

    type:'GET',
    url: "views/suggestion.php",
   /*  data:{
        _session:'check',
    }, */
    success: function(data){
        document.getElementById("main-con").innerHTML = data;
  }
});
}

function check_session(){
    $.ajax({
        type:'GET',
        url: "controller/check_session.php",
        async:false,
        data:{
            _session:'check',
        },
        success: function(data){
            if(parseInt(data)==0){
                location.replace('index.php');
                return true;
            }else{
                return false;
            }
      }
    });
}
function spin(tar){
    document.getElementById(tar).innerHTML='<center></br><div class="spinner-border text-primary center" role="status"><span class="sr-only">Loading...</span></div>&nbsp&nbsp<label style="font-weight:bold;font-size:16px;">Please wait...</label></center>';
}
//Login Statement
function login(a,b){
    a=document.getElementById(a).value;
    b=document.getElementById(b).value;
    $.ajax({
        type:'POST',
        data:{
            username:a,
            pass:b,
        },
        url: "controller/login.php",
        success: function(data){
            console.log(data);
            if(''+data=='block'){
                document.getElementById('HelpBlockMessage').innerHTML='គណនីរបស់លោកអ្នកត្រូវបានបិទ!';
            }else if(''+data=='no have'){
                document.getElementById('HelpBlockMessage').innerHTML='លេខសំងាត់មិនត្រឹមត្រូវ!';
            }else if(''+data=='null'){
                document.getElementById('HelpBlockMessage').innerHTML='សូមព្យាយាមម្តងទៀត!';
            }else{
                location.replace(data)
            }
        }
    });
}
// Table Admin
function get_admin_view(){//top management
    
    // var xmlhttp = new XMLHttpRequest();
    // xmlhttp.onreadystatechange = function() {
    //     if (this.readyState == 4 && this.status == 200) {
    //         document.getElementById("main-con").innerHTML = this.responseText;
    //     }
    // }
    // xmlhttp.open("GET", "views/suggestion.php", true);
    // xmlhttp.send();
    $.ajax({
    
        type:'GET',
        url: "views/admincheck.php",
       /*  data:{
            _session:'check',
        }, */
        success: function(data){
            document.getElementById("main-con").innerHTML = data;
            $('#tableadmin').DataTable({
            });

            $(document).ready(function(){  
                $('.view_detail').click(function(){   
                
                });  
           });  
              
      }
    });
}
function view_detail(id){
                     $.ajax({  
                          url:"views/ViewModal.php",  
                          method:"post",  
                          data:{id:id},  
                          success:function(data){  
                              // get id of div in admincheck.php for show modal 
                               $('#detail_modal').html(data);  
                               // set time out for modal view
                               setTimeout(function(){$('#adminModal').modal("show");},200);
                          }  
                     });  
}
function get_content_view(id){
    if(check_session()){
    return;
}
spin('main-con');
// var xmlhttp = new XMLHttpRequest();
// xmlhttp.onreadystatechange = function() {
//     if (this.readyState == 4 && this.status == 200) {
//         document.getElementById("main-con").innerHTML = this.responseText;
//     }
// }
// xmlhttp.open("GET", "views/suggestion.php", true);
// xmlhttp.send();
$.ajax({

    type:'POST',
    data:{id:id}, 
    url: "views/content.php",
    success: function(data){
        document.getElementById("main-con").innerHTML = data;
  }
});
}