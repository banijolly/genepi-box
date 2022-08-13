<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
	
<!--===============================================================================================-->
<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<style>
    .resultBox
    {
        overflow:scroll;
        height:650px;
        width:100%;
    }
</style>
</head>



<body>
	
	<div class="limiter">
		<div class="container-login100" style="background-image: url('images/bg-01.jpg');">
			<div class="wrap-login100 p-l-80 p-r-80 p-t-40 p-b-33">
				<div class="login100-form validate-form flex-sb flex-w">
					<span class="login100-form-title ">
						<img src="../logo.png" class="logo-image">
					</span>
					<span class="login100-form-title p-b-20">
						RESULTS LOG
					</span>

					<div class="p-t-20 p-b-9 resultBox" id="container" >
						
					<?php
                    ini_set ("display_errors", "1");
                    error_reporting(E_ALL);
					$target_dir = "../uploads/";
					$target_file_runfolder = $target_dir . "sequences_uploaded.fasta";
					$target_file_config =  "../config.txt";

					$target_file_metadata = $target_dir . "Metadata_input.tsv";


					$uploadOk = 1;
					$imageFileType = strtolower(pathinfo($target_file_runfolder,PATHINFO_EXTENSION));
					$imageFileType = strtolower(pathinfo($target_file_config,PATHINFO_EXTENSION));


					$imageFileType = strtolower(pathinfo($target_file_metadata,PATHINFO_EXTENSION));







					if ($uploadOk == 0) {
					echo "Sorry, your file was not uploaded.";
					// if everything is ok, try to upload file
					} 
					else {
					if (move_uploaded_file($_FILES["folderInput"]["tmp_name"], $target_file_runfolder) && move_uploaded_file($_FILES["config"]["tmp_name"], $target_file_config) && move_uploaded_file($_FILES["metadata"]["tmp_name"], $target_file_metadata) ) {
						echo "The files have been uploaded";
					} else {
						echo "Sorry, there was an error uploading your file.";
					}
					}
					chdir("../uploads/");

					chdir("../");
					$output2 =  shell_exec('pwd');

					shell_exec('./parseAndRun_FASTA.sh  > /dev/null 2>run.log &');

					?>

					</div>
										
					<div class="p-t-20 p-b-9 upload" id="result" >
					</div>

                    <script type="text/javascript">					
					$(document).ready(function(){
					
					var status="";
					$('#result').html(status);
					setInterval(function() {$.get('../.status', function (response) {status = response;});;
					$('#result').html(status);},5000);
					 
					
    				//$('#container').load("../LOGFILE.now");
					$('#container').load("../LOGFILE.now", function() {
        				$(this).html($(this).html().replace("\n", "<br>"))});
    				setInterval(function(){
        			//$('#container').load("../LOGFILE.now");
					$('#container').load("../LOGFILE.now", function() {
        				$(this).html($(this).html().replace(/\n/g, "<br>"))});
   				 	},1000);
					});

					</script>
                    <div class="p-t-13 p-b-9 container-login100-form-btn">
						<span onclick='location.href="../index.html"' class="login100-form-btn">Home</span>
					</div>
					

                    </div>
                </div>
            </div>
        </div>
        

<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>
