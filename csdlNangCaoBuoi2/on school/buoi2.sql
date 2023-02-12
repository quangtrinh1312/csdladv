DELIMITER $$
DROP TRIGGER IF EXISTS BEFORE_INSERT_MIN_MAX_SALARY
DELIMITER $$
create trigger BEFORE_INSERT_MIN_MAX_SALARY
BEFORE INSERT ON jobs
for each row
begin
	if(new.min_salary<0 or new.max_salary<0) then
    signal sqlstate '45000'
    set message_text='The min salary or max salary value invalid';
    end if;
end$$
DELIMITER $$
DROP TRIGGER IF EXISTS BEFORE_UPDATE_MIN_MAX_SALARY
DELIMITER $$
create trigger BEFORE_UPDATE_MIN_MAX_SALARY
BEFORE UPDATE ON jobs
for each row
begin
	if(new.min_salary<0 or new.max_salary<0) then
    signal sqlstate '45000'
    set message_text='The min salary or max salary value invalid';
    end if;
end$$
DELIMITER $$
SELECT * FROM jobs;

UPDATE jobs SET min_salary = -1, max_salary = -1 WHERE (job_id = '5');

delimiter $$

set global event_scheduler = on;
show processlist;
delimiter $$
create event if not exists test_event_01
on schedule at current_timestamp
do
	insert into jobs(min_salary,max_salary)
    values(10, NOW())
delimiter $$
SELECT * FROM jobs;
create event if not exists test_event_06
on schedule every 1 second
starts current_timestamp
ends current_timestamp 	+ interval 1  minute
do 
	INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('ad', '10', '10');