/* 
=======================================
DDL script : create stg layer table "HospitalRaw"
=======================================

script purpose :
creates the "HospitalRaw" table in the "stg" schema.
drops the table if it already exists.
run to redefine the DDL for the stg layer.
*/


/*
=======================================
DDL Script: Create STG Hospital Table
=======================================

Script Purpose:
Creates the "stg.hospital_raw" table.
Drops the table if it already exists.
The table stores raw hospital data along with
load metadata for auditing and data tracking.

*/



use MediCoreDW;

DROP TABLE IF EXISTS stg.HospitalRaw;
GO

CREATE TABLE stg.HospitalRaw (
    RecordID            NVARCHAR(50)   NULL,
    ERPTransactionID    NVARCHAR(100)  NULL,
    ERPModule           NVARCHAR(100)  NULL,
    BranchCode          NVARCHAR(50)   NULL,
    FiscalYear          NVARCHAR(50)   NULL,
    FiscalQuarter       NVARCHAR(50)   NULL,
    CreatedBy           NVARCHAR(100)  NULL,
    PatientID           NVARCHAR(50)   NULL,
    PatientName         NVARCHAR(200)  NULL,
    DateOfBirth         NVARCHAR(50)   NULL,
    Gender              NVARCHAR(50)   NULL,
    BloodGroup          NVARCHAR(20)   NULL,
    Phone               NVARCHAR(50)   NULL,
    Email               NVARCHAR(200)  NULL,
    Allergies           NVARCHAR(500)  NULL,
    [Address]           NVARCHAR(500)  NULL,
    City                NVARCHAR(100)  NULL,
    DoctorID            NVARCHAR(50)   NULL,
    DoctorName          NVARCHAR(200)  NULL,
    Specialization      NVARCHAR(100)  NULL,
    DepartmentID        NVARCHAR(50)   NULL,
    DepartmentName      NVARCHAR(100)  NULL,
    ConsultationFeeINR  NVARCHAR(50)   NULL,
    AppointmentID       NVARCHAR(50)   NULL,
    AppointmentDate     NVARCHAR(50)   NULL,
    AppointmentTime     NVARCHAR(50)   NULL,
    AppointmentStatus   NVARCHAR(50)   NULL,
    ChiefComplaint      NVARCHAR(500)  NULL,
    Diagnosis           NVARCHAR(500)  NULL,
    ClinicalNotes       NVARCHAR(MAX)  NULL,
    LabTestName         NVARCHAR(200)  NULL,
    LabResult           NVARCHAR(200)  NULL,
    ReferenceRange      NVARCHAR(200)  NULL,
    IsAbnormal          NVARCHAR(20)   NULL,
    MedicineName        NVARCHAR(200)  NULL,
    Dosage              NVARCHAR(100)  NULL,
    Frequency           NVARCHAR(100)  NULL,
    DurationDays        NVARCHAR(50)   NULL,
    LabChargeINR        NVARCHAR(50)   NULL,
    MedicineChargeINR   NVARCHAR(50)   NULL,
    SubtotalINR         NVARCHAR(50)   NULL,
    DiscountINR         NVARCHAR(50)   NULL,
    GSTAmountINR        NVARCHAR(50)   NULL,
    TotalAmountINR      NVARCHAR(50)   NULL,
    PaymentMode         NVARCHAR(50)   NULL,
    PaymentStatus       NVARCHAR(50)   NULL,
    InsuranceProvider   NVARCHAR(200)  NULL,
    PolicyNumber        NVARCHAR(100)  NULL,
    CoverageLimitINR    NVARCHAR(50)   NULL,
    LoadID              INT            NULL,
    SourceFileName      NVARCHAR(260)  NULL,
    LoadedAt            DATETIME2(0)   NOT NULL DEFAULT SYSDATETIME()
);
GO

