#1) Display all Inpatients whose name starts with ‘S’ and is of length between 5 and 20.
SELECT pname FROM patient 
WHERE pname LIKE 'S%' AND LENGTH(pname) BETWEEN 5 AND 20 AND ptype = 'Inpatient';

#2) Display the patient who are senior citizen (>=60).
SELECT pname FROM patient 
WHERE TIMESTAMPDIFF(YEAR, pdob, CURDATE()) >= 60;

#3) Display patient who were born after 1st of June 1980. 
SELECT pname, pdob FROM patient 
WHERE pdob > '1980-06-01';

#4)The patient are suppose to only provide mobile numbers .All mobile numbers should start with  zero followed by 10 digits. 
#Displaypatient name having invalid phone numbers. 
SELECT pname, pphone FROM patient 
WHERE pphone NOT LIKE '0%' OR LENGTH(pphone) != 11 OR pphone IS NULL;

#5)All emails should have “@” anywhere after the first character and should end with “.com”.  
#Display count of patient having invalid email id. 
SELECT pname, pemail FROM patient 
WHERE pemail NOT LIKE '%.com%' OR pemail NOT LIKE '%@%' OR pemail IS NULL;

#6)Display the name and email of patient who have a Gmail account. 
SELECT pname, pemail FROM patient 
WHERE pemail LIKE '%@gmail.com';

#7)Display the above record but do not consider invalid email id. 
SELECT pname, pemail FROM patient 
WHERE pemail LIKE '%.com%' AND pemail LIKE '%@%';

#8)Display the qualification and the total number of patient registered based on their  qualifications. 
SELECT ptype, COUNT(*) AS totalPatients FROM patient 
GROUP BY ptype;

#9) Display the full name of the month and the total number of patient who are having their  birthday in that month. 
#(Alias use “Month” and “Total”) 
SELECT MONTHNAME(pdob) AS Month, COUNT(*) AS Total FROM patient 
GROUP BY Month;

#10)Display the patient name that was born in a leap year ordering by student name and year of  birth. 
SELECT pname, YEAR(pdob) FROM patient
WHERE (YEAR(pdob) % 4 = 0 AND YEAR(pdob) % 100 != 0) OR YEAR(pdob) % 400 = 0
ORDER BY pname, YEAR(pdob);

#11) Display patient whose city is Kolkata as “Local” and others as “NonLocal”  under a column “Remarks”. 
#Also display the name and city of the patient. 
SELECT pname, pcity,
CASE WHEN pcity = 'Kolkata' THEN 'Local'
    ELSE 'NonLocal'
END AS Remarks FROM patient;

#12)Display count of patient having no contact information. (Either email or phone). 
SELECT count(*) from patient
where pemail is null or pphone is null;

#13) Display treatmentname having above average fees. 
SELECT treatmentname from treatment 
where (SELECT avg(treatmentcost) from treatment)<treatmentcost;

#14) Display treatment treatmentname where fees are less than the average fees of its category. 
SELECT treatmentname FROM treatment t1
WHERE treatmentcost < (
    SELECT AVG(treatmentcost) 
    FROM treatment t2 
    WHERE t2.treatmentcategory = t1.treatmentcategory
);

#15) Display patient name having duplicate email ids. 
SELECT pname FROM patient
WHERE pemail IS NULL OR pemail NOT LIKE '%.com%' OR pemail NOT LIKE '%@%';

#16) Display appointmentid, treatmentname, appointment start date,appointmenth end date for all batches. 
#(appointment end  date=appointment start date +treatment duration). 
SELECT a.appointmentid, t.treatmentname, 
       DATE(a.appointmentdate) AS appointment_start_date,
       DATE(a.appointmentdate + INTERVAL t.treatmentduration DAY) AS appointment_end_date
FROM appointment a 
JOIN treatment t ON a.treatmentid = t.treatmentid;

#17)Display all appointmentid having a difference of 10 hours and less between its starting and ending date
SELECT a.appointmentid FROM appointment a 
JOIN treatment t ON a.treatmentid = t.treatmentid 
WHERE t.treatmentduration <= 10;

#18)Display patient who came for the appointment after its start date.
SELECT p.pname, v.edate AS visit_date, a.appointmentdate FROM patient p 
JOIN patient_visit v ON p.pid = v.pid 
JOIN appointment a ON a.appointmentid = v.appointmentid 
WHERE v.edate > DATE(a.appointmentdate);

#19) Display the patientid, patientname , totalfees for all patient. 
SELECT p.pid, p.pname, SUM(t.treatmentfees) AS totalFees FROM patient p 
JOIN patient_visit v ON p.pid = v.pid 
JOIN appointment a ON v.appointmentid = a.appointmentid 
JOIN treatment t ON a.treatmentid = t.treatmentid 
GROUP BY p.pid, p.pname;

#20) Display the treatment treatmentname having the highest patient count. 
SELECT t.treatmentname, COUNT(*) AS total FROM treatment t 
JOIN appointment a ON a.treatmentid = t.treatmentid 
JOIN patient_visit v ON v.appointmentid = a.appointmentid 
GROUP BY t.treatmentname 
ORDER BY total DESC 
LIMIT 1;

#21) Display patient name having similar name but different email ids. 
SELECT DISTINCT p1.pname FROM patient p1 
JOIN patient p2 
  ON p1.pname = p2.pname AND p1.pemail <> p2.pemail;

#22)Display the treatment name fetching the 2nd highest revenue. 
SELECT * FROM (
    SELECT t.treatmentname, SUM(t.treatmentfees) AS total FROM treatment t 
    JOIN appointment a ON a.treatmentid = t.treatmentid 
    JOIN patient_visit v ON v.appointmentid = a.appointmentid 
    GROUP BY t.treatmentname 
    ORDER BY total DESC 
    LIMIT 2
) AS ranked 
ORDER BY total ASC 
LIMIT 1;

#23) Which among the following have the highest appointment?
SELECT p.ptype, COUNT(*) AS total FROM patient p 
JOIN patient_visit v ON p.pid = v.pid 
GROUP BY p.ptype 
ORDER BY total DESC 
LIMIT 1;

#24) Display patient name, age[Alias] ,treatmentname, appointmentid, appointment date, appointment end_date 
#and appointment date in the format 1st of Jan , 2012 .
SELECT p.pname,TIMESTAMPDIFF(YEAR, p.pdob, CURDATE()) AS age,t.treatmentname,a.appointmentid,
    DATE_FORMAT(a.appointmentdate, '%D of %b, %Y') AS appointment_start_date,
    DATE_FORMAT(a.appointmentdate + INTERVAL t.treatmentduration DAY, '%D of %b, %Y') AS appointment_end_date
FROM patient p
JOIN patient_visit v ON p.pid = v.pid
JOIN appointment a ON v.appointmentid = a.appointmentid
JOIN treatment t ON a.treatmentid = t.treatmentid;
