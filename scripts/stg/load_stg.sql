/* 
=======================================================
Stored Procedure: Load Data In Stg Layer (source ==> stg)
========================================================

script Purpose:

loads data into stg layer from source(external .csv files).
it uses the method truncate and insert.
uses the "bulk insert" cmd to load the entire data in one go.
the view is used as a separate layer between the csv file and the stg table.


example usage:
exec stg.Load_HospitalRaw;
*/


USE MediCoreDW;
GO


CREATE OR ALTER VIEW stg.vw_HospitalRaw_Load AS
SELECT RecordID, ERPTransactionID, ERPModule, BranchCode, FiscalYear,
       FiscalQuarter, CreatedBy, PatientID, PatientName, DateOfBirth,
       Gender, BloodGroup, Phone, Email, Allergies, [Address], City,
       DoctorID, DoctorName, Specialization, DepartmentID, DepartmentName,
       ConsultationFeeINR, AppointmentID, AppointmentDate, AppointmentTime,
       AppointmentStatus, ChiefComplaint, Diagnosis, ClinicalNotes,
       LabTestName, LabResult, ReferenceRange, IsAbnormal, MedicineName,
       Dosage, Frequency, DurationDays, LabChargeINR, MedicineChargeINR,
       SubtotalINR, DiscountINR, GSTAmountINR, TotalAmountINR,
       PaymentMode, PaymentStatus, InsuranceProvider, PolicyNumber,
       CoverageLimitINR
FROM stg.HospitalRaw;
go


CREATE OR ALTER PROCEDURE stg.Load_HospitalRaw
AS
BEGIN

    BEGIN TRY

        TRUNCATE TABLE stg.HospitalRaw;
    

        BULK INSERT stg.vw_HospitalRaw_Load
        FROM 'C:\MediCore\hospital_raw.csv'
        WITH (
            FORMAT          = 'CSV',
            FIRSTROW        = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR   = '0x0d0a',
            CODEPAGE        = '65001',
            TABLOCK,
            MAXERRORS       = 0
        );

        PRINT 'Hospital data loaded successfully.';

    END TRY

    BEGIN CATCH

        PRINT 'Hospital data load failed.';
        PRINT ERROR_MESSAGE();

    END CATCH;


END;



