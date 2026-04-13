-- NIVELL 1 --
/* Crea una base de dades*/

CREATE DATABASE IF NOT EXISTS Ventas;
USE ventas;
CREATE TABLE transactions (
	id VARCHAR (250),
    card_id VARCHAR (250),
    company_id VARCHAR (250),
    timestamp VARCHAR (250),
    amount VARCHAR (250),
    declined VARCHAR (250),
    product_ids VARCHAR (250),
    user_id VARCHAR (250),
    lat VARCHAR (250),
    longitude VARCHAR (250)
 );
CREATE TABLE credit_cards (
	id VARCHAR (250),
    user_id VARCHAR (250),
    iban VARCHAR (250),
    pan VARCHAR (250),
    pin VARCHAR (250),
    cvv VARCHAR (250),
    track1 VARCHAR (250),
    track2 VARCHAR (250),
    expiring_date VARCHAR (250)
 );
CREATE TABLE companies (
	company_id VARCHAR (250),
    company_name VARCHAR (250),
    phone VARCHAR (250),
    email VARCHAR (250),
    country VARCHAR (250),
    website VARCHAR (250)
);
CREATE TABLE users (
	id VARCHAR (250),
    name VARCHAR (250),
    surname VARCHAR (250),
    phone VARCHAR (250),
    email VARCHAR (250),
    birth_date VARCHAR (250),
    country VARCHAR (250),
    city VARCHAR (250),
    postal_code VARCHAR (250),
    adress VARCHAR (250),
	region VARCHAR (250)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\torre\\OneDrive\\Escritorio\\data temporal\\sprint 4\\companies.csv'
INTO TABLE companies
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\\Users\\torre\\OneDrive\\Escritorio\\data temporal\\sprint 4\\credit_cards.csv'
INTO TABLE credit_cards
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
  (id, user_id, iban, pan, pin, cvv, track1, track2, @expiring_date)
SET
	expiring_date = STR_TO_DATE(@expiring_date, '%m/%d/%y');

LOAD DATA LOCAL INFILE 'C:\\Users\\torre\\OneDrive\\Escritorio\\data temporal\\sprint 4\\european_users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, name, surname, phone, email, @birth_date, country, city, postal_code, adress)
SET
	birth_date = STR_TO_DATE(@birth_date,'%b %d, %Y'),
	region = 'europa';
    
LOAD DATA LOCAL INFILE 'C:\\Users\\torre\\OneDrive\\Escritorio\\data temporal\\sprint 4\\american_users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, name, surname, phone, email, @birth_date, country, city, postal_code, adress)
SET
	birth_date = STR_TO_DATE(@birth_date,'%b %d, %Y'),
	region = 'america';

LOAD DATA LOCAL INFILE 'C:\\Users\\torre\\OneDrive\\Escritorio\\data temporal\\sprint 4\\transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT 
    CONCAT(
        'MAX(CHAR_LENGTH(', COLUMN_NAME, ')) AS ', COLUMN_NAME, '_len, ',
        'SUM(CASE WHEN ', COLUMN_NAME, ' IS NULL OR ', COLUMN_NAME, ' = \'\' THEN 1 ELSE 0 END) AS ', COLUMN_NAME, '_nulls',','
    ) AS query_fragment
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'companies' 
  AND TABLE_SCHEMA = 'ventas';
SELECT
MAX(CHAR_LENGTH(company_id)) AS company_id_len, SUM(CASE WHEN company_id IS NULL OR company_id = '' THEN 1 ELSE 0 END) AS company_id_nulls,
MAX(CHAR_LENGTH(company_name)) AS company_name_len, SUM(CASE WHEN company_name IS NULL OR company_name = '' THEN 1 ELSE 0 END) AS company_name_nulls,
MAX(CHAR_LENGTH(phone)) AS phone_len, SUM(CASE WHEN phone IS NULL OR phone = '' THEN 1 ELSE 0 END) AS phone_nulls,
MAX(CHAR_LENGTH(email)) AS email_len, SUM(CASE WHEN email IS NULL OR email = '' THEN 1 ELSE 0 END) AS email_nulls,
MAX(CHAR_LENGTH(country)) AS country_len, SUM(CASE WHEN country IS NULL OR country = '' THEN 1 ELSE 0 END) AS country_nulls,
MAX(CHAR_LENGTH(website)) AS website_len, SUM(CASE WHEN website IS NULL OR website = '' THEN 1 ELSE 0 END) AS website_nulls
FROM companies;

SELECT 
    CONCAT(
        'MAX(CHAR_LENGTH(', COLUMN_NAME, ')) AS ', COLUMN_NAME, '_len, ',
        'SUM(CASE WHEN ', COLUMN_NAME, ' IS NULL OR ', COLUMN_NAME, ' = \'\' THEN 1 ELSE 0 END) AS ', COLUMN_NAME, '_nulls',','
    ) AS query_fragment
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'transactions' 
  AND TABLE_SCHEMA = 'ventas';

SELECT
MAX(CHAR_LENGTH(id)) AS id_len, SUM(CASE WHEN id IS NULL OR id = '' THEN 1 ELSE 0 END) AS id_nulls,
MAX(CHAR_LENGTH(card_id)) AS card_id_len, SUM(CASE WHEN card_id IS NULL OR card_id = '' THEN 1 ELSE 0 END) AS card_id_nulls,
MAX(CHAR_LENGTH(company_id)) AS company_id_len, SUM(CASE WHEN company_id IS NULL OR company_id = '' THEN 1 ELSE 0 END) AS company_id_nulls,
MAX(CHAR_LENGTH(timestamp)) AS timestamp_len, SUM(CASE WHEN timestamp IS NULL OR timestamp = '' THEN 1 ELSE 0 END) AS timestamp_nulls,
MAX(CHAR_LENGTH(amount)) AS amount_len, SUM(CASE WHEN amount IS NULL OR amount = '' THEN 1 ELSE 0 END) AS amount_nulls,
MAX(CHAR_LENGTH(declined)) AS declined_len, SUM(CASE WHEN declined IS NULL OR declined = '' THEN 1 ELSE 0 END) AS declined_nulls,
MAX(CHAR_LENGTH(product_ids)) AS product_ids_len, SUM(CASE WHEN product_ids IS NULL OR product_ids = '' THEN 1 ELSE 0 END) AS product_ids_nulls,
MAX(CHAR_LENGTH(user_id)) AS user_id_len, SUM(CASE WHEN user_id IS NULL OR user_id = '' THEN 1 ELSE 0 END) AS user_id_nulls,
MAX(CHAR_LENGTH(lat)) AS lat_len, SUM(CASE WHEN lat IS NULL OR lat = '' THEN 1 ELSE 0 END) AS lat_nulls,
MAX(CHAR_LENGTH(longitude)) AS longitude_len, SUM(CASE WHEN longitude IS NULL OR longitude = '' THEN 1 ELSE 0 END) AS longitude_nulls
FROM transactions;

SELECT 
    CONCAT(
        'MAX(CHAR_LENGTH(', COLUMN_NAME, ')) AS ', COLUMN_NAME, '_len, ',
        'SUM(CASE WHEN ', COLUMN_NAME, ' IS NULL OR ', COLUMN_NAME, ' = \'\' THEN 1 ELSE 0 END) AS ', COLUMN_NAME, '_nulls',','
    ) AS query_fragment
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'users' 
  AND TABLE_SCHEMA = 'ventas';

SELECT
MAX(CHAR_LENGTH(id)) AS id_len, SUM(CASE WHEN id IS NULL OR id = '' THEN 1 ELSE 0 END) AS id_nulls,
MAX(CHAR_LENGTH(name)) AS name_len, SUM(CASE WHEN name IS NULL OR name = '' THEN 1 ELSE 0 END) AS name_nulls,
MAX(CHAR_LENGTH(surname)) AS surname_len, SUM(CASE WHEN surname IS NULL OR surname = '' THEN 1 ELSE 0 END) AS surname_nulls,
MAX(CHAR_LENGTH(phone)) AS phone_len, SUM(CASE WHEN phone IS NULL OR phone = '' THEN 1 ELSE 0 END) AS phone_nulls,
MAX(CHAR_LENGTH(email)) AS email_len, SUM(CASE WHEN email IS NULL OR email = '' THEN 1 ELSE 0 END) AS email_nulls,
MAX(CHAR_LENGTH(birth_date)) AS birth_date_len, SUM(CASE WHEN birth_date IS NULL OR birth_date = '' THEN 1 ELSE 0 END) AS birth_date_nulls,
MAX(CHAR_LENGTH(country)) AS country_len, SUM(CASE WHEN country IS NULL OR country = '' THEN 1 ELSE 0 END) AS country_nulls,
MAX(CHAR_LENGTH(city)) AS city_len, SUM(CASE WHEN city IS NULL OR city = '' THEN 1 ELSE 0 END) AS city_nulls,
MAX(CHAR_LENGTH(postal_code)) AS postal_code_len, SUM(CASE WHEN postal_code IS NULL OR postal_code = '' THEN 1 ELSE 0 END) AS postal_code_nulls,
MAX(CHAR_LENGTH(adress)) AS adress_len, SUM(CASE WHEN adress IS NULL OR adress = '' THEN 1 ELSE 0 END) AS adress_nulls,
MAX(CHAR_LENGTH(region)) AS region_len, SUM(CASE WHEN region IS NULL OR region = '' THEN 1 ELSE 0 END) AS region_nulls
FROM users;

SELECT 
    CONCAT(
        'MAX(CHAR_LENGTH(', COLUMN_NAME, ')) AS ', COLUMN_NAME, '_len, ',
        'SUM(CASE WHEN ', COLUMN_NAME, ' IS NULL OR ', COLUMN_NAME, ' = \'\' THEN 1 ELSE 0 END) AS ', COLUMN_NAME, '_nulls',','
    ) AS query_fragment
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'credit_cards' 
  AND TABLE_SCHEMA = 'ventas';

SELECT
MAX(CHAR_LENGTH(id)) AS id_len, SUM(CASE WHEN id IS NULL OR id = '' THEN 1 ELSE 0 END) AS id_nulls,
MAX(CHAR_LENGTH(user_id)) AS user_id_len, SUM(CASE WHEN user_id IS NULL OR user_id = '' THEN 1 ELSE 0 END) AS user_id_nulls,
MAX(CHAR_LENGTH(iban)) AS iban_len, SUM(CASE WHEN iban IS NULL OR iban = '' THEN 1 ELSE 0 END) AS iban_nulls,
MAX(CHAR_LENGTH(pan)) AS pan_len, SUM(CASE WHEN pan IS NULL OR pan = '' THEN 1 ELSE 0 END) AS pan_nulls,
MAX(CHAR_LENGTH(pin)) AS pin_len, SUM(CASE WHEN pin IS NULL OR pin = '' THEN 1 ELSE 0 END) AS pin_nulls,
MAX(CHAR_LENGTH(cvv)) AS cvv_len, SUM(CASE WHEN cvv IS NULL OR cvv = '' THEN 1 ELSE 0 END) AS cvv_nulls,
MAX(CHAR_LENGTH(track1)) AS track1_len, SUM(CASE WHEN track1 IS NULL OR track1 = '' THEN 1 ELSE 0 END) AS track1_nulls,
MAX(CHAR_LENGTH(track2)) AS track2_len, SUM(CASE WHEN track2 IS NULL OR track2 = '' THEN 1 ELSE 0 END) AS track2_nulls,
MAX(CHAR_LENGTH(expiring_date)) AS expiring_date_len, SUM(CASE WHEN expiring_date IS NULL OR expiring_date = '' THEN 1 ELSE 0 END) AS expiring_date_nulls
FROM credit_cards;



ALTER TABLE credit_cards 
	MODIFY COLUMN id VARCHAR (10) NOT NULL,
	MODIFY COLUMN user_id INT,
	MODIFY COLUMN iban VARCHAR (50),
	MODIFY COLUMN pan VARCHAR (25),
	MODIFY COLUMN pin VARCHAR (5),
	MODIFY COLUMN cvv VARCHAR (5),
	MODIFY COLUMN track1 VARCHAR (60),
	MODIFY COLUMN track2 VARCHAR (60),
	MODIFY COLUMN expiring_date DATE,
	ADD PRIMARY KEY (id);

ALTER TABLE companies 
	MODIFY COLUMN company_id VARCHAR (10) NOT NULL,
	MODIFY COLUMN company_name VARCHAR (50),
	MODIFY COLUMN phone VARCHAR (20),
	MODIFY COLUMN email VARCHAR (50),
	MODIFY COLUMN country VARCHAR (20),
	MODIFY COLUMN website VARCHAR (50),
    ADD PRIMARY KEY (company_id);

ALTER TABLE users 
	MODIFY COLUMN id INT PRIMARY KEY NOT NULL,
	MODIFY COLUMN name VARCHAR (20),
	MODIFY COLUMN surname VARCHAR (20),
	MODIFY COLUMN phone VARCHAR (20),
	MODIFY COLUMN email VARCHAR (50),
	MODIFY COLUMN birth_date DATE,
	MODIFY COLUMN country VARCHAR (20),
	MODIFY COLUMN city VARCHAR (20),
	MODIFY COLUMN postal_code VARCHAR (10),
	MODIFY COLUMN adress VARCHAR (40),
	MODIFY COLUMN region VARCHAR (10);
 
ALTER TABLE transactions
	MODIFY COLUMN id VARCHAR (45) PRIMARY KEY NOT NULL,
	MODIFY COLUMN card_id VARCHAR (10),
	MODIFY COLUMN company_id VARCHAR (10),
	MODIFY COLUMN timestamp TIMESTAMP,
	MODIFY COLUMN amount DECIMAL (10,2),
	MODIFY COLUMN declined TINYINT,
	MODIFY COLUMN product_ids VARCHAR (50),
	MODIFY COLUMN user_id INT,
	MODIFY COLUMN lat VARCHAR (20),
	MODIFY COLUMN longitude VARCHAR (20),
	ADD CONSTRAINT fk_transactions_credit_cards FOREIGN KEY (card_id) REFERENCES credit_cards(id),
	ADD CONSTRAINT fk_transactions_companies FOREIGN KEY (company_id) REFERENCES companies(company_id),
	ADD CONSTRAINT fk_transactions_users FOREIGN KEY (user_id) REFERENCES users(id);


# EXERCICI 1
/* Realitza una subconsulta que mostri tots els usuaris amb més de 80 transaccions utilitzant almenys 2 taules.*/

SELECT id, name, surname
FROM users
WHERE id IN (
	SELECT user_id
    FROM transactions
    WHERE declined = 0
    GROUP BY user_id
    HAVING count(id)>80)
ORDER BY id;

# EXERCICI 2
/* Mostra la mitjana d'amount per IBAN de les targetes de crèdit a la companyia Donec Ltd, utilitza almenys 2 taules. */

SELECT iban, ROUND(AVG(amount),2) AS media_importe
FROM credit_cards cc
JOIN transactions t
ON cc.id = t.card_id
JOIN companies c
ON c.company_id = t.company_id
WHERE c.company_name = 'Donec Ltd' AND declined = 0
GROUP BY iban
ORDER BY media_importe DESC;

-- NIVELL 2 --
/* Crea una nova taula que reflecteixi l'estat de les targetes de crèdit basat en si les tres últimes transaccions han estat declinades aleshores és inactiu, si almenys una no és rebutjada aleshores és actiu */


CREATE TABLE IF NOT EXISTS estado_credit_cards (
	card_id VARCHAR (10) PRIMARY KEY,
	estado VARCHAR (8)
);

INSERT INTO estado_credit_cards (card_id, estado)
SELECT 
	card_id,
    CASE 
		WHEN SUM(declined) = 3 THEN 'inactiva'
        ELSE 'activa'
	END AS estado
FROM (
	SELECT 
		card_id, 
        declined, 
        ROW_NUMBER() OVER( PARTITION BY card_id ORDER BY timestamp DESC) AS rn
	FROM transactions
    ) t
WHERE rn <= 3
GROUP BY card_id;


# EXERCICI 2
/* Quantes targetes estan actives? */

SELECT count(card_id) AS total_tarjetas_activas
FROM estado_credit_cards
WHERE estado = 'activa';


-- NIVELL 3 --
/* Crea una taula amb la qual puguem unir les dades del nou arxiu products.csv amb la base de dades creada, tenint en compte que des de transaction tens product_ids.*/


CREATE TABLE IF NOT EXISTS products (
	id VARCHAR(250),
    product_name VARCHAR(250),
    price VARCHAR(250),
    colour VARCHAR(250),
    weight VARCHAR(250),
    warehouse_id VARCHAR(250)
    );
    
LOAD DATA LOCAL INFILE 'C:\\Users\\torre\\OneDrive\\Escritorio\\data temporal\\sprint 4\\products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, product_name, @price, colour, weight, @warehouse)
SET
	price = REPLACE(@price, '$', ''),
    warehouse_id = REPLACE(@warehouse, '--', '-');
    
SELECT 
    CONCAT(
        'MAX(CHAR_LENGTH(', COLUMN_NAME, ')) AS ', COLUMN_NAME, '_len, ',
        'SUM(CASE WHEN ', COLUMN_NAME, ' IS NULL OR ', COLUMN_NAME, ' = \'\' THEN 1 ELSE 0 END) AS ', COLUMN_NAME, '_nulls',','
    ) AS query_fragment
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'products' 
  AND TABLE_SCHEMA = 'ventas';

SELECT
MAX(CHAR_LENGTH(id)) AS id_len, SUM(CASE WHEN id IS NULL OR id = '' THEN 1 ELSE 0 END) AS id_nulls,
MAX(CHAR_LENGTH(product_name)) AS product_name_len, SUM(CASE WHEN product_name IS NULL OR product_name = '' THEN 1 ELSE 0 END) AS product_name_nulls,
MAX(CHAR_LENGTH(price)) AS price_len, SUM(CASE WHEN price IS NULL OR price = '' THEN 1 ELSE 0 END) AS price_nulls,
MAX(CHAR_LENGTH(colour)) AS colour_len, SUM(CASE WHEN colour IS NULL OR colour = '' THEN 1 ELSE 0 END) AS colour_nulls,
MAX(CHAR_LENGTH(weight)) AS weight_len, SUM(CASE WHEN weight IS NULL OR weight = '' THEN 1 ELSE 0 END) AS weight_nulls,
MAX(CHAR_LENGTH(warehouse_id)) AS warehouse_id_len, SUM(CASE WHEN warehouse_id IS NULL OR warehouse_id = '' THEN 1 ELSE 0 END) AS warehouse_id_nulls
FROM products;
    
ALTER TABLE products 
	MODIFY COLUMN id INT PRIMARY KEY NOT NULL,
	MODIFY COLUMN product_name VARCHAR (40),  
	MODIFY COLUMN price DECIMAL (10,2),
	MODIFY COLUMN colour VARCHAR (10),   
	MODIFY COLUMN weight DECIMAL (10,2),    
	MODIFY COLUMN warehouse_id VARCHAR (5);      
	
   
    
CREATE TABLE IF NOT EXISTS transaction_product (
	transaction_id VARCHAR (45),
    product_id INT,
    declined TINYINT,
    PRIMARY KEY (transaction_id, product_id),
    CONSTRAINT fk_transaction_product_products FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT fk_transaction_product_transactions FOREIGN KEY (transaction_id) REFERENCES transactions (id)
    );

INSERT INTO transaction_product (transaction_id, declined, product_id)
SELECT 
    t.id,
    t.declined,
    jt.product_id
FROM transactions t,    
JSON_TABLE(
    CONCAT('[', REPLACE(t.product_ids, ', ', ','), ']'),   
    '$[*]' COLUMNS (  			
        product_id INT PATH '$'   
    )
) AS jt;



# EXERCICI 1
/* Necessitem conèixer el nombre de vegades que s'ha venut cada producte.*/

SELECT  product_id, product_name, COUNT(product_id) AS total_ventas
FROM transaction_product tp
JOIN products p
ON tp.product_id = p.id
WHERE declined = 0
GROUP BY product_id, product_name
ORDER BY product_id;



