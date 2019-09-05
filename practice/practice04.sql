-- practice04

-- 1) 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(a.emp_no)
from employees a, salaries b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and b.salary > (select avg(b.salary)
				  from employees a, salaries b
                  where a.emp_no = b.emp_no
                    and b.to_date = '9999-01-01');

-- 2) 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select c.emp_no as '사번', concat(c.first_name, ' ', c.last_name) as '이름', d.dept_name as '부서', b.salary as '연봉'
from dept_emp a, salaries b, employees c, departments d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and a.dept_no = d.dept_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
  and (a.dept_no, b.salary) = any (select c.dept_no, max(b.salary)
                                   from employees a, salaries b, dept_emp c
                                   where a.emp_no = b.emp_no
                                     and a.emp_no = c.emp_no
                                     and b.to_date = '9999-01-01'
                                     and c.to_date = '9999-01-01'
								   group by c.dept_no)
order by b.salary desc;

-- 3) 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요
select a.emp_no as '사번', d.dept_name as '부서', concat(a.first_name, ' ', a.last_name) as '이름', b.salary as '연봉'
from employees a, salaries b, dept_emp c, departments d, (select avg(b.salary) avgs, c.dept_no
                                                          from employees a, salaries b, dept_emp c
                                                          where a.emp_no = b.emp_no
                                                            and a.emp_no = c.emp_no
                                                            and b.to_date = '9999-01-01'
                                                            and c.to_date = '9999-01-01'
					                                      group by c.dept_no) sub
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and c.dept_no = d.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and c.dept_no = sub.dept_no
  and b.salary > sub.avgs;

-- 4) 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', concat(sub.first_name, ' ', sub.last_name) as '메니저', c.dept_name as '부서'
from employees a, dept_emp b, departments c, (select first_name, last_name, c.dept_no
											 from dept_manager a, employees b, dept_emp c
											 where a.emp_no = b.emp_no
                                               and b.emp_no = c.emp_no
                                               and a.to_date = '9999-01-01') sub
where a.emp_no = b.emp_no
  and b.dept_no = sub.dept_no
  and b.dept_no = c.dept_no
  and b.to_date = '9999-01-01';

-- 5) 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', b.title as '직책', c.salary as '연봉'
from employees a, titles b, salaries c, dept_emp d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and a.emp_no = d.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and d.to_date = '9999-01-01'
  and d.dept_no = (select b.dept_no
				   from salaries a, dept_emp b
                   where a.emp_no = b.emp_no
                     and a.to_date = '9999-01-01'
                     and b.to_date = '9999-01-01'
                   group by b.dept_no
                   order by avg(a.salary) desc
                   limit 0, 1)
order by c.salary desc;


-- 6) 평균 연봉이 가장 높은 부서는? 
select c.dept_name as '부서'
from dept_emp a, salaries b, departments c
where a.dept_no = c.dept_no
  and a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
  and a.dept_no = (select a.dept_no
                   from dept_emp a, salaries b
				   where a.emp_no = b.emp_no
                     and a.to_date = '9999-01-01'
                     and b.to_date = '9999-01-01'
				   group by a.emp_no
                   order by avg(b.salary) desc
                   limit 0, 1)
group by a.dept_no;

-- 7) 평균 연봉이 가장 높은 직책?
select a.title as '직책'
from titles a, salaries b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
  and a.emp_no = (select a.emp_no
                   from titles a, salaries b
				   where a.emp_no = b.emp_no
                     and a.to_date = '9999-01-01'
                     and b.to_date = '9999-01-01'
				   group by a.emp_no
                   order by avg(b.salary) desc
                   limit 0, 1)
group by a.emp_no;

-- 8) 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은? 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select d.dept_name as '부서', concat(a.first_name, ' ', a.last_name) as '이름', c.salary as '연봉', sub.m_n as '매니저', sub.m_s as '매니저 연봉'
from employees a, dept_emp b, salaries c, departments d, (select concat(a.first_name, ' ', a.last_name) m_n, b.dept_no m_d, c.salary m_s
                                                          from employees a, dept_manager b, salaries c
                                                          where a.emp_no = b.emp_no
															and a.emp_no = c.emp_no
											                and b.to_date = '9999-01-01'
                                                            and c.to_date = '9999-01-01') sub
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.dept_no = d.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and b.dept_no = sub.m_d
  and c.salary > sub.m_s;


