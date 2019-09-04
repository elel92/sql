-- ANSI JOIN 1999

-- 1. join ~ on (ANSI SQL 1999)
select a.first_name, b.title from employees a join titles b on a.emp_no = b.emp_no;

-- 2. natural join
select a.first_name, b.title from employees a natural join titles b;

-- 2-1. natural join의 문제점 -> 여러개의 컬럼이 곂치면 join이 여러번 됨
select count(*) from salaries a natural join titles b; 

-- 2-2. natural join의 문제점 해결 방식 -> join ~ using
select count(*) from salaries a join titles b using(emp_no); 




