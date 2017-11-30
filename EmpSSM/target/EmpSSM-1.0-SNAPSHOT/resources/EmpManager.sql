/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2017/11/13 22:39:53                          */
/*==============================================================*/


drop table if exists tbl_department;

drop table if exists tbl_empolyee;

/*==============================================================*/
/* Table: tbl_department                                        */
/*==============================================================*/
create table tbl_department
(
   id                   int not null,
   dep_name             varchar(20),
   dep_describetion     varchar(255),
   primary key (id)
);

/*==============================================================*/
/* Table: tbl_empolyee                                          */
/*==============================================================*/
create table tbl_empolyee
(
   id                   int not null,
   emp_name             varchar(50),
   emp_sex              varchar(5),
   emp_age              int,
   emp_tel              varchar(11),
   primary key (id)
);

alter table tbl_department add constraint FK_Reference_1 foreign key (id)
      references tbl_empolyee (id) on delete restrict on update restrict;

