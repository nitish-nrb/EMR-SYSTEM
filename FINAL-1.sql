DROP DATABASE IF EXISTS PROJECTONE ;
CREATE DATABASE PROJECTONE;
USE PROJECTONE;
CREATE TABLE Insurance (
    insurance_id INT PRIMARY KEY NOT NULL,
    insurance_company VARCHAR(50) NOT NULL,
    insurance_group VARCHAR(50) NOT NULL,
    insurance_coverage VARCHAR(50) NOT NULL
);


CREATE TABLE Patient(
patient_id INT Primary key AUTO_INCREMENT NOT NULL,
first_name VARCHAR(45) NOT NULL,
last_name VARCHAR(45) NOT NULL,
gender CHAR(1) NOT NULL,
age INT(10) NOT NULL,
patient_phone VARCHAR(45) NOT NULL,
email VARCHAR(255) NOT NULL,
patient_address VARCHAR(255) NOT NULL,
insurance_id INT NOT NULL,
password varchar(40) NOT NULL,
userType varchar(20),
CONSTRAINT fk_Insure FOREIGN KEY (insurance_id)
REFERENCES Insurance(insurance_id)
);

-- Visits table
CREATE TABLE Visit (
  visit_id INT Primary key AUTO_INCREMENT NOT NULL,
  patient_id INT,
  provider_id INT,
  visit_date DATE,
  visit_time TIME,
  reason_to_visit VARCHAR(200),
  diagnosis VARCHAR(200),
  treatment VARCHAR(200),
CONSTRAINT FK_Patient FOREIGN KEY (patient_id)
REFERENCES Patient(patient_id));

CREATE TABLE Priority (
  priority_id INT Primary key AUTO_INCREMENT NOT NULL,
  priority_level VARCHAR(20),
  visit_id INT,
CONSTRAINT FK_Visit FOREIGN KEY (visit_id)
REFERENCES visit(visit_id));

CREATE TABLE Nurse (
  nurse_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, 
  nurse_name VARCHAR(50),
  nurse_phone VARCHAR(20),
  visit_id INT,
  priority_id INT,
  email VARCHAR(50),
  password VARCHAR(40) NOT NULL,
  userType VARCHAR(20),
  CONSTRAINT FK_visit2 FOREIGN KEY (visit_id) REFERENCES Visit(visit_id),
  CONSTRAINT FK_Priority FOREIGN KEY (priority_id) REFERENCES priority(priority_id)  
);


CREATE TABLE Room (
  number_id INT Primary key AUTO_INCREMENT NOT NULL,
  room_capacity INT,
  nurse_id INT,
  CONSTRAINT FK_NewNurse FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id)
);

-- Providers table
CREATE TABLE Provider (
  provider_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  specialty VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  appointment_fee varchar(10),
  nurse_id INT,
  number_id INT,
  password varchar(40) NOT NULL,
  userType varchar(20),
    CONSTRAINT FK_Nursee FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id) , 
    CONSTRAINT FK_room FOREIGN KEY (number_id) REFERENCES room(number_id)
   
);

CREATE TABLE Medicine (
  medicine_id INT Primary key AUTO_INCREMENT NOT NULL,
  medicine_name VARCHAR(50),
  medicine_description TEXT,
  provider_id INT,
   CONSTRAINT FK_Priovider FOREIGN KEY (provider_id) REFERENCES provider(provider_id)
);

CREATE TABLE Billing (
  billing_id INT Primary key AUTO_INCREMENT NOT NULL,
  patient_id INT,
  billing_amount DECIMAL(10,2),
  medicine_id INT,
  CONSTRAINT FK_medicine FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id),
CONSTRAINT FK_Pat FOREIGN KEY (patient_id) REFERENCES patient(patient_id) 
);



INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (1, 'ABC Insurance', 'Group A', 'Full Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (2, 'XYZ Insurance', 'Group B', 'Partial Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (3, 'DEF Insurance', 'Group C', 'No Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (4, 'GHI Insurance', 'Group A', 'Full Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (5, 'JKL Insurance', 'Group B', 'Partial Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (6, 'MNO Insurance', 'Group C', 'No Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (7, 'PQR Insurance', 'Group A', 'Full Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (8, 'STU Insurance', 'Group B', 'Partial Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (9, 'VWX Insurance', 'Group C', 'No Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (10, 'YZA Insurance', 'Group A', 'Full Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (11, 'BCD Insurance', 'Group B', 'Partial Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (12, 'EFG Insurance', 'Group C', 'No Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (13, 'HIJ Insurance', 'Group A', 'Full Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (14, 'KLM Insurance', 'Group B', 'Partial Coverage');

INSERT INTO Insurance (insurance_id, insurance_company, insurance_group, insurance_coverage)
VALUES (15, 'NOP Insurance', 'Group C', 'No Coverage');








INSERT INTO Patient (first_name, last_name, gender, age, patient_phone, email, patient_address, insurance_id, password, userType)
VALUES('John', 'Wick', 'M', 25, '555-1234', 'johnwick@example.com', '123 Main St', 1, 'password1', 'patient'),
('Jane', 'Smith', 'F', 32, '555-5678', 'janesmith@example.com', '456 Maple Ave', 2, 'password2', 'patient'),
('James', 'Johnson', 'M', 48, '555-9012', 'jamesjohnson@example.com', '789 Oak St', 3, 'password3', 'patient'),
('Sarah', 'Brown', 'F', 19, '555-3456', 'sarahbrown@example.com', '321 Elm St', 4, 'password4', 'patient'),
('David', 'Taylor', 'M', 57, '555-7890', 'davidtaylor@example.com', '987 Pine Rd', 5, 'password5', 'patient'),
('Chris', 'Davis', 'F', 42, '555-2345', 'chrisdavis@example.com', '654 Cedar Ln', 6, 'password6', 'patient'),
('Michael', 'Wilson', 'M', 29, '555-6789', 'michaelwilson@example.com', '321 Oak Ave', 7, 'password7', 'patient'),
('Rachel', 'Miller', 'F', 36, '555-0123', 'rachelmiller@example.com', '789 Maple St', 8, 'password8', 'patient'),
('Andrew', 'Jones', 'M', 51, '555-4567', 'andrewjones@example.com', '456 Elm Ave', 9, 'password9', 'patient'),
('Olivia', 'Clark', 'F', 24, '555-8901', 'oliviaclark@example.com', '123 Pine St', 10, 'password10', 'patient'),
('Will', 'Jackson', 'M', 39, '555-2345', 'willjackson@example.com', '987 Cedar Rd', 11, 'password11', 'patient'),
('Isabella', 'Lee', 'F', 27, '555-6789', 'isabellalee@example.com', '654 Maple Ln', 12, 'password12', 'patient'),
('Christopher', 'Brown', 'M', 44, '555-0123', 'christopherbrown@example.com', '321 Elm Ave', 13, 'password13', 'patient'),
('Evan', 'Smith', 'F', 31, '555-4567', 'evansmith@example.com', '789 Oak St', 14, 'password14', 'patient'),
('Victoria', 'Garcia', 'F', 52, '555-8901', 'victoriagarcia@example.com', '456 Pine Rd', 15, 'password15', 'patient');






INSERT INTO Visit (patient_id, provider_id, visit_date, visit_time, reason_to_visit, diagnosis, treatment)
VALUES
(1, 1, '2022-01-01', '10:00:00', 'Headache', 'Migraine', 'Prescription medication'),
(2, 1, '2022-01-02', '11:00:00', 'Chest pain', 'Angina', 'Nitroglycerin'),
(3, 2, '2022-01-03', '12:00:00', 'Back pain', 'Muscle strain', 'Physical therapy'),
(4, 2, '2022-01-04', '13:00:00', 'Flu-like symptoms', 'Influenza', 'Antiviral medication'),
(5, 3, '2022-01-05', '14:00:00', 'Joint pain', 'Osteoarthritis', 'Pain relievers'),
(6, 3, '2022-01-06', '15:00:00', 'Depression', 'Major depressive disorder', 'Antidepressants'),
(7, 4, '2022-01-07', '16:00:00', 'Headache', 'Tension headache', 'Pain relievers'),
(8, 4, '2022-01-08', '17:00:00', 'Anxiety', 'Generalized anxiety disorder', 'Anxiolytics'),
(9, 5, '2022-01-09', '18:00:00', 'Abdominal pain', 'Gastritis', 'Antacids'),
(10, 5, '2022-01-10', '19:00:00', 'High blood pressure', 'Hypertension', 'Blood pressure medication'),
(11, 6, '2022-01-11', '20:00:00', 'Fatigue', 'Chronic fatigue syndrome', 'Sleep aids'),
(12, 6, '2022-01-12', '21:00:00', 'Sinus congestion', 'Sinusitis', 'Nasal decongestants'),
(13, 7, '2022-01-13', '22:00:00', 'Heartburn', 'Gastroesophageal reflux disease', 'Antacids'),
(14, 7, '2022-01-14', '23:00:00', 'Allergic reaction', 'Anaphylaxis', 'Epinephrine'),
(15, 8, '2022-01-15', '00:00:00', 'Sore throat', 'Pharyngitis', 'Antibiotics');





INSERT INTO Priority (priority_level, visit_id)
VALUES
('High', 1),
('Low', 2),
('Medium', 3),
('High', 4),
('Low', 5),
('Medium', 6),
('High', 7),
('Low', 8),
('Medium', 9),
('High', 10),
('Low', 11),
('Medium', 12),
('High', 13),
('Low', 14),
('Medium', 15);





INSERT INTO Nurse (nurse_name, nurse_phone, visit_id, priority_id, email, password, userType)
VALUES
('Emma Johnson', '123-456-7890', 1, 1, 'emmajohnson@example.com', 'password1', 'nurse'),
('Oliver Lee', '234-567-8901', 2, 2, 'oliverlee@example.com', 'password2', 'nurse'),
('Sophie Brown', '345-678-9012', 3, 3, 'sophiebrown@example.com', 'password3', 'nurse'),
('James Smith', '456-789-0123', 4, 4, 'jamessmith@example.com', 'password4', 'nurse'),
('Emily Davis', '567-890-1234', 5, 5, 'emilydavis@example.com', 'password5', 'nurse'),
('Liam Taylor', '678-901-2345', 6, 6, 'liamtaylor@example.com', 'password6', 'nurse'),
('Grace Wilson', '789-012-3456', 7, 7, 'gracewilson@example.com', 'password7', 'nurse'),
('Noah Clark', '890-123-4567', 8, 8, 'noahclark@example.com', 'password8', 'nurse'),
('Ava Anderson', '901-234-5678', 9, 9, 'avaanderson@example.com', 'password9', 'nurse'),
('William Wright', '012-345-6789', 10, 10, 'williamwright@example.com', 'password10', 'nurse'),
('Chloe Martin', '123-456-7890', 11, 11, 'chloemartin@example.com', 'password11', 'nurse'),
('Benjamin Taylor', '234-567-8901', 12, 12, 'benjamintaylor@example.com', 'password12', 'nurse'),
('Amelia Brown', '345-678-9012', 13, 13, 'ameliabrown@example.com', 'password13', 'nurse'),
('Ethan Jones', '456-789-0123', 14, 14, 'ethanjones@example.com', 'password14', 'nurse'),
('Mia Miller', '567-890-1234', 15, 15, 'miamiller@example.com', 'password15', 'nurse');



INSERT INTO Room (room_capacity, nurse_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 6),
(2, 7),
(3, 8),
(4, 9),
(5, 10),
(1, 11),
(2, 12),
(3, 13),
(4, 14),
(5, 15);





INSERT INTO Provider (first_name, last_name, specialty, email, appointment_fee, nurse_id, number_id , password, userType)
VALUES
('John', 'Doe', 'Cardiology', 'johndoe@example.com', '150', 1, 1, 'password1', 'provider'),
('Jane', 'Doe', 'Dermatology', 'janedoe@example.com', '200', 2, 2, 'password2', 'provider'),
('Michael', 'Johnson', 'Endocrinology', 'michaeljohnson@example.com', '175', 3, 3, 'password3', 'provider'),
('Emily', 'Smith', 'Gastroenterology', 'emilysmith@example.com', '250', 4, 4, 'password4', 'provider'),
('William', 'Brown', 'Hematology', 'williambrown@example.com', '225', 5, 5, 'password5', 'provider'),
('Sophia', 'Taylor', 'Immunology', 'sophiataylor@example.com', '200', 6, 6, 'password6', 'provider'),
('Oliver', 'Clark', 'Neurology', 'oliverclark@example.com', '300', 7, 7, 'password7', 'provider'),
('Ava', 'Lee', 'Oncology', 'avalee@example.com', '275', 8, 8, 'password8', 'provider'),
('Ethan', 'Martin', 'Pediatrics', 'ethanmartin@example.com', '150', 9, 9, 'password9', 'provider'),
('Chloe', 'Miller', 'Psychiatry', 'chloemiller@example.com', '200', 10, 10, 'password10', 'provider'),
('Noah', 'Anderson', 'Radiology', 'noahanderson@example.com', '225', 11, 11, 'password11', 'provider'),
('Grace', 'Wilson', 'Rheumatology', 'gracewilson@example.com', '250', 12, 12, 'password12', 'provider'),
('Liam', 'Jones', 'Surgery', 'liamjones@example.com', '300', 13, 13, 'password13', 'provider'),
('Amelia', 'Anderson', 'Urology', 'ameliaanderson@example.com', '175', 14, 14, 'password14', 'provider'),
('Benjamin', 'Wright', 'Orthopedics', 'benjaminwright@example.com', '225', 15, 15, 'password15', 'provider');




INSERT INTO Medicine (medicine_id, medicine_name, medicine_description, provider_id)
VALUES 
  (1, 'Paracetamol', 'For relief of mild to moderate pain and fever', 3),
  (2, 'Ibuprofen', 'For relief of mild to moderate pain and fever', 1),
  (3, 'Diclofenac', 'For relief of mild to moderate pain and fever', 2),
  (4, 'Amoxicillin', 'For bacterial infections', 4),
  (5, 'Ceftriaxone', 'For bacterial infections', 5),
  (6, 'Levofloxacin', 'For bacterial infections', 6),
  (7, 'Amlodipine', 'For high blood pressure', 9),
  (8, 'Metoprolol', 'For high blood pressure', 7),
  (9, 'Lisinopril', 'For high blood pressure', 8),
  (10, 'Simvastatin', 'For high cholesterol', 10),
  (11, 'Atorvastatin', 'For high cholesterol', 11),
  (12, 'Rosuvastatin', 'For high cholesterol', 12),
  (13, 'Levothyroxine', 'For underactive thyroid', 13),
  (14, 'Liothyronine', 'For underactive thyroid', 14),
  (15, 'Metformin', 'For type 2 diabetes', 15);



INSERT INTO Billing (billing_id, patient_id, billing_amount, medicine_id) 
VALUES 
(1, 1, 50.00, 1),
(2, 2, 75.00, 2),
(3, 3, 100.00, 3),
(4, 4, 125.00, 4),
(5, 5, 150.00, 5),
(6, 6, 175.00, 6),
(7, 7, 200.00, 7),
(8, 8, 225.00, 8),
(9, 9, 250.00, 9),
(10, 10, 275.00, 10),
(11, 11, 300.00, 11),
(12, 12, 325.00, 12),
(13, 13, 350.00, 13),
(14, 14, 375.00, 14),
(15, 15, 400.00, 15);

SELECT p.first_name, p.last_name, b.billing_amount, m.medicine_name, m.medicine_description
FROM Patient p
JOIN Billing b ON p.patient_id = b.patient_id
JOIN Medicine m ON b.medicine_id = m.medicine_id
WHERE p.patient_id = 7;

SELECT p.first_name, p.last_name, SUM(b.billing_amount) AS total_fees
FROM Provider AS pr
JOIN Visit AS v ON pr.provider_id = v.provider_id
JOIN Patient AS p ON v.patient_id = p.patient_id
JOIN Billing AS b ON p.patient_id = b.patient_id
WHERE pr.specialty = 'Cardiology'
GROUP BY p.patient_id;

SELECT patient.first_name, patient.last_name, visit.visit_date, visit.visit_time, provider.specialty
FROM patient
JOIN visit ON patient.patient_id = visit.patient_id
JOIN provider ON visit.provider_id = 7 where provider.specialty = 'Cardiology';

SELECT m.medicine_name
FROM Patient p
INNER JOIN Billing b ON p.patient_id = b.patient_id
INNER JOIN Medicine m ON b.medicine_id = m.medicine_id
WHERE p.patient_id = 2;

SELECT p.first_name, p.last_name, v.visit_date, v.visit_time, r.number_id
FROM Patient p
JOIN Visit v ON p.patient_id = v.patient_id
JOIN Provider pr ON v.provider_id = pr.provider_id
JOIN Room r ON pr.number_id = r.number_id
WHERE r.number_id = 5;

SELECT patient.first_name, patient.last_name, COUNT(visit.patient_id) AS num_visit
FROM patient
LEFT JOIN visit ON patient.patient_id = visit.patient_id
GROUP BY patient.patient_id;

SELECT p.patient_id, p.first_name, p.last_name, p.gender, p.age, p.patient_phone, p.email, p.patient_address, 
       v.visit_date, v.visit_time, pr.first_name AS provider_first_name, pr.last_name AS provider_last_name, pr.specialty
FROM Patient p
JOIN Visit v ON p.patient_id = v.patient_id
JOIN Provider pr ON v.provider_id = pr.provider_id;


