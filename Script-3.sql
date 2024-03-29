-- 1. 회원(MEMBER) 테이블 ⇒ MEMBERS 테이블

CREATE TABLE INFO(
	USER_MAIL VARCHAR2(255) PRIMARY KEY NOT NULL,
	PASSWORD VARCHAR2(255) NOT NULL,
	NAME VARCHAR2(255) NOT NULL,
	FIRST_ID_CARDNUM NUMBER(6) NOT NULL,
	PHONE_NUMBER NUMBER(11) NOT NULL,
	ADDRESS VARCHAR2(255),
	GENDER NUMBER(2) NOT NULL,
	NICKNAME VARCHAR2(255) NOT NULL
	);

INSERT INTO INFO VALUES ('dyddnr33@naver.com', 'asdf', '서용욱', 960125, 01098111691, '서울시 관악구', 1, '막강한바지');
INSERT INTO INFO VALUES ('wnsdud12@daum.com', '123456', '김준영', 940321, 01043453454, '서울시 강남구', 2, '불법유턴');

-- 방 등록(GRADE) 테이블 
CREATE TABLE RoomInfo(
    house_num NUMBER(38) PRIMARY KEY NOT NULL,
    user_id VARCHAR2(255) UNIQUE NOT NULL,
    photo_url VARCHAR2(255),
    trade_method VARCHAR(50) NOT NULL, 
    price NUMBER(38) NOT NULL,
    area VARCHAR2(255) NOT NULL,
    accept_date DATE,
    household NUMBER(10) NOT NULL,
    address VARCHAR2(255) NOT NULL,
    floor1 VARCHAR2(255) NOT NULL,
    remark VARCHAR2(255),
    phonenumber  NUMBER(15) NOT NULL,
    regit_date DATE,
    roomtitle varchar2(255) NOT NULL,
    option_id NUMBER(38) REFERENCES house_option(option_id) NOT NULL
);

INSERT INTO RoomInfo VALUES(123456789,'집가고싶다','HTTP 암튼 URL임', '매매',10000000000,'148.76M^2','2024-03-29',6,'강남구 강남구 테헤란로14길 6 KH정보교육원',
'2F','강남역이랑 역삼역 10분 거리임 개?꿀? 인가?','01022221111','2024-03-29','강남에서 제일가는 명당룸',10);

-- 옵션(house_option) 테이블 생성
create table house_option(
	option_id NUMBER(38) PRIMARY KEY NOT NULL,
    refrigerator number(2) not null,
    washing_machine number(2) not null,
    sink number(2) not null,
    gas_stove number(2) not null,
    microwave number(2) not null,
    air_conditioner number(2) not null,
    parkinglot number(2) not null
);

-- 옵션 테이블 데이터 입력
insert into house_option(option_id,refrigerator, washing_machine,sink, gas_stove,microwave, air_conditioner, parkinglot)
    values(10,1, 1, 1, 1, 1, 1, 0); -- 주자 이외에 모든 옵션 
insert into house_option(option_id,refrigerator, washing_machine,sink, gas_stove,microwave, air_conditioner, parkinglot)
    values(11,1, 0, 1, 1, 0, 1, 0); -- 세탁기, 전자레인지, 주차 제외 옵션

-- 4. 마이페이지(MY PAGE) 테이블
CREATE TABLE MY_PAGE(
	USER_MAIL VARCHAR2(255) UNIQUE NOT NULL,
	LOVE_ROOM NUMBER(2),
	profile_photo VARCHAR2(255) 
	);

INSERT INTO MY_PAGE VALUES ('dyddnr33@naver.com', 1, 'url1');
INSERT INTO MY_PAGE VALUES ('wnsdud12@daum.com', 1, 'url2');

-- 5. 찜한 방 목록 테이블 생성
create table love_room(
   roomtitle varchar(255),
   user_id varchar(255) REFERENCES my_page(USER_MAIL) not NULL,
   Shouse_num NUMBER(38) references RoomInfo(house_num) NOT null
);
INSERT INTO love_room VALUES('평생 살고싶은 원룸','dyddnr33@naver.com',123456789);
INSERT INTO love_room VALUES('강남에서 제일가는 명당룸.','wnsdud12@daum.com',123456789);

-- 6. 관리자 계정(ADMIN INFO)

CREATE TABLE ADMIN_INFO(
	ADM_NO NUMBER(20) UNIQUE NOT NULL,
	ADM_ID VARCHAR(255),
	ADM_PW VARCHAR(255)
	);

INSERT INTO ADMIN_INFO VALUES (1, 'admin','admin');
INSERT INTO ADMIN_INFO VALUES (2, 'system','system');

SELECT * FROM INFO;
SELECT * FROM RoomInfo;
SELECT * FROM house_option;
SELECT * FROM MY_PAGE;
SELECT * FROM love_room;
SELECT * FROM ADMIN_INFO;
