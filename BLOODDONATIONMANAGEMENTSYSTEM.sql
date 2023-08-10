CREATE DATABASE blood_donation_management;
USE blood_donation_management;

CREATE TABLE donor (donor_id VARCHAR(7) PRIMARY KEY NOT NULL ,
                   don_name varchar(200),
				   bloodtype varchar(10),
				   don_address varchar(50),
				   don_email varchar(50),
				   don_phoneno char(12) UNIQUE);
                   
CREATE TABLE branch (branch_no VARCHAR(7) PRIMARY KEY NOT NULL,
					street VARCHAR(20)	,
                    city CHAR(20),
                    postcode INT);
                    
CREATE TABLE blooddonevent (event_id VARCHAR(7) PRIMARY KEY  NOT NULL  ,
                            branch_no VARCHAR(7) ,
                            event_date DATE,
                            FOREIGN KEY (branch_no) REFERENCES branch(branch_no));
            



CREATE TABLE PATIENT( patient_id VARCHAR(7) PRIMARY KEY NOT NULL,
					 patient_name VARCHAR(7),
					 bloodtype VARCHAR(7),
                     patient_address VARCHAR(50),
                     patient_email VARCHAR(30),
                     patient_phoneno CHAR(12));


CREATE TABLE blood (donor_blood_id VARCHAR(7) PRIMARY KEY NOT NULL,
                    donor_id VARCHAR(7),
                    event_id VARCHAR(7),
                    blood_quantity INT,
					FOREIGN KEY (donor_id) REFERENCES donor(donor_id),
					FOREIGN KEY (event_id) REFERENCES blooddonevent(event_id));

                    
CREATE TABLE bloodpatient ( patient_id VARCHAR(7) PRIMARY KEY NOT NULL,
							blood_id VARCHAR(7),
                            blood_date DATE,
                            quantity INT ,
							FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
					        FOREIGN KEY (blood_id) REFERENCES blood(donor_blood_id));

		
INSERT INTO donor (donor_id, don_name, bloodtype, don_address, don_email, don_phoneno)
VALUES
    ('D003', 'rohit', 'A+', 'abmika chowk, Nagpur', 'rohit22@gmail.com', 9985646468),
    ('D006', 'saurabh', 'AB-', 'jalgaon, baramati', 'aasu34@gmail.com', 8456746998),
    ('D001', 'Aditya', 'A+', 'Dhumalwadi, baramati', 'aditya77@gmail.com', 7894561234),
    ('D005', 'onmkar', 'A-', 'bk road, sambhajinagar', 'laudex34@gmail.com', 9511875686),
    ('D002', 'abhishek', 'o-', 'karjat, jamkhed', 'abhi4@gmail.com', 9531877996),
    ('D004', 'laaltape', 'B-', 'laalpatehouse, nagar', 'taape@gmail.com', 8651685745);

							
INSERT INTO patient (patient_id,patient_name,bloodtype,patient_address,patient_email,patient_phoneno)
VALUES
   ('P006','aniket','o-','burud galli,indapur','ani11@gmail.com','9898798654'),
   ('P005','vilas','o+','ashok nagar,baramati','vilas1@gmail.com','9897654354'),
   ('P003','anil','A+','amrai,baramati','ani11@gmail.com','9898812354'),
   ('P001','sushil','AB+','tambenagar,baramati','sush1@gmail.com','98874139854'),
   ('P004','abhi','B-','tandulwadi','abhi1@gmail.com','98565898654'),
   ('P002','chetan','B+','abkikanagar,bartamati','chetan13@gmail.com','9898798654');


INSERT INTO blood (donor_blood_id,donor_id,event_id,blood_quantity)
VALUES
 ('BL01','D005','E002',1),
 ('BL02','D003','E001',2),
 ('BL03','D004','E006',1),
 ('BL04','D002','E005',1),
 ('BL05','D006','E003',2),
 ('BL06','D001','E004',1);

INSERT INTO blooddonevent (event_id,event_date,branch_no)
VALUES
 ('E003','2019-01-02','B004'),
 ('E004','2019-03-01','B003'),
 ('E005','2019-05-04','B001'),
 ('E001','2019-08-14','B002'), 
 ('E006','2019-04-11','B006'),
 ('E002','2019-05-12','B005');

INSERT INTO branch (branch_no,street,city,postcode)
VALUES
 ('B002','karveroad','pune',413106),
 ('B004','JM road','punecity',413046),
 ('B001','bhigwan road','baramati',413116),
 ('B003','matoshree road','mumbai',413116),
 ('B005','MG road','nagpur',413156),
('B006','DR road','indapur',413167);


INSERT INTO bloodpatient (patient_id,blood_id,blood_date,quantity)
VALUES
 ('P003','BL02','2019-01-21',1),
('P002','BL01','2019-08-21',1),
('P001','BL04','2019-05-21',1),
('P006','BL06','2019-07-1',2),
('P004','BL05','2019-01-21',1),
 ('P005','BL03','2019-09-11',1);




SElECT * FROM bloodDonevent;
SELECT * FROM bloodpatient;
SELECT * FROM branch;
SELECT * FROM donor;
SELECT * FROM patient;
SELECT* FROM blood;

-- =========================================================================QUERIES ==========================================

--  dispaly76 the name and phoneno of donor whose name starts with D
SELECT don_name ,don_phoneno FROM donor WHERE don_name LIKE 'A%';

SELECT * from PATIENT  WHERE bloodtype='O-';

SELECT * FROM donor where don_email='aasu34@gmail.com';




-- display street ,city,postcode which located in branch B004

SELECT street,city,postcode FROM branch where branch_no='B004';

-- DISPLAY blood_ID OF PATIENT THAT RECEIVED MORE THEN 1 QUANTITY OF BLOOD

SELECT COUNT(BLOOD_ID) FROM bloodpatient where quantity>1;

-- Display blood donattion event which is registered on 7 june 2019

SELECT  event_id  FROM blooddonevent where event_date ='2019-08-14';

-- no of patient in each blood type

SELECT bloodtype ,COUNT(patient_id) FROM patient GROUP BY bloodtype;

-- display donorname,address,phpneno that have o- blood type in order

SELECT bloodtype ,don_name,don_address FROM donor 
WHERE bloodtype='o-'
ORDER BY don_name;

-- display list of branchno,eventid and dates  from earliest to recent date

SELECT event_id,branch_no,event_date FROM blooddonevent ORDER BY event_date;

-- display donor id,blood type and quantity od blood donated

SELECT b.donor_id,b.blood_quantity,d.bloodtype FROM blood b,donor d WHERE b.donor_id=d.donor_id;

-- nested subqueries

-- display all patient info who receiuved blood on 2019-09-11

SELECT * FROM PATIENT 
WHERE patient_id= (
                    SELECT patient_id from bloodpatient where blood_date='2019-09-11');
                    


-- ispaly donid,donname,bloodtype phoineno,who donate blood at event id E004

SELECT donor_id,don_name,bloodtype,don_phoneno
  FROM Donor
  WHERE Donor_id IN 
				(SELECT donor_id FROM blood 
                 WHERE Event_id='E004');

-- display all info of eb=vent that is managed by branch boo5

SELECT * FROM Blooddonevent
 WHERE branch_no IN (
                      SELECT branch_no FROM branch 
                      WHERE branch_no ='B005');
                     


-- DISPLAY PATIENTID,NAME,PHONRE NO THAR RECEIVES MORE THAN 1 QUANTITY BLOOD

SELECT patient_id,patient_name,patient_phoneno FROM patient
                          WHERE patient_id IN (SELECT PATIENT_ID FROM BLOODPATIENT where quantity>1);

