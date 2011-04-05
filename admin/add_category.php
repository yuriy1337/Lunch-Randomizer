<?php
/*
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Project Title: Lunch Randomizer
File Title: add_option.php
Original Author: Yuriy Myronchenko

Description: 

Created: 03/31/2011
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/

session_start();
include('../resources/functions.php');
$errorText = '';

connectToDatabase();

if (isset($_POST['name'])) { 
  $newCategory = sanitize_input($_POST['name']);

  // If they didn't enter something valid, we return an error.
  if($newCategory == '') {
    $errorText = 'You need to provide the name of the category to add.';
  }

  // Check to see if this entry already exists.
  $qry = '
    SELECT * 
    FROM categories 
    WHERE category = \'' . $newCategory . '\'';
  $result = runQuery($qry);
  if(mysql_num_rows($result)) {
    $errorText = 'The entry: \'' . $newCategory . '\' already exists.';
  }

  if($errorText == '') {
    $qry = 'INSERT INTO categories (category) VALUES (\'' . $newCategory . '\')';
    runQuery($qry);
  }
}


// Get the possible categories.
$qry = '
  SELECT categoryID, category
  FROM categories
  ORDER BY category';
$result = runQuery($qry);

$categories = "";
for($i = 0; $row = mysql_fetch_assoc($result); $i ++) {
  $categories .= $row['category'] . '</br>';
}

?>

<html>
  <head>
  </head>
  <body>
    <h1>Add Lunch Category</h1>
    <p style="color:red;"><?php echo $errorText; ?></p>
    <form action="add_category.php" method="post">
      <p>Name of Category: <input type="text" name="name" /></p>
      <input type="submit" value="Submit" />
    </form>
    <div><h4>Current Options Are:</h4> <?php echo $categories; ?></div>
  </body>
</html>