
DELIMITER $$
create procedure pro_Demo1()
begin
	select re.region_name,
		c.country_name,
		l.street_address,
		l.postal_code,
		l.city,l.state_province  
from regions re join countries c on re.region_id=c.region_id
join locations l on c.country_id=l.country_id;
end;$$
call pro_Demo1;
-- tạo một thủ tục có tên proc_Salary để xét thưởng cuối năm như sau 
-- nếu nhân viên làm trên: >= 9 thưởng lương 12tr
-- nếu làm trên 6 năm thưởng 8 tr
-- nếu làm trên 4 năm thưởng 6 tr 
-- còn lại thưởng 5 tr
DROP PROCEDURE IF EXISTS proc_Salary;
DELIMITER $$
create procedure proc_Salary()
begin
	WITH temp AS (
    SELECT first_name, 
	ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 0) AS experience, 
           salary, 
           CASE 
               WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 0) >= 9 THEN 12000
               WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 0) > 6 THEN 8000
               WHEN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 0) > 4 THEN 6000
               ELSE 5000
           END AS bonus
    FROM employees
)
SELECT first_name, experience, salary, bonus, salary + bonus AS total_salary
FROM temp;
end;
$$
call proc_Salary()

-- tạo một pro_Search_Name(Fistname)
-- sau đó cho hiển thị toàn bộ thông tin của nhân viên đó
-- trong đó nối Fullname Firstname+ Lastname
DROP PROCEDURE IF EXISTS pro_Search_Name;
DELIMITER $$
CREATE PROCEDURE pro_Search_Name(Firstname varchar(20))
begin
	select  employee_id, concat(first_name,' ',last_name) as Fullname,
		email, phone_number, hire_date, job_id, salary, manager_id, department_id 
    from 
		employees
    where
		first_name = Firstname;
end;$$
call pro_Search_Name('David')
delimiter $$