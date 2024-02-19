/*
    조인
    1. 조회할 때 필요한 칼럼이 2개 이상의 테이블에 존재할 때 조인을 사용한다.
    2. 조인 조건을 이용해서 각 테이블을 조인한다.
    3. 조인 종류
       1) 내부 조인 : 조회할 테이블에 모두 존재하는 데이터를 대상으로 조인
       2) 외부 조인 : 어느 한 테이블에만 존재하는 데이터를 조회 대상에 포함
    4. 조인할 때 웬만하면 별명을 붙여야 한다. 실무에선 칼럼명이 같은 경우가 많기 때문에
*/

/*
    내부 조인(INNER JOIN)
    1. 조인하는 두 테이블에 모두 존재하는 데이터만 조회
    2. 어느 한 테이블에만 존재하는 데이터는 조회되지 않는다.
    3. ANSI 문법
        SELECT 조회할 칼럼, ...
        FROM 테이블1 INNER JOIN 테이블2
          ON 조인 조건
             FROM 절 : PK와  FK의 관계를 찾으면 된다. (PK를 왼쪽에 두면 성능상 도움을 얻을 수 있다.)
                     ㄴPK는 자동적으로 인덱스가 부여되기 때문에  ON절 좌측에 검색값에 PK값을 둘 수 있도록 해야한다. 
*/
-- 1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오.
SELECT E.EMP_NO, E.NAME, E.DEPART, D.DEPT_NAME
 FROM DEPART_T D INNER JOIN EMPLOYEE_T E
 ON D.DEPT_NO = E. DEPART ;

-- 2. 부서별 평균연봉을 조회하시오. 부서명과 평균연봉을 조회하시오.
SELECT D.DEPT_NAME , AVG(E.SALARY)
 FROM DEPART_T D INNER JOIN EMPLOYEE_T E
 ON D.DEPT_NO = E.DEPART -- 왼쪽에  PK 오른쪽에 FK
GROUP BY D.DEPT_NAME;

/*
   
    외부 조인(OUTER JOIN)
     1. 어느 한 테이블에만 존재하는 데이터도 조회된다.
     2. 해당 테이블이 왼쪽에 있으면 왼쪽 외부 조인이고 오른쪽에 있으면 오른쪽 외부 조인이다.
     3. ANSI 문법
      1) 왼쪽 외부 조인
        SELECT 조회할 칼럼, ...
        FROM 테이블1 LEFT [OUTER] JOIN 테이블2
          ON 조인 조건
      2) 오른쪽 외부 조인
        SELECT 조회할 칼럼, ...
        FROM 테이블1 RIGHT [OUTER] JOIN 테이블2
          ON 조인 조건

*/
-- 외부 조인 확인을 위한 데이터 입력
INSERT INTO EMPLOYEE_T (
     EMP_NO
   , NAME
   , DEPART
   , POSITON
   , GENDER
   , HIRE_DATE
   , SALARY
) VALUES( 
  EMPLOYEE_SEQ.NEXTVAL
  , '홍길동'
  , NULL
  , '회장'
  , 'F'
  , '00/01/01'
  , 10000000
  );
  COMMIT ;
  
  -- 1. 모든 사원들의 사원번호, 사원명, 부서명을 조회하시오.
  SELECT E.EMP_NO, E.NAME, D.DEPT_NAME
  FROM DEPART_T D RIGHT JOIN EMPLOYEE_T E
  ON D.DEPT_NO = E. DEPART ;

  -- 2. 부서별 사원수를 조회하시오. 부서명, 사원수를 조회하시오. 사원이 없으면 0으로 조회하시오.
  SELECT D.DEPT_NAME, COUNT(E.EMP_NO) ---EMP.NO가 PK키이기 때문에 갯수를 세서 정확함 *는 모든 데이터기 때문에 정확하지않음
  FROM DEPART_T D LEFT JOIN EMPLOYEE_T E
  ON D.DEPT_NO = E. DEPART
  GROUP BY D.DEPT_NAME ;
  
-- HR 계정으로 접속  

-- 내부 조인 연습

-- 1. 사원번호, 사원명, 부서명을 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E 
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID ;

-- 2. 부서번호, 부서명, 지역명을 조회하시오.
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.STREET_ADDRESS,
FROM LOCATIONS L INNER JOIN DEPARTMENTS D
ON L.LOCATION_ID = D.LOCATION_ID ;

-- 3. 사원번호, 사원명, 직업, 직업별 최대연봉, 연봉을 조회하시오.
SELECT E.EMPLOYEE_ID, E. LAST_NAME, E.JOB_ID , J.MAX_SALARY,E.SALARY
FROM JOBS J INNER JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID ;

-- 외부 조인

-- 4. 사원번호, 사원명, 부서명을 조회하시오. 부서가 없으면 '부서없음'으로 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, NVL(D.DEPARTMENT_NAME, '부서없음')
FROM DEPARTMENTS D RIGHT JOIN EMPLOYEES E 
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID ;

-- 5. 부서별 평균급여를 조회하시오. 부서명, 평균급여를 조회하시오. 근무중인 사원이 없으면 평균급여를 0으로 조회하시오.
SELECT D.DEPARTMENT_NAME, NVL(FLOOR(AVG(E.SALARY)),0)
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID 
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME ; -- PK 두개를 이용하여 그룹화함으로 정확도 UP

-- 3개 이상 테이블 조인하기 

-- 6. 사원번호, 사원명, 부서번호, 부서명, 지역번호, 지역명을 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME , L.LOCATION_ID, L.STREET_ADDRESS
FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E. DEPARTMENT_ID INNER JOIN LOCATIONS L  -- 2개 먼저 조인한 ON절 마지막에 INNER JOIN을 한번 더 쓰고 테이블을 입력 후 셀릭트 절에 테이블에 따른 칼럼 추가
ON D.LOCATION_ID = L.LOCATION_ID ;

SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME , L.LOCATION_ID, L.STREET_ADDRESS
FROM LOCATIONS L INNER JOIN DEPARTMENTS D
ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID ; -- 성능 상 아래꺼 선택, PK가 앞에 있기 때문

-- 7. 국가명, 도시명, 부서명을 조회하시오.
SELECT C.COUNTRY_NAME, L.STREET_ADDRESS, D.DEPARTMENT_NAME
FROM COUNTRIES C INNER JOIN LOCATIONS L
ON C. COUNTRY_ID = L. COUNTRY_ID INNER JOIN DEPARTMENTS D
ON L. LOCATION_ID = D. LOCATION_ID ;

-- 셀프 조인(하나의 테이블에 일대다 관계를 가지는 칼럼들이 존재하는 경우)

-- 8. 사원번호, 사원명, 매니저번호, 매니저명을 조회하시오. (사원과 매니저테이블을 구분한다고 생각) 
-- 관계
-- 1명의 매니저가 N명의 사원을 관리한다. 
--  1                                 N         (매니저 테이블과 사원테이블의 별명을 붙여 구분)
-- 매니저 테이블 : EMPLOYEES M        사원 테이블 : EMPLOYEES E 
-- 조인조건: PK                       FK
SELECT E.EMPLOYEE_ID AS 사원번호
, E. LAST_NAME AS 사원명
, E.MANAGER_ID AS 매니저번호
, M.LAST_NAME AS 매니저명
FROM EMPLOYEES M INNER JOIN EMPLOYEES E
ON M.EMPLOYEE_ID = E.MANAGER_ID ;

-- 9. 같은 부서내에서 나보다 급여를 더 많이 받는 사원을 조회하시오.
-- 관계
-- 나는 여러 사원과 관계를 맺는다.
-- 나(EMPLOYEES ME)             너님들(EMPLOYEES YOU)
-- 같은 부서의 사원만 조인하기 위해서 부서 번호로 조인조건을 생성함
SELECT ME.EMPLOYEE_ID  AS 사원번호
     , ME.LAST_NAME    AS 사원명
     , ME.SALARY       AS 급여
     , YOU.EMPLOYEE_ID AS 너사원번호
     , YOU.LAST_NAME   AS 너사원명
     , YOU.SALARY      AS 너급여
  FROM EMPLOYEES ME INNER JOIN EMPLOYEES YOU
    ON ME.DEPARTMENT_ID = YOU.DEPARTMENT_ID
 WHERE ME.SALARY < YOU.SALARY;


