create database if not exists cost_to_custmr;
use  cost_to_custmr;
show tables;
-- Rename Table and columns for sanity check
alter table cost_to_custmr.`hospitalisation details`
rename to hospitalisation_details;

alter table cost_to_custmr.`medical examinations`
rename to medical_examinations;

alter table  hospitalisation_details
rename column `Customer ID` to Customer_ID;

alter table hospitalisation_details
rename column `Hospital tier` to hospital_tier;

alter table hospitalisation_details
rename column `City tier` to city_tier;

alter table hospitalisation_details
rename column `State ID` to state_id;
select * from hospitalisation_details;
select distinct 'customer_id' , count(*) from hospitalisation_details;

-- Before adding Primary key , checking NUll,string'?' and Duplicate value

select * from hospitalisation_details
where customer_id is null;
select * from medical_examinations
where customer_id is null;
-- as no null is found , checking and delete for string '?'


select count(*) from hospitalisation_details
where customer_id ='?' or state_id = '?'or city_tier ='?' or hospital_tier = '?';

delete from hospitalisation_details
where customer_id ='?' or state_id = '?'or city_tier ='?' or hospital_tier = '?';

-- modify column data type and adding constrain primary key

alter table hospitalisation_details
modify column customer_id varchar(255);

alter table hospitalisation_details
add constraint primary key (customer_id );
describe	  hospitalisation_details;

-- some prior operation on table medical_examinations
select * from medical_examinations;
desc medical_examinations;

alter table medical_examinations
rename column `Customer ID` to customer_id;

alter table medical_examinations
rename column `Heart Issues` to heart_issue;

alter table medical_examinations
rename column `Any Transplants` to any_transplants;

alter table medical_examinations
rename column `Cancer history` to cancer_history;

select distinct 'customer_id' ,count(*) from medical_examinations;

select * from medical_examinations
where smoker='?' ;

delete from medical_examinations
where smoker='?' ;

-- modify column data type and adding constrain primary key

alter table medical_examinations
modify column customer_id varchar(255);
alter table medical_examinations
add constraint primary key (customer_id);
describe medical_examinations;

-- merging two table for further analysis as per project requirement

SELECT *
FROM hospitalisation_details as HD
join medical_examinations as ME
on HD.Customer_ID = ME.Customer_ID ;
SELECT distinct count(*)
FROM hospitalisation_details as HD
join medical_examinations as ME
on HD.Customer_ID = ME.Customer_ID ;

-- 2. Retrieve information about people who are diabetic and have heart problems with their average
-- age, the average number of dependent children, average BMI, and average hospitalization costs


SELECT *
FROM hospitalisation_details;
select (2024-year)  AS age
FROM hospitalisation_details ;

select me.HBA1C, me.heart_issue, avg(me.BMI),avg(HD.charges),avg(HD.children)
FROM hospitalisation_details as HD
join medical_examinations as ME
on HD.Customer_ID = ME.Customer_ID 
where me.HBA1C > 6.5 and me.heart_issue='yes'
group by me.HBA1C , me.heart_issue;


SELECT avg(HBA1C)
FROM medical_examinations;

select me.HBA1C, me.heart_issue, avg(me.BMI),avg(HD.charges),avg(HD.children)
FROM hospitalisation_details as HD
join medical_examinations as ME
on HD.Customer_ID = ME.Customer_ID 
where me.HBA1C > 6.5 and me.heart_issue='yes'
group by me.HBA1C , me.heart_issue;

-- 3. Find the average hospitalization cost for each hospital tier and each city level

select  hospital_tier,city_tier,avg(charges)
from hospitalisation_details
group by hospital_tier,city_tier;

-- 4. Determine the number of people who have had major surgery with a history of cancer

SELECT customer_id,NumberOfMajorSurgeries,cancer_history
FROM medical_examinations
where  cancer_history='yes' ;
SELECT count(customer_id) as number_of_ppl
FROM medical_examinations
where cancer_history='yes' ;

-- 5. Determine the number of tier-1 hospitals in each state
SELECT  state_id , count(hospital_tier) as tier_1_hospital
FROM hospitalisation_details
where hospital_tier = 'tier - 1'
group by state_id



-- END OF SQL PART OF PROJECT --