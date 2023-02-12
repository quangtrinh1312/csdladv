-- bịa ra 2 trigger
delimiter $$
drop trigger if exists trigger_21
delimiter $$
create trigger trigger_21
before insert on jobs
    for each row
    begin
		if(exists(select job_title from jobs where job_title = new.job_title))
        then
			signal sqlstate '45000'
			set message_text='The jobs_title value is avalable';
		end if;
    end$$
delimiter $$
drop trigger if exists trigger_21
delimiter $$
create trigger trigger_22
before insert on employees
    for each row
    begin
		if(DATEDIFF(CURDATE(), new.hire_date) / 365<0)
        then
			signal sqlstate '45000'
			set message_text='The hire date invalid';
        end if;
    end$$
    delimiter $$
-- bịa ra 2 event
delimiter $$
SELECT * FROM jobs;
delimiter $$
create event if not exists test_event_06
on schedule every 1 second
starts current_timestamp
ends current_timestamp 	+ interval 5  second
do 
	INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('mobile dev', '10000', '20000');
delimiter $$
create event if not exists test_event_07
on schedule every 1 second
starts current_timestamp
ends current_timestamp 	+ interval 2  second
do 
	INSERT INTO employees( `first_name`, `last_name`, `email`, `phone_number`, `hire_date`, `job_id`, `salary`, `manager_id`, `department_id`) VALUES ( 'duong', 'quang', 'trinh@gmail.com', '0333333333', '2010-09-08', '83', '11000.00', '206', '6');
delimiter $$
-- thêm dữ liệu vào employees khi đến thời điểm 16-02 lúc 6:30
create event if not exists test_event_08
on schedule at '2023-02-16 06:30:00'
do 
	INSERT INTO employees( `first_name`, `last_name`, `email`, `phone_number`, `hire_date`, `job_id`, `salary`, `manager_id`, `department_id`) VALUES ( 'duong', 'quang', 'trinh@gmail.com', '0333333333', current_date(), '83', '11000.00', '206', '6');
-- test
delimiter $$
create event if not exists test_event_09
on schedule at '2023-02-12 13:29:00'
do 
	INSERT INTO employees( `first_name`, `last_name`, `email`, `phone_number`, `hire_date`, `job_id`, `salary`, `manager_id`, `department_id`) VALUES ( 'duong', 'quang', 'trinh@gmail.com', '0333333333', current_date(), '83', '11000.00', '206', '6');
