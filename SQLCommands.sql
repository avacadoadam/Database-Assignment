CREATE DATABASE IF NOT EXISTS Barbers;

USE Barbers;

CREATE TABLE Barbershop (
  id      INT AUTO_INCREMENT,
  address TEXT         NOT NULL,
  name    VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (id)
)
  ENGINE = InnoDB;

CREATE TABLE Barber (
  id           INT AUTO_INCREMENT,
  fname        VARCHAR(50)  NOT NULL,
  lname        VARCHAR(50)  NOT NULL,
  email        VARCHAR(255) NOT NULL UNIQUE,
  passwd       VARCHAR(255) NOT NULL,
  phone_number VARCHAR(10),
  BarbershopID INT,
  approved     BIT DEFAULT 0,
  PRIMARY KEY (id),
  FOREIGN KEY (BarbershopID) REFERENCES Barbershop (id)
    ON DELETE SET NULL,
  CHECK (email REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,63}$')

)
  ENGINE = InnoDB;

CREATE TABLE Customer (
  id           INT AUTO_INCREMENT,
  fname        VARCHAR(50)  NOT NULL,
  lname        VARCHAR(50)  NOT NULL,
  email        VARCHAR(255) NOT NULL UNIQUE,
  passwd       VARCHAR(255) NOT NULL,
  phone_number VARCHAR(10),
  PRIMARY KEY (id),
  CHECK (email REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,63}$')
)
  ENGINE = InnoDB;

CREATE TABLE Customer_Complaints (
  id         INT AUTO_INCREMENT,
  customerID INT,
  complaint  TEXT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (customerID) REFERENCES Customer (id)
    ON DELETE CASCADE
)
  ENGINE = InnoDB;

CREATE TABLE Barber_Complaints (
  id        INT AUTO_INCREMENT,
  barberID  INT,
  complaint TEXT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (barberID) REFERENCES Barber (id)
    ON DELETE CASCADE
)
  ENGINE = InnoDB;

CREATE TABLE Customer_Rating (
  id         INT AUTO_INCREMENT,
  customerID INT UNIQUE,
  rating     INT(2),
  PRIMARY KEY (id),
  FOREIGN KEY (customerID) REFERENCES Customer (id)
    ON DELETE CASCADE,
  CHECK (rating > 0 && rating < 10)
)
  ENGINE = InnoDB;

CREATE TABLE Barber_Rating (
  id       INT AUTO_INCREMENT,
  barberID INT UNIQUE,
  rating   INT(2),
  FOREIGN KEY (barberID) REFERENCES Barber (id)
    ON DELETE CASCADE,
  PRIMARY KEY (id),
  CHECK (rating > 0 && rating < 10)
)
  ENGINE = InnoDB;

# Ensure time is between 9am and 6pm
# uSING THE 25 HOUR clock
CREATE TABLE Appointments (
  id                 INT  AUTO_INCREMENT,
  barberID           INT  NOT NULL,
  customerID         INT  NOT NULL,
  barbershopID       INT  NOT NULL,
  date               DATE NOT NULL,
  time               TIME NOT NULL,
  appointment_length TIME DEFAULT '00:30:00', #30 minutes
  PRIMARY KEY (id),
  FOREIGN KEY (barberID) REFERENCES Barber (id)
    ON DELETE CASCADE,
  FOREIGN KEY (customerID) REFERENCES Customer (id)
    ON DELETE CASCADE,
  FOREIGN KEY (barbershopID) REFERENCES Barbershop (id)
    ON DELETE CASCADE,
  CHECK (date < CURRENT_DATE()),
  CHECK (HOUR(time) BETWEEN 8 AND 18)

)
  ENGINE = InnoDB;

CREATE TABLE Admin (
  id     INT AUTO_INCREMENT,
  fname  VARCHAR(20)  NOT NULL,
  lname  VARCHAR(20)  NOT NULL,
  passwd VARCHAR(255) NOT NULL,
  email  VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  CHECK (email REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,63}$')
)
  ENGINE = InnoDB;

# Insert
# Admin
INSERT INTO `admin` (`id`, `fname`, `lname`, `passwd`, `email`)
VALUES ('1', 'Adam', 'Sever', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A', 'admin@barber.com');
# Barber
INSERT INTO `barber` (`id`, `BarbershopID`, `fname`, `lname`, `email`, `passwd`,`approved`) VALUES
  ('1', NULL, 'jason', 'cahill', 'jasonChaill@gmail.com',
   '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A', b'0');
INSERT INTO `barber` (`BarbershopID`, `fname`, `lname`, `email`, `passwd`, `approved`) VALUES
  (NULL, 'bill', 'higgins', 'bill@gmail.com', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A',
   b'0');
INSERT INTO `barber` (`BarbershopID`, `fname`, `lname`, `email`, `passwd`, `approved`) VALUES
  (NULL, 'Andrew', 'glennen', 'Andrew@gmail.com', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A',
  b'0');
INSERT INTO `barber` (`BarbershopID`, `fname`, `lname`, `email`, `passwd`, `approved`) VALUES
  (NULL, 'micheal', 'stanic', 'micheal@gmail.com', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A',
   b'0');
# Customers
INSERT INTO `customer` (`id`, `fname`, `lname`, `passwd`, `email`, `phone_number`) VALUES
  ('1', 'Giovanni', 'Chambers', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A', 'mwitte@mac.com',
   NULL);
INSERT INTO `customer` (`fname`, `lname`, `passwd`, `email`, `phone_number`) VALUES
  ('Julius ', 'Holmes', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A', 'elflord@outlook.com',
   NULL);
INSERT INTO `customer` (`fname`, `lname`, `passwd`, `email`, `phone_number`) VALUES
  ('Lacey-Mai ', 'Bailey', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A', 'bjornk@me.com',
   NULL);
INSERT INTO `customer` (`fname`, `lname`, `passwd`, `email`, `phone_number`) VALUES
  ('Dylon ', 'Mcghee', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A', 'keiji@live.com',
   NULL);
#BarberShops
INSERT INTO `barbershop` (`id`, `address`, `name`) VALUES
  ('1', 'Main st Goleen Skibbereen', 'BarberShop1');
INSERT INTO `barbershop` (`address`, `name`) VALUES
  ('Main st Buttevant', 'BarberShop2');
INSERT INTO `barbershop` (`address`, `name`) VALUES
  ('34A Hillview', 'BarberShop3');
#Appointments
INSERT INTO `appointments` (`id`, `barberID`, `customerID`, `barbershopID`, `date`, `time`, `appointment_length`)
VALUES ('1', '2', '2', '1', '2018-10-20', '05:00:00', '00:30:00');

