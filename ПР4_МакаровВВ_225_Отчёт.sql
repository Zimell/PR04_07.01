-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE doctors_id_doctor_seq;

CREATE SEQUENCE doctors_id_doctor_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE doctors_id_doctor_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE doctors_id_doctor_seq TO postgres;

-- DROP SEQUENCE patients_id_patients_seq;

CREATE SEQUENCE patients_id_patients_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE patients_id_patients_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE patients_id_patients_seq TO postgres;

-- DROP SEQUENCE session_patient_id_session_patient_seq;

CREATE SEQUENCE session_patient_id_session_patient_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE session_patient_id_session_patient_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE session_patient_id_session_patient_seq TO postgres;
-- public.doctors определение

-- Drop table

-- DROP TABLE doctors;

CREATE TABLE doctors (
	id_doctor serial4 NOT NULL,
	surname varchar NOT NULL,
	"Name" varchar NOT NULL,
	patronymic varchar NULL,
	specialization varchar NOT NULL,
	CONSTRAINT doctors_pk PRIMARY KEY (id_doctor)
);

-- Permissions

ALTER TABLE doctors OWNER TO postgres;
GRANT ALL ON TABLE doctors TO postgres;


-- public.patients определение

-- Drop table

-- DROP TABLE patients;

CREATE TABLE patients (
	id_patients serial4 NOT NULL,
	surname varchar NOT NULL,
	"name" varchar NOT NULL,
	patronymic varchar NOT NULL,
	birthday varchar NOT NULL,
	address varchar NULL,
	CONSTRAINT patients_pk PRIMARY KEY (id_patients)
);

-- Permissions

ALTER TABLE patients OWNER TO postgres;
GRANT ALL ON TABLE patients TO postgres;


-- public.session_patient определение

-- Drop table

-- DROP TABLE session_patient;

CREATE TABLE session_patient (
	id_session_patient serial4 NOT NULL,
	id_doctor int4 NOT NULL,
	id_patient int4 NOT NULL,
	cost_seeing numeric NULL,
	percent_salary numeric NULL,
	salary numeric GENERATED ALWAYS AS (cost_seeing * (percent_salary / 100::numeric) * 0.87) STORED NULL,
	CONSTRAINT session_patient_pk PRIMARY KEY (id_session_patient),
	CONSTRAINT "seesion_patient_doctors_FK" FOREIGN KEY (id_doctor) REFERENCES doctors(id_doctor) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT "seesion_patient_patient_FK" FOREIGN KEY (id_patient) REFERENCES patients(id_patients) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Permissions

ALTER TABLE session_patient OWNER TO postgres;
GRANT ALL ON TABLE session_patient TO postgres;




-- Permissions

GRANT ALL ON SCHEMA public TO pg_database_owner;
GRANT USAGE ON SCHEMA public TO public;
INSERT INTO public.doctors (surname,"Name",patronymic,specialization) VALUES
	 ('Сидорова','Марина','Петровна','Невролог'),
	 ('Васильев','Алексей','Станиславович','Терапевт'),
	 ('Громова','Светлана','Викторовна','Эндокринолог'),
	 ('Федоров','Владимир','Сергеевич','Дерматолог'),
	 ('Клюев','Антон','Игоревич','Хирург-травматолог'),
	 ('Калинина','Екатерина','Николаевна','Педиатр'),
	 ('Зайцева','Татьяна','Ивановна','Гинеколог'),
	 ('Соловьев','Роман','Игоревич','Радиолог'),
	 ('Шарова','Людмила','Федоровна','Анестезиолог'),
	 ('Ильин','Сергей','Валерьевич','Психотерапевт');
INSERT INTO public.patients (surname,"name",patronymic,birthday,address) VALUES
	 ('Сидорова','Марина','Петровна','1991-04-12','ул. Красная, дом 10, квартира 3'),
	 ('Васильев','Алексей','Станиславович','1985-11-30','пр-т Ленина, дом 25, офис 201'),
	 ('Громова','Светлана','Викторовна','1979-06-15','ул. Мира, дом 5, этаж 2, квартира 8'),
	 ('Федоров','Владимир','Сергеевич','1993-01-22','пос. Зеленый, ул. Лесная, дом 4'),
	 ('Клюев','Антон','Игоревич','1970-08-09','г. Казань, ул. Баумана, дом 18'),
	 ('Калинина','Екатерина','Николаевна','1989-03-17','ул. Пушкина, дом 12, квартира 6'),
	 ('Зайцева','Татьяна','Ивановна','1994-10-25','пос. Солнечный, ул. Солнечная, дом 30'),
	 ('Соловьев','Роман','Игоревич','1976-12-02','г. Екатеринбург, пр-т Уралмаш, дом 45'),
	 ('Шарова','Людмила','Федоровна','2001-07-19','ул. Студенческая, дом 20, студия 101'),
	 ('Ильин','Сергей','Валерьевич','1958-05-05','пос. Лесной, ул. Лесная, дом 50');
INSERT INTO public.session_patient (id_doctor,id_patient,cost_seeing,percent_salary) VALUES
	 (1,1,6000.00,25),
	 (2,2,8000.00,35),
	 (3,3,5000.00,20),
	 (4,4,7000.00,30),
	 (5,5,6500.00,27),
	 (6,6,5500.00,22),
	 (7,7,7500.00,32),
	 (8,8,4000.00,18),
	 (9,9,7000.00,28),
	 (10,10,5200.00,21);
