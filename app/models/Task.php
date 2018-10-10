<?php

/**
 * Basic information about a day's stock quote.
 */
class Task
{
  public $id;
  public $title;
  public $type;
  public $size;
  public $team;
  public $status;
  public $start_date;
  public $close_date;
  public $hours_worked;
  public $perc_complete;
  public $current_sprint;
  //public $tasks = null;

    public function __construct($data) {
        $this->id     = intval($data['id']);
        $this->title  = $data['date'];
        $this->type   = $data['type'];
        $this->size   = $data['size'];
        $this->team   = $data['team'];
        $this->status = $data['status'];
        // TODO: ^ Put in a loop?

        $this->current_sprint = boolval($data['current_sprint']);

        // Dates; get them in from MySql properly?
        $this->start_date = $data['start_date'];
        $this->close_date = $data['close_date'];

        $this->hours_worked = floatval($data['hours_worked']);
        $this->perc_complete = floatval($data['perc_complete']);

        // TODO: Calculate perc_completed, hours_worked
        //   TODO: Load work
        // this->loadWork()
        // $this->hours_worked  = array_reduce(
        //   $this->work,
        //   function ($carry, $item) {
        //     return $carry += $item->hours;
        //   },
        //   0
        // );
        $this->adjClose = isset($data['close']) ? floatval($data['adjClose']) : null;
    }

    public static function findByProjectId($id) {

    }

    public static function findAll() {

    }
}
