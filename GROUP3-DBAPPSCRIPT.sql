-- -----------------------------------------------------
-- Schema dining_db ()
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS dining_db;
CREATE SCHEMA IF NOT EXISTS dining_db;
USE dining_db;

--

DROP TABLE IF EXISTS staff_position;
CREATE TABLE IF NOT EXISTS staff_position (
  position	    	VARCHAR(45) NOT NULL,
  PRIMARY KEY		(position)
);

--

DROP TABLE IF EXISTS staff;
CREATE TABLE IF NOT EXISTS staff (
  staff_id			INT NOT NULL,
  lastname			VARCHAR(45) NOT NULL,
  middlename		VARCHAR(45) NOT NULL,
  firstname			VARCHAR(45) NOT NULL,
  mobile_no			VARCHAR(45) NOT NULL,
  email_add			VARCHAR(45) NOT NULL,
  salary			FLOAT NOT NULL,
  position			VARCHAR(45) NOT NULL,
  PRIMARY KEY		(staff_id),
  INDEX         	(position ASC),
  FOREIGN KEY		(position)
	REFERENCES		staff_position(position)
);

--

DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer (
  customer_id	INT NOT NULL,
  PRIMARY KEY	(customer_id)
);

--
DROP TABLE IF EXISTS order_transaction;
CREATE TABLE IF NOT EXISTS order_transaction (
    transaction_id  INT  NOT NULL,
    customer_id    	INT  NOT NULL,
    order_status   	ENUM('Pending','Complete') NOT NULL,
    PRIMARY KEY     (transaction_id),
    INDEX          	(customer_id ASC),
    FOREIGN KEY     (customer_id)
      REFERENCES    customer(customer_id)
);

DROP TABLE IF EXISTS payment;
CREATE TABLE IF NOT EXISTS payment(
    transaction_id          INT NOT NULL,
    totalDue                FLOAT NOT NULL,
    cash                   	FLOAT NOT NULL,
    amount_change    		FLOAT NOT NULL,
    authorizing_employee_id INT  NOT NULL,
    PRIMARY KEY            	(transaction_id),
    INDEX                   (transaction_id ASC),
    INDEX                  	(authorizing_employee_id ASC),
    FOREIGN KEY             (authorizing_employee_id)
        REFERENCES          staff(staff_id),
    FOREIGN KEY             (transaction_id)
        REFERENCES          order_transaction(transaction_id)
);

DROP TABLE IF EXISTS meal;
CREATE TABLE IF NOT EXISTS meal (
  meal_id			INT  NOT NULL,
  meal_name			VARCHAR(45) NOT NULL,
  meal_category		VARCHAR(45) NOT NULL,
  meal_price		FLOAT  NOT NULL,
  meal_description	VARCHAR(100)  NOT NULL,
  meal_type			ENUM('Ala carte', 'Combo') NOT NULL,
  PRIMARY KEY		(meal_id)
);

DROP TABLE IF EXISTS delete_meal;
CREATE TABLE IF NOT EXISTS delete_meal(
	meal_id 		INT NOT NULL, 
	INDEX			(meal_id),
    PRIMARY KEY		(meal_id),
    FOREIGN KEY		(meal_id)
		REFERENCES 	meal(meal_id)
);

DROP TABLE IF EXISTS transaction_meal;
CREATE TABLE IF NOT EXISTS transaction_meal(
    transaction_meal_id    INT NOT NULL,
    transaction_id         INT NOT NULL,
    meal_id                INT NOT NULL,
    quantity               INT NOT NULL,
    PRIMARY KEY            (transaction_meal_id),
    INDEX                  (transaction_id ASC),
    INDEX                  (meal_id ASC),
    FOREIGN KEY            (transaction_id)
        REFERENCES         order_transaction(transaction_id),
    FOREIGN KEY            (meal_id)
        REFERENCES         meal(meal_id)
);

DROP TABLE IF EXISTS ingredient;
CREATE TABLE IF NOT EXISTS ingredient (
  ingredient_id				INT        		NOT NULL,
  ingredient_name			VARCHAR(45) 	NOT NULL,
  ingredient_description	VARCHAR(45) 	NOT NULL,
  quantity					INT         	NOT NULL,
  PRIMARY KEY				(ingredient_id)
);

DROP TABLE IF EXISTS meal_ingredient;
CREATE TABLE IF NOT EXISTS meal_ingredient (
    meal_ingredient_id  INT NOT NULL,
    ingredient_id      	INT NOT NULL,
    meal_id             INT NOT NULL,
    quantityUsed 		INT NOT NULL,
    PRIMARY KEY         (meal_ingredient_id),
    INDEX               (ingredient_id ASC),
    INDEX               (meal_id ASC),
    FOREIGN KEY         (ingredient_id)
        REFERENCES      ingredient(ingredient_id),
    FOREIGN KEY         (meal_id)
        REFERENCES      meal(meal_id)
);

DROP TABLE IF EXISTS order_history;
CREATE TABLE IF NOT EXISTS order_history (
  order_history_id		INT	NOT NULL,
  order_rating			FLOAT NOT NULL,
  order_satisfaction	VARCHAR(45) NOT NULL,
  totalPrice			FLOAT NOT NULL,
  date_ordered          DATETIME NOT NULL,
  order_transaction_id 	INT NOT NULL,
  PRIMARY KEY		    (order_history_id),
  INDEX                 (order_transaction_id ASC),
  FOREIGN KEY		    (order_transaction_id)
	REFERENCES		    order_transaction(transaction_id)
);

DROP TABLE IF EXISTS ingredient_deduction;
CREATE TABLE IF NOT EXISTS ingredient_deduction (
    ingredient_deduction_id 	INT NOT NULL,
    order_history_id 			INT NOT NULL,
    ingredient_id          		INT NOT NULL,
    PRIMARY KEY            		(ingredient_deduction_id),
    INDEX                   	(order_history_id ASC),
    INDEX                   	(ingredient_id ASC),
    FOREIGN KEY             	(ingredient_id)
        REFERENCES          	ingredient(ingredient_id),
	FOREIGN KEY             	(order_history_id)
        REFERENCES          	order_history(order_history_id)
);


-- Inserting values to customer
INSERT INTO customer (customer_id) 
VALUES 	(1001),
		(1002),
		(1003),
		(1004);

-- Inserting values to order_transaction
INSERT INTO order_transaction 
 VALUES 	(2001, 1001, 'Complete'),
			(2002, 1002, 'Complete'),
			(2003, 1003, 'Complete'),
			(2004, 1004, 'Complete');
                    
-- Inserting values to staff_position
INSERT INTO staff_position
    VALUES  ('Cashier'),
			('Cook'),
			('Server'),
			('Manager');

-- Inserting values to staff
INSERT INTO staff
    VALUES  (3001, 'Santos', 'J.', 'Juan', "639011223344", 'juan.santos@email.com', 15000, 'Cashier'),
			(3002, 'Cruz', 'S.', 'Maria', "639123456789", 'maria.cruz@email.com', 17000, 'Cook'),
			(3003, 'Reyes', 'R.', 'Antonio', "639234567890", 'antonio.reyes@email.com', 15000, 'Server'),
			(3004, 'Lim', 'L.', 'Lisa', "639345678901", 'lisa.lim@email.com', 15000, 'Server'),
			(3005, 'Tan', 'T.', 'Joaquin', "639456789012", 'joaquin.tan@email.com', 17000, 'Manager');
			
-- Inserting values to payment
INSERT INTO payment 
	VALUES	(2001, 120, 150, 30, 3001),
			(2002, 250, 250, 0, 3001),
			(2003, 130, 150, 20, 3001),
			(2004, 280, 500, 220, 3001);


-- Inserting values to meal
INSERT INTO meal
    VALUES  (6001, 'Chickenjoy', 'Chickenjoy', 80.0, 'Crispy and savory fried chicken that''s a true delight.', 'Ala carte'),
			(6002, 'Yumburger', 'Burgers', 70.0, 'A tasty and satisfying burger packed with deliciousness.', 'Ala carte'),
			(6003, 'Burger Steak', 'Burger Steak', 60.0, 'A hearty meal featuring juicy burger patties in savory mushroom gravy.', 'Ala carte'),
			(6004, 'Spaghetti', 'Spaghetti', 60.0, 'Sweet and savory pasta in a delightful Filipino-style sauce.', 'Ala carte'),
			(6005, 'Fries', 'Sides', 50.0, 'Golden and crispy potato fries, the perfect side dish.', 'Ala carte'),
			(6006, '1-pc. Chickenjoy w/ Jolly Spaghetti', 'Chickenjoy', 130.0, 'A perfect duo of crispy fried chicken and sweet spaghetti.', 'Combo'),
			(6007, '1-pc. Chickenjoy w/ Burger Steak', 'Chickenjoy', 130.0, 'A satisfying combo of fried chicken and burger steak.', 'Combo'),
			(6008, 'Yumburger, Jolly Spaghetti, & Fries', 'Burgers', 140.0, 'A trio of flavors with a delicious burger, sweet spaghetti, and golden fries.', 'Combo'),
			(6009, '1-pc. Burger Steak w/Fries', 'Burger Steak', 130.0, 'A hearty meal featuring burger steak and crispy fries.', 'Combo'),
			(6010, 'Jolly Spaghetti w/ Burger Steak', 'Spaghetti', 110.0, 'A delightful pairing of sweet spaghetti and savory burger steak.', 'Combo');

-- Inserting values to transaction_meal
INSERT INTO transaction_meal
    VALUES  (4001, 2001, 6002, 1),
			(4002, 2001, 6005, 1),
			(4003, 2002, 6004, 2),
			(4004, 2002, 6006, 1),
			(4005, 2003, 6006, 1),
			(4006, 2004, 6002, 1),
			(4007, 2004, 6004, 1),
			(4008, 2004, 6005, 3);


-- Inserting values to ingredient
INSERT INTO ingredient
VALUES  (8001, 'Rice', '1 pack', 700),
		(8002, 'Chicken drumpstick', '1 piece', 300),
		(8003, 'Burger patty', '1 piece', 250),
		(8004, 'Gravy', '5 tbps', 250),
		(8005, 'Sliced Mushroom', '5 ounces', 250),
		(8006, 'Spaghetti noodles', '500g', 250),
		(8007, 'Banana Ketchup', '1/2 cup', 250),
		(8008, 'Tomato Sauce', '1/2 cup', 250),
		(8009, 'Shredded Cheese', '1/2 Cup', 250),
		(8010, 'Hotdog', '1 piece', 250),
		(8011, 'Sliced Cheese', '1 piece', 100),
		(8012, 'Burger Bun', '1 piece', 100),
		(8013, 'Burger Dressing', '1 tbps', 100),
		(8014, 'Coca-Cola Bottle', '15oz', 800),
		(8015, 'Potato fries', '500g', 200),
		(8016, 'Salt', '1/2 tspn', 200);

-- Inserting values to order_history
INSERT INTO order_history 
	VALUES 	(10001, 5, 'Very Satisfied', 120, '2023-11-13 12:00:00', 2001),
			(10002, 3, 'OK', 250, '2023-11-13 12:01:00', 2002),
			(10003, 2, 'Disatisfied', 130, '2023-11-13 12:10:00', 2003),
			(10004, 4, 'Satisfied', 280, '2023-11-13 12:15:00', 2004);

-- Inserting values to ingredient_deduction
INSERT INTO	ingredient_deduction
	VALUES		(10001, 10001, 8003),
				(10002, 10001, 8011),
				(10003, 10001, 8012),
				(10004, 10001, 8013),
				(10005, 10001, 8015),
				(10006, 10001, 8016),
				(10007, 10002, 8006),
				(10008, 10002, 8007),
				(10009, 10002, 8008),
				(10010, 10002, 8010),
				(10011, 10002, 8006),
				(10012, 10002, 8007),
				(10013, 10002, 8008),
				(10014, 10002, 8010),
				(10015, 10002, 8001),
				(10016, 10002, 8002),
				(10017, 10003, 8006),
				(10018, 10003, 8007),
				(10019, 10003, 8008),
				(10020, 10003, 8009),
				(10021, 10003, 8010),
				(10022, 10003, 8001),
				(10023, 10003, 8002),
				(10024, 10004, 8003),
				(10025, 10004, 8011),
				(10026, 10004, 8012),
				(10027, 10004, 8013),
				(10028, 10004, 8006),
				(10029, 10004, 8007),
				(10030, 10004, 8008),
				(10031, 10004, 8009),
				(10032, 10004, 8010),
				(10033, 10004, 8015),
				(10034, 10004, 8016),
				(10035, 10004, 8015),
				(10036, 10004, 8016),
				(10037, 10004, 8015),
				(10038, 10004, 8016);
			
INSERT INTO meal_ingredient
VALUES		(7001, 8002, 6001, 1),
		(7002, 8001, 6001, 1),
		(7003, 8012, 6002, 1),
		(7004, 8003, 6002, 1),
		(7005, 8011, 6002, 1),
		(7006, 8013, 6002, 1),
		(7007, 8001, 6003, 1),
		(7008, 8003, 6003, 1),
		(7009, 8005, 6003, 1),
		(7010, 8004, 6003, 1),
		(7011, 8006, 6004, 1),
		(7012, 8008, 6004, 1),
		(7013, 8007, 6004, 1),
		(7014, 8010, 6004, 1),
		(7015, 8009, 6004, 1),
		(7016, 8015, 6005, 1),
		(7017, 8016, 6005, 1),
		(7018, 8002, 6006, 1),
		(7019, 8006, 6006, 1),
		(7020, 8008, 6006, 1),
		(7021, 8007, 6006, 1),
		(7022, 8009, 6006, 1),
		(7023, 8010, 6006, 1),
		(7024, 8001, 6006, 1),
		(7025, 8002, 6007, 1),
		(7026, 8003, 6007, 1),
		(7027, 8005, 6007, 1),
		(7028, 8004, 6007, 1),
		(7029, 8001, 6007, 1),
		(7030, 8012, 6008, 1),
		(7031, 8011, 6008, 1),
		(7032, 8003, 6008, 1),
		(7033, 8009, 6008, 1),
		(7034, 8013, 6008, 1),
		(7035, 8006, 6008, 1),
		(7036, 8008, 6008, 1),
		(7037, 8007, 6008, 1),
		(7038, 8010, 6008, 1),
		(7039, 8015, 6008, 1),
		(7040, 8016, 6008, 1),
		(7041, 8001, 6009, 1),
		(7042, 8003, 6009, 1),
		(7043, 8005, 6009, 1),
		(7044, 8004, 6009, 1),
		(7045, 8015, 6009, 1),
		(7046, 8016, 6009, 1),
		(7047, 8006, 6010, 1),
		(7048, 8009, 6010, 1),
		(7049, 8008, 6010, 1),
		(7050, 8007, 6010, 1),
		(7051, 8010, 6010, 1),
		(7052, 8001, 6010, 1),
		(7053, 8003, 6010, 1),
		(7054, 8005, 6010, 1),
		(7055, 8004, 6010, 1);



