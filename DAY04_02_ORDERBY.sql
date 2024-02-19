/*
    ORDER BY 
    1. 조회 결과를 정렬할 때 사용한다.
    2. 정렬 방식
      1) 오름차순 정렬 : ASC 또는 생략(기본정렬이 오름차순)
      2) 내림차순 정렬 : DESC(생략 불가)
    
    3. 2개 이상의 정렬 기준을 추가할 수 있다.
    4. 구문도 실행도 가장 마지막 순서.
*/


-- 1. 연봉이 높은 순으로 사원을 조회하시오.
SELECT *
FROM EMPLOYEE_T
ORDER BY SALARY DESC ;

-- 2. 입사순으로 사원 정보를 조회하시오.
SELECT *
FROM EMPLOYEE_T
ORDER BY HIRE_DATE ;

-- 3. 성별의 오름차순으로 정렬하시오. 동일한 성별 내에서는 이름의 내림차순으로 정렬하시오.
SELECT *
FROM EMPLOYEE_T
ORDER BY GENDER /* ASC 생략됨*/ , NAME DESC ;