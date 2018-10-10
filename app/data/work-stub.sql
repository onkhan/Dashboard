# -------------------
# --    Projects
# -------------------
DROP TABLE IF EXISTS Projects;
CREATE TABLE Projects (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  name VARCHAR(31) NOT NULL,
  short_description TEXT NOT NULL,
  start_date DATE NOT NULL,
  target_date DATE NOT NULL,
  budget DECIMAL(11,2) NOT NULL,
  spent DECIMAL(11,2) NOT NULL DEFAULT 0, -- calculated from work completed
  projected_spend DECIMAL(11,2) NOT NULL DEFAULT 0, -- based off of size of remaining open tasks
  hours_worked DECIMAL(5,1) DEFAULT 0,  -- aggregated from component tasks
  weekly_effort_target INT NOT NULL DEFAULT 100 -- doesn't really belong here; used for calculation of projected_spend
);

INSERT INTO Projects (id, name, short_description, start_date, target_date, budget, spent, projected_spend, hours_worked, weekly_effort_target)
VALUES (1, 'Tapestry', 'Build a visualization layer for the project dashboard', '2018-07-01','2018-11-03', 4950000, 3456700, 4740500, 0, 400);

# -------------
# --  Teams  --
# -------------
DROP TABLE IF EXISTS Teams;
CREATE TABLE Teams (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  name VARCHAR(31) NOT NULL,
  hourly_rate DECIMAL(6,2) NOT NULL
);

INSERT INTO Teams (id, name, hourly_rate) VALUES (1, 'California Dream', 90);
INSERT INTO Teams (id, name, hourly_rate) VALUES (2, 'Noble Carrots', 100);
INSERT INTO Teams (id, name, hourly_rate) VALUES (3, 'MS Why S', 80);
INSERT INTO Teams (id, name, hourly_rate) VALUES (4, 'Luke\'s Parents', 90);

# -------------
# --  Tasks  --
# -------------
DROP TABLE IF EXISTS Tasks;
CREATE TABLE Tasks (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  title VARCHAR(64) NOT NULL,
  type ENUM ('Epic', 'Story', 'Bug') DEFAULT 'Story',
  size ENUM ('XS','S','M','L','XL','2XL'),
  team_id INT,
  open_date DATE NOT NULL,
  close_date DATE DEFAULT NULL,
  status ENUM('Open', 'Started', 'On Hold', 'Closed'),
  hours_worked DECIMAL(5,1) DEFAULT 0,
  perc_complete int DEFAULT 0,
  current_sprint BOOLEAN
);

INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (1, 'Update Unit tests', 'Epic', 'L', 1, '2018-07-21', null, 'Open', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (2, 'Build UI', 'Story', 'XS', 4, '2018-03-23', null, 'Open', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (3, 'Fix permissions leading to privacy leak', 'Bug', 'L', 2, '2018-06-15', null, 'Open', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (4, 'Evaluate accessibility to screen-readers', 'Epic', '2XL', 2, '2018-03-03', '2018-09-16', 'Closed', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (5, 'Correct repeated 404 errors in settings', 'Bug', 'S', 3, '2018-01-21', null, 'Started', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (6, 'Prepare for internationalization', 'Epic', 'XL', 1, '2018-05-29', null, 'On Hold', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (7, 'Update password hashing from MD5', 'Story', 'M', 4, '2018-07-27', null, 'On Hold', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (8, 'Build CRUD for vendor product models', 'Story', 'L', 2, '2018-05-11', '2018-09-16', 'Closed', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (9, 'Remove unused vendor packages; possible hole', 'Bug', 'XL', 2, '2018-06-12', null , 'Started', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (10, 'Provide error messages on timeout', 'Bug', 'L', 1, '2017-12-29', null , 'Started', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (11, 'Two-factor authentication', 'Story', 'M', 4, '2018-04-23', '2018-10-03', 'Closed', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (12, 'Review automated test suite', 'Epic', 'M', 1, '2018-02-22', null, 'Started', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (13, 'Out of memory error for Win7/IE7', 'Bug', 'XS', 2, '2018-02-28', null , 'Open', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (14, 'Patch over temporary middleware regression', 'Bug', 'S', 2, '2017-12-23', null, 'Open', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (15, '0-Day: Log in as any user', 'Bug', 'S', 3, '2018-06-06', null, 'Started', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (16, 'Require SSL/TLS', 'Story', 'L', 3, '2018-02-25', null, 'Open', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (17, 'Update to current middelware', 'Story', 'XS', 4, '2018-07-30', null, 'Open', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (18, 'Apply ACL to archival data', 'Story', 'L', 2, '2018-02-15', null, 'On Hold', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (19, 'Update copyright year', 'Story', 'XS', 1, '2018-02-15', null, 'Open', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (20, 'Site breaks when using trackpad', 'Bug', 'L', 4, '2018-02-20', null, 'Open', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (21, 'Document API for public release', 'Epic', '2XL', 4, '2018-02-26', '2018-10-01', 'Closed', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (22, 'Star-schemas for ETL', 'Story', 'XL', 1, '2018-06-23', null, 'Started', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (23, 'Touch events not regognized on privacy settings page', 'Bug', 'M', 4, '2018-05-24', null, 'On Hold', 0);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (24, 'Complete feedback survey (10/10)', 'Story', 'L', 1, '2018-05-06', '2018-09-25', 'Closed', 1);
INSERT INTO `Tasks` (`id`, `title`, `type`, `size`, `team_id`, `open_date`, `close_date`, `status`, `current_sprint`) VALUES (25, 'Transition to new CI/DevOps', 'Epic', 'XL', 3, '2018-05-23', null, 'Open', 1);

-- Oops, we left off a column!
ALTER TABLE Tasks
ADD COLUMN project_id INT NOT NULL
AFTER id;

UPDATE Tasks SET project_id = 1;

# ------------
# --  Work  --
# ------------
DROP TABLE IF EXISTS Work;
CREATE TABLE Work (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  team_id INT NOT NULL,
  task_id INT NOT NULL,
  start_date DATETIME NOT NULL,
  hours DECIMAL(3,1) NOT NULL,
  -- tz VARCHAR(10), --TODO? Too messy to deal with time zones?
  completion_estimate int NOT NULL CHECK(0 <= completion_estimate <= 100)
);


# -----------------
# --  Triggers!  --
# -----------------
-- Trigger to sum work to the task it is associated with.
DROP TRIGGER IF EXISTS SumWorkToTask;

CREATE TRIGGER SumWorkToTask
AFTER INSERT ON Work
FOR EACH ROW
  UPDATE Tasks
  SET
    hours_worked = hours_worked + NEW.hours,
    perc_complete = IF(
      NEW.start_date = (
        SELECT MAX(start_date)
        FROM Work
        WHERE task_id = NEW.task_id
      ),
      NEW.completion_estimate,
      perc_complete
    )
  WHERE id = NEW.task_id
;

-- Trigger to sum updated task work and update the project it is associated with
-- This trigger should cascade and be "triggered" (pardon the pun)
-- by the effect of the SumWorkToTask trigger
DROP TRIGGER IF EXISTS SumTaskWorkToProject;

CREATE TRIGGER SumTaskWorkToProject
AFTER UPDATE ON Tasks
FOR EACH ROW
  UPDATE Projects
  SET
    Projects.hours_worked = (SELECT SUM(Tasks.hours_worked)
                             FROM Tasks WHERE Tasks.project_id = NEW.project_id)
  WHERE id = NEW.project_id
;

-- Insert some rows in the Work table.
-- Make sure these are inserted after the trigger is declared.

-- Insert some work item for task #1.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 1, '2018-08-17 10:07:37', '3.2', 9);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 1, '2018-08-24 09:03:32', '6.0', 25);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 1, '2018-08-29 12:47:30', '3.0', 61);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 1, '2018-08-30 09:25:04', '5.0', 80);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 1, '2018-09-09 09:41:18', '1.5', 85);

-- Insert some work item for task #2.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 2, '2018-08-19 08:01:09', '6.0', 26);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 2, '2018-09-11 09:41:40', '3.8', 36);

-- Insert some work item for task #3.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 3, '2018-08-06 11:00:39', '4.0', 34);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 3, '2018-08-26 08:53:52', '1.2', 45);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 3, '2018-09-05 11:27:27', '3.2', 59);

-- Insert some work item for task #4.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 4, '2018-08-16 10:33:28', '1.1', 28);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 4, '2018-08-21 09:03:36', '1.7', 43);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 4, '2018-09-06 11:03:21', '2.5', 59);

-- Insert some work item for task #5.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 5, '2018-08-25 11:00:29', '1.0', 25);

-- Insert some work item for task #6.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 6, '2018-08-05 12:23:48', '5.7', 8);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 6, '2018-08-19 11:26:50', '4.0', 16);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 6, '2018-09-02 12:48:43', '6.0', 36);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 6, '2018-09-07 10:15:50', '3.0', 44);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 6, '2018-09-10 10:43:48', '5.1', 67);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 6, '2018-09-10 10:57:54', '4.9', 89);

-- Insert some work item for task #7.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 7, '2018-08-06 10:27:04', '6.0', 9);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 7, '2018-08-29 09:43:27', '1.3', 59);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 7, '2018-09-05 08:39:07', '2.0', 66);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 7, '2018-09-11 11:20:45', '4.0', 87);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 7, '2018-09-13 11:16:51', '3.5', 96);

-- Insert some work item for task #8.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 8, '2018-08-11 10:31:46', '3.9', 62);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 8, '2018-08-21 09:25:22', '4.0', 86);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 8, '2018-09-08 08:48:20', '1.5', 100);

-- Insert some work item for task #9.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 9, '2018-08-15 11:25:03', '4.1', 10);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 9, '2018-08-22 12:46:53', '4.9', 16);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 9, '2018-09-01 09:27:30', '4.0', 56);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 9, '2018-09-12 10:49:31', '3.2', 79);

-- Insert some work item for task #10.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 10, '2018-08-16 10:16:20', '4.8', 7);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 10, '2018-08-22 09:53:03', '1.6', 14);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 10, '2018-09-13 09:07:39', '5.0', 50);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 10, '2018-09-13 10:04:43', '2.5', 81);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 10, '2018-09-14 09:30:18', '3.2', 96);

-- Insert some work item for task #11.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 11, '2018-08-06 12:17:19', '5.8', 10);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 11, '2018-08-11 10:44:41', '5.7', 60);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 11, '2018-09-04 09:39:16', '3.0', 100);

-- Insert some work item for task #12.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 12, '2018-08-20 09:47:18', '4.1', 45);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 12, '2018-08-25 09:52:49', '6.0', 59);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 12, '2018-08-30 12:59:18', '3.8', 82);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 12, '2018-09-04 08:57:03', '3.7', 87);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 12, '2018-09-05 08:35:49', '1.4', 90);

-- Insert some work item for task #13.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 13, '2018-08-04 12:22:07', '2.0', 14);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 13, '2018-08-11 09:51:04', '1.0', 35);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 13, '2018-08-13 09:55:40', '6.0', 44);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 13, '2018-08-30 08:06:57', '4.0', 56);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 13, '2018-09-03 09:14:18', '5.0', 83);

-- Insert some work item for task #14.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 14, '2018-08-13 10:49:06', '6.0', 9);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 14, '2018-08-22 09:54:34', '5.0', 16);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 14, '2018-08-26 11:03:15', '2.0', 52);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 14, '2018-09-05 11:13:30', '3.0', 78);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 14, '2018-09-07 10:20:32', '5.0', 90);

-- Insert some work item for task #15.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 15, '2018-08-11 11:41:11', '2.1', 11);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 15, '2018-08-12 08:52:22', '4.0', 23);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 15, '2018-08-13 11:45:13', '6.0', 36);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 15, '2018-08-21 11:14:25', '1.6', 41);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 15, '2018-08-22 08:55:42', '3.0', 56);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 15, '2018-08-30 10:31:51', '4.8', 61);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 15, '2018-09-04 11:50:50', '5.0', 76);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 15, '2018-09-05 09:09:33', '3.1', 81);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 15, '2018-09-06 09:07:47', '4.9', 88);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 15, '2018-09-08 09:17:07', '3.0', 94);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 15, '2018-09-10 09:21:21', '3.2', 97);

-- Insert some work item for task #16.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 16, '2018-08-28 10:36:45', '1.2', 52);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 16, '2018-09-14 08:56:03', '1.4', 78);

-- Insert some work item for task #17.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 17, '2018-08-20 10:36:55', '3.3', 39);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 17, '2018-08-30 08:01:38', '4.0', 72);

-- Insert some work item for task #18.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 18, '2018-09-09 09:32:07', '1.9', 78);

-- Insert some work item for task #19.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 19, '2018-08-04 09:06:42', '2.1', 16);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 19, '2018-08-11 09:44:20', '6.0', 25);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 19, '2018-08-26 10:10:24', '5.8', 39);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 19, '2018-09-02 10:42:07', '2.2', 47);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 19, '2018-09-08 08:42:59', '4.0', 57);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 19, '2018-09-11 09:42:49', '3.1', 86);

-- Insert some work item for task #20.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 20, '2018-08-08 10:46:21', '1.3', 5);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 20, '2018-08-10 11:02:26', '3.0', 10);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 20, '2018-08-15 08:37:24', '2.3', 28);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 20, '2018-08-16 08:49:24', '2.4', 56);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 20, '2018-08-19 12:50:40', '5.0', 71);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 20, '2018-08-31 09:29:24', '5.8', 81);

-- Insert some work item for task #21.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 21, '2018-08-08 11:40:48', '4.9', 25);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 21, '2018-08-28 08:15:02', '5.1', 47);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 21, '2018-09-04 11:57:03', '4.4', 100);

-- Insert some work item for task #22.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 22, '2018-08-18 11:33:34', '2.5', 10);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 22, '2018-08-31 08:47:41', '6.0', 16);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 22, '2018-09-02 08:48:00', '1.5', 68);

-- Insert some work item for task #23.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 23, '2018-08-03 10:40:38', '2.0', 40);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 23, '2018-08-15 09:48:39', '1.5', 74);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 23, '2018-08-16 08:25:15', '1.6', 89);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 23, '2018-09-13 09:25:32', '4.9', 95);

-- Insert some work item for task #24.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 24, '2018-09-03 08:34:06', '3.0', 14);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (2, 24, '2018-09-08 08:38:17', '4.9', 26);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 24, '2018-09-10 10:37:28', '5.1', 45);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 24, '2018-09-13 10:23:09', '4.7', 76);

-- Insert some work item for task #25.
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (4, 25, '2018-08-07 10:49:53', '3.4', 26);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (1, 25, '2018-08-23 09:38:56', '1.6', 65);
INSERT INTO `Work` (`team_id`, `task_id`, `start_date`, `hours`, `completion_estimate`) VALUES (3, 25, '2018-09-07 10:51:16', '3.6', 93);
