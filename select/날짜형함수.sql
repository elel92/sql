-- curdate(), current_date - yyyy-mm-dd
select curdate(), current_date;

-- curtime(), current_time - hh:mm:ss
select curtime(), current_time;

-- now(), sysdate(), current_timestamp() - yyyy-mm-dd hh:mm:ss
select now(), sysdate(), current_timestamp();

-- now() vs sysdate()
select now(), sleep(2), now(); -- query 분석 전에 계산
select sysdate(), sleep(2), sysdate(); -- query 실행 중에 계산

-- date_format
select date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초');
select date_format(now(), '%Y년 %c월 %d일 %h시 %i분 %s초');

-- period_diff(p1, p2)
-- : YYMM, YYYYMM으로 표기되는 p1과 p2의 차이의 개월을 반환.
select concat(first_name, ' ', last_name) as name, period_diff(date_format(curdate(), '%Y%m'), date_format(hire_date, '%Y%m')) from employees;

-- date_add, adddate
-- date_sub, subdate
-- (date, INTERVAL expr type)
-- : 날짜 date에 type 형식으로 지정한 expr 값을 더하거나 빼기.
select concat(first_name, ' ', last_name) as name, hire_date, date_add(hire_date, INTERVAL 6 month) from employees;

-- cast
select now(), cast(now() as date), cast(now() as datetime);
select 1-2, cast(1-2 as unsigned);
select cast(cast(1-2 as unsigned) as signed);

