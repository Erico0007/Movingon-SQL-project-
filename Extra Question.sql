USE MovinOn_Team10;
/* : Answer the extra Question*/

/* Question 4 :What is the average length of a rental period? */

create view AverageLengthOfARentalPeriod AS 
Select
AVG(DATEDIFF(COALESCE( Dateout,CURDATE()),DateIn)) AS averagerentaldays
from unitrentals
;

select * from AverageLengthOfARentalPeriod;