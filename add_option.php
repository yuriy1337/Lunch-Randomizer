<?php
/*
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Project Title: Lunch Randomizer
File Title: add_option.php
Original Author: Yuriy Myronchenko
Modified By: Patrick Swanson

Description: 

Created: 03/21/2011
Modified: 03/22/2011
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/

session_start();
include('resources/functions.php');

connectToDatabase();

if (isset($_POST['name'])) { 
  $newLocation = sanitize_input($_POST['name']);
  $category = sanitize_input($_POST['category']);

  // Now add the new option.
  $canAddThisEntry = true;

  // Check to see if this entry already exists.
  $qry = '
    SELECT name 
    FROM options 
    WHERE name = \'' . $newLocation . '\'';
  $result = runQuery($qry);
  if(mysql_num_rows($result)) {
    echo 'The entry: \'' . $newLocation . '\' already exists.';
    $canAddThisEntry = false;
  }

  if($canAddThisEntry) {
    $qry = 'INSERT INTO options (name, categoryID) VALUES (\'' . $newLocation . '\', ' . $category . ')';
    runQuery($qry);
  }
}


// Get the possible categories.
$qry = '
  SELECT categoryID, category
  FROM categories
  ORDER BY category';
$result = runQuery($qry);

$categories = '';
for($i = 0; $row = mysql_fetch_assoc($result); $i ++) {
  $categories .= '<option value=\'' . $row['categoryID'] . '\'>' . $row['category'] . '</option>';
}

?>

<html>
  <head>
  </head>
  <body>
    <form action="add_option.php" method="post">
      <p>Name of Place: <input type="text" name="name" /></p>
      <p>Category: 
        <select name="category">
          <?php
            echo $categories;
          ?>
        </select>
      </p>
      <input type="submit" value="Submit" />
    </form>
  </body>
</html>