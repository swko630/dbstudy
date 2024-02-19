/*
     WITH
     1. 자주 사용하거나 복잡한 쿼리문은 WITH 절로 등록시켜 놓을 수 있다.
     2. WITH 절에 등록된 쿼리문은 임시 저장 상태이므로 곧바로 사용해야 한다. 
     3. WITH 절을 이용하면 쿼리문의 가독성이 좋아진다.
     
*/

-- 1. 연봉 2 ~ 3위 사원 정보를 조회하시오.
SELECT EMP_NO, NAME, DEPART, POSITON, GENDER, HIRE_DATE, SALARY
 FROM (SELECT RANK() OVER(ORDER BY SALARY DESC) AS RN, EMP_NO, NAME, DEPART, POSITON, GENDER, HIRE_DATE, SALARY
        FROM EMPLOYEE_T)
        WHERE RN BETWEEN 2 AND 3 ;
        
-- 2. WITH 절을 이용하여 연봉 2 ~ 3위 사원 정보를 조회하시오.
WITH RANKING_T --AS 뒤의 서브쿼리를 RANKING_T라고 부르겠다
AS (SELECT RANK() OVER(ORDER BY SALARY DESC) AS RN, EMP_NO, NAME, DEPART, POSITON, GENDER, HIRE_DATE, SALARY
     FROM EMPLOYEE_T)
SELECT EMP_NO, NAME, DEPART, POSITON, GENDER, HIRE_DATE, SALARY
FROM   RANKING_T
WHERE RN BETWEEN 2 AND 3 ;

-- 3. 부서별 부서번호, 부서명, 연봉총액을 조회하시오.두번째 서브쿼리 사용버전은 모수를 줄여서 조인한거라 성능 UP
SELECT DEPART
     , (SELECT DEPART
        FROM DEPART_T
        WHERE 
     , SUM(SALARY) AS 연봉총액
FROM EMPLOYEE_T ;

-- 4. WITH 절을 이용하여 부서별 부서번호, 부서명, 연봉총액을 조회하시오.
WITH GROUP_T
AS (SELECT DEPART, SUM(SALARY) AS TOTAL_SALARY
    FROM EMPLOYEE_T
    GROUP BY DEPART)
SELECT D.DEPT_NO
      ,D.DEPT_NAME
      ,G.TOTAL_SALARY
      FROM DEPART_T D INNER JOIN GROUP_T G
      ON D.DEPT_NO = G.DEPART ;
