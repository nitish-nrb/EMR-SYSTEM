-- Stored procedure GetVisitsByDateRange

drop procedure if exists GetVisitsByDateRange;
DELIMITER $$
CREATE PROCEDURE GetVisitsByDateRange(IN startDate DATE, IN endDate DATE, IN providerId INT)
BEGIN

SELECT CONCAT('Debug: startDate=', startDate) AS Debug;
    SELECT CONCAT('Debug: endDate=', endDate) AS Debug;
    SELECT CONCAT('Debug: providerId=', providerId) AS Debug;
    SELECT *
    FROM Visit
    WHERE visit_date BETWEEN startDate AND endDate
    AND provider_id = providerId;
END$$
DELIMITER ;

CALL GetVisitsByDateRange('2022-01-01', '2023-12-31', 1);


drop procedure if exists UpdatePatientDetails;

DELIMITER //
CREATE PROCEDURE UpdatePatientDetails(
    IN patientID INT,
    IN newPhone VARCHAR(45),
    IN newAge INT,
    IN newAddress VARCHAR(255)
)
BEGIN
    UPDATE Patient
    SET
        patient_phone = newPhone,
        age = newAge,
        patient_address = newAddress
    WHERE patient_id = patientID;
    
    SELECT 'Patient details updated successfully' AS message;
END//

DELIMITER ;
CALL UpdatePatientDetails(1, '1234567890', 25, 'New Address');


drop procedure if exists CreatePatient;

DELIMITER //

CREATE PROCEDURE CreatePatient(
    IN p_patient_id INT,
    IN p_first_name VARCHAR(45),
    IN p_last_name VARCHAR(45),
    IN p_gender CHAR(1),
    IN p_age INT,
    IN p_patient_phone VARCHAR(45),
    IN p_email VARCHAR(255),
    IN p_patient_address VARCHAR(255),
    IN p_insurance_id INT,
    IN p_password VARCHAR(255),
    IN p_userType varchar(45)
)
BEGIN
    DECLARE existing_count INT;
    
    -- Check if the patient ID already exists
    SELECT COUNT(*) INTO existing_count
    FROM Patient
    WHERE patient_id = p_patient_id;
    
    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Patient ID already exists.';
    ELSE
        -- Insert the new patient record
        INSERT INTO Patient (
            patient_id,
            first_name,
            last_name,
            gender,
            age,
            patient_phone,
            email,
            patient_address,
            insurance_id,
            password,
            userType
        ) VALUES (
            p_patient_id,
            p_first_name,
            p_last_name,
            p_gender,
            p_age,
            p_patient_phone,
            p_email,
            p_patient_address,
            p_insurance_id,
            p_password,
            p_userType
        );
    END IF;
END //

DELIMITER ;


#CALL CreatePatient(90, 'Johndd', 'Dode', 'M', 30, '123-456-7890', 'johddn.doe@example.com', '123 Main St', 1, 'passworddemo','patient');
select * from patient;


drop procedure if exists createProvider;

DELIMITER //

CREATE PROCEDURE CreateProvider(
    IN p_provider_id INT,
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_specialty VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_appointment_fee VARCHAR(10),
    IN p_nurse_id INT,
    IN p_number_id INT,
    IN p_password VARCHAR(50),
    IN p_userType VARCHAR(20)
)
BEGIN
    DECLARE existing_count INT;
    
    -- Check if the provider ID already exists
    SELECT COUNT(*) INTO existing_count
    FROM Provider
    WHERE provider_id = p_provider_id;
    
    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Provider ID already exists.';
    ELSE
        -- Insert the new provider record
        INSERT INTO Provider (
            provider_id,
            first_name,
            last_name,
            specialty,
            email,
            appointment_fee,
            nurse_id,
            number_id,
            password,
            userType
        ) VALUES (
            p_provider_id,
            p_first_name,
            p_last_name,
            p_specialty,
            p_email,
            p_appointment_fee,
            p_nurse_id,
            p_number_id,
            p_password,
            p_userType
        );
    END IF;
END //

DELIMITER ;

#CALL CreateProvider(100, 'Erwin', 'Smith', 'Cardiology', 'erwin.smith@example.com', '100', 1, 1, 'password', 'provider');
select * from Provider;

desc provider;	

drop procedure if exists CreateNurse;


DELIMITER //

CREATE PROCEDURE CreateNurse(
    IN p_nurse_id INT,
    IN p_nurse_name VARCHAR(50),
    IN p_nurse_phone VARCHAR(20),
    IN p_visit_id INT,
    IN p_priority_id INT,
    IN p_email VARCHAR(50),
    IN p_password VARCHAR(50),
    IN p_userType VARCHAR(20)
)
BEGIN
    DECLARE existing_count INT;
    
    -- Check if the nurse ID already exists
    SELECT COUNT(*) INTO existing_count
    FROM Nurse
    WHERE nurse_id = p_nurse_id;
    
    IF existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nurse ID already exists.';
    ELSE
        -- Insert the new nurse record
        INSERT INTO Nurse (
            nurse_id,
            nurse_name,
            nurse_phone,
            visit_id,
            priority_id,
            email,
            password,
            userType
        ) VALUES (
            p_nurse_id,
            p_nurse_name,
            p_nurse_phone,
            p_visit_id,
            p_priority_id,
            p_email,
            p_password,
            p_userType
        );
    END IF;
END //

DELIMITER ;

#CALL CreateNurse(123, 'John Bha', '123-456-7890', 1, 1, 'john.doe@example.com', 'passwordjha', 'nurse');

select * from nurse;

drop procedure if exists CalculateBill;
DELIMITER $$
CREATE PROCEDURE CalculateBill(IN patientID INT)
BEGIN
    DECLARE totalAmount DECIMAL(10, 2);
    
    SELECT SUM(billing_amount) INTO totalAmount
    FROM billing
    WHERE patient_id = patientID;
    
    SELECT CONCAT('Total Bill Amount: $', totalAmount) AS bill;
END$$
DELIMITER ;



CALL CalculateBill(4);
