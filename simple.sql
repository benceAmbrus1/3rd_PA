ROLLBACK;

DROP TABLE IF EXISTS bonds;
DROP TABLE IF EXISTS insurance_serv;
DROP TABLE IF EXISTS insurance_comp;
DROP TABLE IF EXISTS cars;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    salary INTEGER,
    CONSTRAINT email_not_empty CHECK (email <> ''),
    CONSTRAINT salary_not_minus CHECK (salary >= 0)
);

CREATE TABLE cars(
    id SERIAL PRIMARY KEY,
    license_plate TEXT UNIQUE NOT NULL,
    manufacturer TEXT NOT NULL,
    model_name TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT license_plate_not_empty CHECK (license_plate <> ''),
    CONSTRAINT manufacturer_not_empty CHECK (manufacturer <> ''),
    CONSTRAINT model_name_not_empty CHECK (model_name <> '')
);

CREATE TABLE insurance_comp(
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    CONSTRAINT name_not_empty CHECK (name <> '')
);

CREATE TABLE insurance_serv(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    min_salary INTEGER,
    length_year INTEGER,
    issuer TEXT,
    FOREIGN KEY(issuer) REFERENCES insurance_comp(name),
    CONSTRAINT name_not_empty CHECK (name <> ''),
    CONSTRAINT min_salary_not_minus CHECK (min_salary >= 0),
    CONSTRAINT length_year_1_atleast CHECK (length_year >= 1)
);

CREATE TABLE bonds(
    issued_date DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id INTEGER,
    car_id INTEGER,
    serv_id INTEGER,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(car_id) REFERENCES cars(id),
    FOREIGN KEY(serv_id) REFERENCES insurance_serv(id)
);

/* trigger for bond insert del */
CREATE TRIGGER newBond BEFORE INSERT ON bonds
    FOR EACH ROW EXECUTE PROCEDURE newBond();

CREATE OR REPLACE FUNCTION newBond() RETURNS trigger AS 
$newBond$
    BEGIN
        IF (SELECT salary FROM users WHERE id = NEW.user_id) < (SELECT min_salary FROM insurance_serv WHERE id = NEW.serv_id) THEN
            RAISE EXCEPTION 'You need bigger salary to bond this service';
        END IF;
        RETURN NEW;
    END;
$newBond$
LANGUAGE plpgsql;

/* trigger for company del */
CREATE TRIGGER comp_del BEFORE DELETE ON insurance_comp
    FOR EACH ROW EXECUTE PROCEDURE comp_del();

CREATE OR REPLACE FUNCTION comp_del() RETURNS trigger AS 
$comp_del$
    BEGIN
        IF (SELECT issuer FROM insurance_serv WHERE issuer = OLD.name) IS NOT NULL THEN
            RAISE EXCEPTION 'THis company got existing service';
        END IF;
        RETURN NEW;
    END;
$comp_del$
LANGUAGE plpgsql;

/* trigger for car del */
CREATE TRIGGER car_del BEFORE DELETE ON cars
    FOR EACH ROW EXECUTE PROCEDURE car_del();

CREATE OR REPLACE FUNCTION car_del() RETURNS trigger AS 
$car_del$
    BEGIN
        IF (SELECT car_id FROM bonds WHERE car_id = NEW.id) IS NOT NULL THEN
            RAISE EXCEPTION 'THis car bonded';
        END IF;
        RETURN NEW;
    END;
$car_del$
LANGUAGE plpgsql;

/* trigger for serv del */
CREATE TRIGGER serv_del BEFORE DELETE ON insurance_serv
    FOR EACH ROW EXECUTE PROCEDURE serv_del();

CREATE OR REPLACE FUNCTION serv_del() RETURNS trigger AS 
$serv_del$
    BEGIN
        IF (SELECT serv_id FROM bonds WHERE serv_id = NEW.id) IS NOT NULL THEN
            RAISE EXCEPTION 'THis service already bonded';
        END IF;
        RETURN NEW;
    END;
$serv_del$
LANGUAGE plpgsql;


/* ***** USER CASES ***** */

/* Add new user */
begin;
INSERT INTO users (email, salary) VALUES ('vki@gmail.com', 200000);
INSERT INTO users (email, salary) VALUES ('mégVki@gmail.com', 300000);
commit;

/* List users */
begin;
SELECT email FROM users;
commit;

/* User details */
begin;
SELECT email, salary FROM users WHERE id = 1;
commit;

/* Del existing user */
begin;
DELETE FROM users WHERE id = 2;
DELETE FROM bonds WHERE user_id = 2;
commit;

/* List users /w No salary */
begin;
SELECT email FROM users WHERE salary <= 0;
commit;

/* Add new car */
begin;
INSERT INTO cars (license_plate, manufacturer, model_name, user_id) VALUES ('VMI001', 'FORD', 'Mondeo', 1);
INSERT INTO cars (license_plate, manufacturer, model_name, user_id) VALUES ('VMI002', 'OPEL', 'Astra', 1);
INSERT INTO cars (license_plate, manufacturer, model_name, user_id) VALUES ('VMI003', 'AUDI', 'A4', 1);
commit;

/* List cars */
begin;
SELECT manufacturer, model_name FROM cars;
commit;

/* List insured cars */
begin;
SELECT cars.manufacturer, cars.model_name FROM cars
FULL JOIN bonds
ON cars.id = bonds.car_id
WHERE bonds.car_id IS NULL
GROUP BY cars.manufacturer, cars.model_name;
commit;

/* List unInsured cars NOT DONE */
begin;
SELECT cars.manufacturer, cars.model_name FROM cars
JOIN bonds
ON cars.id = bonds.car_id
GROUP BY cars.manufacturer, cars.model_name;
commit;

/* Delete existing car */
DELETE FROM cars WHERE id = 2;

/* Add new insurance company */
begin;
INSERT INTO insurance_comp (name) VALUES ('K&H');
INSERT INTO insurance_comp (name) VALUES ('GENERALI');
INSERT INTO insurance_serv (name, min_salary, length_year, issuer) VALUES ('PremiumProtection', 190000, 5, 'GENERALI');
INSERT INTO insurance_serv (name, min_salary, length_year, issuer) VALUES ('NotPremiumProtection', 90000, 2, 'GENERALI');
commit;

/* List insurance services*/
begin;
SELECT * FROM insurance_comp
commit;

/*Delete existing insurance company*/

begin;
DELETE FROM insurance_comp WHERE name = 'K&H';
commit;

/* Add new insurance service */
INSERT INTO insurance_serv (name, min_salary, length_year, issuer) VALUES ('FULLProtection', 300000, 10, 'GENERALI');

/* List insurance services */
begin;
SELECT * FROM insurance_serv;
commit;

/* List insurance company services */
begin;
SELECT issuer, name,  min_salary, length_year FROM insurance_serv WHERE issuer LIKE '&GENERALI&';
commit;

/* Delete an existing insurance service */
begin; 
DELETE FROM insurance_serv WHERE id = 1;
commit;

/* Insure car */
begin;
INSERT INTO bonds (user_id, car_id, serv_id) VALUES (1, 1, 1);
INSERT INTO bonds (user_id, car_id, serv_id) VALUES (1, 3, 2);
commit;

/* Lengthen insurance bond */


/* List invalid insurance bonds NOT dONE */
begin;
SELECT user_id, car_id, serv_id, EXTRACT(YEAR FROM issued_date) AS YEAR FROM bonds
commit;

/* List valid insurance bonds */


/* List number of insurance bonds issued by companies*/
begin;
SELECT insurance_comp.name, COUNT(insurance_serv.id) FROM insurance_comp
JOIN insurance_serv
ON insurance_comp.name = insurance_serv.issuer
GROUP BY insurance_comp.name;
commit;
