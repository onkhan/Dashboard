<?php

class WorkHoursReport
{

  public static function fetchByProjectId($projectId) {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT DATE(start_date) as date, SUM(hours) AS hours
            FROM Work, Tasks
            WHERE Work.task_id = Tasks.id
              AND Tasks.project_id = ?
            GROUP BY DATE(start_date)';

    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute(
        [$projectId]
    );

    // 4. Handle the results
    // I'm going to cheat a bit here, and *not* make model objects w/ each row
    // As this is a report, an array will work ...
    // We set this up by using 'AS' statements in the SQL to get the keys right
    $arr = $statement->fetchAll(PDO::FETCH_ASSOC);

    // 4.b. return the array of all results
    return $arr;
  }
}
