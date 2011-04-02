<?php 
/*
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Project Title: Lunch Randomizer
File Title: functions.php
Original Author: Patrick Swanson


Description: 

Created: 03/22/2011
Modified: 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/


function sanitize_input($var) {
  return trim(mysql_real_escape_string(str_replace('&nbsp;', '', $var)));
}


// -------------------- MySQL methods ------------------------

function connectToDatabase() {
  $con = mysql_connect('localhost', 'root', '');
  if (!$con) { die('Could not connect: ' . mysql_error()); }
  mysql_select_db('lunch', $con) or die('Could not select database.');

  return $con;
}


function runQuery($qry) {
  if (!($result = mysql_query($qry))) { die('Error running query: ' . mysql_error() . '<br /><br />' . $qry); }
  return $result;
}

// ------------------- Yuriy's methods --------------------------------
if (isset($_GET['DEBUG'])) {  
  header("Content-Type: text/plain");  
  var_dump($_SERVER);  
}  


if (isset($_GET['source'])) {
  $page = highlight_file(__FILE__, true);
  $page = preg_replace('/\$con.*?mysql_connect.*?\)\;/', '$con <span style="color: #007700">= </span><span style="color: #FF8000">/* Line removed on account of malicious coworkers. */</span>', $page, 1);
  echo $page;
  exit;
}  

if (isset($_GET['env'])) {  
  header("Content-Type: text/plain");  
  var_dump($_SERVER);  
  exit;  
}  

?>