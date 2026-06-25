desc branches;
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Cuddalore',    'Cuddalore',   'Tamil Nadu',   '4142-253029254029', DATE '2010-03-15');
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Ramapuram',       'Cuddalore',   'Tamil Nadu',   '4142-274545', DATE '2011-06-20');
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Velachery',        'Chennai',    'Tamil Nadu',  '	44-22431892 22434377', DATE '2009-01-10');
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Chidambaram',       'Cuddalore',    'Tamil Nadu',  '	4144-24522602452265', DATE '2012-08-05');
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Guindy',      'Chennai',    'Tamil Nadu',       '011-23456785', DATE '2008-11-30');
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Saligramam',  'Chennai',     'Tamil Nadu',        '44-23622152', DATE '2013-04-18');
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Koramangala',   'Bangalore', 'Karnataka',    '080-23456787', DATE '2010-07-22');
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Indiranagar',   'Bangalore', 'Karnataka',    '080-23456788', DATE '2014-09-14');
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Bellandur', 'Bangalore', 'Telangana',    '	080-25740222', DATE '2011-02-28');
INSERT INTO branches (branch_name, city, state, phone, established_date) VALUES
('Jubilee Hills', 'Hyderabad', 'Telangana',    '040-23456790', DATE '2015-05-10');



COMMIT;
SELECT * FROM branches;

SELECT BRANCH_ID,BRANCH_NAME,CITY FROM BRANCHES
WHERE BRANCH_NAME IN 'Velachery'
ORDER BY BRANCH_ID DESC;
--reset squence
ALTER SEQUENCE seq_branch_id      RESTART START WITH 1;



TRUNCATE TABLE branches;