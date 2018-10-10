<?php

// Change the working directory to this file.
chdir(__DIR__);
set_include_path (__DIR__);

require 'environment.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST'
&& stripos($_SERVER['CONTENT_TYPE'], 'application/json')) {
  $_POST = json_decode(file_get_contents('php://input'), true);
}


/** MODELS **/
require 'models/Team.php';
require 'models/Work.php';
require 'models/WorkHoursReport.php';
