<?php

// This is the configuration for yiic console application.
// Any writable CConsoleApplication properties can be configured here.
    define('DB_NAME', 'mellisa');
    define('DB_USER', 'bernardina');
    define('DB_PASSWORD', '62mTnygx');
    define('DB_HOST', '127.0.0.1'); 
    define('DB_PORT', 3307);

return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
	'name'=>'My Console Application',
	// application components
	'components'=>array(
		//'db'=>array(
		//	'connectionString' => 'sqlite:'.dirname(__FILE__).'/../data/testdrive.db',
		//),
		// uncomment the following to use a MySQL database
		
		'db'=>array(
			'connectionString' => 'mysql:host=' . DB_HOST . ';port=' . DB_PORT . ';dbname=' . DB_NAME,
			'emulatePrepare' => true,
			'username' => DB_USER,
			'password' => DB_PASSWORD,
			'charset' => 'utf8',
		),
	),
);
