CREATE INDEX idx_patient_email
ON patient (email);

SELECT * FROM patient WHERE email = 'johnwick@example.com';

EXPLAIN SELECT * FROM patient WHERE email = 'johndoe@example.com';

select * from patient;

SET profiling = 1;

SHOW PROFILE;

CREATE INDEX idx_provider_email
ON provider (email);

CREATE INDEX idx_nurse_email
ON nurse (email);

CREATE INDEX idx_billing_amount
ON billing (billing_amount);

CREATE INDEX idx_patient_age
ON patient (age);

CREATE INDEX idx_insurance_id 
ON Insurance (insurance_id);

CREATE INDEX idx_insurance_company 
ON Insurance (insurance_company);

CREATE INDEX idx_insurance_group ON Insurance (insurance_group);
CREATE INDEX idx_insurance_coverage ON Insurance (insurance_coverage);

CREATE INDEX idx_patient_id ON Patient (patient_id);
CREATE INDEX idx_insurance_id2 ON Patient (insurance_id);

CREATE INDEX idx_visit_id
 ON Visit (visit_id);
 
CREATE INDEX idx_patient_id2 
ON Visit (patient_id);

CREATE INDEX idx_provider_id ON Visit (provider_id);

CREATE INDEX idx_priority_id ON Priority (priority_id);
CREATE INDEX idx_visit_id2 ON Priority (visit_id);

CREATE INDEX idx_nurse_id ON Nurse (nurse_id);
CREATE INDEX idx_visit_id3 ON Nurse (visit_id);
CREATE INDEX idx_priority_id2 ON Nurse (priority_id);

CREATE INDEX idx_number_id 
ON Room (number_id);

CREATE INDEX idx_nurse_id2 
ON Room (nurse_id);

CREATE INDEX idx_provider_id2
 ON Medicine (provider_id);

CREATE INDEX idx_medicine_id
 ON Billing (medicine_id);
CREATE INDEX idx_patient_id3
 ON Billing (patient_id);





