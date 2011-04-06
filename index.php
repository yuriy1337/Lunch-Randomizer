<?php 
/*
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Project Title: Lunch Randomizer
File Title: index.php
Original Author: Yuriy Myronchenko
Modified By: Patrick Swanson

Description: 

Created: 03/21/2011
Modified: 04/05/2011
- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/

session_start();
include('resources/functions.php');

if(isset($_POST['username'])) {
  $username = sanitize_input($_POST['username']);
  $password = sanitize_input($_POST['password']);

  connectToDatabase();

  $qry = '
    SELECT userID
    FROM users
    WHERE name = \'' . $username . '\' AND password = \'' . $password . '\'';
  $result = runQuery($qry);
  
  if(mysql_num_rows($result) == 1) {
    $row = mysql_fetch_assoc($result);
    $_SESSION['userID'] = $row['userID'];
  } else {
    echo 'Incorrect username/password combination.<br /><br />';
  }
}

/*if(!isset($_SESSION['userID'])) { // Display login form if they aren't logged in.
?>
  <form action="index.php" method="post">
    <p>Login</p>
    <p>User Name: <input type="text" name="username" /></p>
    <p>Password: <input type="password" name="password" /></p>
    <input type="submit" value="Submit" />
  </form>

<?php
*/
//} else {
?>
  <br />
  <a href="get_option.php">Pick a random menu option</a>
  <br />
  <a href="view_all_options.php">View list of all lunch options</a>
<?php
//}
?>