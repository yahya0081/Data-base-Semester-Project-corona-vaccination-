
-- ------------------------------
-- DATABASE: COVID19_Vaccination_System
-- ------------------------------

CREATE DATABASE IF NOT EXISTS COVID19_Vaccination_System;
USE COVID19_Vaccination_System;

-- Table: Vaccine
CREATE TABLE Vaccine (
    VaccineID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Manufacturer VARCHAR(100),
    DoseCount INT,
    GapBetweenDoses INT
);

-- Table: VaccinationCenter
CREATE TABLE VaccinationCenter (
    CenterID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Location VARCHAR(100),
    Capacity INT
);

-- Table: Patient
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    CNIC VARCHAR(15) UNIQUE,
    DOB DATE,
    Gender CHAR(1),
    Phone VARCHAR(20),
    Address TEXT
);

-- Table: Staff
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    Role VARCHAR(50),
    CenterID INT,
    ShiftStart TIME,
    ShiftEnd TIME,
    FOREIGN KEY (CenterID) REFERENCES VaccinationCenter(CenterID)
);

-- Table: Inventory
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    CenterID INT,
    VaccineID INT,
    Quantity INT,
    LastUpdated DATETIME,
    FOREIGN KEY (CenterID) REFERENCES VaccinationCenter(CenterID),
    FOREIGN KEY (VaccineID) REFERENCES Vaccine(VaccineID)
);

-- Table: Appointment
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    CenterID INT,
    VaccineID INT,
    DoseNumber INT,
    AppointmentDate DATETIME,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (CenterID) REFERENCES VaccinationCenter(CenterID),
    FOREIGN KEY (VaccineID) REFERENCES Vaccine(VaccineID)
);

-- Table: VaccinationRecord
CREATE TABLE VaccinationRecord (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT UNIQUE,
    VaccinationDate DATE,
    BatchNumber VARCHAR(50),
    AdministeredBy INT,
    Remarks TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
    FOREIGN KEY (AdministeredBy) REFERENCES Staff(StaffID)
);

-- Table: SideEffectsReport
CREATE TABLE SideEffectsReport (
    ReportID INT PRIMARY KEY AUTO_INCREMENT,
    RecordID INT,
    Symptoms TEXT,
    Severity VARCHAR(20),
    ReportedOn DATE,
    FOREIGN KEY (RecordID) REFERENCES VaccinationRecord(RecordID)
);
