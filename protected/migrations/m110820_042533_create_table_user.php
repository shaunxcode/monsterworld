<?php

class m110820_042533_create_table_user extends CDbMigration
{
	public function up()
	{
		$this->createTable('user', array(
    		'id' => 'pk',
    		'email' => 'string NOT NULL',
    		'password' => 'string NOT NULL',
    		'create_date' => 'datetime'
    	));
	}

	public function down()
	{
		$this->dropTable('user'); 
	}
}