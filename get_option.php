<?php 
/*
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Project Title: Lunch Randomizer
File Title: get_option.php
Original Author: Yuriy Myronchenko
Modified By: Patrick Swanson

Description: 

Created: 
Modified: 03/22/2011
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/

session_start();
include('resources/functions.php');

connectToDatabase();

// Display how many choices there are.
$qry = 'SELECT count(*) AS numOptions FROM options';
$result = runQuery($qry);
$row = mysql_fetch_assoc($result);
$numOptions = $row['numOptions'];
echo 'There are ' . $numOptions . ' options available.<br /><br />';
if($numOptions == 0) {
  echo 'Add some options.';
}

// Check if we've already requested a choice for today. If no, request one and add a record to the database for today. If yes, display that one.
$qry = '
  SELECT name, category
  FROM meals NATURAL JOIN options NATURAL JOIN categories
  WHERE date = \'' . date('Y-m-d') . '\'';
$result = runQuery($qry);
if(mysql_num_rows($result) > 0) { // A record already exists. Display that.
  $qry = '
    SELECT optionID, name, category
    FROM meals NATURAL JOIN options NATURAL JOIN categories
    WHERE date = \'' . date('Y-m-d') . '\'';
  $result = runQuery($qry);
  $row = mysql_fetch_assoc($result);
  echo 'A random lunch location has already been generated.<br /><br />';
} else { // Get a random option and display it.
  $qry = '
    SELECT optionID, name
    FROM options
    ORDER BY rand()
    LIMIT 1';
  $result = runQuery($qry);
  $row = mysql_fetch_assoc($result);
  
  // Add a record to the database.
  $qry = 'INSERT INTO meals (date, optionID) VALUES (\'' . date('Y-m-d') . '\', ' . $row['optionID'] . ')';
  runQuery($qry);
  echo 'You have generated a random lunch location.<br /><br />';
}

echo 'Today we are going to ' . $row['name'] . '.';



// TODO: Display voting information, allowing the users to override whether or not they're actually going to this one.







?>