<div class="row">
              <div class=" col-md-12 col-sm-12 col-lg-12 col-xs-12 text-center" id="footer" style="background: #d42931;padding:5px;text-align:center;width:100%;height:30px; !important">
                <div style="padding-bottom:0px;margin-bottom: 0;color:white;font-family: 'Battambang';font-size:14px;">
                    <p>
                    &copy; <span id="copy-year"></span> TURBOTECH CO., LTD connect & innovate, 
                    <a style="text-decoration:none;"
                    class="text-dark"
                    href="https://www.turbotech.com/"
                    target="_blank"
                    >All Rights Reserved</a
                    >.
                    </p>
                </div> 
                </div>
            </div>
            </div>
        </div>
        <script src="storage/js/jquery-3.4.1.min.js"></script>
        <script src="storage/js/bootstrap.min.js"></script>
        <script src="storage/js/main.js"></script>
        <script src="storage/js/all.js"></script>
        <script src="storage/js/popper.min.js"></script>
        <script src="storage/js/jquery.mCustomScrollbar.concat.min.js"></script>
        <!-- Datatable JS -->
        <script src="storage/DataTables/datatables.min.js"></script>
        <!-- Scipt admin -->
        <script type="text/javascript">
   $(document).ready(function() {
  $(".list-group").mCustomScrollbar({	
                    scrollInertia:200,
                    setHeight:"100%",
                    scrollbarPosition:"inside",
                    autoHideScrollbar:true,
					theme:"dark"
  });
   });
</script>
<script>
                var d = new Date();
                var year = d.getFullYear();
                document.getElementById("copy-year").innerHTML = year;
            </script>
    </body>
</html>