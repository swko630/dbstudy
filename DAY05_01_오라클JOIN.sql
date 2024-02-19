/*

   내부 조인
*/
-- 1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오.
SELECT E.EMP_NO, E.NAME, E.DEPART, D.DEPT_NAME
 FROM DEPART_T D , EMPLOYEE_T E     -- FROM절에 조인 없애고 ,로 바꾸고
 WHERE D.DEPT_NO = E. DEPART ;      -- ON절이 아니라 WHERE 절로

-- 2. 부서별 평균연봉을 조회하시오. 부서명과 평균연봉을 조회하시오.
SELECT D.DEPT_NAME , AVG(E.SALARY)
 FROM DEPART_T D INNER JOIN EMPLOYEE_T E
 ON D.DEPT_NO = E.DEPART -- 왼쪽에  PK 오른쪽에 FK
GROUP BY D.DEPT_NAME;

/*
   
    외부 조인(OUTER JOIN)

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
  FROM DEPART_T D , EMPLOYEE_T E
  WHERE D.DEPT_NO(+) = E. DEPART ; -- 오른쪽 조인은 왼쪽에 (+) 추가하기

  -- 2. 부서별 사원수를 조회하시오. 부서명, 사원수를 조회하시오. 사원이 없으면 0으로 조회하시오.
  SELECT D.DEPT_NAME, COUNT(E.EMP_NO) ---EMP.NO가 PK키이기 때문에 갯수를 세서 정확함 *는 모든 데이터기 때문에 정확하지않음
  FROM DEPART_T D , EMPLOYEE_T E -- 왼쪽 조인은 오른쪽에 (+) 추가하기
  WHERE D.DEPT_NO = E. DEPART (+)
  GROUP BY D.DEPT_NAME ;
  
-- HR 계정으로 접속  

-- 내부 조인 연습

-- 1. 사원번호, 사원명, 부서명을 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
FROM DEPARTMENTS D , EMPLOYEES E 
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID ;

-- 2. 부서번호, 부서명, 지역명을 조회하시오.
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.STREET_ADDRESS,
FROM LOCATIONS L , DEPARTMENTS D
WHERE L.LOCATION_ID = D.LOCATION_ID ;

-- 3. 사원번호, 사원명, 직업, 직업별 최대연봉, 연봉을 조회하시오.
SELECT E.EMPLOYEE_ID, E. LAST_NAME, E.JOB_ID , J.MAX_SALARY,E.SALARY
FROM JOBS J , EMPLOYEES E
WHERE J.JOB_ID = E.JOB_ID ;

-- 외부 조인

-- 4. 사원번호, 사원명, 부서명을 조회하시오. 부서가 없으면 '부서없음'으로 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, NVL(D.DEPARTMENT_NAME, '부서없음')
FROM DEPARTMENTS D , EMPLOYEES E 
WHERE D.DEPARTMENT_ID (+) = E.DEPARTMENT_ID ;

-- 5. 부서별 평균급여를 조회하시오. 부서명, 평균급여를 조회하시오. 근무중인 사원이 없으면 평균급여를 0으로 조회하시오.
SELECT D.DEPARTMENT_NAME, NVL(FLOOR(AVG(E.SALARY)),0)
FROM DEPARTMENTS D , EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID (+) 
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME ; -- PK 두개를 이용하여 그룹화함으로 정확도 UP

-- 3개 이상 테이블 조인하기 

-- 6. 사원번호, 사원명, 부서번호, 부서명, 지역번호, 지역명을 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME , L.LOCATION_ID, L.STREET_ADDRESS
FROM DEPARTMENTS D , EMPLOYEES E, LOCATIONS L
WHERE D.DEPARTMENT_ID = E. DEPARTMENT_ID   -- 2개 먼저 조인한 ON절 마지막에 INNER JOIN을 한번 더 쓰고 테이블을 입력 후 셀릭트 절에 테이블에 따른 칼럼 추가
AND D.LOCATION_ID = L.LOCATION_ID ;  -- FROM 절로 테이블 다 데리고 오고 ,로 정리 후 첫 조건을 WHERE절로 하고 두번째 묶는 조건을 AND로 일반 조건처럼 처리

SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME , L.LOCATION_ID, L.STREET_ADDRESS
FROM LOCATIONS L INNER JOIN DEPARTMENTS D
ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID ; -- 성능 상 아래꺼 선택, PK가 앞에 있기 때문

-- 7. 국가명, 도시명, 부서명을 조회하시오.
SELECT C.COUNTRY_NAME, L.STREET_ADDRESS, D.DEPARTMENT_NAME
FROM COUNTRIES C , LOCATIONS L , DEPARTMENTS D                   
WHERE C. COUNTRY_ID = L. COUNTRY_ID 
AND L. LOCATION_ID = D. LOCATION_ID ;

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
  FROM EMPLOYEES ME , EMPLOYEES YOU
    WHERE ME.DEPARTMENT_ID = YOU.DEPARTMENT_ID
    AND ME.SALARY < YOU.SALARY;

