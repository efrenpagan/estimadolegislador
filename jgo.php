<?php 

header("Content-Type: text/html;charset=utf-8");

$name = $_POST['first_name'];
$email = $_POST['email'];
$message = $_POST['comments'];


$to = "jgo@camaraderepresentantes.org";
$subject = "Estimado Representante";
$body = ' 
<html> 
	<head> 
		<title>Estimado Representante</title> 
	</head> 
	<body>  
		<p><b>Name: </b> '.$name.'</p>
		<p><b>Email: </b> '.$email.'</p> 
		<p><b>Message: </b> '.$message.'</p>
	</body> 
</html>
'; 


$headers = "MIME-Version: 1.0\r\n"; 
$headers .= "Content-type: text/html; charset=utf-8\r\n"; 
$headers .= "Bcc: estimadosenador@gmail.com" . "\r\n";


$headers .= "From: ".$name." <".$email.">\r\n"; 

$sended = mail($to, $subject, $body, $headers);
?>


<html>
<head>
	<title>Estimado Representante</title>

	<link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>

<div class="bigone">	

	<div class="menu clearfix">
		<a href="index.html"><h2>Home</h2></a>
		<a href="about.html"><h2>About</h2></a>
	</div>

	<div class="line"></div>
	
	<div class="cta">
	<h1>Estimado Representante,</h1>
	<h4>
		Esta p&aacute;gina es dedicada al pueblo puertorrique&ntilde;o para ejercer nuestro derecho de libertad de expresi&oacute;n <br>y exigir el m&aacute;s alto respeto y cumplimiento a nuestros representantes legislativos. Este canal ser&aacute; una fuente de ideas, uno que fomente la unidad y el progreso, uno que demande fiscalizaci&oacute;n, responsabilidad, &eacute;tica, e igualdad.<br> 

		<br><b>Puertorrique&ntilde;o</b>, felicita, comenta, y protesta pero siempre con propiedad y respeto. Di lo que ves. Di lo que piensas. La libertad de expresi&oacute;n te lo permite. La democracia te lo pide. Porque todo representante tiene que escuchar para poder cumplir.
	</h4>
	</div>

<div class="about">
		<h5><b>Tu mensaje fue enviado.</b><br> 
 
		<br>Si te gust&oacute; la p&aacute;gina, por favor comp&aacute;rtela, y as&iacute; lograremos que m&aacute;s puertorrique&ntilde;os se expresen.<br>

 
		<br>Gracias por usar Estimado Representante.</h5>
	</div>

</body>
</html>
