
-- 1) Drop the audit table if it already exists
DROP TABLE IF EXISTS new_patient_details;

-- Create the audit table
CREATE TABLE new_patient_details (
    patient_id INT ,
    old_phone_number VARCHAR(100),
    new_phone_number VARCHAR(100),
    tabl_name VARCHAR(100),
    timestamp DATETIME,
    user VARCHAR(100)
);

-- Create the trigger
DROP TRIGGER IF EXISTS UPDATE_USER_DETAILS;
DELIMITER //
CREATE TRIGGER UPDATE_USER_DETAILS
BEFORE UPDATE ON patient
FOR EACH ROW
BEGIN
    IF OLD.patient_phone <> NEW.patient_phone THEN
        INSERT INTO new_patient_details (patient_id, old_phone_number, new_phone_number, tabl_name, timestamp, user)
        VALUES (OLD.patient_id, OLD.patient_phone, NEW.patient_phone, "patient", NOW(), USER());
    END IF;
END //
DELIMITER ;



select * from new_patient_details;









##############################

DROP TABLE IF EXISTS new_patient_age_details ;

-- Create the audit table
CREATE TABLE new_patient_age_details  (
    patient_id int,
    old_data_age int,
    new_data_age int,
    tabl_name VARCHAR(100),
    timestamp DATETIME,
    user VARCHAR(100)
);

-- Create the trigger
DROP TRIGGER IF EXISTS UPDATE_USER_AGE_DETAILS;
DELIMITER //
CREATE TRIGGER UPDATE_USER_AGE_DETAILS
BEFORE UPDATE ON patient
FOR EACH ROW
BEGIN
    IF OLD.age <> NEW.age THEN
        INSERT INTO new_patient_age_details (patient_id, old_data_age, new_data_age, tabl_name, timestamp, user)
        VALUES (OLD.patient_id, OLD.age, NEW.age, "patient", NOW(), USER());
    END IF;
END //
DELIMITER ;


select * from new_patient_age_details;

#################################################

DROP TABLE IF EXISTS new_patient_address_details ;

-- Create the audit table
CREATE TABLE new_patient_address_details  (
    patient_id int,
    old_data_address varchar(200),
    new_data_address varchar(200),
    tabl_name VARCHAR(100),
    timestamp DATETIME,
    user VARCHAR(100)
);

-- Create the trigger
DROP TRIGGER IF EXISTS UPDATE_USER_ADDRESS_DETAILS;
DELIMITER //
CREATE TRIGGER UPDATE_USER_ADDRESS_DETAILS
BEFORE UPDATE ON patient
FOR EACH ROW
BEGIN
    IF OLD.patient_address <> NEW.patient_address THEN
        INSERT INTO new_patient_address_details (patient_id, old_data_address, new_data_address, tabl_name, timestamp, user)
        VALUES (OLD.patient_id, OLD.patient_address, NEW.patient_address, "patient", NOW(), USER());
    END IF;
END //
DELIMITER ;


select * from new_patient_address_details;










select * from nurse;

