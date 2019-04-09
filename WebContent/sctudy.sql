drop database if exists sctudy;
create database if not exists sctudy;
use sctudy;

create table studySpaces(
	locationID int(11) primary key AUTO_INCREMENT,
    sName varchar(50),
	photoURL varchar(2083),
	latitude double,
	longitude double,
	seatingTypes varchar(50),
	lightSource varchar(50),
	noiseLevel int(3), 
	cafeAvailability boolean,
	hourOpen varchar(10),
	hourClose varchar(10),
	indoorOutdoor boolean, -- true means outdoor, false means indoor
    outletAvailability varchar(50),
	overallRating double,
    numberRatings double
);

insert into studySpaces (sName, photoURL, latitude, longitude, seatingTypes, lightSource, noiseLevel, cafeAvailability, 
	hourOpen, hourClose, indoorOutdoor, outletAvailability, overallRating, numberRatings) 
    values ('Leavey Library', 'https://s3-media3.fl.yelpcdn.com/bphoto/0Zn3_vsQhh_YloIU-O9mfQ/l.jpg', 34.022100, -118.282968, 
			'Chair', 'LED', 2, true, '12am', '12am', false, 'Abundant', 5, 1),
        ('Doheny Memorial Library', 'http://kckarchitects.com/wp-content/uploads/2015/02/doheny-memorial-library-uscb.jpg', 34.020392, -118.283726, 
			'Couch', 'Combo', 1, true, '8am', '10pm', false, 'Available', 5, 1),
		('VKC Library', 'http://viterbivoices.usc.edu/wp-content/uploads/2014/11/VKC.png', 34.021488, -118.283993, 
			'Couch', 'Windows', 1, true, '8am', '10pm', false, 'Available', 5, 1);

create table users(
	userID int(11) primary key AUTO_INCREMENT,
	username varchar(50),
	uPassword varchar(50)
);

create table reviews(
	reviewID int(11) primary key AUTO_INCREMENT,
	userID int(11),
	locationID int(11),
	review varchar(200),
	reviewPhotoURL varchar(2083),
	overallRating int(3),
    FOREIGN KEY (userID) references users(userID)
);

create table favorites(
	favoriteID int(11) primary key AUTO_INCREMENT,
    userID int(11),
    locationID int(11),
    FOREIGN KEY (userID) references users(userID),
    FOREIGN KEY (locationID) references studySpaces(locationID)
);
