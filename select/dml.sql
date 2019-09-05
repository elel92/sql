drop table users;
show tables;

create table user(
      no int unsigned not null auto_increment,
      email varchar(100) not null default 'NO EMAIL',
      passwd varchar(64) not null,
      name varchar(25),
      dept_name varchar(25),
      primary key(no)
);

select * from user;

-- insert
insert into user values(null, 'rkdalsghek@naver.com', password('1234'), '강민호', '개발팀');
insert into user(email, passwd) values('rkdalsghek@naver.com', password('1234'));
insert into user(passwd) values(password('1234'));


-- alter table
alter table user add juminbunho char(13) not null after no;
alter table user drop juminbunho;
alter table user add join_date datetime default now();
alter table user change email email varchar(200) not null default 'no email';
alter table user change dept_name department_name varchar(25);
alter table user rename users;


-- update(DML)
update user
set email = 'elsin92@gamil.com'
where no = 3;


-- delete(DML)
delete from user
where no = 4;

