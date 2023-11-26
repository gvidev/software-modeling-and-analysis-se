DROP DATABASE StoryTel
CREATE DATABASE StoryTel
GO
USE StoryTel
GO
CREATE TABLE Author(
AuthorId INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(70) NOT NULL,
DateOfBirth DATE,
Nationality NVARCHAR(60),
ShortBiography NVARCHAR(200),
PhotoUrl NVARCHAR(100)
);
GO
CREATE TABLE Subscription(
SubscriptionId INT PRIMARY KEY IDENTITY(1,1),
SubscriptionType NVARCHAR(50) NOT NULL,
SubscriptionPlan NVARCHAR(50) NOT NULL,
TimeInMonths INT NOT NULL,
Price FLOAT NOT NULL,
MaxProfiles INT NOT NULL,
);
GO
CREATE TABLE Users(
UserId INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(70) NOT NULL,
Username NVARCHAR(15) UNIQUE NOT NULL,
Email NVARCHAR(60) UNIQUE NOT NULL,
Password NVARCHAR(30) NOT NULL,
DateOfBirth DATE NOT NULL,
PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
CONSTRAINT CHK_PasswordLength CHECK (LEN(Password) >= 9), 
CONSTRAINT CHK_EmailFormat CHECK (Email LIKE '%_@__%.__%')
);
GO
CREATE TABLE Narrator(
NarratorId INT PRIMARY KEY IDENTITY(1,1),
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
Nationality NVARCHAR(60),
Bio NVARCHAR(100),
Gender NVARCHAR(20)
);
GO
CREATE TABLE UserSubscription(
UserSubscriptionId INT PRIMARY KEY IDENTITY(1,1),
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
UserId INT UNIQUE,
SubscriptionId INT,
FOREIGN KEY (UserId) REFERENCES Users(UserId),
FOREIGN KEY (SubscriptionId) REFERENCES Subscription(SubscriptionId)
);
GO
CREATE TABLE Book(
BookId INT PRIMARY KEY IDENTITY(1,1),
AuthorId INT,
ISBN VARCHAR(13) UNIQUE NOT NULL,
Title NVARCHAR(50) NOT NULL,
ReleaseDate DATE NOT NULL,
NumberOfPages INT NOT NULL,
Category NVARCHAR(50) NOT NULL,
Language NVARCHAR(30) NOT NULL,
Description NVARCHAR(300) NOT NULL,
FOREIGN KEY (AuthorId) REFERENCES Author(AuthorId)
);
GO
CREATE TABLE Review(
ReviewId INT PRIMARY KEY IDENTITY(1,1),
UserId INT,
BookId INT,
ReviewText NVARCHAR(250),
DateOfReview DATE NOT NULL,
Stars INT NOT NULL,
FOREIGN KEY (UserId) REFERENCES Users(UserId),
FOREIGN KEY (BookId) REFERENCES Book(BookId)
);
GO
CREATE TABLE AudioTrack(
AudioTrackId INT PRIMARY KEY IDENTITY(1,1),
BookId INT,
NarratorId INT,
TrackLanguage NVARCHAR(50) NOT NULL,
FilePath NVARCHAR(100) NOT NULL,
UploadDate DATE NOT NULL,
Duration DECIMAL(10,2) NOT NULL,
FOREIGN KEY (BookId) REFERENCES Book(BookId),
FOREIGN KEY (NarratorId) REFERENCES Narrator(NarratorId)
);
GO
CREATE TABLE UserAudioTracks(
UserAudioTrackId INT PRIMARY KEY IDENTITY(1,1),
UserId INT,
AudioTrackId INT,
CurrentTime DECIMAL(10,2) NOT NULL,
SelectedOnDate DATE NOT NULL,
FOREIGN KEY (UserId) REFERENCES Users(UserId),
FOREIGN KEY (AudioTrackId) REFERENCES AudioTrack(AudioTrackId)
);
GO

--Inserting into tables 
INSERT INTO Author (Name, DateOfBirth, Nationality, ShortBiography, PhotoUrl)
VALUES
('Jane Doe', '1980-05-15', 'American', 'Author of mystery novels', '/photos/jane_doe.jpg'),
('John Smith', '1975-09-20', 'British', 'Bestselling author of fantasy books', '/photos/john_smith.jpg'),
('Mark Johnson', '1982-03-08', 'Canadian', 'Science fiction writer', '/photos/mark_johnson.jpg'),
('Anna Williams', '1990-12-18', 'Australian', 'Romance author with a passion for storytelling', '/photos/anna_williams.jpg'),
('Carlos Rodriguez', '1988-07-22', 'Mexican', 'Author of historical novels', '/photos/carlos_rodriguez.jpg'),
('Emily White', '1972-11-30', 'Irish', 'Award-winning author of literary fiction', '/photos/emily_white.jpg'),
('Michael Lee', '1985-06-14', 'Chinese', 'Thriller and suspense writer', '/photos/michael_lee.jpg'),
('Sophie Brown', '1995-02-25', 'French', 'Young adult fiction author', '/photos/sophie_brown.jpg'),
('Ahmed Khan', '1979-09-05', 'Indian', 'Author of thought-provoking philosophical works', '/photos/ahmed_khan.jpg'),
('Olivia Davis', '1987-04-12', 'Swedish', 'Poet and essayist', '/photos/olivia_davis.jpg');
GO
INSERT INTO Subscription (SubscriptionType, SubscriptionPlan, TimeInMonths, Price, MaxProfiles)
VALUES
('Basic', 'Monthly', 1, 12.49, 1),
('Basic', 'Yearly', 12, 124.99, 1),
('Family', 'Monthly', 1, 29.99, 5),
('Family', 'Yearly', 12, 299.99, 5);
GO
INSERT INTO Users (Name, Username, Email, Password, DateOfBirth, PhoneNumber)
VALUES
('Alice Johnson', 'alice123', 'alice@email.com', 'password123', '1990-03-10', '1234567890'),
('Bob Smith', 'bob789', 'bob@email.com', 'securepass', '1985-08-25', '9876543210'),
('Catherine Davis', 'cathy85', 'cathy@email.com', 'passCathy123', '1982-11-15', '5551234567'),
('Daniel White', 'danielW', 'daniel@email.com', 'danielPass456', '1995-06-30', '7890123456'),
('Eva Johnson', 'evaJ', 'eva@email.com', 'evaPassword789', '1988-04-22', '4567890133'),
('Frank Miller', 'frankM', 'frank@email.com', 'frankPass789', '1979-09-05', '3210987654'),
('Grace Robinson', 'graceR', 'grace@email.com', 'gracePass123', '1992-02-18', '2345678901'),
('Henry Brown', 'henryB', 'henry@email.com', 'henryPass456', '1987-07-12', '6789012345'),
('Isabella Lee', 'isabellaL', 'isabella@email.com', 'isabellaPass789', '1990-12-08', '8901234567'),
('Jack Wang', 'jackW', 'jack@email.com', 'jackPass123', '1984-05-25', '4567890123');
GO
INSERT INTO Users (Name, Username, Email, Password, DateOfBirth, PhoneNumber)
VALUES
('Goshkata', 'g1234', 'gog@email.com', 'password123', '1990-03-10', '1222567890'),
('Hriskata', 'h1234', 'hih@email.com', 'securepass', '1985-08-25', '9876643210');
GO
INSERT INTO Narrator (FirstName, LastName, Nationality, Bio, Gender)
VALUES
('Emily', 'Davis', 'Canadian', 'Experienced narrator with a soothing voice', 'Female'),
('David', 'Johnson', 'American', 'Known for narrating adventure stories', 'Male'),
('Sophie', 'Williams', 'British', 'Narrator specializing in romance novels', 'Female'),
('Carlos', 'Garcia', 'Mexican', 'Voice artist for historical and cultural audiobooks', 'Male'),
('Elena', 'Martinez', 'Spanish', 'Talented narrator with a passion for storytelling', 'Female'),
('Alex', 'Wilson', 'Australian', 'Narrator for science fiction and fantasy genres', 'Male'),
('Lily', 'Chen', 'Chinese', 'Voice artist known for thrillers and mysteries', 'Female'),
('Max', 'Andersson', 'Swedish', 'Narrator with a unique style for literary fiction', 'Male'),
('Aarav', 'Patel', 'Indian', 'Experienced voice for philosophical and spiritual audiobooks', 'Male'),
('Olivia', 'Larsson', 'Swedish', 'Poetry and essay narration specialist', 'Female');
GO

select * from Users
INSERT INTO UserSubscription (StartDate, EndDate, UserId, SubscriptionId)
VALUES
('2023-01-01', '2023-01-31', 1, 1),
('2023-02-01', '2024-02-01', 2, 2),
('2023-03-01', '2023-03-31', 3, 3),
('2023-04-01', '2023-04-30', 4, 4),
('2023-05-01', '2023-05-31', 5, 1),
('2023-06-01', '2023-06-30', 6, 1),
('2023-07-01', '2024-07-01', 7, 2),
('2023-08-01', '2024-08-01', 8, 2),
('2023-09-01', '2023-09-30', 9, 3),
('2023-10-01', '2024-10-01', 10, 4);
GO

INSERT INTO UserSubscription (StartDate, EndDate, UserId, SubscriptionId)
VALUES
('2023-01-01', '2023-01-31', 12, 4),
('2023-02-01', '2024-02-01', 13, 4);
GO

INSERT INTO Book (AuthorId, ISBN, Title, ReleaseDate, NumberOfPages, Category, Language, Description)
VALUES
(1, '9781234567890', 'Mystery of the Missing Key', '2022-05-20', 300, 'Mystery', 'English', 'A thrilling mystery novel'),
(2, '9780987654321', 'Realm of Fantasy', '2021-11-15', 500, 'Fantasy', 'English', 'An epic fantasy adventure'),
(3, '9789876543210', 'The Science Fiction Odyssey', '2023-02-10', 400, 'Science Fiction', 'English', 'Exploring the wonders of the universe'),
(4, '9780123456789', 'Love in Bloom', '2022-08-05', 250, 'Romance', 'English', 'A heartwarming tale of love and passion'),
(5, '9785678901234', 'Historical Tapestry', '2021-04-18', 350, 'Historical Fiction', 'English', 'Unraveling the threads of the past'),
(6, '9782345678901', 'Whispers of the Wind', '2023-01-30', 280, 'Poetry', 'English', 'Capturing the essence of nature in verse'),
(7, '9783456789012', 'In the Shadows', '2022-07-12', 320, 'Thriller', 'English', 'A gripping tale of suspense and intrigue'),
(8, '9784567890123', 'The Lost Generation', '2021-10-25', 420, 'Literary Fiction', 'English', 'Exploring the struggles of a generation'),
(9, '9787890123456', 'Philosophical Reflections', '2023-03-15', 200, 'Philosophy', 'English', 'Contemplating the mysteries of existence'),
(10, '9788901234567', 'Northern Lights', '2022-06-08', 300, 'Adventure', 'English', 'An exhilarating journey through the wilderness');
GO
INSERT INTO AudioTrack (BookId, NarratorId, TrackLanguage, FilePath, UploadDate, Duration)
VALUES
(1, 1, 'English', '/audio/mystery_track1.mp3', '2022-05-25', 120.50),
(1, 2, 'Spanish', '/audio/mystery_track2.mp3', '2022-05-26', 115.75),
(2, 3, 'English', '/audio/fantasy_track1.mp3', '2021-11-20', 180.75),
(2, 4, 'French', '/audio/fantasy_track2.mp3', '2021-11-22', 150.25),
(3, 5, 'English', '/audio/scifi_track1.mp3', '2023-02-10', 200.00),
(3, 6, 'German', '/audio/scifi_track2.mp3', '2023-02-12', 185.50),
(4, 7, 'English', '/audio/romance_track1.mp3', '2022-08-05', 90.25),
(4, 8, 'Italian', '/audio/romance_track2.mp3', '2022-08-07', 95.75),
(5, 9, 'English', '/audio/historical_track1.mp3', '2021-04-18', 130.00),
(5, 10, 'Russian', '/audio/historical_track2.mp3', '2021-04-20', 110.50);
GO
INSERT INTO Review (UserId, BookId, ReviewText, DateOfReview, Stars)
VALUES
(1, 7, 'Great story!', '2022-06-01', 5),
(1, 1, 'Great mystery story!', '2022-06-01', 5),
(2, 2, 'Captivating fantasy world!', '2022-01-20', 4),
(3, 3, 'Mind-blowing sci-fi adventure!', '2023-02-15', 5),
(4, 4, 'Heartfelt romance with well-developed characters.', '2022-08-10', 4),
(5, 5, 'Fascinating journey through historical events.', '2021-04-25', 4),
(6, 6, 'Beautifully written poetry collection.', '2023-01-31', 5),
(7, 7, 'Thrilling suspense and unexpected twists!', '2022-07-15', 4),
(8, 8, 'Deep exploration of human experiences.', '2021-11-01', 5),
(9, 9, 'Provocative and thought-provoking philosophy.', '2023-03-20', 4),
(10, 10, 'Exciting adventure in the wilderness!', '2022-06-15', 5),
(1, 10, 'Exciting book!', '2022-06-15', 5);
;
GO
INSERT INTO UserAudioTracks (UserId, AudioTrackId, CurrentTime, SelectedOnDate)
VALUES
(1, 1, 30.25, '2022-06-05'),
(2, 2, 45.50, '2022-01-25'),
(3, 3, 20.75, '2023-02-18'),
(4, 4, 15.00, '2022-08-12'),
(5, 5, 10.25, '2021-05-01'),
(6, 6, 5.50, '2023-02-28'),
(7, 7, 40.75, '2022-07-20'),
(8, 8, 25.00, '2021-11-10'),
(9, 9, 18.25, '2023-03-25'),
(10, 10, 33.50, '2022-06-25');
GO

--Stored Procedure
CREATE PROCEDURE GetBooksWithReviews
AS
BEGIN
    SELECT
        Book.Title,
        Book.ReleaseDate,
        Author.Name AS AuthorName,
        COUNT(Review.ReviewId) AS NumberOfReviews,
        AVG(Review.Stars) AS AverageRating
    FROM
        Book
    JOIN Author ON Book.AuthorId = Author.AuthorId
    LEFT JOIN Review ON Book.BookId = Review.BookId
    GROUP BY
        Book.Title, Book.ReleaseDate, Author.Name;
END;

EXEC GetBooksWithReviews;
GO

--end procedure 

SELECT * FROM BOOK;
SELECT * FROM AUDIOTRACK

--Function
CREATE FUNCTION CalculateTotalDuration (@bookId INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @totalDuration DECIMAL(10,2)

    SELECT @totalDuration = AVG(Duration)
    FROM AudioTrack
    WHERE BookId = @bookId;

    RETURN @totalDuration;
END;


DECLARE @bookId INT = 4;
DECLARE @totalDuration DECIMAL(10,2);

SET @totalDuration = dbo.CalculateTotalDuration(@bookId);

SELECT 'Total Duration for Book ' + CAST(@bookId AS NVARCHAR(10)) + ': ' + CAST(@totalDuration AS NVARCHAR(20)) + ' minutes' AS Result;

--end function

--Trigger
CREATE TRIGGER CheckBestReviewBook
ON Review
AFTER INSERT
AS
BEGIN
    DECLARE @BookId INT, @LastReviewStars INT, @MaxStars INT

    SELECT TOP 1 @BookId = r.BookId, @LastReviewStars = r.Stars
    FROM Review r
    ORDER BY r.ReviewId DESC;

    -- Check if the new review has the highest star rating for the book
    SELECT TOP 1 @MaxStars = Stars
    FROM Review
    WHERE BookId = @BookId
    ORDER BY Stars asc;

    -- Display a message if the new review is the best review
    IF @MaxStars < @LastReviewStars
    BEGIN
        PRINT 'Congratulations! This review is the best for the book.';
    END;
END;
--end trigger

INSERT INTO Review (UserId, BookId, ReviewText, DateOfReview, Stars)
VALUES
(1, 4, 'Super super cool story!', '2022-06-01', 5);
SELECT * FROM REVIEW ORDER BY ReviewId DESC;
Select * from review where BookId = 4 order by Stars asc


