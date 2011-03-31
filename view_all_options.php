<?php
/*
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Project Title: Lunch Randomizer
File Title: view_all_options.php
Original Author: Patrick Swanson


Description: Shows all of the options to the user, sorted alphabetically.

Created: 03/22/2011
Modified: 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/

session_start();
include('resources/functions.php');

connectToDatabase();

$qry = '
  SELECT name, category
  FROM options NATURAL JOIN categories
  ORDER BY name';
$result = runQuery($qry);

echo 'There are ' . mysql_num_rows($result) . ' options available.<br /><br />';

if(mysql_num_rows($result) > 0) {
  while($row = mysql_fetch_assoc($result)) {
    echo $row['name'] . '<br />';
  }
}

?>