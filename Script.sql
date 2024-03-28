-- 연결 연산자 : SELECT문 조회시 컬럼 사이에 특정한 문자를 넣을 때 사용
SELECT ENAME || 'S JOB IS' || JOB AS "EMPLOYEE"
FROM emp;

-- 실습문제 1 : 사원이름이 S로 끝나는 사원 데이터 모두 출력

SELECT * FROM EMP
WHERE ENAME LIKE '%S';

-- 실습문제 2 :30번 부서에서 근무하고 있는 사원 중에 직책이 SALESMAN인 사원의
-- 사원 번호, 이름, 직책, 급여, 부서 번호 출력

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 30;

-- 실습문제 3 : 20번 30번 부서에 근무하고 있는 사원 중 급여가 2000초과인 사원의
-- 사원번호, 이름, 급여, 부서 번호 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN(20,30);

-- 실습문제 4: NOT BETWEEN A AND B 연산자를 쓰지 않고 급여가 2000이상, 3000이하 범위 이외의
-- 값을 가진 데이터만 출력

SELECT * FROM EMP
WHERE SAL < 2000 OR SAL > 3000;

-- 실습문제 5: 사원 이름에 E가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가 아닌,
-- 사원 이름, 사원 번호, 급여, 부서 번호 출력

SELECT ENAME, EMPNO, SAL, DEPTNO
FROM EMP
WHERE ENAME LIKE '%E%' AND DEPTNO = 30 AND SAL NOT BETWEEN 1000 AND 2000;

-- 실습문제 6: 추가수당이 존재하지 않고 상급자가 있고, 직책이 MANAGER, CLERK인 사원 중에
-- 사원 이름의 두 번째 글자가 L이 아닌 사원의 정보 출력

SELECT * FROM EMP
WHERE COMM IS NULL AND MGR IS NOT NULL AND JOB IN('MANAGER','CLERK') AND ENAME NOT LIKE '_L%';

-- 숫자 함수 : 수학적 계산식을 처리하기 위한 함수를 의미
SELECT -10, ABS(-10) FROM DUAL; --DUAL은 가상테이블(더미테이블)

--ROUND : 반올림한 결과를 반환, 반올람한 위치를 지정할 수 있으며 지정하지 않으면,
-- 0으로 지정한 위치에서 반올림.

SELECT ROUND(1234.5678) AS round,--위치를 지정하지 않으면 0의 위치(소수점 첫번째 자리를 반올림)
	ROUND(1234.5678, 0) AS round_0,
	ROUND(1234.5678, 1) AS round_1,
	ROUND(1234.5678, 2) AS round_2,
	ROUND(1234.5678, -1) AS round_minus1,
	ROUND(1234.5678, -2) AS round_minus2
FROM DUAL;

-- TRUNC : 버림을 한 결과를 반환하는 함수
SELECT TRUNC(1234.5678) AS TRUNC,--위치를 지정하지 않으면 0의 위치(소수점 첫번째 자리를 반올림)
	TRUNC(1234.5678, 0) AS TRUNC_0,
	TRUNC(1234.5678, 1) AS TRUNC_1,
	TRUNC(1234.5678, 2) AS TRUNC_2,
	TRUNC(1234.5678, -1) AS TRUNC_minus1,
	TRUNC(1234.5678, -2) AS TRUNC_minus2
FROM DUAL;

-- MOD : 나누기한 후 나머지를 출력하는 함수
SELECT MOD(21,5) FROM DUAL;
-- CEIL : 소수점 이하가 있으면 무조건 올림
SELECT CEIL(12.345) FROM DUAL;
-- FLOOR 소수점 이하를 무조건 버림
SELECT FLOOR(12.545) FROM DUAL;
-- POWER : 정수A를 정수B만큼 제곱하는 함수
SELECT POWER(3,4) FROM DUAL;

-- 문자 함수 : 문자 데이터를 가공하거나 문자 데이터로부터 특정 결과를 얻고자 할때 사용
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

-- 문자열 길이를 구하는 LENGTH 함수
SELECT ENAME, LENGTH(ENAME) FROM EMP;
-- LENGTH(문자열 길이)와 LENGTHB(문자열의 바이트 수) 함수 비교
SELECT LENGTH('한글'), LENGTH('ENG'), LENGTHB ('한글'), LENGTHB('ENG') 
FROM DUAL;

-- SUBSTR(대상, 시작위치, 길이) / SUBSTRB
-- 대상 문자열의 시작위치부터 선택한 갯수만큼 문자를 반환
-- 데이터베이스는 프로그래밍 언어와 달리 0부터 시작하는 인덱스가 아님
SELECT JOB, SUBSTR(JOB,1,2),SUBSTR(JOB,3,2), SUBSTR(JOB,5)
FROM EMP;
-- 음수값은 뒤에서부터 계산함()
SELECT JOB,SUBSTR(JOB,-LENGTH(JOB)),
	SUBSTR(JOB,-LENGTH(JOB),2),
	SUBSTR(JOB,-3)
FROM EMP;

--INSTR :문자열 데이터 안에 측정 문자나 문자열이 어디에 포함되어 있는지를 알아 낼 때 사용
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR1, -- 1번째부터 검색시작
	INSTR('HELLO ORACLE!','L',5) AS INSTR2, -- 5번째부터 검색 시작
	INSTR('HELLO ORACLE!','L',2,2) AS INSTR3  --2번째부터 검색하는데 해당 문자 2번째 나타날때까지 검색
FROM DUAL;

--특정 문자가 포함된 행 찾기
SELECT *FROM EMP
WHERE INSTR(ENAME, 'S') > 0;

SELECT * FROM EMP
WHERE ENAME LIKE '%S%';

-- REPLACE : 특정 문자열데이터에 포함된 문자를 다른 문자로 대체 할 때 사용
SELECT '010-1234-5678' AS REPLACE_BEFORE,
	REPLACE('010-1234-5678','-',' ') AS REPLACE1,
	REPLACE('010-1234-5678','-') AS REPLACE2
FROM DUAL

-- LPAD/ RPAD : 기준 공간 칸수를 지정하고 빈칸 만큼 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+'),
	RPAD('ORACLE',10,'-'),
	LPAD('ORACLE',10)
FROM DUAL;

-- 개인정보 뒷자리를 *로 표시하기
SELECT RPAD('971215-1',14,'*') AS RPAD_JUMIN,
	RPAD('010-1234-',13,'*') AS RPAD_PHONE
FROM DUAL;

-- 두 문자열을 합치는 CONCAT 함수
SELECT CONCAT(EMPNO, ENAME),CONCAT(EMPNO,CONCAT(' : ',ENAME)) 
FROM EMP
WHERE ENAME = 'JAMES';

-- TRIM / LTRIM / RTRIM : 문자열 데이터 내에서 특정 문자를 지우기 위해 사용
SELECT '[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
 '[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
 '[' || LTRIM('<_Oracle_>', '<_') || ']' AS LTRIM_2,
 '[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
 '[' || RTRIM('<_Oracle_>', '_>') || ']' AS RTRIM_2
 FROM DUAL;

-- 날짜 데이터를 다루는 날짜 함수
-- SYSDATE : 운영체제로부터 시간을 읽어 옴
SELECT SYSDATE FROM DUAL; -- 현재시간

SELECT SYSDATE AS "현재시간",
	SYSDATE -1 AS "어제",
	SYSDATE +1 AS "내일"
FROM DUAL;

-- 몇 개월 이후 날짜를 구하는 ADD_MONTHS 함수
 -- 지금부터 3개월 이후의 날짜구하기
SELECT SYSDATE,
	ADD_MONTHS(SYSDATE,3)
FROM DUAL;
-- 입사 10주년이 되는 사원들 데이터 출력하기
SELECT EMPNO, ENAME, HIREDATE,
	ADD_MONTHS(HIREDATE,120) AS "입사 10주년"
FROM EMP

-- 연습문제 : SYSDATE와 ADD_MONTH함수를 사용하여 현재날짜와 6개월 이후 날짜 출력
SELECT SYSDATE,
	ADD_MONTHS(SYSDATE,6)
FROM DUAL;

-- 다중행 함수 : 여러 행에 대해 함수가 적용되어 하나의 결과를 나타내는 함수
SELECT SUM(SAL) 
FROM EMP;

-- 집계가 되는 부분 안되는 부분을 같이 쓰면 안된다.
--EX) SELECT SUM(SAL), EMPNO -- 한개의 행과 어려개의 행 -> 에러
--    FROM EMP;
-- > 그래서 나온게 GROUP BY
-- GROUP BY
SELECT DEPTNO , SUM(SAL)
FROM EMP
GROUP BY DEPTNO;  --> 그룹별로 급여 합 계산
-- 1. 먼저 사원 테이블을 가져 옴
-- 2. 사원 테이블을 부서 단위로 묶음
-- 3. 부서와 부서의 급여의 합계를 출력

-- 모든 사원의 급여와 수당의 합계 구하기
SELECT SUM(SAL), SUM(COMM)
FROM EMP;
-- 테이블의 데이터 COUNT
-- 행의 개수 출력
SELECT COUNT(*)
FROM EMP;
-- 30번 부서의 사원 수 출력 1. FROM 2. WHERE 3. SELECT
SELECT COUNT(*)
FROM EMP
WHERE DEPTNO = 30;
-- NULL이 아닌 COMM행 COUNT
SELECT COUNT(COMM)
FROM EMP

-- 10번 부서의 사원 중 최대 급여 출력하기
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 10;

-- 30번 부서의 평균 급여 출력하기
SELECT ROUND(AVG(SAL))
FROM EMP
WHERE DEPTNO =30;

-- 써브 쿼리
SELECT E.ENAME, E.SAL
FROM EMP E
WHERE E.DEPTNO  = 10
AND E.SAL =(SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10);

-- 출력 순서 1. FROM 2. WHERE 3. GROUP BY 4. SELECT 5. ORDER BY

-- 부서별 평균 급여 출력하기
SELECT AVG(SAL), DEPTNO
FROM EMP
GROUP BY DEPTNO;

-- 이렇게 출력할 수도 있지만 그러면 DEPTNO는 출력할 수 없음.
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 20;

SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30

-- 부서 번호 및 직책별 평균 급여 정렬하기
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO ,JOB
ORDER BY DEPTNO ,JOB;

-- 부서 코드, 급여 합계, 부서 평균, 부서 코드 순 정렬로 출력하기
SELECT DEPTNO AS "부서 코드",
	SUM(SAL) AS "급여 합계",
	ROUND(AVG(SAL)) AS "급여 평균",
	COUNT(*) AS "인원수"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 1. FROM 2. WHERE 3. GROUP BY 4. HAVING 5.SELECT 6. ORDER BY

-- HAVING절 : GROUP BY 절이 존재 할때만 사용
-- GRUOP BY로 절을 통해 그룹화된 결과 값의 범위를 제한하는데 사용
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
	HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;
-- 점점 짬뽕이 되어가고 있다아아아아아아아아아아아아아
SELECT JOB, AVG(SAL)
FROM EMP
WHERE DEPTNO = 10
GROUP BY JOB
	HAVING AVG(SAL) >= 2000
ORDER BY JOB;

-- 1. HAVING절을 사용하여 부서별 직책의 평균 급여가 500이상인 사원들의 부서번호, 직책
-- 부서별 직책의 평균 급여 출력
SELECT DEPTNO, JOB, AVG(SAL) 
FROM EMP
GROUP BY DEPTNO, JOB
	HAVING AVG(SAL) > =500; 
-- 2. 부서번호, 평균 급여, 최고 급여, 최저 급여, 사원수 출력, 단, 평균급여는 소수점 제외하고 출력
-- 단, 평균 급여는 소수점 제외하고 부서 번호별 출력
SELECT DEPTNO, FLOOR(AVG(SAL)) AS "평균 급여" , 
		MAX(SAL) AS "최고 급여", 
		MIN(SAL) AS "최저 급여", 
		COUNT(*) AS "사원수 출력"
FROM EMP
GROUP BY DEPTNO;
-- 3. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력
SELECT JOB AS "직책", 
		COUNT(*) AS "사원 수"
FROM EMP
GROUP BY JOB
	HAVING COUNT(JOB) >= 3;

-- 4. 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT EXTRACT(YEAR FROM HIREDATE) AS "입사 년도",
			DEPTNO, 
			COUNT(*) AS "사원 수"
FROM EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE), DEPTNO
ORDER BY "입사 년도";

-- 5. 추가 수장을 받는 사원과 받지 않은 사원수 출력, 추가 수당 여부는 0, X로 표기
SELECT NVL2(COMM, 'O','X') AS "추가 수당",COUNT(*)
FROM EMP
GROUP BY NVL2(COMM, 'O','X');

-- 6. 각 부서의 입사 년도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력
SELECT DEPTNO,EXTRACT(YEAR FROM HIREDATE) AS "입사 년도",
		COUNT(*) AS "사원 수", 
		MAX(SAL) AS "최고 급여", 
		SUM(SAL) AS "급여 합",
		AVG(SAL) AS "평균 급여"
FROM EMP
GROUP BY DEPTNO, EXTRACT(YEAR FROM HIREDATE)
ORDER BY DEPTNO, "입사 년도";

-- ROLLUP 함수 :
SELECT DEPTNO,JOB,COUNT(*), MAX(SAL), MIN(SAL), SUM(SAL),AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB); -- 중간 통계를 내줌, DEPTNO 그룹에 대한 중간 통계

-- 집합연산자 : 두개 이상의 퀴리 결과를 하나로 결합하는 연산자(수직적 처리)
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 20;
-- 컬럼이 다르면 안됌!

-- 조인(Join) : 두 개 이상의 테이블에서 데이터를 가져와서 연결하는 데 사용되는 SQL 기능
-- 테이블에 대한 식별 값인 PRIMARY KEY, FOREIGN KEY 간의 공통 값인 FROEIGN KEY 값을 사용하여 조인
-- 내부 조인(동등 조인, inner join)이며 오라클 방식, 양쪽에 동일한 컬럼이 있는 경우 테이블 이름을 표시해야함.

SELECT EMPNO, ENAME, MGR, e.DEPTNO 
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO
AND SAL >= 2000
ORDER BY DEPTNO;
-- 	ANSI 방식
SELECT EMPNO, ENAME, MGR, e.DEPTNO
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE SAL >= 2000
ORDER BY DEPTNO;

-- EMP 테이블 별칭을 E로, DEPT 테이블 별칭은 D로 하여 다음과 같이 등가 조인을 했을 때,
-- 급여가 2500이하이고 사원 번호가 9999이하인 사원의 정보가 출력되도록 작성
SELECT E.EMPNO , E.ENAME, D.DEPTNO , D.DNAME, D.LOC 
FROM EMP E  JOIN DEPT D
ON E.DEPTNO  = D.DEPTNO 
WHERE SAL <=2500 AND EMPNO <=9999
ORDER BY EMPNO;

-- 비등가 조인: 동일한 컬럼이 없을 때 사용하는 조인(일반적으로 많이 사용되지는 않음)

SELECT * FROM EMP;
SELECT * FROM SALGRADE;

SELECT e.ENAME, e.SAL , s.GRADE
FROM EMP e JOIN SALGRADE s
ON e.SAL BETWEEN s.LOSAL AND s.HISAL; --JOIN을 할수 있는 조건만 있으면 조인을 할 수 있다.

-- 자체 조인: 현재 테이블을 조인해서 자체적인 결과를 찾아 낼 때 사용.
SELECT e1.EMPNO, e1.ENAME , e1.MGR,
		e2.EMPNO AS "상관 사원번호",
		e2.ENAME AS "상관 이름"
FROM EMP e1 JOIN EMP e2
ON e1.MGR = e2.EMPNO 

-- 외부 조인 (LEFT OUTER JOIN) : 왼쪽 기준으로 오른쪽을 채줘달나라
SELECT e.ENAME, e.DEPTNO, d.DNAME
FROM EMP e, DEPT d
WHERE e.DEPTNO(+)  = d.DEPTNO
ORDER BY e.DEPTNO;
-- 결핍된 값이 있는 개체정보를 알려면 OUTER JOIN.

SELECT e.ENAME, e.DEPTNO, d.DNAME
FROM EMP e FULL OUTER JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
ORDER BY e.DEPTNO;

-- NATURAL JOIN : 동등조인을 사용하는 다른 방법, 조건절 없이 사용, 두 테이블의 같은 열을 자동으로 연결
SELECT e.EMPNO, e.ENAME, d.DNAME, DEPTNO
FROM EMP e NATURAL JOIN DEPT d ; 

--JOIN ~USING : 동등조인(등가 조인)을 대신하는 방식 중의 하나
SELECT e.EMPNO, e.ENAME, d.DNAME, DEPTNO
FROM EMP e JOIN DEPT d USING(DEPTNO) 
WHERE SAL >= 3000
ORDER BY DEPTNO , e.EMPNO;

-- 연습문제 1 : 급여가  2000 초과인 사원들의 부서 정보, 사원 정보 출력(SQL-99 방식)
SELECT DEPTNO, DNAME, EMPNO, ENAME, SAL
FROM EMP NATURAL JOIN DEPT
WHERE SAL >2000;

-- 연습문제 2 : 부서별 평균, 최대 급여, 최소 급여, 사원 수 출력(ANSI JOIN)
SELECT d.DEPTNO, DNAME,
		ROUND(AVG(SAL)) AS "평균 급여",
		MAX(SAL) AS "최대 급여",
		MIN(SAL) AS "최소 급여",
		COUNT(*) AS "사원 수"
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
GROUP BY d.DEPTNO, d.DNAME;

-- 연습문제 3 : 모든 부서 정보와 사원 정보를 부서 번호, 사원 이름순으로 정렬해서 출력
SELECT d.DEPTNO, d.DNAME, e.EMPNO, e.ENAME, e.JOB, e.SAL
FROM EMP e RIGHT OUTER JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
ORDER BY DEPTNO, ENAME;

-- scott 계정 연습 문제(2)
-- 1. 사원번호가 7499인 사원의 이름, 입사일 부서번호 출력
SELECT ENAME,TO_CHAR(HIREDATE,'YY/MM/DD'), DEPTNO
FROM EMP
WHERE EMPNO = 7499;

-- 2. 이름이 ALLEN인 사원의 모든 정보 출력
SELECT EMPNO ,ENAME,JOB,MGR,TO_CHAR(HIREDATE,'YY/MM/DD'),SAL, COMM,DEPTNO
FROM EMP
WHERE ENAME = 'ALLEN';
-- 3. 이름이 K보다 큰 글자로 시작하는 사원의 모든 정보 출력
SELECT EMPNO ,ENAME,JOB,MGR,SAL, COMM, DEPTNO
FROM EMP
WHERE ENAME > 'K';
-- 4. 입사일이 81년 4월2일보다 늦고, 82년 12월9일보다 빠른 사원의 이름, 급여, 부서번호 출력
SELECT ENAME,SAL ,DEPTNO,TO_CHAR(HIREDATE,'YY/MM/DD')
FROM EMP
WHERE HIREDATE > '81.04.02' AND HIREDATE <'82.12.9';
-- 5. 급여가 1,600보다 크고, 3000보다 작은 사원의 이름, 직무, 급여를 출력
SELECT ENAME,JOB,SAL
FROM EMP
WHERE SAL BETWEEN 1601 AND 2999;
-- 6. 입사일이 81년 이외에 입사한 사원의 모든 정보 출력
SELECT EMPNO ,ENAME,JOB,MGR,TO_CHAR(HIREDATE,'YY/MM/DD'),SAL, COMM,DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE,'YY') != '81';
-- 7. 직업이 MANAGER와 SALESMAN인 사원의 모든 정보를 출력
SELECT EMPNO ,ENAME,JOB,MGR,TO_CHAR(HIREDATE,'YY/MM/DD'),SAL, COMM,DEPTNO
FROM EMP
WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN';
-- 8. 부서가 20번, 30번을 제외한 모든 사원의 이름, 사원번호, 부서번호
SELECT ENAME,EMPNO,DEPTNO
FROM EMP
WHERE DEPTNO NOT IN(20,30);
-- 9. 이름이 S로 시작하는 사원의 사원번호, 이름, 부서번호 출력
SELECT EMPNO, ENAME,DEPTNO
FROM EMP
WHERE ENAME LIKE 'S%';
-- 10. 처음 글자는 관계없고, 두 번째 글자가 A인 사원의 모든 정보를 출력
SELECT EMPNO ,ENAME,JOB,MGR,TO_CHAR(HIREDATE,'YY/MM/DD'),SAL, COMM,DEPTNO
FROM EMP
WHERE ENAME LIKE '_A%';
-- 11. 커미션이 NULL이 아닌 사원의 모든 정보 출력
SELECT EMPNO ,ENAME,JOB,MGR,TO_CHAR(HIREDATE,'YY/MM/DD'),SAL, COMM,DEPTNO
FROM EMP
WHERE COMM IS NOT NULL;
-- 12. 이름이 J자로 시작하고 마지막 글자가 S인 사원의 모든 정보를 출력
SELECT EMPNO ,ENAME,JOB,MGR,TO_CHAR(HIREDATE,'YY/MM/DD'),SAL, COMM,DEPTNO
FROM EMP
WHERE ENAME LIKE 'J%S';
-- 13. 급여가 1500이상이고, 부서번호가 30번인 사원중 직무가 MANAGER인 사원의 모든 정보 출력
SELECT EMPNO ,ENAME,JOB,MGR,TO_CHAR(HIREDATE,'YY/MM/DD'),SAL, COMM,DEPTNO
FROM EMP
WHERE SAL >= 1500 AND DEPTNO =30 AND JOB = 'MANAGER';
-- 14. 모든 사원의 이름,급여,커미션,총액(급여+커미션)을 구하여 총액이 많은 순서로 출력 (단, 커미션이 NULL인 사원도 0으로 포함)
SELECT ENAME, SAL, NVL(COMM,0), NVL2(COMM, SAL+COMM, SAL) AS 총액
FROM EMP
ORDER BY 총액 DESC;
-- 15. 10번 부서의 모든 사원에게 급여의 13%를 보너스로 지불하기로 하였다. 10번 부서 사원들의 이름, 급여, 보너스, 부서번호 출력
SELECT ENAME, SAL, SAL*1.13, DEPTNO
FROM EMP
WHERE DEPTNO =10;
-- 16. 모든 사원에 대해 입사한 날로부터 60일이 지난 후의 '월요일'에 대한 년,월,일을 구하여 이름,입사일, 60일 후의 '월요일' 날짜를 출력
SELECT ENAME, TO_CHAR(HIREDATE,'YY/MM/DD') AS HIREDATE,
TO_CHAR(NEXT_DAY(HIREDATE+60,'월요일'), 'YYYY/MM/DD') AS HIREDATE
FROM EMP;
-- 17. 이름의 글자수가 6자 이상인 사원의 이름을 앞에서 3자만 구하여 소문자로 이름만 출력
SELECT LOWER(SUBSTR(ENAME,1,3))
FROM EMP
WHERE LENGTH(ENAME) >= 6;
-- 18. 사원들의 사원번호와 급여 커미션, 연봉(COMM+SAL)*12)을 연봉이 많은 순서로 출력
SELECT EMPNO, SAL,NVL(COMM,0) AS 커미션, NVL2(COMM,(COMM+SAL)*12,SAL*12) AS 연봉0
FROM EMP
ORDER BY SAL DESC;
-- 19. 모든 사원들의 입사한 년/월/일
--(예, 1981년 5월30일)
SELECT TO_CHAR(HIREDATE,'YYYY"년"MM"월"DD"일"')
FROM EMP;
-- 20. 10번 부서에 대해 급여의 평균 값, 최대 값, 최소 값, 인원 수를 출력
SELECT AVG(SAL), MAX(SAL),MIN(SAL),COUNT(*)
FROM EMP
WHERE DEPTNO =10;
-- 21. 사원번호가 짝수인 사원들의 모든 정보를 출력
SELECT EMPNO ,ENAME,JOB,MGR,TO_CHAR(HIREDATE,'YY/MM/DD'),SAL, COMM,DEPTNO
FROM EMP
WHERE MOD(EMPNO, 2) = 0;
-- 22. 각 부서별 같은 직무를 갖는 사원의 인원수를 구하여 부서번호, 직무, 인원수 출력
SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY DEPTNO,JOB;
-- 23. EMP와 DEPT테이블을 조인하여 모든 사원에 대해 부서 번호, 부서이름, 사원이름 급여를 출력
SELECT e.DEPTNO,DNAME,ENAME,SAL
FROM EMP e JOIN DEPT D
ON e.DEPTNO = d.DEPTNO
ORDER BY DEPTNO;
-- 24. 이름이 'ALLEN'인 사원의 부서 번호, 부서 이름, 사원 이름, 급여 출력
SELECT e.DEPTNO,DNAME,ENAME,SAL
FROM (SELECT ENAME, SAL, DEPTNO FROM EMP WHERE ENAME = 'ALLEN') e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO;
-- 25. 'ALLEN'과 직무가 같은 사원의 이름, 부서 이름, 급여, 부서 위치를 출력
SELECT ENAME, DNAME, SAL, LOC
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME = 'ALLEN');
-- 26. 모든 사원들의 평균 급여보다 많이 받는 사원들의 사원번호와 이름 출력
SELECT EMPNO, ENAME
FROM EMP
WHERE SAL> (SELECT AVG(SAL) FROM EMP);
-- 27. 부서별 평균 급여가 2000보다 적은 부서 사원들의 부서 번호 출력
SELECT DEPTNO
FROM EMP
GROUP BY DEPTNO
	HAVING AVG(SAL) <2000;
-- 28. 30번 부서의 최고급여보다 급여가 많은 사원의 사원 번호, 이름, 급여를 출력
SELECT EMPNO, JOB, SAL
FROM EMP
WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30);
SELECT * FROM EMP;
-- 29. 'FORD'와 부서가 같은 사원들의 이름, 부서 이름, 직무, 급여를 출력
SELECT ENAME, DNAME, JOB, SAL
FROM EMP e JOIN DEPT d
ON e.DEPTNO  = d.DEPTNO
WHERE DNAME = (SELECT DNAME FROM EMP e JOIN DEPT d ON e.DEPTNO  = d.DEPTNO WHERE ENAME ='FORD');
-- 30. 부서 이름이 'SALES'인 사원들의 평균 급여보다 많고, 부서 이름이 'RESEARCH'인 사원들의 평균 급여보다 적은 사원들의 이름, 부서번호, 급여, 직무 출력
SELECT ENAME, EMPNO, JOB
FROM EMP
WHERE SAL BETWEEN (SELECT AVG(SAL) FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO WHERE DNAME = 'SALES') AND
							 (SELECT AVG(SAL) FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO WHERE DNAME = 'RESEARCH')