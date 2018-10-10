<?php

class Work
{
  public $id;
  public $task_id;
  public $team_id;
  public $start;  //'YYYY-MM-DD'
  public $stop;   //'YYYY-MM-DD', needs to be calculated
  public $hours;
  public $completion_estimate;

  public function __construct($row) {
    $this->id = intval($row['id']);

    $this->task_id = intval($row['task_id']);
    $this->team_id = intval($row['team_id']);

    $this->start = $row['start_date'];
    $this->hours = floatval($row['hours']);

    // Calculate stop date
    $hours = floor($this->hours);
    $mins = intval(($this->hours - $hours) * 60); // Take advantage of one decimal place
    $interval = 'PT'. ($hours ? $hours.'H' : '') . ($mins ? $mins.'M' : '');

    $date = new DateTime($this->start);
    $date->add(new DateInterval($interval));
    $this->stop = $date->format('Y-m-d H:i:s');

    $this->completion_estimate = intval($row['completion_estimate']);
  }

  public static function getWorkByTaskId(int $taskId) {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * FROM Work WHERE task_id = ?';

    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute(
        [$taskId]
    );

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      // 4.a. For each row, make a new work object
      $workItem =  new Work($row);

      array_push($arr, $workItem);
    }

    // 4.b. return the array of work objects

    return $arr;
  }
}
