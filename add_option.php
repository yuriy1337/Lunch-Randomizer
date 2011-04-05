<?php
/*
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Project Title: Lunch Randomizer
File Title: add_option.php
Original Author: Yuriy Myronchenko
Modified By: Patrick Swanson

Description: 

Created: 03/21/2011
Modified: 04/05/2011
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/

session_start();
include('resources/functions.php');
$errorText = '';

connectToDatabase();

if (isset($_POST['name'])) {
  $newLocation = sanitize_input($_POST['name']);
  $categoryID = sanitize_input($_POST['category']);

  // If they didn't enter something valid, we return an error.
  if($newLocation == '') {
    $errorText = 'You need to provide the name of the place to add.';
  }

  // Check to see if this entry already exists.
  $qry = '
    SELECT name 
    FROM options 
    WHERE name = \'' . $newLocation . '\'';
  $result = runQuery($qry);
  if(mysql_num_rows($result)) {
    $errorText = 'The entry: \'' . $newLocation . '\' already exists.';
  }

  if($errorText == '') {
    $qry = 'INSERT INTO options (name, categoryID) VALUES (\'' . $newLocation . '\', ' . $categoryID . ')';
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
    <p style="color:red;"><?php echo $errorText; ?></p>
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