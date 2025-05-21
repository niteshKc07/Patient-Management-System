DROP DATABASE IF EXISTS patient;
CREATE DATABASE patient_details;
USE patient_details;
CREATE TABLE patient (
  pid CHAR(4) PRIMARY KEY,
  pname VARCHAR(20),
  pdob DATE,
  pcity VARCHAR(20),
  ptype VARCHAR(20),
  pemail VARCHAR(30),
  pphone VARCHAR(20)
);

CREATE TABLE treatment (
  treatmentid CHAR(4) PRIMARY KEY,
  treatmentname VARCHAR(40),
  treatmentcategory VARCHAR(20),
  treatmentfees DECIMAL(10,2),
  treatmentduration INT
);

CREATE TABLE appointment (
  appointmentid CHAR(4) PRIMARY KEY,
  appointmentdate DATETIME,
  appointmentstrength INT,
  treatmentid CHAR(4),
  FOREIGN KEY (treatmentid) REFERENCES treatment(treatmentid)
);

CREATE TABLE patient_visit (
  appointmentid CHAR(4),
  pid CHAR(4),
  edate DATE,
  PRIMARY KEY (appointmentid, pid),
  FOREIGN KEY (pid) REFERENCES patient(pid),
  FOREIGN KEY (appointmentid) REFERENCES appointment(appointmentid)
);

INSERT INTO patient VALUES
('s001','rajesh','1980-12-17','kolkata','graduate','rajesh@gmail.com','09830978900'),
('s002','john','1949-01-07','hyderabad','postgraduate','john@yahoo.com','9833978933'),
('s003','kunal','1967-02-03','pune','postgraduate','kunal@gmail.com','09830922900'),
('s004','maya','1990-12-17','kolkata','graduate','maya.com','09830765900'),
('s005','jack','1940-01-23','kolkata','postgraduate','jack@yahoo.com','09837865432'),
('s006','suman','1995-06-17','kolkata','undergraduate','suman@gmail.com','0983097890'),
('s007','soha','1990-07-17','mumbai','undergraduate',NULL,NULL),
('s008','thapa','1980-08-17','assam','graduate','thapa@gmail.com','19830978900'),
('s009','hira','1954-09-17','mumbai','postgraduate','hira@gmail.com','09234097890'),
('s010','akash','1977-01-27','kolkata','postgraduate','akash@gmail.com',NULL),
('s011','amir','1992-01-01','delhi','undergraduate','amirgmail.com','09831118900'),
('s012','ramesh','1980-12-17','kolkata','graduate','ramesh@yahoo.com','09830918900'),
('s013','suresh','1980-03-22','kolkata','graduate','suresh@gmail.com','09830978912'),
('s014','amir','1945-01-13','delhi','postgraduate','amir123@rediffmail.com','29830978900'),
('s015','esha','1981-10-30','mumbai','graduate','esha@gmail.com','09831378900'),
('s016','gopal','1966-05-07','assam','postgraduate','gopal@gmail.com','09831918100'),
('s017','sonali','1995-11-11','mumbai','undergraduate','sonali@gmail.com','09855978900'),
('s018','lokesh','1983-01-31','delhi','graduate','lokesh@gmail.com','09832978923'),
('s019','smith','1980-12-17','pune','graduate','smith@yahoo.com','09831111900'),
('s020','rajesh','1994-07-08','pune','graduate','rajesh@gmail.com','09830978900');


insert into treatment values('c001','sql server','teeth',1000,40);
insert into treatment values('c002','compmat','ear',3000,120);
insert into treatment values('c003','biomaths','eye',4000,160);
insert into treatment values('c004','word','bones',500,8);
insert into treatment values('c005','photo','bones',800,8);

insert into patient_visit values('b001','2013-02-01 09:30' ,10, 'c001');
insert into patient_visit values('b002','2013-03-01 09:30' ,10, 'c002');
insert into patient_visit values('b003','2013-01-01 09:30' ,10, 'c003');
insert into patient_visit values('b004','2013-03-31 09:30' ,10, 'c003');
insert into patient_visit values('b005','2013-04-04 09:30' ,10, 'c005');
insert into patient_visit values('b006','2013-01-27 09:30' ,10, 'c002');
insert into patient_visit values('b007','2012-11-30 09:30' ,10, 'c004');
insert into patient_visit values('b008','2013-01-28 09:30' ,10, 'c002');
insert into patient_visit values('b009','2013-02-16 09:30' ,10,'c001');
insert into patient_visit values('b010','2012-12-12 09:30' ,10, 'c003');

insert into patient_visit values('b001','s001','2013-01-01');
insert into patient_visit values('b001','s002','2013-01-31');
insert into patient_visit values('b001','s003','2013-01-11');
insert into patient_visit values('b001','s004','2013-02-02');
insert into patient_visit values('b001','s005','2013-01-01');
insert into patient_visit values('b001','s006','2013-01-01');
insert into patient_visit values('b001','s007','2013-01-01');
insert into patient_visit values('b001','s008','2013-01-01');
insert into patient_visit values('b001','s009','2013-01-30');
insert into patient_visit values('b002','s010','2013-02-01');
insert into patient_visit values('b002','s012','2013-02-27');
insert into patient_visit values('b002','s014','2013-01-21');
insert into patient_visit values('b002','s016','2013-01-12');
insert into patient_visit values('b002','s017','2013-02-15');

insert into patient_visit values('b003','s018','2013-12-11');
insert into patient_visit values('b003','s019','2013-02-27');
insert into patient_visit values('b003','s020','2013-01-21');
insert into patient_visit values('b003','s013','2013-01-01');
insert into patient_visit values('b003','s007','2013-12-15');
insert into patient_visit values('b003','s008','2013-11-25');

insert into patient_visit values('b004','s001','2013-02-11');
insert into patient_visit values('b004','s003','2013-02-27');
insert into patient_visit values('b004','s006','2013-01-21');
insert into patient_visit values('b004','s009','2013-03-01');

insert into patient_visit values('b005','s001','2013-02-11');
insert into patient_visit values('b005','s003','2013-02-27');
insert into patient_visit values('b005','s006','2013-03-21');
insert into patient_visit values('b005','s009','2013-04-01');

insert into patient_visit values('b006','s001','2013-01-11');
insert into patient_visit values('b006','s003','2012-12-27');
insert into patient_visit values('b006','s006','2013-01-11');
insert into patient_visit values('b006','s009','2013-01-01');
insert into patient_visit values('b006','s007','2013-01-13');
insert into patient_visit values('b006','s002','2012-12-17');
insert into patient_visit values('b006','s008','2013-01-21');
insert into patient_visit values('b006','s005','2013-01-01');


insert into patient_visit values('b007','s001','2012-11-11');
insert into patient_visit values('b007','s002','2012-11-11');
insert into patient_visit values('b007','s003','2012-11-21');
insert into patient_visit values('b007','s004','2012-11-13');
insert into patient_visit values('b007','s007','2012-10-13');
insert into patient_visit values('b007','s010','2012-10-17');
insert into patient_visit values('b007','s009','2012-12-01');

insert into patient_visit values('b008','s011','2012-11-11');
insert into patient_visit values('b008','s012','2012-11-11');
insert into patient_visit values('b008','s013','2012-11-21');
insert into patient_visit values('b008','s014','2012-11-13');
insert into patient_visit values('b008','s017','2012-10-13');
insert into patient_visit values('b008','s020','2012-10-17');
insert into patient_visit values('b008','s019','2012-12-01');

insert into patient_visit values('b009','s001','2012-11-11');
insert into patient_visit values('b009','s012','2012-11-11');
insert into patient_visit values('b009','s013','2012-11-21');
insert into patient_visit values('b009','s004','2012-11-13');
insert into patient_visit values('b009','s007','2012-10-13');
insert into patient_visit values('b009','s010','2012-10-17');
insert into patient_visit values('b009','s009','2012-12-01');

insert into patient_visit values('b010','s011','2012-11-11');
insert into patient_visit values('b010','s002','2012-11-11');
insert into patient_visit values('b010','s003','2012-11-21');
insert into patient_visit values('b010','s014','2012-11-13');
insert into patient_visit values('b010','s017','2012-10-13');
insert into patient_visit values('b010','s010','2012-10-17');
insert into patient_visit values('b010','s009','2012-12-01');