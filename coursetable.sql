CREATE TABLE Users
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,

    FirstName VARCHAR(100) NOT NULL,

    LastName VARCHAR(100) NOT NULL,

    MobileNumber VARCHAR(15) NOT NULL,

    Email VARCHAR(150) NOT NULL UNIQUE,

    PasswordHash VARCHAR(500) NOT NULL,

    Role VARCHAR(20) NOT NULL,

    IsActive BIT NOT NULL DEFAULT 1,

    CreatedDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE Courses
(
    CourseId INT IDENTITY(1,1) PRIMARY KEY,

    CourseName VARCHAR(100) NOT NULL,

    TrainerName VARCHAR(100) NOT NULL,

    Duration INT NOT NULL,

    Fees DECIMAL(10,2) NOT NULL,

    CreatedBy INT NULL,

    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),

    UpdatedBy INT NULL,

    UpdatedDate DATETIME NULL
);
GO
