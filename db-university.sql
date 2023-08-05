
-- 1. Selezionare tutti gli studenti nati nel 1990 (160)

SELECT * 
FROM `students`
WHERE (date_of_birth) LIKE '1990-%-%';

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)

SELECT * 
FROM `courses`
WHERE (cfu) > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni

SELECT * 
FROM `students`
WHERE YEAR(date_of_birth) < 1993;

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)

SELECT * 
FROM `courses`
WHERE (period) = 'I semestre'
AND (year) = 1;

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)

SELECT * 
FROM `exams`
WHERE (date) = '2020-06-20'
AND HOUR(hour) >= '14';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)

SELECT * 
FROM `degrees`
WHERE level = 'magistrale';

-- 7. Da quanti dipartimenti è composta l'università? (12)

SELECT COUNT(id) AS 'total_departments' 
FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)

SELECT * 
FROM `teachers`
WHERE phone IS NOT NULL;

-- 1. Contare quanti iscritti ci sono stati ogni anno

SELECT COUNT(*) as 'number_students', YEAR(enrolment_date) 
FROM `students`
GROUP BY YEAR(enrolment_date);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT COUNT(*) as 'number_of_teachers', (office_address)  
FROM `teachers`
GROUP BY (office_address);

-- 3. Calcolare la media dei voti di ogni appello d'esame

SELECT AVG(vote) as 'media_votes', exam_id 
FROM `exam_student`
WHERE vote >= 18
GROUP BY exam_id;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT COUNT(*) as 'num_degrees', (department_id) 
FROM `degrees`
GROUP BY department_id;

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT S.`name`, S.`surname`, D.`name`
FROM `students` AS S
JOIN `degrees` AS D
ON D.`id` = S.`degree_id`
WHERE D.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze

SELECT DEG.`name` , DEP.`name` 
FROM `degrees` AS DEG
JOIN `departments` AS DEP
ON DEG.`department_id` = DEP.`id`
WHERE DEP.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT C.`name`, `T`.`name`, `T`.`surname`
FROM `teachers` AS T
JOIN `course_teacher` AS CT
ON T.`id` = `CT`.`teacher_id`
JOIN `courses` AS C
ON C.`id`= `CT`.`course_id`
WHERE T.`id`= 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e ilrelativo dipartimento, in ordine alfabetico per cognome e nome

SELECT S.`name`, S.`surname`, DEG.`name`, DEP.`name` 
FROM `students` AS S
JOIN `degrees` AS DEG
ON DEG.`id`= S.`degree_id`
JOIN `departments` AS DEP
ON DEP.`id`= DEG.`department_id`
ORDER BY S.`surname`, S.`name` ASC;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT `DEG`.`name` , `C`.`name` , `T`.`name`, `T`.`surname`
FROM `degrees` AS DEG
JOIN `courses` AS C
ON DEG.`id` = C.`degree_id`
JOIN `course_teacher` AS CT
ON C.`id` = CT.`course_id`
JOIN `teachers` as T
ON T.`id` = `CT`.`teacher_id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT DISTINCT T.`name` , `T`.`surname`, DEP.`name`
FROM `departments` as DEP
JOIN `degrees` as DEG
ON DEP.`id` = DEG.`department_id`
JOIN `courses` as C
ON DEG.`id` = `C`.`degree_id`
JOIN `course_teacher` as CT
ON `C`.`id`= `CT`.`course_id`
JOIN `teachers` as T 
ON `T`.`id`= `CT`.`teacher_id`
WHERE `DEP`.`name`= 'Dipartimento di Matematica';

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami

 