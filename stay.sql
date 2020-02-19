desc user;



SELECT * FROM room_img;

DELETE FROM room_img;

select * from room_closed;


UPDATE room_closed SET closed_from=TIMESTAMP('2020-02-12') WHERE closed_to=TIMESTAMP('2020-02-14');

SELECT * FROM buy;



-- 최대 인원을 18로 지정해놓자. 
SELECT r_no, b_date_from, b_date_to, b_guest FROM buy WHERE b_status=1 AND r_no=1;


INSERT INTO buy (r_no, u_no, b_date_from, b_date_to, b_guest, b_total_price, b_status) 
VALUES(1, 1, TIMESTAMP('2020-02-26'), TIMESTAMP('2020-03-02'), 9, 45000, 1);

INSERT INTO buy (r_no, u_no, b_date_from, b_date_to, b_guest, b_total_price, b_status) 
VALUES(1, 1, TIMESTAMP('2020-02-28'), TIMESTAMP('2020-02-29'), 9, 9000, 1);


SELECT MIN(b_date_from) as min_date_from, MAX(b_date_to) as max_date_to FROM buy WHERE b_status=1 AND r_no=1;

DESC rooms;

DESC buy;

--God 지유
select sum(b_guest) as sum_guests from buy where r_no=1 AND b_status=1 AND b_date_from<='2020-02-29' AND b_date_to>'2020-02-29';

SELECT * FROM rooms WHERE r_no=1 AND r_guests <= 
(SELECT sum(b_guest) as sum_guests FROM buy WHERE r_no=1 AND b_status=1 AND b_date_from<='2020-02-29' AND b_date_to>'2020-02-29');

--그 날짜에 숙박이 다 찬 경우?
SELECT * FROM rooms WHERE r_no=1 AND r_guests < 
(SELECT sum(b_guest)+8 as sum_guests FROM buy WHERE r_no=1 AND b_status=1 AND b_date_from<='2020-03-02' AND b_date_to>='2020-03-02');



select * from buy where r_no=1 and b_status = 1;

--r_guest_booked 삭제
ALTER TABLE rooms DROP r_guest_booked;



-- 유저!!
select * from user;

select * from comment;


desc comment;

desc amenity;

SELECT * FROM rooms;

select * from buy ;

select * from amenity;

select * from room_img;

select * from room_closed;









