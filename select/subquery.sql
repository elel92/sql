-- 단일행 연산

-- ex) (현재 Fai Bale이 근무하는 부서)에서 근무하는 (직원의 사번, 전체이름)을 출력해보세요.
select a.emp_no, concat(b.first_name, ' ', b.last_name)
from dept_emp a, employees b
where a.emp_no = b.emp_no
  and concat(b.first_name, ' ', b.last_name) = 'Fai Bale'
  and a.to_date = '9999-01-01';


-- 서브쿼리는 괄호로 묶기.
-- 단, 서브쿼리 내에 ORDER BY 사용 x.
-- group by 절 외에 거의 모든 절에서 사용 가능(특히, from절, where절에서 많이 사용).
-- where절인 경우,
-- 1) 단일행 연산자 : =, >, <, >=, <=, <>(!=)

-- 2) 다중(복수)행 연산자 : in, not in, any, all
--    any 사용법 :
--           =any : in과 동일
--           >any, >=any : 최소값
--           <any, <=any : 최대값
--           <>any, !=any : !=all과 동일 
--    all 사용법 : 
--           =all : in과 동일
--           >all, >=all : 최대값
--           <all, <=all : 최소값


-- 실습문제1)
-- 현재 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 나타내세요.
select concat(a.first_name, ' ', a.last_name) as '이름', b.salary as '급여'
from employees a, salaries b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and b.salary < (select avg(salary) from salaries where to_date = '9999-01-01');
   
-- 실습문제2)
-- 현재 가장 적은 평균 급여를 받고 있는 직책에 대해서 평균급여를 구하세요.
select a.title, avg(b.salary)
from titles a, salaries b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by a.title
having round(avg(b.salary)) = (select round(avg(b.salary))
                               from titles a, salaries b
                               where a.emp_no = b.emp_no
                                 and a.to_date = '9999-01-01'
                                 and b.to_date = '9999-01-01'
						       group by a.title
                               order by avg(b.salary) asc
							   limit 0, 1);

select b.title, avg(a.salary)
from salaries a, titles b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by b.title
  having round(avg(a.salary)) = (select min(a.avg_salary)
                                 from (select round(avg(a.salary)) as avg_salary
                                 from salaries a, titles b
								 where a.emp_no = b.emp_no
								   and a.to_date = '9999-01-01'
                                   and b.to_date = '9999-01-01'
								 group by b.title) a);


-- 실습문제3)
-- 현재 급여가 50000 이상인 직원 이름 출력.
select concat(b.first_name, ' ', b.last_name) as '이름'
from salaries a, employees b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and a.salary >= 50000;


select first_name
from employees
where emp_no in (select emp_no
                 from salaries
				 where to_date = '9999-01-01'
                   and salary > 50000);


-- 각 부서별로 최고 월급과 사원 이름 출력
select a.first_name, c.dept_no, b.salary
from employees a, salaries b, dept_emp c
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and (c.dept_no, b.salary) = any (select c.dept_no, max(b.salary) as max_salary
                                   from employees a, salaries b, dept_emp c
                                   where a.emp_no = b.emp_no
								     and a.emp_no = c.emp_no
                                     and b.to_date = '9999-01-01'
								     and c.to_date = '9999-01-01'
						           group by c.dept_no)
order by b.salary desc;







