CREATE DATABASE Animal_shelter;


-- At the top of each table is the name of the person responsible for that table --
-- and the name of the table--

-- Patrick219835 --
-- Diet table --
CREATE TABLE Diet
(
    Diet_ID         INT,
    Diet_type       VARCHAR(20), -- Herbivorous or Carnevorous
    Date_started    DATE default GETDATE(), -- If no date entered: default for current date
    Comment        VARCHAR(100), -- Description of the diet

    CONSTRAINT Diet_pk PRIMARY KEY (Diet_ID)
);

-- Sameh218767 --
-- Unit Table --
CREATE TABLE Unit
(
Unit_ID					INT	NOT NULL,
Habitat_type		VARCHAR(40) ,

CONSTRAINT Unit_pk
PRIMARY KEY (Unit_ID)
);

-- Sameh218767 --
-- Cage Table --
CREATE TABLE Cage
(
Cage_num			INT		NOT NULL,
Size					VARCHAR(20),
Cage_status		BIT, --When value is 1 it means it's occupied, if 0 then the cage is empty
Unit_ID				INT,

CONSTRAINT Cage_pk
PRIMARY KEY(Cage_num),

CONSTRAINT Cage_unit_fk
FOREIGN KEY (Unit_ID) REFERENCES Unit (Unit_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

-- Patrick218835 --
-- Animal Table --
CREATE TABLE Animal
(
    Animal_ID       INT,
    Name            VARCHAR(15),
    Breed           VARCHAR(40),
    Color           VARCHAR(15),
    Gender          CHAR,
  	Age							INT,
    Common_term     VARCHAR(30), -- Dog, cat, frog, parrot etc.
    Scientific_term VARCHAR(50), -- Species and genus
    Diet_ID         INT,
    Cage_ID         INT,

     CONSTRAINT Animal_pk PRIMARY KEY (Animal_ID),
     CONSTRAINT Animal_Diet_fk FOREIGN KEY (Diet_ID) REFERENCES Diet (Diet_ID) -- Foreign key Diet table
     ON UPDATE CASCADE
     ON DELETE SET NULL,
     CONSTRAINT Animal_Cage_fk FOREIGN KEY (Cage_ID) REFERENCES Cage (Cage_num) -- Foreign key Cage table
     ON UPDATE CASCADE
     ON DELETE SET NULL
);

-- Patrick219835 --
-- Sheltered --
CREATE TABLE Sheltered
(
    Animal_ID       INT,
    Admission_date  DATE default GETDATE(), -- If new animal: date becomes today's date by default
    Entry_reason    VARCHAR(10), -- Born in shelter, found in the wild or was returned after being adopted

    CONSTRAINT Sheltered_pk PRIMARY KEY (Animal_ID),
    CONSTRAINT Sheltered_fk FOREIGN KEY (Animal_ID) REFERENCES Animal (Animal_ID) -- Foreign key Animal table
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Amir224049 -- 
-- Worker Table -- 
CREATE TABLE Worker
(
Worker_ID	int		NOT NULL,
Worker_name varchar(20),
Gender char,
Age int,
Salary int, 
Years_of_experience float

CONSTRAINT worker_pk PRIMARY KEY (Worker_ID)
);

-- Amir22409-- 
-- Volunteer Table -- 
CREATE TABLE Volunteer
(
Volunteer_ID int NOT NULL,                          
Credit float,

CONSTRAINT volunteer_pk PRIMARY KEY (Volunteer_ID), 

CONSTRAINT volunteer_fk FOREIGN KEY (Volunteer_ID) REFERENCES Worker (Worker_ID) 

ON UPDATE CASCADE
ON DELETE CASCADE
);

-- Amir224049 -- 
-- Volunteer_Task Table --
CREATE TABLE Volunteer_task
(
Volunteer_Task_ID int NOT NULL,
Task varchar(20),


CONSTRAINT volunteer_task_pks PRIMARY KEY (Volunteer_Task_ID, Task),

CONSTRAINT volunteer_task_fk FOREIGN KEY (Volunteer_Task_ID) REFERENCES Volunteer (Volunteer_ID)

ON UPDATE CASCADE
ON DELETE CASCADE
);

-- Amir224049 -- 
-- Staff Table -- 
CREATE TABLE Staff
(
Staff_ID int NOT NULL,
Position varchar(20),

CONSTRAINT staff_pk PRIMARY KEY (Staff_ID),

CONSTRAINT staff_fk FOREIGN KEY (Staff_ID) REFERENCES Worker (Worker_ID)

ON UPDATE CASCADE
ON DELETE CASCADE
);

-- Amir224049 -- 
-- Trainer Table -- 
CREATE TABLE Trainer
(
Trainer_ID int NOT NULL,
Degree varchar(20),
Specialization varchar(20),

CONSTRAINT trainer_pk PRIMARY KEY (Trainer_ID),

CONSTRAINT trainer_fk FOREIGN KEY (Trainer_ID) REFERENCES Worker (Worker_ID)

ON UPDATE CASCADE
ON DELETE CASCADE
);

-- Konouz227447 --
-- Care Plan Table --
CREATE TABLE Care_plan
(
Case_ID INT NOT NULL,
Start_date DATE,
End_date DATE,
Care_location VARCHAR(35),
RFlag BIT,
Type_of_damage VARCHAR(35),
Status VARCHAR(35),
Severity_of_case VARCHAR(35),
TFlag BIT,
Equipment VARCHAR(35),
Training_name VARCHAR(35),
A_ID INT,

CONSTRAINT Careplan_pk PRIMARY KEY (Case_ID),
CONSTRAINT Animal_hasa_careplan FOREIGN KEY (A_ID) references Animal(Animal_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

-- Konouz227447 --
-- Trainer Does Training Junction Table --
create table Trainer_does_training ( -- many to many relationship --
C_ID INT, -- foreign key for case_id in care plan table --
W_ID INT, -- foreign key for worker_id in trainer table --
CONSTRAINT Does_pk PRIMARY KEY (C_ID, W_ID),
CONSTRAINT Does_careplan_fk FOREIGN KEY (C_ID) references Care_plan(Case_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT Does_trainer_fk FOREIGN KEY (W_ID) references Trainer(Trainer_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

-- Zeinab222188 --
-- Adopter Table --
CREATE TABLE Adopter
(
Adopter_id INT NOT NULL,
Adopter_name VARCHAR(30) NOT NULL,
Street VARCHAR (50),
City VARCHAR (15),
Zip_code VARCHAR(5),

CONSTRAINT adopter_pk PRIMARY KEY (Adopter_id)
);

-- Zeinab222188 --
-- Adopter Phone Table --
CREATE TABLE Adopter_Phone 
(
Padopter_id INT NOT NULL,
Phone_number VARCHAR(11) NOT NULL,

CONSTRAINT adopter_phone_pk PRIMARY KEY (Padopter_id,Phone_number),

CONSTRAINT adopter_id_in_phone_fk FOREIGN KEY (Padopter_id) REFERENCES Adopter (Adopter_id) 
ON UPDATE CASCADE
ON DELETE CASCADE
);

-- Zeinab222188 --
-- Adopter Email Table --
CREATE TABLE Adopter_Email 
(
Eadopter_id INT NOT NULL,
Email VARCHAR(40) NOT NULL,

CONSTRAINT adopter_email_pk PRIMARY KEY (Eadopter_id,Email),

CONSTRAINT adopter_id_in_email_fk FOREIGN KEY (Eadopter_id) REFERENCES Adopter (Adopter_id)
ON UPDATE CASCADE
ON DELETE CASCADE
);

-- Zeinab222188 --
-- Adoption Table --
CREATE TABLE Adoption 
(
Adop_case INT NOT NULL,
Date_of_adoption DATE NOT NULL,
Request_date DATE,
Interval_of_checkup VARCHAR(10),
Adop_id INT,

CONSTRAINT adoption_pk PRIMARY KEY (Adop_case),

CONSTRAINT adoption_adopter_fk FOREIGN KEY (Adop_id) REFERENCES Adopter (Adopter_id)
ON UPDATE CASCADE
ON DELETE SET NULL
);

-- Zeinab222188 --
-- Adopted Table --
CREATE TABLE Adopted
(
Adopted_animal_id INT NOT NULL, 
Adoption_reason VARCHAR(30),
Name_after_adoption VARCHAR(10) NOT NULL,
Adptr_id INT,

CONSTRAINT adopted_pk PRIMARY KEY (Adopted_animal_id),

CONSTRAINT adopted_animal_fk FOREIGN KEY (Adopted_animal_id) REFERENCES Animal (Animal_id) 
ON UPDATE CASCADE
ON DELETE CASCADE,

CONSTRAINT adopted_adopter_fk FOREIGN KEY (Adptr_id) REFERENCES Adopter (Adopter_id)
ON UPDATE CASCADE
ON DELETE SET NULL
);

-- Sameh218767 --
-- Vaccination Table --
CREATE TABLE Vaccination
(
Vaccine_name		VARCHAR(120)	NOT NULL,
Vaccine_type		VARCHAR(120),
Dosage					INT,
Cost						FLOAT,
Stock						INT,

CONSTRAINT vaccination_pk
PRIMARY KEY(Vaccine_name)
);

-- Sameh218767 --
-- Medical Record Table --
CREATE TABLE Medical_record
(
Record_num					INT		NOT NULL,
Doctor							VARCHAR(40),
Animal_description	VARCHAR(120),
Allergy							VARCHAR(120),
A_ID								INT,

CONSTRAINT Medical_record_pk
PRIMARY KEY(Record_num),

CONSTRAINT Medicalrecord_animal_fk 
FOREIGN KEY (A_ID) REFERENCES Animal(Animal_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);


-- Sameh218767 --
-- Junction Table between Vaccination and Medical_record tables --
CREATE TABLE Vaccination_history
(
Record_num		INT		NOT NULL,
V_name				VARCHAR(120),

CONSTRAINT Vaccination_history_pk
PRIMARY KEY(Record_num, V_name),
  
CONSTRAINT Vaccine_name_fk
FOREIGN KEY (V_name) REFERENCES Vaccination(Vaccine_name)
ON DELETE CASCADE
ON UPDATE CASCADE,
  
CONSTRAINT Record_num_fk
FOREIGN KEY (Record_num) REFERENCES Medical_record(Record_num)
ON DELETE CASCADE
ON UPDATE CASCADE
);


-- Sameh218767 --
-- Animal Medication Table --
CREATE TABLE Animal_medication
(
Record_num		INT		NOT NULL,
Medication		VARCHAR(100),

CONSTRAINT Animal_med_pk
PRIMARY KEY(Record_num, Medication)
);

-- Sameh218767 --
-- Animal Ailment Table --
CREATE TABLE Animal_ailment
(
Record_num			INT		NOT NULL,
Disease					VARCHAR(120),
Contraction_date	DATE,

CONSTRAINT Animal_ail_pk
PRIMARY KEY(Record_num, Disease)
);
-- All Alters --

--- Amir224049 Alter ---
ALTER TABLE Staff
ADD Number_of_children int;

--Konouz 227447 alter table--
ALTER TABLE Care_plan
ADD Effectiveness INT;

-- Patrick219835 Alter --
-- Add attribute to animal table --
ALTER TABLE Animal
ADD Tempermant VARCHAR(20);



-- All Triggers --

--- Amir224049 Trigger ---
GO
CREATE TRIGGER Increase_credit ON Volunteer_task
AFTER INSERT 
AS BEGIN
SET NOCOUNT ON
UPDATE Volunteer
SET Credit = Credit + 10
WHERE EXISTS(SELECT Task
			 FROM Volunteer_task
			 WHERE Task = 'Helping Animals'
			 );

PRINT 'HERE we are testing increased credit by 10'
END

--Konouz Rflag trigger--
GO
CREATE TRIGGER R_flag on CARE_PLAN
after INSERT 
AS BEGIN 
UPDATE CARE_PLAN
SET Severity_of_case= NULL, Type_of_damage= NULL, Status =NULL
WHERE RFlag=0
PRINT 'Rflag insertion trigger successfuly done'
END

--Konouz Tflag trigger--
GO
CREATE TRIGGER T_flag on CARE_PLAN
after INSERT 
AS BEGIN 
UPDATE CARE_PLAN
SET Training_name=NULL, Equipment=NULL
WHERE Tflag=0
PRINT 'Tflag insertion trigger successfuly done'
END

-- Sameh218767 --
/* Trigger that changes the status of cage when a 
new animal occupies it
*/
GO
CREATE TRIGGER Occupying_cage ON Animal
AFTER INSERT
AS 
BEGIN
SET NOCOUNT ON
UPDATE Cage
SET Cage.Cage_status = 1
WHERE EXISTS (SELECT Cage_ID
						FROM Animal
						WHERE Animal.Cage_ID = Cage.Cage_num
					);
PRINT 'Insert trigger executed succesfully'
END


-- Sameh218767 --
/* Trigger that changes the status of cage when an
animal leaves it
*/
GO
CREATE TRIGGER Empty_cage ON Animal
AFTER DELETE
AS 
BEGIN
SET NOCOUNT ON
UPDATE Cage
SET Cage.Cage_status = 0
WHERE NOT EXISTS (SELECT Cage_ID
					FROM Animal
					WHERE Animal.Cage_ID=Cage.Cage_num
					);
PRINT 'Delete trigger executed succesfully'
END

-- Patrick219835 Trigger --
-- Changes cage size based on animal --
GO
CREATE TRIGGER Change_size ON Animal
AFTER INSERT
AS BEGIN
SET NOCOUNT ON
UPDATE Cage
SET [Size] = 'Large'
WHERE EXISTS (
    SELECT *
    FROM Animal
    WHERE Common_term = 'Chimpanzee'
);
PRINT 'Cage size changed successfully'
END

-- Zeinab 222188 Trigger--
/* Trigger upadates interval of checkup when city is updated to Alexandria to
minimise the number of visits to Alexandria due to budget issues*/
GO 
CREATE TRIGGER AlexandriaAnimals
ON Adopter
FOR UPDATE
AS
BEGIN
SET NOCOUNT ON
DECLARE @City VARCHAR (15); 
select @City = i.City from inserted i;
UPDATE Adoption
SET Interval_of_checkup='12 months'
WHERE @City='Alexandria'
AND Adoption.Adop_id IN(SELECT Adopter.Adopter_id
                            FROM Adopter
                            WHERE Adopter.Adopter_id=Adoption.Adop_id
                            AND Adopter.City='Alexandria');
PRINT 'Interval Updated successfully'
END

-- Zeinab 222188 --
-- View to show number of months waited during the adoption process--
GO
CREATE VIEW MonthsWaited 
AS 
SELECT Adopter_id, Adopter_name, DATEDIFF(month,Request_date, Date_of_adoption) AS 'Months Waited by Adopter'
FROM Adopter INNER JOIN Adoption
ON Adopter_id = Adop_id;

GO
-- All Insertions --

-- Patrick219835 --
-- Inserts for Diet Table --
INSERT INTO Diet
VALUES
(50, 'Herbivorous', '2020/10/01', 'Contains grass, nuts, seeds and shrubs. Mainly for small animals.'),
(51, 'Carnivorous', '2019/09/05', 'Contains beef and chicken.'),
(52, 'Herbivorous', '2020/1/25', 'Contains grass, aquatic vegitation and tree bark. Mainly for large animals.'),
(53, 'Herbivorous', '2017/05/09', 'Contains only grass.'),
(54, 'Carnivorous', '2018/03/18', 'Contains small fish like sardines.'),
(55, 'Herbivorous', '2019/04/08', 'Contains many kinds of berries.'),
(56, 'Carnivorous', '2021/06/01', 'Contains larger kinds of fish. Mainly for large land or aquatic animals.'),
(57, 'Herbivorous', '2019/01/01', 'Contains a variety of fruits and vegetables.'),
(58, 'Carnivorous', '2020/07/07', 'Contains small animals like mice and other rodents or rabbits'),
(59, 'Carnivorous', '2019/03/09', 'Contains small animals like insects, lizzards or small amphibians');

-- Sameh218767 --
-- Unit Insertions --
INSERT INTO Unit
VALUES (1,'Mammal');
INSERT INTO Unit
VALUES (2,'Bird');
INSERT INTO Unit
VALUES (3,'Reptile');
INSERT INTO Unit
VALUES (4,'Amphibian');
INSERT INTO Unit
VALUES (5,'Fish');
INSERT INTO Unit
VALUES (6,'Anthropod');

-- Sameh218767 --
-- Cage insertions -- 
INSERT INTO Cage
VALUES 
(1,'Big',1,1),
(2,'Big',1,1),
(3,'Small',0,1),
(4,'Medium',0,1),
(5,'Small',1,1),
(6,'Big',1,2),
(7,'Big',1,2),
(8,'Small',0,2),
(9,'Medium',0,2),
(10,'Small',1,2),
(11,'Big',1,3),
(12,'Big',0,3),
(13,'Small',0,3),
(14,'Medium',1,3),
(15,'Small',1,3),
(16,'Big',1,4),
(17,'Big',1,4),
(18,'Small',1,4),
(19,'Medium',0,4),
(20,'Small',0,4),
(21,'Small',1,5),
(22,'Big',0,5),
(23,'Big',0,5),
(24,'Small',1,5),
(25,'Medium',1,5),
(26,'Small',1,6),
(27,'Big',1,6),
(28,'Big',0,6),
(29,'Small',0,6),
(30,'Medium',1,6);

-- Patrick219835 --
-- Inserts for Animal Table --
INSERT INTO Animal(Animal_ID, Name, Breed, Color, Gender, Age, Common_term, Scientific_term, Diet_ID, Cage_ID)
VALUES
(100,'Max','Golden Retriever', 'Brown', 'M', 10, 'Dog', 'Canis lupus familiaris',  51 , 1),
(101, 'Rex', 'Pitbull', 'Black', 'F', 6, 'Dog', 'Canis lupus familiaris', 51 , 1),
(102, 'Amoura', 'Persian', 'Grey', 'M', 7, 'Cat', 'Felis catus', 54, 4),
(103, 'Koki', 'Syrian', 'Brown', 'F', 5, 'Hamster', 'Cricetinae', 50 , 5),
(104, 'Zainoob', 'Cuban amazon', 'Red', 'F', 10, 'Parrot', 'Amazona leucocephala', 50 , 10),
(105, 'Samh', 'Western chimpanzee', 'Black', 'M', 8, 'Chimpanzee', 'Pan troglodytes verus', 57 , 2),
(106, 'Asoor', 'Barn Owl', 'White', 'F', 2, 'Owl', 'Tyto alba', 58, 6),
(107, 'Shork', 'Cuy', 'White', 'F', 4, 'Guinea Pig', 'Cavia porcellus', 50, 3),
(108, 'Mohb', 'British Shorthair', 'Black', 'M', 6, 'Cat', 'Felis catus', 54, 4),
(109, 'Prisk', 'Australian copperhead', 'Brown', 'F', 8, 'Snake', 'Austrelaps superbus', 58, 14),
(110, 'Abnb', 'Mission golden-eyed tree frog', 'Brown', 'M', 7, 'Frog', 'Trachycephalus resinifictrix', 59, 21),
(111, 'Ptck', 'Brown rat', 'White', 'M', 6, 'Rat', 'Rattus norvegicus', 57, 3),
(112, 'Bobber', 'Domestic rabbit', 'Grey', 'M', 12, 'Rabbit', 'Oryctolagus cuniculus domesticus', 50, 2),
(113, 'Boney', 'Himalayan red pandas', 'Red', 'M', 10, 'Red panda', 'Ailurus fulgens', 57, 2),
(114, 'Teddy', 'Red-eared slider', 'Green', 'F', 5, 'Turtle', 'Trachemys scripta elegans', 50, 15);

-- Patrick219835 --
-- Inserts for Sheltered Table --
INSERT INTO Sheltered(Animal_ID, Admission_date, Entry_reason)
VALUES
(101, '2020/12/15', 'Wild'),
(103, '2021/09/03', 'Born'),
(105, '2018/06/12', 'Wild'),
(107, '2017/05/20', 'Returned'),
(109, '2018/01/23', 'Born'),
(111, '2019/03/29', 'Returned'),
(113, '2020/12/12', 'Born');

--- Amir224049 --- 
--- Insertion in Worker Table -- 
INSERT INTO Worker
VALUES (100, 'Amir', 'M', 21, 3000, 1);

INSERT INTO Worker
VALUES (101, 'Zeinab', 'F', 19, 5000, 2);

INSERT INTO Worker
VALUES (102, 'Konouz', 'F', 24, 5500, 2.5);

INSERT INTO Worker
VALUES (103, 'Patrick', 'M', 26, 4500, 1.5);

INSERT INTO Worker
VALUES (104, 'Assar', 'F', 24, 8000, 5);

INSERT INTO Worker
VALUES (105, 'Sherouk', 'F', 22, 9000, 5.5);

INSERT INTO Worker
VALUES (106, 'Sara', 'F', 20, 1500, 0.5);

INSERT INTO Worker
VALUES (107, 'Mohamed', 'M', 23, 4000, 2.5);

INSERT INTO Worker
VALUES (108, 'Ziad', 'M', 21, 3000, 2);

INSERT INTO Worker
VALUES (109, 'Amira', 'F', 25, 11000, 6);

INSERT INTO Worker
VALUES (110, 'Shadia', 'F', 26, 12000, 6);

INSERT INTO Worker
VALUES (111, 'Marian', 'F', 27, 15000, 7);

-- Amir224049 --
--- Insertion in Volunteer Table -- 
INSERT INTO Volunteer
VALUES (100, null);

INSERT INTO Volunteer
VALUES (101, 6);

INSERT INTO Volunteer
VALUES (102, 4);

INSERT INTO Volunteer
VALUES (103, null);

-- Amir224049 --
--- Insertion in Volunteer_task
INSERT INTO Volunteer_task
VALUES (100, 'Raising Awarness');

INSERT INTO Volunteer_task
VALUES (101, 'Helping Animals');

INSERT INTO Volunteer_task
VALUES (102, 'Managing Campaigns');

INSERT INTO Volunteer_task
VALUES (103, 'Cleaning');

-- Amir224049 --
--- Insertion in Staff Table --
INSERT INTO Staff(Staff_ID, Position)
VALUES (104, 'Secretary');

INSERT INTO Staff(Staff_ID, Position)
VALUES (105, 'Accountant');

INSERT INTO Staff(Staff_ID, Position)
VALUES (106, 'Veteranian');

INSERT INTO Staff(Staff_ID, Position)
VALUES (107, 'Manager');

-- Amir224049 --
--- Insertion in Trainer Table --
INSERT INTO Trainer
VALUES (108, 'Bachelor Degree', 'Animal Behaviour');

INSERT INTO Trainer
VALUES (109, 'Diploma', 'Pet Grooming');

INSERT INTO Trainer
VALUES (110, null, null);

INSERT INTO Trainer
VALUES (111, 'High School', null);

-- Konouz227447 --
-- Inserts for Careplan Table --
INSERT INTO Care_plan(Case_ID, Start_date, End_date, Care_location, RFlag, Type_of_damage, Status, Severity_of_case, TFlag, Equipment, Training_name,A_ID)
VALUES 
(100,'2017/09/25','2018/04/21','doki',1,'birth','healed','critical',1,'treadmill','litter training',100),
(101,'2019/12/25','2020/04/5','maadi',0,'broken bone','healed','critical',1,'buzzer','comand training',101), --intentional mistake: test input to test query trigger--
(102,'2021/09/25',NULL,'madinty',1,'burns','care in progress','critical',0,NULL,NULL,102),--null end date test --
(103,'2018/11/25','2023/04/01','helliopolis',1,'infection','care in progress','critical',0,'treadmill','litter training',103),--intentional mistake: test input to test query trigger--
(104,'2017/12/03','2023/08/02','madinat nasr',1,'birth','care in progress','mild',1,'balls','command training',104),
(105,'2022/09/25','2022/12/01','maadi',1,'hernia','care in progress','mild',0,NULL, NULL,105),--test for nested query(status supposed to be healed)--
(106,'2015/12/13','2019/09/21','assuit',0,NULL,NULL,NULL,1,'collar','weight-loss training',106),
(107,'2017/10/21','2023/04/21','alexandria',1,'After birth bleeding','care in progress','critical',1,'balls','taming training',107),
(108,'2016/04/12','2020/09/05','doki',1,'birth','healed','critical',1,'hoop','tricks training',108),
(109,'2019/07/04','2020/11/07','tagamoaa',0,NULL,NULL,NULL,0,NULL,NULL,109),
(110,'2020/08/11','2020/09/05','doki',1,'parasite infection','healed','critical',1,'hoop','tricks training',110),
(111,'2015/04/25','2023/09/25','saraya',1,'auto-immune','care in progress','critical',1,'litter box','litter training',111),
(112,'2022/09/25','2023/12/23','madinty',1,'ticks','care in progress','mild',0,NULL,NULL,112),
(113,'2020/04/25','2023/09/25','zamalek',1,'rabies','care in progress','critical',1,'litter box','litter training',113),
(114,'2019/04/25','2020/09/25','madinty',1,'emaciation','healed','mild',1,'hoop','tricks training',114);


-- Konouz227447 --
-- Trainer Does Training Inserstions --
INSERT INTO Trainer_does_training(C_ID, W_ID )
VALUES
(100,108),
(101,108),
(101,109),
(102,109),
(103,109),
(111,110),
(111,111),
(114,108),
(106,111),
(107,110),
(104,108),
(105,109),
(101,110),
(108,108),
(109,109),
(110,108);

--Zeinab222188--
--Adopter Table Insertions--
INSERT INTO Adopter(Adopter_id,Adopter_name,Street,City,Zip_code)
VALUES 
(001,	'Amir Amgad',	'Makram Ebeid  St.',	'Cairo', 	'11762'),
(002,	'Sara Salem',	'Saad Zaghloul St.', 'Alexandria',	'21542'),
(003,	'Ahmed Abdalla',	'39 Ismail El Falaky St.',	'Cairo',	'11577'),
(004,	'Mary Mounir',	'Chamber of Commerce St.',	'Alexandria',	'21519'),
(005,	'Carmen Callan ',	'Saad Zaghloul St.',	'Alexandria',	'21542'),
(006,	'Ahmed Ashraf',	'Elkordy St.',	'Cairo',	'11575'),
(007,	'Mohamed Mostafa',	'El Kasr El Aini St.',	'Cairo',	'11562');

UPDATE Adopter
SET City='Alexandria'
WHERE Adopter_id=4;
--Zeinab222188--
--Adopter Phone Table Insertions--
INSERT INTO Adopter_Phone(Padopter_id,Phone_number)
VALUES
(001,	'01023987465'),
(002,	'01275642973'),
(003,	'01547394733'),
(004,	'01178975268'),
(005,	'01588446790'),
(006,	'01289337982'),
(007,	'01078658076');

--Zeinab222188--
--Adopter Email Table Insertions--
INSERT INTO Adopter_Email(Eadopter_id,Email)
VALUES 
(001,	'Amir001@gmail.com'), 
(002,	'Sara002@yahoo.com'), 
(003,	'Ahmed003@yahoo.com'),
(004,	'Mary004@gmail.com'),
(005,	'Carmen005@gmail.com'),
(006,	'Ahmed006@yahoo.com'),
(007,	'Mohamed007@yahoo.com');

--Zeinab222188--
--Adoption Table Insertions--
INSERT INTO Adoption(Adop_case,Date_of_adoption,Request_date,Interval_of_checkup,Adop_id)
VALUES 
(101,	'2011/11/11',	'2011/3/6',	'6 months',	001),
(201,	'2009/3/7',	'2008/12/12',	'12 months',	002),
(301,	'2017/6/7',	'2017/2/3',	'9 months',	003),
(401,	'2020/4/5',	'2020/2/1',	'4 months',	004),
(501,	'2010/7/8',	'2009/8/8',	'12 months',	005),
(601,	'2018/3/3',	'2017/12/4',	'4 months',	006),
(701,	'2019/6/9',	'2019/3/5',	'12 months',	007),
(801,   '2022/3/8', '2022/1/4', '5 months', 006);

--Zeinab222188--
--Adoped Table Insertions--
INSERT INTO Adopted(Adopted_animal_id,Adoption_reason,Name_after_adoption,Adptr_id)
VALUES 
(100,	'Security',	'Oscar',	005),
(102,	'Pet',	'Mitsy',	006),
(104,	'Pet',	'Oliver',	003),
(106,	'Security',	'Chase',001),
(108,	'Pet',	'Loki',	007),
(110,	'Pet',	'Oreo',	002),
(112,	'Pet',	'Coco', 	006),
(114,	'Security',	'Rex',	004);

-- Sameh218767 --
-- Vaccination insertions -- 
INSERT INTO Vaccination
VALUES ('RotaTeq','Live-attenuated',2,93.19,3);
INSERT INTO Vaccination
VALUES ('Gardasil','Live-attenuated',3,268.02,73);
INSERT INTO Vaccination
VALUES ('HDCV ','Inactive',4,481.41,80);
INSERT INTO Vaccination
VALUES ('Havrix ','Inactive',1,35.87,53);
INSERT INTO Vaccination
VALUES ('Fluzone','Inactive',1,60.73,33);
INSERT INTO Vaccination
VALUES ('Pneumovax','Subunit',2,117.08,37);
INSERT INTO Vaccination
VALUES ('Zostavax','Subunit',2,242,72);
INSERT INTO Vaccination
VALUES ('CCoV ','mRNA',2,35,83);
INSERT INTO Vaccination
VALUES ('Tenivac','Toxoid',1,36.14,75);

-- Sameh218767 --
-- Medical Record insertions --
INSERT INTO Medical_record (Record_num,Doctor, Animal_description,Allergy,A_ID)
VALUES
(0001,'Yacoub Dibiazah','Has history with Hepatitis A','Pollen',100),
(0002,'Mohammad Sumbul','Has history with Flu',NULL,101),
(0003,'Khaled Kashmiri','Has history with Rabies','Spores',102),
(0004,'Khaled Kashmiri','Healthy and Lively','Pollen',103),
(0005,'Khaled Kashmiri','Healthy and Lively',NULL,104),
(0006,'Khaled Kashmiri','Healthy and Lively',NULL,105),
(0007,'Osman Sisha','Healthy and Lively',NULL,106),
(0008,'Osman Sisha','Healthy and Lively',NULL,107),
(0009,'Osman Sisha','Healthy and Lively','Pollen',108),
(0010,'Osman Sisha','Healthy and Lively',NULL,109),
(0011,'Khidr Karawita','Has history with Shingles','Spores',110),
(0012,'Ismail Kanabawi','Has history with Diphtheria',NULL,111),
(0013,'Mohammed Sumbul','Had history with Tetanus','Spores',112),
(0014,'Osman Sisha','Has history with COVID19',NULL,113),
(0015,'Mohammed Sumbul','Had history with Rabies',NULL,114);

-- Sameh218767 --
-- Vaccination_history junction table insertions --
INSERT INTO Vaccination_history
VALUES(0001, 'Havrix');
INSERT INTO Vaccination_history
VALUES(0002, 'Fluzone');
INSERT INTO Vaccination_history
VALUES(0003, 'HDCV');
INSERT INTO Vaccination_history
VALUES(0005, 'HDCV');
INSERT INTO Vaccination_history
VALUES(0006, 'Fluzone');
INSERT INTO Vaccination_history
VALUES(0009, 'Zostavax');
INSERT INTO Vaccination_history
VALUES(0011, 'Zostavax');
INSERT INTO Vaccination_history
VALUES(0012, 'Tenivac');
INSERT INTO Vaccination_history
VALUES(0013, 'Tenivac');
INSERT INTO Vaccination_history
VALUES(0014, 'CCoV');
INSERT INTO Vaccination_history
VALUES(0015, 'HDCV');

-- Sameh218767 --
-- Animal_medication insertions --
INSERT INTO Animal_medication(Record_num, Medication)
VALUES
(0001,'Albendazole'),
(0002,'Albendazole'),
(0003,'Albendazole'),
(0004,'Albendazole'),
(0004,'artificial tears'),
(0005,'artificial tears'),
(0006,'artificial tears'),
(0006,'atenolol'),
(0007,'atenolol'),
(0009,'atenolol'),
(0011,'butorphanol'),
(0012,'butorphanol'),
(0013,'butorphanol'),
(0015,'deracoxib');

-- Sameh218767 --
-- Animal_ailment insertions --
INSERT INTO Animal_ailment
VALUES(0001, 'Hepatitis A','2019-5-1');
INSERT INTO Animal_ailment
VALUES(0002, 'Flu','2018-3-1');
INSERT INTO Animal_ailment
VALUES(0003, 'Rabies','2020-2-1');
INSERT INTO Animal_ailment
VALUES(0011, 'Shingles','2020-5-5');
INSERT INTO Animal_ailment
VALUES(0012, 'Diphtheria','2020-5-6');
INSERT INTO Animal_ailment
VALUES(0013, 'Tetanus','2020-5-1');
INSERT INTO Animal_ailment
VALUES(0014, 'COVID19','2019-4-3');
INSERT INTO Animal_ailment
VALUES(0015, 'Rabies','2019-5-6');


-- All Queries --

--- Amir224049 Queries --- 
-- Query to get the number of trainers and the number of animals these trainers watch over --- 
SELECT COUNT(*) AS 'Number of Trainers', COUNT(*) AS 'Number of Animals being watched'
FROM Worker JOIN Trainer
ON Worker.Worker_ID = Trainer.Trainer_ID
JOIN Trainer_does_training
ON Trainer_ID = W_ID
JOIN Care_plan
ON Trainer_does_training.C_ID = Care_plan.Case_ID
JOIN Animal
ON Care_plan.A_ID = Animal.Animal_ID
WHERE Animal.Common_term = 'Cat'



--- get the IDs and Names of the workers who has salary greater than 4000 regardless of their specialization (Volunteer - Staff - Trainer)
SELECT Worker_ID AS 'The IDs of these Workers', Worker_name AS 'Worker Name'
FROM Worker
WHERE Salary > 4000;


-- get the Average Salary 
-- to check if someone has a high years of experience and low salary compared to others --
SELECT AVG(Salary) AS 'Average Salary', Years_of_experience AS 'Years of Experience'
FROM Staff JOIN Worker
ON Staff.Staff_ID = Worker.Worker_ID
GROUP BY Worker.Years_of_experience;

-- get the ID of trainers that use certain equipment like hoop
-- and work with animals that have a certain condition like parasite infection
-- also get the ID of these animals
SELECT Trainer_ID AS 'Trainer ID', A_ID AS 'Animal ID'
FROM Trainer JOIN Trainer_does_training
ON Trainer.Trainer_ID = Trainer_does_training.W_ID
JOIN Care_plan
ON Care_plan.Case_ID = Trainer_does_training.C_ID
WHERE Equipment = 'hoop' AND Type_of_damage = 'parasite infection';




-- get Trainer IDs, their Degree, Specialization and Salary after comparing Trainer's Salary to the MAX salary of Staff 
SELECT Trainer_ID, Degree, Specialization, Salary
FROM Trainer JOIN Worker
ON Trainer_ID = Worker_ID
WHERE Salary > ALL  (
						SELECT MAX(Salary)
						FROM Worker JOIN Staff
						ON Worker_ID = Staff_ID
					)	


--Konouz 227447 Retrieve names and severity of case of female animals who have birth damage (inner join)--
SELECT Name, Severity_of_case
FROM Animal JOIN CARE_PLAN
ON Animal.Animal_ID= CARE_PLAN.A_ID
WHERE Gender='F' AND Type_of_damage='birth';


--konouz 227447 retrieve the number of cases of animals who are doing tricks training with trainers specializing in animal behavior (INNER JOIN WITH MANY TO MANY+AGGREGATE)--
SELECT COUNT(*) AS 'Number of animals in tricks training', Specialization
FROM Care_plan JOIN Trainer_does_training
ON Care_plan.Case_ID=Trainer_does_training.C_ID
JOIN Trainer
ON Trainer_does_training.W_ID= Trainer.Trainer_ID
WHERE Training_name='tricks training' AND Specialization='Animal Behaviour'
GROUP BY Specialization;


--Konouz 227447 simple query, retrieve careplans located in doki --
SELECT*
FROM Care_plan
WHERE Care_location= 'doki';



--konouz 227447 derived attribute 'Care duration'--

SELECT DATEDIFF(day, Start_date, End_date ) AS 'Care duration'
FROM CARE_PLAN
WHERE  NOT EXISTS (SELECT End_date
                      FROM CARE_PLAN
					  WHERE End_date=NULL);

--Konouz 227447 retrieve case id for trainers that have a diploma --
SELECT Case_ID
FROM Care_plan JOIN Trainer_does_training
ON Case_ID = C_ID
JOIN Trainer
ON W_ID = Trainer_ID
WHERE Degree = 'Diploma';

-- Sameh218767 --
-- Number of empty cages depending on size --
SELECT Size AS 'Cage size', COUNT(Cage_num) AS 'Number of empty enclosures'
FROM Cage
WHERE Cage_status=0
GROUP BY Cage.Size;


-- Sameh218767 --
--  Animals who have a history with an illness and should get vaccinated prioritized by first infected --
SELECT MR.Record_num AS 'Record number', AD.Disease, VH.V_name AS 'Vaccine to be taken', MR.Doctor, AD.Contraction_date AS 'First infected'
FROM Medical_record AS MR INNER JOIN Vaccination_history AS VH
ON MR.Record_num=VH.Record_num
AND MR.Animal_description != 'Healthy and Lively'
INNER JOIN Animal_ailment AS AD
ON AD.Record_num = MR.Record_num
ORDER BY AD.Contraction_date ASC;


-- Sameh218767 --
-- Number of occupied cages based on habitat type --
SELECT Habitat_type AS 'Habitat', COUNT(Cage_num) AS 'Number of occupied enclosures'
FROM Unit JOIN Cage 
ON Unit.Unit_ID = Cage.Unit_ID
AND Cage_status=1
GROUP BY Habitat_type;

-- Sameh218767 --
-- Animals who are healthy with history of effective vaccination --
SELECT Animal.Animal_ID, VH.V_name AS 'Vaccine name'
FROM Animal, Vaccination_history as VH
WHERE VH.Record_num IN (SELECT Medical_record.Record_num
							FROM Medical_record
							WHERE Medical_record.A_ID = Animal.Animal_ID
							AND Medical_record.Animal_description ='Healthy and Lively');

-- Sameh218767 --
-- Full display of an animal's information and medical history for an adopter to judge -- 

SELECT MR.Record_num AS 'Medical Record File No.',
A.Animal_ID AS 'Animal ID',
A.Age, A.Breed,A.Gender, MR.Animal_description,
CASE WHEN MR.Allergy IS NULL THEN 'No allergies' ELSE MR.Allergy END AS 'Allergy',
CASE WHEN AD.Disease IS NULL THEN 'No disease' ELSE AD.Disease END AS 'Disease',
CASE WHEN VH.V_name IS NULL THEN 'No Vaccination History' ELSE VH.V_name END AS 'Vaccines'

FROM Medical_record AS MR LEFT OUTER JOIN Animal_ailment AS AD
ON MR.Record_num = AD.Record_num
LEFT OUTER JOIN Animal_medication AS AM
ON MR.Record_num=AM.Record_num
LEFT OUTER JOIN Vaccination_history AS VH
ON MR.Record_num = VH.Record_num
INNER JOIN Animal AS A
ON MR.A_ID = A.Animal_ID;


-- Patrick219835 Queries --

-- Title: Critical health in Cairo --
-- Retrieve animal names and IDs that are in critical condition
-- that are adopted and located in Cairo --
SELECT Animal_ID, Name
FROM Cage JOIN Animal
ON Cage_num = Cage_ID
JOIN Care_plan
ON Animal_ID = A_ID
WHERE Severity_of_case = 'Critical'
AND Animal_ID IN (
	SELECT Adopted_animal_id
	FROM Adopted JOIN Adopter
	ON Adptr_id = Adopter_id
	WHERE City = 'Cairo'
);

-- Title: Number of animals based on age and diet
-- Retrieve animal names and IDs that
-- are over the age of 8 and follow diet 51 --
SELECT COUNT(*) AS 'Number of animals', Common_term
FROM Animal JOIN Diet
ON Animal.Diet_ID = Diet.Diet_ID
WHERE Diet.Diet_ID = 51
AND Age < 8
GROUP BY Common_term;

-- Title: Critical animal: diet and diseases
-- Retrieve number of animals and thier diet comment 
-- that are in critical condition and check
-- if they had any diseases prior to the critical condition 
-- then group the animals by comments --
SELECT COUNT(*) AS 'Number of critical animals', Diet.Comment
FROM Animal JOIN Diet
ON Animal.Diet_ID = Diet.Diet_ID
WHERE Animal_ID IN (
    SELECT Medical_record.A_ID
    FROM Medical_record JOIN Animal_ailment
    ON Medical_record.Record_num = Animal_ailment.Record_num
)
GROUP BY Comment;

-- Title: All Dogs --
-- Retrieve all animals which are dogs --
SELECT *
FROM Animal
WHERE Common_term = 'Dog';

-- Title: Average Cats --
-- Retrieve the average age of all the cats --
SELECT AVG(Age) AS 'Average age'
FROM Animal
WHERE Common_term = 'Cat'

-- Zeinab222188 Query--
/*Query gets the names of adopters who waited for a long time in the adoption 
process to hand out coupons and gifts to maintain the shelter’s good reputation*/
SELECT Adopter_id, Adopter_name, DATEDIFF(month,Request_date,Date_of_adoption) AS 'Month Waited', Email
FROM Adopter
INNER JOIN Adopter_Email
ON Adopter_id=Eadopter_id
INNER JOIN Adoption
ON Adop_id=Adopter_id 
WHERE DATEDIFF(month,Request_date,Date_of_adoption)>3;

-- Zeinab222188 Query--
/*Query collecting information on animals with care in 
progress to inform Adopters when care is no longer needed*/
SELECT Adopted_animal_id, Name_after_adoption,Care_plan.Status, Severity_of_case, Phone_number
FROM Adopted
INNER JOIN Adopter_Phone
ON Adptr_id=Padopter_id
INNER JOIN Care_plan
ON Adopted_animal_id=Care_plan.A_ID 
WHERE Care_Plan.Status LIKE '%care in progress%';

-- Zeinab222188 Query--
/*Query gets animals living in Alexandria, their Interval of checkup, and 
adopter contact info to communicate with adopters and set checkup meetings*/
SELECT Adopted_animal_id, Name_after_adoption, Interval_of_checkup, Email, Phone_number
FROM Adopter
RIGHT OUTER JOIN Adopter_Email
ON Adopter_id = Eadopter_id
RIGHT OUTER JOIN Adopter_Phone
ON Adopter_id = Padopter_id
INNER JOIN Adoption
ON Adopter_id = Adop_id
INNER JOIN Adopted
ON Adopter_id = Adptr_id
WHERE City = 'Alexandria';

-- Zeinab222188 Query--
/*Counting the number of different streets where animals in Alexandria live to know how many 
checkup specialists to send*/
SELECT COUNT(Adopter_id) AS 'Number of Animals', Street
FROM Adopter INNER JOIN Adoption
ON Adopter_id=Adop_id
WHERE City='Alexandria'
GROUP BY Street;

--Zeinab222188 Query--
/*Get the (frequent) adopters who adopted more than 1 animal 
to send them recommendations for animals to adopt*/
SELECT Adopter_id, Adopter_name, Email
FROM Adopter
INNER JOIN Adopter_Email
ON Adopter_id=Eadopter_id
WHERE Adopter_id IN (
						SELECT Adop_id
						FROM Adoption
						WHERE Adop_id=Adopter_id
						GROUP BY Adop_id
						HAVING COUNT(Adop_case) >1);
