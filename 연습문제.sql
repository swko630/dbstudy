-- 1. 사원번호가 110인 사원과 동일한 직책(JOB_ID)을 가진 사원을 조회하시오.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 110);

-- 2. 부서명이 'IT'인 부서에 근무하는 사원을 조회하시오.
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');

-- 3. 가장 높은 연봉를 받는 사원을 조회하시오.
SELECT A.*
FROM (SELECT ROW_NUMBER () OVER(ORDER BY SALARY DESC) AS RN, EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES) A
WHERE A.RN = 1;

-- 4. 평균 연봉 미만인 사원을 조회하시오.
SELECT *
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEES);

-- 5. 평균 근속 개월 수 이상인 사원을 조회하시오.
SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE > (SELECT AVG((SELECT MONTHS_BETWEEN(SYS, HIRE_DATE)
                FROM EMPLOYEES)
                FROM EMPLOYEES);
            

-- 6. 'Seattle'에서 근무하는 사원을 조회하시오.
SELECT 


-- 7. 가장 먼저 입사한 사원을 조회하시오.


-- 8. 부서번호가 50인 부서와 같은 국가(COUNTRY_ID)에 있는 부서 정보를 조회하시오.


-- 9. 부서명이 'Marketing'인 부서에서 가장 높은 연봉를 받는 사람보다 더 높은 연봉를 받는 사원을 조회하시오.


-- 10. 11 ~ 20번째로 입사한 사원을 조회하시오.