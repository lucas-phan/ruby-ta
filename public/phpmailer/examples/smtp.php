<?php
/**
 * This example shows making an SMTP connection with authentication.
 */

//SMTP needs accurate times, and the PHP time zone MUST be set
//This should be done in your php.ini, but this is how to do it if you don't have access to that
date_default_timezone_set('Etc/UTC');

require '../PHPMailerAutoload.php';
	
	$username =  $_POST['username'];
	$email =  $_POST['email'];
	$subject =  $_POST['subject'];
	$message =  $_POST['message'];

	//Create a new PHPMailer instance
	$mail = new PHPMailer;
	//Tell PHPMailer to use SMTP
	$mail->isSMTP();
	//Enable SMTP debugging
	// 0 = off (for production use)
	// 1 = client messages
	// 2 = client and server messages
	$mail->SMTPDebug = 4;
	//Ask for HTML-friendly debug output
	$mail->Debugoutput = 'html';
	//Set the hostname of the mail server
	$mail->Host = "webmail.asiacom.co.th";
	//Set the SMTP port number - likely to be 25, 465 or 587
	$mail->Port = 25;
	//Whether to use SMTP authentication
	$mail->SMTPAutoTLS = false; 
	$mail->SMTPSecure = "none";
	$mail->SMTPAuth = true;
	//Username to use for SMTP authentication
	$mail->Username = "support@asiacom.co.th";
	//Password to use for SMTP authentication
	$mail->Password = "AsiacomSupport365";
	//Set who the message is to be sent from
	$mail->setFrom('support@asiacom.co.th', 'TRACK Support');
	//Set an alternative reply-to address
	$mail->addReplyTo('support@asiacom.co.th', 'TRACK Support');
	//Set who the message is to be sent to
	$mail->addAddress('support@asiacom.co.th', 'TRACK Support');
	$mail->addAddress('lewis_kwek@acecom.com.sg', 'Lewis');
	$mail->addAddress('anthony_agustin@acecom.com.sg', 'Anthony');
	$mail->addAddress('loh_jia_ming@acecom.com.sg', 'JM');
	//Set the subject line
	$mail->Subject = $subject;
	//Read an HTML message body from an external file, convert referenced images to embedded,
	//convert HTML into a basic plain-text alternative body
	//$mail->msgHTML(file_get_contents('contents.html'), dirname(__FILE__));
	$mail->msgHTML('From User : '.$username.'<br>Email : '.$email.'<br>Message : '.$message, dirname(__FILE__));
	//Replace the plain text body with one created manually
	$mail->AltBody = 'This is a plain-text message body';
	//Attach an image file
	//$mail->addAttachment('images/phpmailer_mini.png');

	//send the message, check for errors
	if (!$mail->send()) {
		echo "Mailer Error: " . $mail->ErrorInfo;

	} else {
		echo "Message sent!";
	}
