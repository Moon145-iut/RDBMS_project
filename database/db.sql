-- Drop existing tables if they exist
DROP TABLE IF EXISTS Bills;
DROP TABLE IF EXISTS Referral;
DROP TABLE IF EXISTS PresTest;
DROP TABLE IF EXISTS PresMed;
DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Test;
DROP TABLE IF EXISTS Medicine;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Medications;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS MedicationReminder;
DROP TABLE IF EXISTS Login;
DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Pharmacy;
DROP TABLE IF EXISTS Appointments;

-- Create Student table
CREATE TABLE Student (
    ID VARCHAR2(10),
    Name VARCHAR2(100),
    Department VARCHAR2(10),
    Email VARCHAR2(255),
    PRIMARY KEY (ID)
);

-- Create Doctor table
CREATE TABLE Doctor (
    ID VARCHAR2(10),
    Name VARCHAR2(100),
    Specialization VARCHAR2(100),
    Email VARCHAR2(255),
    PRIMARY KEY (ID)
);

-- Create Medicine table
CREATE TABLE Medicine (
    ID NUMBER,
    Name VARCHAR2(100),
    Generic VARCHAR2(100),
    Company VARCHAR2(100),
    Quantity NUMBER,
    PRIMARY KEY (ID)
);

-- Create Test table
CREATE TABLE Test (
    ID NUMBER,
    Name VARCHAR2(100),
    Price VARCHAR2(30),
    Availability NUMBER(1),
    PRIMARY KEY (ID)
);

-- Create Visit table
CREATE TABLE Visit (
    ID NUMBER,
    StudentID VARCHAR2(10),
    DoctorID VARCHAR2(10),
    VisitTime DATE,
    PRIMARY KEY (ID),
    CONSTRAINT FK_Visit_DoctorID FOREIGN KEY (DoctorID) REFERENCES Doctor(ID),
    CONSTRAINT FK_Visit_StudentID FOREIGN KEY (StudentID) REFERENCES Student(ID)
);

-- Create PresMed table
CREATE TABLE PresMed (
    ID NUMBER,
    VisitID NUMBER,
    MedicineID NUMBER,
    Quantity NUMBER,
    PRIMARY KEY (ID),
    CONSTRAINT FK_PresMed_VisitID FOREIGN KEY (VisitID) REFERENCES Visit(ID),
    CONSTRAINT FK_PresMed_MedicineID FOREIGN KEY (MedicineID) REFERENCES Medicine(ID)
);

-- Create PresTest table
CREATE TABLE PresTest (
    ID NUMBER,
    VisitID NUMBER,
    TestID NUMBER,
    PRIMARY KEY (ID),
    CONSTRAINT FK_PresTest_VisitID FOREIGN KEY (VisitID) REFERENCES Visit(ID),
    CONSTRAINT FK_PresTest_TestID FOREIGN KEY (TestID) REFERENCES Test(ID)
);

-- Create Referral table
CREATE TABLE Referral (
    ID NUMBER,
    VisitID NUMBER,
    Details VARCHAR2(255),
    PRIMARY KEY (ID),
    CONSTRAINT FK_Referral_VisitID FOREIGN KEY (VisitID) REFERENCES Visit(ID)
);

-- Create Bill table
CREATE TABLE Bill (
    ID NUMBER,
    RefID NUMBER,
    Amount NUMBER,
    PRIMARY KEY (ID),
    CONSTRAINT FK_Bill_RefID FOREIGN KEY (RefID) REFERENCES Referral(ID)
);

-- Create Medications table
CREATE TABLE Medications (
    M_ID NUMBER,
    Name VARCHAR2(100),
    Type VARCHAR2(50),
    Manufacturer VARCHAR2(100),
    DosageForm VARCHAR2(50),
    SideEffects TEXT,
    ReminderID NUMBER,
    PRIMARY KEY (M_ID),
    CONSTRAINT FK_Medications_ReminderID FOREIGN KEY (ReminderID) REFERENCES MedicationReminder(ReminderID)
);

-- Create Prescriptions table
CREATE TABLE Prescriptions (
    pre_ID NUMBER,
    P_ID NUMBER,
    Doctor_ID NUMBER,
    Issue_date DATE,
    Instruction TEXT,
    PRIMARY KEY (pre_ID),
    CONSTRAINT FK_Prescriptions_PatientID FOREIGN KEY (P_ID) REFERENCES Patient(P_ID),
    CONSTRAINT FK_Prescriptions_DoctorID FOREIGN KEY (Doctor_ID) REFERENCES Doctors(DoctorID)
);

-- Create Bills table
CREATE TABLE Bills (
    B_ID NUMBER,
    Type VARCHAR2(50),
    Amount VARCHAR2(50),
    PRIMARY KEY (B_ID)
);

-- Create Patient table
CREATE TABLE Patient (
    P_ID NUMBER,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    DOB DATE,
    Gender VARCHAR2(10),
    Email VARCHAR2(100),
    PhoneNumber VARCHAR2(15),
    Address VARCHAR2(255),
    Allergies TEXT,
    MedicalHistory TEXT,
    EmergencyContact VARCHAR2(15),
    PRIMARY KEY (P_ID)
);

-- Create MedicationReminder table
CREATE TABLE MedicationReminder (
    ReminderID NUMBER,
    P_ID NUMBER,
    pre_ID NUMBER,
    ReminderTime DATE,
    Status VARCHAR2(50),
    PRIMARY KEY (ReminderID),
    CONSTRAINT FK_MedicationReminder_PatientID FOREIGN KEY (P_ID) REFERENCES Patient(P_ID),
    CONSTRAINT FK_MedicationReminder_PrescriptionID FOREIGN KEY (pre_ID) REFERENCES Prescriptions(pre_ID)
);

-- Create Login table
CREATE TABLE Login (
    loginID NUMBER,
    Password VARCHAR2(255),
    Username VARCHAR2(50),
    role_ID NUMBER,
    PRIMARY KEY (loginID),
    CONSTRAINT FK_Login_RoleID FOREIGN KEY (role_ID) REFERENCES Role(role_ID)
);

-- Create Role table
CREATE TABLE Role (
    role_ID NUMBER,
    role_name VARCHAR2(50),
    role_DESC VARCHAR2(255),
    PRIMARY KEY (role_ID)
);

-- Create Admin table
CREATE TABLE Admin (
    Admin_ID NUMBER,
    P_ID NUMBER,
    pre_ID NUMBER,
    Doctor_ID NUMBER,
    B_ID NUMBER,
    Status VARCHAR2(50),
    PRIMARY KEY (Admin_ID),
    CONSTRAINT FK_Admin_PatientID FOREIGN KEY (P_ID) REFERENCES Patient(P_ID),
    CONSTRAINT FK_Admin_PrescriptionID FOREIGN KEY (pre_ID) REFERENCES Prescriptions(pre_ID),
    CONSTRAINT FK_Admin_DoctorID FOREIGN KEY (Doctor_ID) REFERENCES Doctors(DoctorID),
    CONSTRAINT FK_Admin_BillID FOREIGN KEY (B_ID) REFERENCES Bills(B_ID)
);

-- Create Pharmacy table
CREATE TABLE Pharmacy (
    Pharmacy_ID NUMBER,
    Address TEXT,
    PhoneNumber NUMBER,
    Admin_ID NUMBER,
    Pres_ID NUMBER,
    PRIMARY KEY (Pharmacy_ID),
    CONSTRAINT FK_Pharmacy_AdminID FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID),
    CONSTRAINT FK_Pharmacy_PrescriptionID FOREIGN KEY (Pres_ID) REFERENCES Prescriptions(pre_ID)
);

-- Create Appointments table
CREATE TABLE Appointments (
    AppointmentID NUMBER,
    PatientID NUMBER,
    DoctorID NUMBER,
    AppointmentDate DATE,
    Reason VARCHAR2(255),
    Status VARCHAR2(50),
    PRIMARY KEY (AppointmentID),
    CONSTRAINT FK_Appointments_PatientID FOREIGN KEY (PatientID) REFERENCES Patient(P_ID),
    CONSTRAINT FK_Appointments_DoctorID FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
CREATE TABLE user_info (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    dob DATE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('doctor', 'patient', 'admin') NOT NULL
);

