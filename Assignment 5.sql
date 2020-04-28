/* *** 3.49 *** */
CREATE TABLE CUSTOMER(
CustomerNumber Int NOT NULL auto_increment,
CustomerLastName Char(25) NOT NULL,
CustomerFirstName Char(25) NOT NULL,
Phone Char(12) NOT NULL,
CONSTRAINT CUSTOMER_PK PRIMARY KEY(CustomerNumber)
);

CREATE TABLE COURSE(
CourseNumber Int NOT NULL auto_increment,
Course Char(50) NOT NULL,
CourseDate Date NOT NULL,
Fee Numeric (8,2) NOT NULL,
CONSTRAINT COURSE_PK PRIMARY KEY(CourseNumber)
);

CREATE TABLE ENROLLMENT(
CustomerNumber Int NOT NULL,
CourseNumber Int NOT NULL,
AmountPaid Numeric (8,2) NULL,
CONSTRAINT ENROLLMENT_PK 
	PRIMARY KEY (CustomerNumber, CourseNumber),
    CONSTRAINT ENROLL_CUST_FK FOREIGN KEY (CustomerNumber)
    REFERENCES CUSTOMER(CustomerNumber)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	CONSTRAINT ENROLL_COURSE_FK FOREIGN KEY (CourseNumber)
									REFERENCES COURSE(CourseNumber)
                                    ON UPDATE CASCADE
                                    ON DELETE CASCADE
);

/* *** 3.50 *** */
/*For Customer Table*/
INSERT INTO CUSTOMER VALUES('Johnson','Ariel','206-567-1234');
INSERT INTO CUSTOMER VALUES('Green','Robin','425-678-8765');
INSERT INTO CUSTOMER VALUES('Jackson','Charles','306-789-3456');
INSERT INTO CUSTOMER VALUES('Pearson','Jeffery','206-567-2345');
INSERT INTO CUSTOMER VALUES('Sears','Muguel','360-789-4567');
INSERT INTO CUSTOMER VALUES('Kyle','Leah','425-678-5678');
INSERT INTO CUSTOMER VALUES('Myers','Lynda','360-789-5678');

/* For Course Table */
INSERT INTO COURSE VALUES('Adv Pastels', '2015-10-01', '500.00');
INSERT INTO COURSE VALUES('Beg Oils', '2015-09-15', '350.00');
INSERT INTO COURSE VALUES('Int Pastels', '2015-03-15', '350.00');
INSERT INTO COURSE VALUES('Beg Oils','2015-10-15','350.00');
INSERT INTO COURSE VALUES('Adv Pastels','2015-11-15','50000');

/* For Enrollment Table */
INSERT INTO ENROLLMENT VALUES('1','1','250.00');
INSERT INTO ENROLLMENT VALUES('1','3','350.00');
INSERT INTO ENROLLMENT VALUES('2','2','350.00');
INSERT INTO ENROLLMENT VALUES('3','1','500.00');
INSERT INTO ENROLLMENT VALUES('4','1','500.00');
INSERT INTO ENROLLMENT VALUES('5','2','350.00');
INSERT INTO ENROLLMENT VALUES('6','5','250.00');
INSERT INTO ENROLLMENT VALUES('7','4','0.00');

/* *** 3.51 *** */
SELECT *
FROM COURSE
WHERE Course="Adv Pastels";

/* *** 3.52 *** */
SELECT CUSTOMER.CustomerNumber, CustomerLastName, CustomerFirstName, Phone, CourseNumber, AmountPaid
FROM CUSTOMER INNER JOIN ENROLLMENT ON CUSTOMER.CustomerNumber=
ENROLLMENT.CustomerNumber;

/* *** 3.53 *** */
SELECT COURSE.Course, COURSE.CourseDate, COURSE.Fee, CUSTOMER.CustomerLastName, CUSTOMER.CustomerFirstName,
CUSTOMER.Phone
FROM CUSTOMER.CUSTOMER, COURSE.COURSE, ENROLLMENT.ENROLLMENT
WHERE CUSTOMER.CustomerNumber = ENROLLMENT.CustomerNumber
AND COURSE.CourseNumber = ENROLLMENT.CourseNumber
AND COURSE.Course = 'Adv Pastels'
AND COURSE.CourseDate > '2019-10-01';

/* *** 3.54 *** */
SELECT Course, CourseDate, CustomerLastName, CustomerFirstName, Phone, Fee, AmountPaid
FROM CUSTOMER AS CU JOIN ENROLLMENT AS E
ON CU.CustomerNumber=E.CustomerNumber
JOIN COURSE AS CO
ON CO.CourseNumber=E.CourseNumber
WHERE CO.Course='Adv Pastels'
AND CO.CourseDate>'2019-10-01';







