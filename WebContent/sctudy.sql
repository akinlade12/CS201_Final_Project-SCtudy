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
	phoneNumber varchar(20),
	address varchar(150),
	buildingCode varchar(12),
    rating double,
    numRatings int(10)
);

insert into studySpaces (sName, photoURL, latitude, longitude, seatingTypes, lightSource, noiseLevel, cafeAvailability, 
	hourOpen, hourClose, indoorOutdoor, outletAvailability, phoneNumber, address, buildingCode, rating, numRatings) 
    values ('Leavey Library', 'https://s3-media3.fl.yelpcdn.com/bphoto/0Zn3_vsQhh_YloIU-O9mfQ/l.jpg', 34.022100, -118.282968, 
			'Chair', 'LED', 2, true, '12am', '12am', false, 'Abundant', '(213) 740-4350', '651 W 35th St, Los Angeles, CA 90089',  '1234', 0, 0),
        ('Doheny Memorial Library', 'http://kckarchitects.com/wp-content/uploads/2015/02/doheny-memorial-library-uscb.jpg', 34.020392, -118.283726, 
			'Couch', 'Combo', 1, true, '8am', '10pm', false, 'Available', '(213) 740-2531', '3550 Trousdale Pkwy, Los Angeles, CA 90089', '3456',0, 0),
		('VKC Library', 'http://viterbivoices.usc.edu/wp-content/uploads/2014/11/VKC.png', 34.021488, -118.283993, 
			'Couch', 'Windows', 1, false, '8am', '10pm', false, 'Available', '(213) 740-1769', '3518 Trousdale Pkwy, Los Angeles, CA 90089', '2345', 0, 0),
		('New Annenberg', 'https://upload.wikimedia.org/wikipedia/commons/8/87/Wallis_Annenberg_Hall.jpeg', 34.022376, -118.286068, 
			'Couch', 'Windows', 3, true, '8am', '10pm', false, 'Available', '(213) 740-6180', '3630 Watt Way Suite 402, Los Angeles, CA 90089', '5678', 0, 0),
		('Cafe 84 Starbucks', 'https://media.thetab.com/blogs.dir/187/files/2017/10/d2cd21496cae45df718b0eb118c463e61508198802941.jpeg', 34.024905, -118.288049, 
			'Chair', 'Windows', 3, true, '12am', '12am', false, 'Sparse', '(213) 740-9556', '1025 WEST 34TH ST KINGS, HALL 1ST FLOOR, Los Angeles, CA 90089', '6789',0,0),
		('Law School Library', 'http://www.top-law-schools.com/uploads/images/medium/usc2.jpg', 34.019038, -118.284491, 
			'Chair', 'Windows', 2, true, '7:30am', '11pm', false, 'Available', '(213) 740-6482', '699 Exposition Blvd, Los Angeles, CA 90089', '9876',0,0),
		('Gaughan & Tiberti Library', 'https://www.marshall.usc.edu/sites/default/files/styles/1440x400/public/2017-03/library_hero-gaughan-tiberti-library.jpg?itok=gCJ-V6EB', 34.018871, -118.282499, 
			'Couch', 'Windows', 2, true, '7:30am', '11pm', false, 'Abundant', '(213) 740-8520', '610 Childs Way, Los Angeles, CA 90089', '5432',0,0),
		('Verna and Peter Dauterive Hall', 'https://www.enr.com/ext/resources/Issues/Web/National/November/2-Interior-Atrium.jpg', 34.019292, -118.283869, 
			'Couch', 'Windows', 2, true, '8am', '8pm', false, 'Abundant', '(213) 821-4577', '645 Exposition Blvd, Los Angeles, CA 90089', '6543',0,0),
		('SCA Balconies', 'https://static1.squarespace.com/static/53922b3ae4b0bc5c292e9b2c/t/53c2c31ae4b02bad42343e6b/1405272892006/14620.jpg', 34.023677, -118.287171, 
			'Couch', 'Windows', 2, true, '8am', '8pm', true, 'Abundant', '(213) 740-2311', '900 W 34th St, Los Angeles, CA 90007', '3214',0,0),
		('Cafe Dulce', 'https://news.usc.edu/files/2018/08/08_DSCF4289.png', 34.025688, -118.285292, 
			'Couch', 'Windows', 2, true, '7am', '10pm', false, 'Sparse', '(213) 536-5609', '3096 McClintock Ave Ste 1420, Los Angeles, CA 90007', '6782',0,0),
		('BBCM', 'https://static1.squarespace.com/static/5639b8b4e4b0938162bc271c/5adbb1f288251bc8641701ce/5adbb266f950b7b16a856f15/1524350193721/IMG_0413.jpeg?format=1000w', 34.024377, -118.284471, 
			'Couch', 'Windows', 2, true, '8am', '9pm', false, 'Abundant', '(310) 360-6900', '8653 Sunset Blvd, West Hollywood, CA 90069', '5432',0,0),
		('Engineering Quad', 'http://viterbivoices.usc.edu/wp-content/uploads/2013/11/equad1.jpg', 34.020651, -118.288813, 
			'Couch', 'Windows', 2, false, '12am', '12pm', true, 'Sparse', '(213) 740-2311', '3650 McClintock Ave, Los Angeles, CA 90089', '3463',0,0),
		('USC Village Tables', 'https://www.starrez.com/wp-content/uploads/University-Village-USC-Plaza-Area.jpg', 34.025567, -118.285203, 
			'Couch', 'Windows', 2, true, '12am', '12pm', true, 'Sparse', '213) 740-2311', '3301 S Hoover St, Los Angeles, CA 90007', '5234',0,0);

create table users(
	userID int(11) primary key AUTO_INCREMENT,
	username varchar(50),
	uPassword varchar(50)
);

insert into users (username, uPassword) 
values ('jessica', 'jessica'), ('anna', 'anna'), ('ashwin', 'ashwin'), ('toyosi', 'toyosi');


create table reviews(
	reviewID int(11) primary key AUTO_INCREMENT,
	userID int(11),
	locationID int(11),
	review varchar(200),
    rating int(3),
    FOREIGN KEY (userID) references users(userID)
);
insert into reviews (userID, locationID, review, rating)
values (1,1,'Great because it is 24/7, but it does not have the best lighting and is often kind of 
	sad', 4),
    (2,2,'Does not have a ton of outlets so I can never stay too long. Great coffee
	shop though', 4),
	(2,7,'Nice chairs but infested with snakes', 2),
	(3,7,'I love the smell of sushi in the air', 5),
	(3,7,'The new hours are great!', 5),
	(1,9,'Secret spot, great for sunny days', 5),
	(1,1,'Saw my first Leavey sunset the other day!', 5),
	(2,2,'Looks like Hogwarts in here!', 5),
	(3,3,'Great when it rains!', 5),
	(4,4,'Comfiest seats at USC', 5),
	(1,5,'Great late night coffee fix!', 5),
	(2,6,'Study for my LSAT here every day!', 5),
	(3,7,'Such a nice building!', 5),
	(4,8,'Best environment for studying, hands down!', 5),
	(1,9,'Reminds me of Romeo and Juliet!', 5),
	(2,10,'Highkey best coffee at USC!', 5),
	(3,11,'Bad wifi!', 2),
	(3,12,'Outdoors, but you can smell the engineers!', 1),
	(3,13,'Great on a sunny day!', 3);

create table favorites(
	favoriteID int(11) primary key AUTO_INCREMENT,
    userID int(11),
    locationID int(11),
    FOREIGN KEY (userID) references users(userID),
    FOREIGN KEY (locationID) references studySpaces(locationID)
);
insert into favorites (userID, locationID)
values (1, 1), (1,3), (2, 1), (2, 2), (3, 1), (3,2),
	(1, 9), (2,10), (3, 12), (4, 8), (1, 7), (2,5),
	(1, 8), (2,6), (3, 6), (4, 6), (1, 9), (2,4);
