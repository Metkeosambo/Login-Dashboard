// Hide submenus
$('#body-row .collapse').collapse('show'); 

// Collapse/Expand icon
/* $('#collapse-icon').addClass('fa-angle-double-left');  */
$('#Expand-icon').addClass('fa-angle-double-left'); 

// Collapse click
$('#sidebar-container').hover(function() {
    SidebarCollapse();
});

function SidebarCollapse () {
    $('#menu-name').toggleClass('d-flex');
    $('.menu-collapsed').toggleClass('d-flex');
    $('.sidebar-submenu').toggleClass('d-flex');
    $('.submenu-icon').toggleClass('d-none');
    $('#sidebar-container').toggleClass('sidebar-collapsed sidebar-expanded');
    
    // Treating d-flex/d-none on separators with title
    var SeparatorTitle = $('.sidebar-separator-title');
    if ( SeparatorTitle.hasClass('d-flex') ) {
        SeparatorTitle.removeClass('d-flex');
    } else {
        SeparatorTitle.addClass('d-flex');
    }
    
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