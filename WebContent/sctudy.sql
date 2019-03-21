create database if not exists sctudy;
use sctudy;

create table studySpaces(
	locationID int(11) primary key AUTO_INCREMENT,
    Sname varchar(50),
	coordinates varchar(50),
	photoURL varchar(2083),
	outletAvailability varchar(50),
	seatingTypes varchar(50),
	lightSource varchar(50),
	noiseLevel int(3), 
	cafeAvailability boolean,
	hours varchar(10),
	indoorOutdoor boolean,
	overallRating int(3)
);

create table users(
	userID int(11) primary key AUTO_INCREMENT,
	username varchar(50),
	uPassword varchar(50)
);

create table reviews(
	reviewID int(11) primary key,
	userID int(11),
	locationID int(11),
	review varchar(200),
	reviewPhotoURL varchar(2083),
	overallRating int(3),
    FOREIGN KEY (userID) references users(userID)
);
create table reviews(
	reviewID int(11) primary key,
	userID int(11),
	locationID int(11),
	review varchar(200),
	reviewPhotoURL varchar(2083),
	overallRating int(3),
    FOREIGN KEY (userID) references users(userID)
);
