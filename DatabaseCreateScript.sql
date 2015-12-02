--
-- Table Creation Script
--
--
--

--
--Status Table
--

CREATE TABLE IF NOT EXISTS 'Status' (
  'StatusID' INT(11) NOT NULL AUTO_INCREMENT,
  'Status' VARCHAR(20) NOT NULL,
  PRIMARY KEY  ('StatusID')
) AUTO_INCREMENT=4 ;

--
-- AdmissionTypes Table
--

CREATE TABLE IF NOT EXISTS 'AdmissionTypes' (
  'AdmissionTypeID' INT(11) NOT NULL AUTO_INCREMENT,
  'Type' VARCHAR(50) NOT NULL,
  PRIMARY KEY  ('AdmissionTypeID')
)  AUTO_INCREMENT=7 ;

--
-- Image TABLE
--

CREATE TABLE IF NOT EXISTS 'Image' (
  'ImageID' INT(11) NOT NULL AUTO_INCREMENT,
  'Name' VARCHAR(100) ,
  'Description' VARCHAR(255) ,
  'Location' VARCHAR(255) NOT NULL DEFAULT 'images/',
  PRIMARY KEY  ('ImageID')
) AUTO_INCREMENT=86 ;

--
--Genre TABLE
--

CREATE TABLE IF NOT EXISTS 'Genre' (
   'GenreID' INT(11) NOT NULL AUTO_INCREMENT
   'Genre' VARCHAR(100),
   PRIMARY KEY ('GenreID')
)

--
--Composer TABLE
--

CREATE TABLE IF NOT EXISTS 'Composer' (
   'ComposerID' INT(11) NOT NULL AUTO_INCREMENT
   'FirstName' VARCHAR(100),
   'LastName' VARCHAR(100),
   'MiddleName' VARCHAR(100),
   'Alias' VARCHAR(100),
   PRIMARY KEY ('ComposerID')
)

--
--Publisher TABLE
--

CREATE TABLE IF NOT EXISTS 'Publisher' (
   'PublisherID' INT(11) NOT NULL AUTO_INCREMENT
   'Name' VARCHAR(100),
   'Address1' VARCHAR(100),
   'Address2' VARCHAR(100),
   'City' VARCHAR(100),
   'State' VARCHAR(2),
   'Website' VARCHAR(255),
   'Phone' VARCHAR(9),
   PRIMARY KEY ('PublisherID')
)

--
-- Section TABLE
--

CREATE TABLE IF NOT EXISTS 'Section' (
  'SectionID' INT(11) NOT NULL AUTO_INCREMENT,
  'Section' VARCHAR(50) NOT NULL,
  'ImageID' INT(11) ,
  PRIMARY KEY  ('SectionID'),
  FOREIGN KEY ('ImageID') REFERENCES 'Image'('ImageID')
) AUTO_INCREMENT=12 ;

--
-- EventTypes Table
--

CREATE TABLE IF NOT EXISTS 'EventTypes' (
  'EventTypesID' INT(11) NOT NULL DEFAULT AUTO_INCREMENT,
  'Description' VARCHAR(50) NOT NULL ,
  'ImageID' INT(11) ,
  PRIMARY KEY  ('EventTypesID'),
  FOREIGN KEY ('ImageID') REFERENCES 'Image'('ImageID')
)  AUTO_INCREMENT=7;

--
-- Position TABLE
--

CREATE TABLE IF NOT EXISTS 'Position' (
  'PositionID' INT(11) NOT NULL AUTO_INCREMENT,
  'SectionID' INT(11) NOT NULL,
  'Position' VARCHAR(50) NOT NULL,
  'InstrumentID' INT(11),
  PRIMARY KEY  ('PositionID'),
  FOREIGN KEY ('SectionID') REFERENCES 'Section'('SectionID'),
  FOREIGN KEY ('InstrumentID') REFERENCES 'Instruments'('InstrumentID')
) AUTO_INCREMENT=21;

--
-- Instruments
--

CREATE TABLE IF NOT EXISTS 'Instruments' (
   'InstrumentID' INT(11) NOT NULL AUTO_INCREMENT,
   'Instrument' VARCHAR(50) NOT NULL,
   PRIMARY KEY ('InstrumentID')
) AUTO_INCREMENT=3;

--
-- DressType TABLE
--

CREATE TABLE IF NOT EXISTS 'DressType' ( 
   'DressTypeID' INT(11) NOT NULL, AUTO_INCREMENT,
   'DressType' VARCHAR(50) NOT NULL,
   PRIMARY KEY ('DressTypeID')
) AUTO_INCREMENT=4;

--
-- Group TABLE
--

CREATE TABLE IF NOT EXISTS 'Group' (
   'GroupID' INT(11) NOT NULL, AUTO_INCREMENT,
   'Name' VARCHAR(50) NOT NULL,
   PRIMARY KEY ('GroupID')
)  AUTO_INCREMENT=5;

--
-- MemberType TABLE
--

CREATE TABLE IF NOT EXISTS 'MemberType' (
   'MemberTypeID' INT(11) NOT NULL AUTO_INCREMENT,
   'Type' VARCHAR(100) NOT NULL,
   PRIMARY KEY ('MemberTypeID')
) AUTO_INCREMENT=2;

--
-- Jobs TABLE
--

CREATE TABLE IF NOT EXISTS 'Jobs' (
   'JobsID' INT(11) NOT NULL, AUTO_INCREMENT,
   'Name' VARCHAR(100) NOT NULL,
   'Description' VARCHAR(255) ,
   'GroupID' INT(11) NOT NULL,
   PRIMARY KEY ('JobsID'),
   FOREIGN KEY ('GroupID') REFERENCES 'Group'('GroupID')
)  AUTO_INCREMENT=23;

--
-- MemberJobs TABLE
--

CREATE TABLE IF NOT EXISTS 'MemberJobs' (
   'MemberJobsID' INT(11) NOT NULL AUTO_INCREMENT,
   'MemberID' INT(11) NOT NULL,
   'JobID' INT(11) NOT NULL,
   PRIMARY KEY ('MemberJobsID'),
   FOREIGN KEY ('MemberID') REFERENCES Member('MemberID'),
   FOREIGN KEY ('JobID') REFERENCES 'Jobs'('JobID')
);
--
-- Menu TABLE
--

CREATE TABLE IF NOT EXISTS 'Menu' (
   'MenuID' INT(11) NOT NULL AUTO_INCREMENT,
   'ParentID' INT(11) NOT NULL,
   'Title' VARCHAR(100),
   'Location' VARCHAR(255),
   'Link' VARCHAR(100),
   PRIMARY KEY ('MenuID'),
   FOREIGN KEY ('ParentID') REFERENCES 'Menu'('MenuID'),
);

--
-- Permissions TABLE
--

CREATE TABLE IF NOT EXISTS 'Permissions' (
   'PermissionID' INT(11) NOT NULL AUTO_INCREMENT,
   'MenuID' INT(11) NOT NULL,
   'JobID' INT(11) NOT NULL,
   PRIMARY KEY ('PermissionID'),
   FOREIGN KEY ('MenuID') REFERENCES 'Menu'('MenuID'),
   FOREIGN KEY ('JobID') REFERENCES 'Jobs'('JobID')
);

--
-- AvailabilityRequest Table
--

CREATE TABLE IF NOT EXISTS 'AvailabilityRequest' (
   'RequestID' INT(11) NOT NULL AUTO_INCREMENT,
   'RequestorID' INT(11) NOT NULL,
   'CreateDate' TIMESTAMP DEFAULT 0,
   'ModifiedDate' TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
		ON UPDATE CURRENT_TIMESTAMP,
   'DateSent' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   'Title' VARCHAR(255) NULL,
   PRIMARY KEY ('RequestID'),
   FOREIGN KEY ('RequestorID') REFERENCES 'Member'('MemberID')
);

--
--RequestDates TABLE
--

CREATE TABLE IF NOT EXISTS 'RequestDates' (
   'RequestDatesID' INT(11) NOT NULL AUTO_INCREMENT,
   'RequestID' INT(11) NOT NULL,
   'Date' DATE,
   PRIMARY KEY ('RequestDatesID'),
   FOREIGN KEY ('RequestID') REFERENCES 'AvailabilityRequest'('RequestID')
);

--
-- RequestPeople TABLE
--

CREATE TABLE IF NOT EXISTS 'RequestPeople' (
   'RequestPeopleID' INT(11) NOT NULL AUTO_INCREMENT,
   'RequestID' INT(11) NOT NULL,
   'MemberID' INT(11) NOT NULL,
   PRIMARY KEY ('RequestedPeopleID'),
   FOREIGN KEY ('MemberID') REFERENCES 'Member'('MemberID'),
   FOREIGN KEY ('RequestID') REFERENCES 'AvailabilityRequest'('RequestID')
);

--
-- PersonAvailability TABLE
--

CREATE TABLE IF NOT EXISTS 'Availability' (
   'AvailabilityID' INT(11) NOT NULL AUTO_INCREMENT,
   'RequestID' INT(11) NOT NULL,
   'MemberID' INT(11) NOT NULL,
   'DateID' INT(11) NOT NULL,
   PRIMARY KEY ('AvailabilityID'),
   FOREIGN KEY ('RequestID') REFERENCES 'AvailabilityRequest'('RequestID'),
   FOREIGN KEY ('MemberID') REFERENCES 'Member'('MemberID'),
   FOREIGN KEY ('DateID') REFERENCES 'RequestDates'('DateID')
);

--
-- Venue TABLE
--

CREATE TABLE IF NOT EXISTS 'Venue' (
  'VenueID' INT(11) NOT NULL AUTO_INCREMENT,
  'VenueName' VARCHAR(50) NOT NULL,
  'Address1' VARCHAR(50) NOT NULL,
  'Address2' VARCHAR(50) ,
  'City' VARCHAR(50),
  'State' VARCHAR(2),
  'Zip' VARCHAR(5) NOT NULL,
  'Website' VARCHAR(255) ,
  'ImageID' INT(11),
  PRIMARY KEY  ('VenueID'),
  FOREIGN KEY ('ImageID') REFERENCES 'Image'('ImageID')
);

--
-- Member TABLE
--

CREATE TABLE IF NOT EXISTS 'Member' (
  'MemberID' INT(11) NOT NULL auto_increment,
  'LoginCount' INT(11),
  'LastLogin' DATETIME,
  'Username' VARCHAR(20),
  'Password' VARCHAR(16),
  'FirstName' VARCHAR(50),
  'LastName' VARCHAR(50),
  'MiddleName' VARCHAR(50),
  'StatusID' INT(11) NOT NULL,
  'PositionID' INT(11),
  'InternalEmail' VARCHAR(100),
  'ExternalEmail' VARCHAR(100),
  'Address1' VARCHAR(50),
  'Address2' VARCHAR(50),
  'City' VARCHAR(24),
  'State' char(2),
  'Zip' VARCHAR(5),
  'HomePhone' VARCHAR(16),
  'MobilePhone' VARCHAR(16),
  'Birthday' DateTime,
  'ImageID' INT(11),
  'Bio' BLOB,
  'HighlightCount' INT(11),
  'HighlightDate' DATETIME,
  'MemberTypeID' INT(11) NOT NULL,
  PRIMARY KEY  ('MemberID'),
  FOREIGN KEY ('MemberTypeID') REFERENCES 'Member'('MemberTypeID'),
  FOREIGN KEY ('StatusID') REFERENCES 'Status'('StatusID'),
  FOREIGN KEY ('PositionID') REFERENCES 'Position'('PositionID'),
  FOREIGN KEY ('ImageID') REFERENCES 'Image'('ImageID'),
) AUTO_INCREMENT=120;

--
-- Event TABLE
--

CREATE TABLE IF NOT EXISTS 'Event'(
  'EventID' INT(11) NOT NULL AUTO_INCREMENT,
  'EventDate' DATETIME,
  'EventTypeID' INT(11) NOT NULL ,
  'ImageID' INT(11),
  'Title' VARCHAR(100) NOT NULL,
  'Description' VARCHAR(1000),
  'StartTime' TIME NOT NULL DEFAULT '19:30:00',
  'StopTime' TIME NOT NULL DEFAULT '19:30:00',
  'CallTime' TIME DEFAULT '18:30:00',
  'Website' VARCHAR(100),
  'Website' VARCHAR(100),
  'VenueID' INT(11) NOT NULL DEFAULT '1',
  'DressTypeID' INT(11),
  'Show' TinyINT(1) NOT NULL DEFAULT '1' COMMENT 'This field determines if this event should show on the homepage',
  PRIMARY KEY  ('event_id'),
  FOREIGN KEY ('ImageID') REFERENCES 'Image'('ImageID'),
  FOREIGN KEY ('DressTypeID') REFERENCES 'DressType'('DressTypeID'),
  FOREIGN KEY ('EventTypeID') REFERENCES 'EventType'('EventTypeID')
);

--
-- Admission TABLE
--

CREATE TABLE IF NOT EXISTS 'Admission' (
  'AdmissionID' INT(11) NOT NULL,
  'AdmissionTypeID' INT(11) NOT NULL,
  'EventID' INT(11) NOT NULL,
  'Cost' DOUBLE,
  'Comments' VARCHAR(255),
  'Age' TinyINT(20),
  PRIMARY KEY  ('admission_id'),
  FOREIGN KEY ('EventID') REFERENCES 'Event'('EventID'),
  FOREIGN KEY ('AdmissionTypeID') REFERENCES 'AdmissionType'('AdmissionTypeID')
);

--
-- SoloistEvent TABLE
--

CREATE TABLE IF NOT EXISTS 'SoloistEvent' (
  'SoloistEventID' INT(11) NOT NULL auto_increment,
  'EventID' INT(11) NOT NULL,
  'MemberID' INT(11) NOT NULL,
  PRIMARY KEY  ('SoloistEventID'),
  FOREIGN KEY ('EventID') REFERENCES 'Event'('EventID'),
  FOREIGN KEY ('MemberID') REFERENCES 'Member'('MemberID')
 )
 
 --
 -- Library TABLE
 --
 
 CREATE TABLE IF NOT EXISTS 'Library' (
  'LibraryID' INT(11) NOT NULL,
  'Title' VARCHAR(100) NOT NULL,
  'SubTitle' VARCHAR(100),
  'ComposerID' INT(11),
  'ArrangerID' INT(11),
  'PublisherID' INT(11),
  'Score' VARCHAR(20),
  'GenreID' VARCHAR(30),
  'Originals' TinyINT(1),
  'Copies' TinyINT(1),
  'MissingParts' VARCHAR(255),
  'Notes' VARCHAR(255),
  'DateChecked' DATETIME,
  'CheckedByID' INT(11),
  'LastPerformed' DATETIME,
  'PerformedCount' INT(5)
  PRIMARY KEY ('LibraryID'),
  FOREIGN KEY ('ComposerID') REFERENCES 'Composer'('ComposerID'),
  FOREIGN KEY ('ArrangerID') REFERENCES 'Composer'('ComposerID'),
  FOREIGN KEY ('PublisherID') REFERENCES 'Publisher'('PublisherID'),
  FOREIGN KEY ('GenreID') REFERENCES 'Genre'('GenreID'),
  FOREIGN KEY ('CheckedByID') REFERENCES 'Member'('MemberID'),
);

--
-- Program TABLE
--

CREATE TABLE IF NOT EXISTS 'Program' (
   'ProgramID' INT(11) NOT NULL AUTO_INCREMENT,
   'EventID' INT(11),
   'LibraryID' INT(11),
   'Set' TinyINT(2),
   'Sequence' TinyINT(2),
  PRIMARY KEY ('ProgramID'),
  FOREIGN KEY ('EventID') REFERENCES 'Event'('EventID'),
  FOREIGN KEY ('LibraryID') REFERENCES 'Library'('LibraryID'),   
);
