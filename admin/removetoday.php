<?php
include('../resources/functions.php');
connectToDatabase();

$qry = "DELETE FROM meals WHERE date = '" . date('Y-m-d'). "'";
  runQuery($qry);
  echo $qry;
  
 $qry = "SELECT * FROM meals";
 $result = runQuery($qry);
 echo "<br>";
 while($row = mysql_fetch_array($result) ) {
	foreach($row as $entry)
		echo $entry." ";
	echo "<br>";
	
	}
?>