-- upper 자바보다 db가 더 빠름 되도록 db에서 포멧팅 처리 등, 자바에서는 출력만.
select upper('seoul'), upper('Seoul');
select upper(first_name) from employees;

-- lower
select lower('SEoul');

-- substring() db는 1부터 시작
select substring('Happy Day', 3, 2);
select first_name, substring(hire_date, 1, 4) as '입사년도' from employees;

-- lpad 오른쪽부터 채우고 빈칸은 지정해서 채우기, rpad 왼쪽부터 채우고 빈칸은 지정해서 채우기
select lpad('1234', 10, '-') as test;
select rpad('1234', 10, '-') as test;

-- ex) salaries 테이블에서 2001년 급여가 70000불 이하의 직원만 사번, 급여로 출력하되 급여는 10자리로 부족한 자리수는 *로 표시
select emp_no, lpad(cast(salary as char), 10, '*') from salaries where from_date like '2001%' and salary < 70000;

-- ltrim, rtrim, trim
select concat('---', ltrim('     hello     '), '---') as 'LTRIM',
       concat('---', rtrim('     hello     '), '---') as 'RTRIM',
       concat('---', trim('     hello     '), '---') as 'TRIM',
       concat('---', trim(both 'x' from 'xxxxxhelloxxxxx'), '---') as 'TRIM2',
       concat('---', trim(leading 'x' from 'xxxxxhelloxxxxx'), '---') as 'TRIM3',
       concat('---', trim(trailing 'x' from 'xxxxxhelloxxxxx'), '---') as 'TRIM4';





