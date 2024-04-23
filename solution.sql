--1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko).
--W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.

CREATE TABLE employee
(
    id        INT PRIMARY KEY auto_increment,
    name      VARCHAR(30) NOT NULL,
    surname   VARCHAR(50) NOT NULL,
    salary    INT         NOT NULL,
    birthDate date        NOT NULL,
    position  VARCHAR(30) NOT NULL
);

-- 2. Wstawia do tabeli co najmniej 6 pracowników

INSERT INTO employee (name, surname, salary, birthDate, position)
VALUES ('Marcin', 'Fundalewicz', 10000, '1998-09-06', 'CEO'),
       ('Sławek', 'Ludwiczak', 9000, '1997-09-06', 'Director'),
       ('Grzegorz', 'Nowak', 5000, '1996-09-06', 'Cleaner'),
       ('Marcin', 'Kunert', 9000, '1995-09-06', 'Director'),
       ('Krystyna', 'Czubówna', 6000, '1990-09-06', 'Asisstant'),
       ('Damian', 'Kowalski', 6500, '1985-09-06', 'HR');

-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku

SELECT *
FROM employee
ORDER BY surname;

-- 4. Pobiera pracowników na wybranym stanowisku

SELECT *
FROM employee
WHERE position = 'CEO';

-- 5. Pobiera pracowników, którzy mają co najmniej 30 lat

SELECT *
FROM employee
WHERE DATEDIFF(NOW(), data_urodzenia) >= 365 * 30 + 7;

-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%

UPDATE employee
SET salary = 1.1 * salary
WHERE position = 'CEO';

-- 7.Pobiera najmłodszego pracowników
-- (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)

SELECT *
FROM employee
WHERE birthDate = (SELECT MAX(birthDate) FROM employee);

-- 8. Usuwa tabelę pracownik

DROP TABLE employee;

-- 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)

CREATE TABLE position
(
    id          INT PRIMARY KEY auto_increment,
    name        VARCHAR(30) NOT NULL,
    description VARCHAR(200),
    salary      INT         NOT NULL
);

-- 10.Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)

CREATE TABLE address
(
    id       INT PRIMARY KEY auto_increment,
    street   VARCHAR(100),
    zip_Code VARCHAR(6),
    city     VARCHAR(30)
);

-- 11.Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres

CREATE TABLE employee
(
    id          INT PRIMARY KEY auto_increment,
    name        VARCHAR(30) NOT NULL,
    surname     VARCHAR(50) NOT NULL,
    address_id  INT,
    position_id INT,
    FOREIGN KEY (address_id) REFERENCES address (id),
    FOREIGN KEY (position_id) REFERENCES position (id)
);

-- 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)

INSERT INTO position (name, description, salary)
VALUES ('CEO', 'Main person in company', 10000),
       ('Cleaner', 'Cleaning stuff', 5000),
       ('Director', 'Managin people', 9000),
       ('Assisstant', 'Helping other employees', 6000),
       ('HR', 'Human resources', 6500);

INSERT INTO address (street, zip_Code, city)
VALUES ('ul.Wielka 20', '00-001', 'Katowice'),
       ('ul.Wielka 21', '00-002', 'Kraków'),
       ('ul.Wielka 22', '00-003', 'Gdynia'),
       ('ul.Wielka 23', '00-004', 'Gliwice'),
       ('ul.Wielka 24', '00-005', 'Warszawa');

INSERT INTO employee (name, surname, address_id, position_id)
VALUES ('Marcin', 'Fundalewicz', 1, 1),
       ('Sławek', 'Ludwiczak', 2, 2),
       ('Grzegorz', 'Nowak', 3, 3),
       ('Marcin', 'Kunert', 4, 4),
       ('Krystyna', 'Czubówna', 1, 5),
       ('Damian', 'Kowalski', 5, 1);

-- 13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)

SELECT name, surname, position, street, zip_Code, city
FROM employee
         JOIN position ON employee.position_id = position.id
         JOIN address ON employee.address_id = address.id;

-- 14. Oblicza sumę wypłat dla wszystkich pracowników w firmie

SELECT SUM(salary)
FROM position
         JOIN employee ON position.id = employee.position_id;

-- 15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym
-- 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)

SELECT *
FROM employee
         JOIN address ON employee.address_id = address.id
WHERE address.zip_Code = '00-001';

