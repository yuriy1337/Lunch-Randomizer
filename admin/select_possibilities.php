<?php 
/*
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Project Title: Lunch Randomizer
File Title: select_possibilities.php
Original Author: William Hanson
Modified By: 

Description: 


Created: 04/05/2011
Modified: 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/
session_start();
include('../resources/functions.php');
connectToDatabase();

if(isset($_GET['fail']) ) {
	echo "<br />No options were availible.  Be less picky. <br />";
}

$qry = '
  SELECT name, category
  FROM meals NATURAL JOIN options NATURAL JOIN categories
  WHERE date = \'' . date('Y-m-d') . '\'';
$result = runQuery($qry);
//Not sure what could create this condition, but avoid the possibility of a redirect loop
if( mysql_num_rows($result) > 0 && !isset($_GET['fail']) )
	header( 'Location: ../get_option.php' );

$qry = '
  SELECT categoryID, category
  FROM categories';
$result = runQuery($qry);
echo "<form name='categoryPicks' method='POST' action='../get_option.php'>\n";
while( $row=mysql_fetch_row($result) ) {
	echo "\t<input type='hidden' name='{$row[0]}' value='0'>\n " .
	"\t<input type='checkbox' value='1' name='{$row[0]}' checked>{$row[1]}<br />\n";
	//If the box is checked, the value is overwritten in POST
}
?>
	<input type='submit' value="Submit">
</form>
