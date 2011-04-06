<html>
<head> <title>Drop database</title>

</head>
<body>
<?php
	include '../resources/functions.php';
	if( isset($_GET['confirm']) ) {
		$con = mysql_connect('localhost', 'root', '') or die( "Error connecting: " . mysql_error() );
		
		$drop_query = "DROP DATABASE IF EXISTS `lunch`";
		runQuery($drop_query);
		echo "Deleted old database.<br>\n";

		$create_query = "CREATE DATABASE `lunch`";
		runQuery($create_query);
		echo "Created new database.<br>\n";
		
		mysql_select_db('lunch', $con) or die('Could not select database.');
		
		$query = "CREATE TABLE `lunch`.`categories` (
			`categoryID` int(10) unsigned NOT NULL AUTO_INCREMENT,
			`category` varchar(20) NOT NULL,
			PRIMARY KEY (`categoryID`)
			) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;";
		runQuery($query);
		echo "Created new categories table.<br>\n";
		
		$query ="INSERT INTO `lunch`.`categories` (`categoryID`, `category`) VALUES
			(1, 'Chinese'),
			(2, 'Mexican'),
			(3, 'Burgers'),
			(4, 'Steak'),
			(5, 'Sandwiches'),
			(6, 'Italian'),
			(8, 'Breakfast');";
		runQuery($query);
		echo "Filled categories table.<br>\n";
		
		$query = "CREATE TABLE IF NOT EXISTS `lunch`.`days` (
			`dayID` int(10) unsigned NOT NULL AUTO_INCREMENT,
			`name` varchar(10) NOT NULL,
			`isCatered` tinyint(1) NOT NULL,
			PRIMARY KEY (`dayID`)
			) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;";
		runQuery($query);
		echo "Created new days table.<br>\n";
		
		$query = "INSERT INTO `lunch`.`days` (`dayID`, `name`, `isCatered`) VALUES
			(1, 'Monday', 1),
			(2, 'Tuesday', 0),
			(3, 'Wednesday', 1),
			(4, 'Thursday', 0),
			(5, 'Friday', 1);";
		runQuery($query);
		echo "Filled days table.<br>\n";
		
		$query = "CREATE TABLE IF NOT EXISTS `lunch`.`meals` (
			`mealID` int(10) unsigned NOT NULL AUTO_INCREMENT,
			`date` date NOT NULL,
			`optionID` int(11) unsigned NOT NULL,
			PRIMARY KEY (`mealID`),
			UNIQUE KEY `date` (`date`),
			KEY `optionID` (`optionID`)
			) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;";
		runQuery($query);
		echo "Created new options table.<br>\n";
		
		$query = "CREATE TABLE IF NOT EXISTS `lunch`.`options` (
			`optionID` int(11) unsigned NOT NULL AUTO_INCREMENT,
			`name` varchar(25) NOT NULL,
			`categoryID` int(10) unsigned NOT NULL,
			`availability` enum('Catered','non-Catered','Either') NOT NULL,
			PRIMARY KEY (`optionID`),
			KEY `categoryID` (`categoryID`)
			) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;";
		runQuery($query);
		echo "Created new options table.<br>\n";
		
		$query = "CREATE TABLE IF NOT EXISTS `lunch`.`users` (
			`userID` int(11) unsigned NOT NULL AUTO_INCREMENT,
			`name` varchar(40) NOT NULL,
			`password` varchar(25) NOT NULL,
			PRIMARY KEY (`userID`)
			) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;";
		runQuery($query);
		echo "Created new users table.<br>\n";
		
		$query = "INSERT INTO `lunch`.`options` (`optionID`, `name`, `categoryID`, `availability`) VALUES
			(1, 'China Bowl', 1, 'non-Catered'),
			(2, 'Panda Express', 1, 'non-Catered'),
			(4, 'Five Guys', 3, 'non-Catered'),
			(5, 'Red Robin', 3, 'non-Catered'),
			(7, 'Texas de Brazil', 4, 'non-Catered'),
			(8, 'Portillo''s', 3, 'non-Catered'),
			(9, 'EBT', 2, 'non-Catered'),
			(10, 'Burger King', 3, 'non-Catered'),
			(16, 'Chipotle', 3, 'Either'),
			(17, 'Subway', 5, 'non-Catered'),
			(18, 'Unknown Mexican', 2, 'Catered'),
			(19, 'Unknown Sandwiches', 5, 'Catered'),
			(20, 'Unknown Sanwiches', 5, 'Catered');";
		runQuery($query);
		echo "Filled options table.<br>\n";
	}
	else { ?>
	Are you sure you want to delete everything?<br>
	<a href="createNew.php?confirm">Yup</a> &nbsp;&nbsp; <a href="/">No</a>
	<?php
	}

?>
</body>
</head>