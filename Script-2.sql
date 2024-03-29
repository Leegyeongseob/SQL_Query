-- TCL
-- 트랜잭션 : 사건!! 하나의 논리적인 작업단위 : 원자성이 있다!!!! 전체를 하나의 작업단위로 본다.
-- 스프링부트 : 자동 롤백 기능 제공~, UNIT TEST를 집중적으로 해야함.(기능단위로 테스트)

-- 원자성 : 모두 하나의 작업단위 : 성공 OR 실패
-- 일관성 : 실행전에 잘못되어 있지 않으면 실행 후에도 잘못되어 있지 않아야한다.
-- 고립성 : 실행중에는 별도의 공간에서 실행되는 개념이다.
-- 영속성 : DB를 꺼도 트랜잭션은 영구적으로 저장되어야한다. 휘발성 데이터는 램에 저장(휘발성)~

-- 세션이란? 어떤 활동들을 위한 시간이나 기간! 절차 하나의 연결! 클라이언트 - 서버 관계에서도 웹세션이라고 한다.

-- 랜카드에 TCP/IP가 내장되어있다. 

-- DDL : 테이블 생성
-- JPA : CLASS로 테이블을 만듬. @사용
-- OOP(Object Oriented PROGRAMMING) CLASS -> OBJECT, INSTANCE VS RDMS(ROW DATA MANAGEMENT SYSTEM) TABLE -> INSTANCE, RECORD, TUPLE , ROW
--                차이점 :      
--                               객체 상속                                 조인
--                  차이를 메워주는 ORM(OBJECT RELATIONAL MAPPING)     API로 만든게 JPA 객체지향으로 만들면 JPA가 TABLE로 바꿔준다. DDL도 자바에서 가능!!
-- REACT NATIVE : 웹 바깥에 세상 , 앱으로!!!  그래서 REST.API가 중요!!!

-- 데이터를 보관하고 관리하기 위해 제공되는 여러 객체의 생성(create), 변경(alter), 삭제(drop) 관련 기능을 수행
-- DDL은 COMMIT, ROLLBACK이 없음. (위험!)


CREATE TABLE EMP_DDL (
		EMPNO    NUMBER(4),
		ENAME     VARCHAR2(10),
		JOB         VARCHAR2(9),
		MGR        NUMBER(4),
		HIRDATE   DATE,
		SAL         NUMBER(7 , 2), -- 총 7자리의 숫자 중 소수점 이하가 2자리, 정수부 5자리
		COMM     NUMBER(7 , 2),
		DEPTNO   NUMBER(2)
);

SELECT * FROM EMP_DDL;

-- 제약조건 : 중복여부, NULL, NOT NULL

-- 기존 테이블을 복사해서 새 테이블 만들기
CREATE TABLE DEPT_DDL
		AS SELECT * FROM DEPT;

SELECT * FROM DEPT_DDL;


CREATE TABLE EMP_DDL_30
		AS SELECT * FROM EMP
		WHERE DEPTNO = 30;
	
SELECT * FROM EMP_DDL_30;

-- 테이블을 변경하는 ALTER : 테이블에 새 열을 추가, 삭제하거나 열의 자료형 또는 길이 변경
CREATE TABLE EMP_ALTER
			AS SELECT * FROM EMP;
		
SELECT * FROM EMP_ALTER;

-- ALTER에 ADD : 컬럼을 추가
ALTER TABLE EMP_ALTER
		ADD PHONENUMBER VARCHAR(20);
	
-- ALLTER에 RENAME: 널 이름을 변경
ALTER TABLE EMP_ALTER
		RENAME COLUMN PHONENUMBER TO PHONE;

-- ALLTER에 MODIFY : 열의 자료형을 변경
ALTER TABLE EMP_ALTER
		MODIFY EMPNO NUMBER(20); -- 크기를 크게하는 건 가능
	
		
		
ALTER TABLE EMP_ALTER
		MODIFY PHONE VARCHAR(18); -- 크기를 줄였지만 영향 받는 해당 컬럼에 대한 데이터가 영향 받지 않으면 가능.
		
-- ALTER에 DROP : 특정 열을 삭제 할 때		
ALTER TABLE EMP_ALTER
		DROP COLUMN PHONE;
	
-- 테이블 이름 변경
RENAME EMP_ALTER TO EMP_RENAME;
SELECT* FROM EMP_RENAME;

-- 테이블 데이터를 삭제하는 TRUNCATE
TRUNCATE  TABLE EMP_RENAME; -- ROLLBACK 안됨.
DELETE FROM EMP_RENAME; -- ROLLBACK 가능.


-- 테이블을 삭제하는 DROP
DROP TABLE EMP_RENAME;

-- 제약조건
-- NOT NULL
-- UNIQUE
-- PRIMARY KEY
-- FKREIGN KEY
-- CHECK

-- 1. 부적절한 데이터 방지
-- 2. 무결성 유지(영역무결성, 객체무결성, 참조무결성)

CREATE TABLE TABLE_NOTNULL(
		LOGIN_ID VARCHAR2(20) NOT NULL,
		LOGIN_PWD VARCHAR2(20) NOT NULL,
		TEL VARCHAR2(20)
);

INSERT INTO TABLE_NOTNULL VALUES('KES2024','SPHB8250', NULL);
SELECT * FROM TABLE_NOTNULL;

-- UPDATE는 DML이며 열의 데이터를 수정
UPDATE TABLE_NOTNULL
		SET TEL = '010-5006-4146'
		WHERE LOGIN_ID = 'KES2024';
	
ALTER TABLE TABLE_NOTNULL
		MODIFY TEL NOT NULL;

-- 중복 값을 허용하지 않는 UNIQUE,
CREATE TABLE TABLE_UNIQUE (
		LOGIN_ID VARCHAR2(20) UNIQUE NOT NULL,
		LOGIN_PWD VARCHAR2(20) NOT NULL,
		TEL VARCHAR(20)
);

INSERT INTO TABLE_UNIQUE  VALUES('안유진', 'AUJ1234', '010-1234-5678');
INSERT INTO TABLE_UNIQUE  VALUES('설윤', 'su1234','010-1234-8436');
SELECT * FROM TABLE_UNIQUE;
DROP TABLE TABLE_UNIQUE;

-- PRIMARY KEY는 UNIQUE와 NOT NULL기능을 갖고 자동으로 인덱스가 만들어져서 검색이 빠르다.

-- 다른 테이블과 관계를 맺는 FOREIGN KEY(외래키)
-- 외래키는 서로 다른 테이블과 관계를 정의하는데 사용하는 제약 조건
-- 참조하고 있는 기본키의 데이터 타입과 일치해야 하며, 외래키에 참조되고 있는 기본키는 삭제 할 수 없음.

CREATE TABLE DEPT_FK(
		DEPTNO NUMBER(20) PRIMARY KEY,
		DNAME VARCHAR2(14),
		LOC VARCHAR2(13)
);

CREATE TABLE EMP_FK(
		EMPNO NUMBER(4) PRIMARY KEY,
		ENAME VARCHAR(10),
		JOB VARCHAR2(9),
		MGR NUMBER(4),
		HIREDATE DATE,
		SAL NUMBER(7,2),
		COMM NUMBER(7,2),
		DEPTNO NUMBER(2) REFERENCES DEPT_FK(DEPTNO)
);

INSERT INTO DEPT_FK VALUES(10,'걸그룹','서울');
INSERT INTO DEPT_FK VALUES(20,'걸그룹','서울');

INSERT INTO EMP_FK VALUES(9000,'안유진','아이브', 8000, SYSDATE, 5000, 1000, 10);
INSERT INTO EMP_FK VALUES(9001,'유나','잇지', 8000, SYSDATE, 5000, 1000, 20);

SELECT * FROM EMP_FK;
SELECT * FROM DEPT_FK;

DELETE FROM EMP_FK
WHERE DEPTNO = 20;
DELETE FROM DEPT_FK
WHERE DEPTNO = 10;

-- CHECK 제약조건 설정 : 길이에 관한 제약조건, 기본값을 정하는 제약조건 DEFAULT



-- 데이터 사전
-- * 인덱스, 뷰, 시퀀스!!!!

-- 데이터 사전이란 ? 데이터베이스 메모리 성능, 사용자, 권한, 객체 등 
-- 오라클 데이터베이스 운영에 필요한 중요 데이터가 보관되어 있음.

SELECT * FROM DICT;

-- 인덱스란? 데이터 검색 성능 향상을 위해 테이블 열에 사용하는 객체
-- 장점 : 검색속도가 빨라지면, 시스템의 부하를 줄여 전체적인 성능을 향상 시킨다. -> 검색을 빈번하게 하는 경우

-- 인덱스의 단점
-- 1. 생성 시간 필요, 추가적이 공간이 필요
-- 2. 검색 외 데이터 변경(INSERT/UPDATE/DELETE)가 빈번히 일어날 경우 성능이 저하됨.

SELECT * FROM USER_INDEXES; --> 인덱스 테이블

CREATE INDEX idx_emp_sal ON EMP(SAL);

-- 뷰는 일부만 테이블로 만들어서 저장하는 방법

-- 테이블 뷰 : 가상 테이블로 부르는 뷰는 하나 이상의 테이블을 조회하는 SELECT문을 저장하는 객체

-- 사용 목적은 필요한 테이블만 제공하거나 테이블의 특정 열을 숨기는 등의 보안 목적으로 사용할 수 있음.



CREATE VIEW VW_EMP20
AS (SELECT EMPNO, ENAME, JOB, DEPTNO 
		FROM EMP
		WHERE DEPTNO = 20);

SELECT * FROM VW_EMP20;

-- 시퀀스란?
-- 규칙에 따라 순번을 생성하는 시퀀스
-- 시퀀스(Sequence)는 오라클 데이터베이스에서 특정 규칙에 맞는 연속 숫자를 생성하는 객체

CREATE TABLE DEPT_SEQUENCE
AS (SELECT * FROM DEPT WHERE 1 <> 1);

SELECT * FROM DEPT_SEQUENCE;

-- 시퀀스 테이블 만들기
CREATE SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 2;

SELECT* 
FROM USER_SEQUENCES;

INSERT INTO DEPT_SEQUENCE VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL,'DATABASE', 'SEOUL');
INSERT INTO DEPT_SEQUENCE VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL,'DATABASE', 'SEOUL');











