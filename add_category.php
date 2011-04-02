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
include('resources/functions.php');

connectToDatabase();

if (isset($_POST['name'])) { 
  $newCategory = sanitize_input($_POST['name']);

  // Now add the new option.
  $canAddThisEntry = true;

  // Check to see if this entry already exists.
  $qry = '
    SELECT * 
    FROM categories 
    WHERE category = \'' . $newCategory . '\'';
  $result = runQuery($qry);
  if(mysql_num_rows($result)) {
    echo 'The entry: \'' . $newCategory . '\' already exists.';
    $canAddThisEntry = false;
  }

  if($canAddThisEntry) {
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

$test = "hello";

?>

<html>
  <head>
  </head>
  <body>
    <form action="add_category.php" method="post">
      <p>Name of Category: <input type="text" name="name" /></p>
      <input type="submit" value="Submit" />
    </form>
    <div>Current Options Are:</br> <?php echo $categories ?></div>
  </body>
</html>