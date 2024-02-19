/*
      SELECT 문의 실행 순서
      
      1. FROM 
      2. WHERE
      3. GROUP BY
      4. HAVING
      5. SELECT
      6. ORDER BY
    */
      
-- 1. 부서번호를 기준으로 오름차순 정렬하시오.
SELECT DEPART AS 부서번호 -- 3
FROM EMPLOYEE_T  -- 1
ORDER BY 부서번호 ; -- 2

-- 2. 부서별로 연봉 평균을 조회하시오.
SELECT DEPART AS 부서번호, AVG(SALARY) AS 평균연봉  -- 3
FROM EMPLOYEE_T          -- 1
GROUP BY 부서번호; -- 2 실행순서에 따라 '부서번호'가 뭔지 인식이 안됨

-- 3. 부서별로 연봉 평균과 사원 수를 조회하시오. 평균연봉의 내림차순 정렬하시오.

SELECT DEPART AS 부서번호, COUNT(*) AS 사원수, AVG(SALARY) AS 평균연봉 -- 4
FROM EMPLOYEE_T           -- 1
GROUP BY DEPART           -- 2
HAVING COUNT(*) >=2       -- 3
ORDER BY 평균연봉 DESC; -- 5 ORDER BY 절의 실행순서가 마지막이기 때문에 '평균연봉'을 인식한다 

-- 서브쿼리는 정렬을 하고 조회를 하고싶어 사용





      
      
      
      
      
      
