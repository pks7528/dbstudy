-- 1. EMPLOYEES 테이블에서 JOB_ID를 조회하시오. 동일한 JOB_ID는 한 번만 출력하고 알파벳 순으로 정렬하여 조회하시오.
SELECT DISTINCT JOB_ID
  FROM EMPLOYEES
 ORDER BY JOB_ID;

-- 2. EMPLOYEES 테이블에서 DEPARTMENT_ID가 50인 사원 중에서 SALARY가 5000 이상인 사원을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50
   AND SALARY >= 5000;

-- 3. EMPLOYEES 테이블에서 FIRST_NAME이 'Steven', LAST_NAME이 'King'인 사원을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'Steven'
   AND LAST_NAME = 'King';

-- 4. EMPLOYEES 테이블에서 EMPLOYEE_ID가 151 ~ 200인 사원을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID BETWEEN 151 AND 200;

-- 5. EMPLOYEES 테이블에서 JOB_ID가 'IT_PROG', 'ST_MAN'인 사원을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE JOB_ID IN('IT_PROG', 'ST_MAN');

-- 6. EMPLOYEES 테이블에서 HIRE_DATE가 2005년도인 사원을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE TO_DATE(HIRE_DATE, 'YY/MM/DD') BETWEEN TO_DATE('2005/01/01', 'YYYY/MM/DD') AND TO_DATE('2005/12/31', 'YYYY/MM/DD');

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2005;

-- 7. EMPLOYEES 테이블에서 MANAGER_ID가 없는 사원을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE MANAGER_ID IS NULL; 

-- 8. EMPLOYEES 테이블에서 COMMISSION_PCT를 받는 사원들의 실제 커미션을 조회하시오. 커미션은 COMMISSION_PCT * SALARY로 계산하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, COMMISSION_PCT * SALARY AS COMMISSION
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL;

-- 9. EMPLOYEES 테이블에서 FIRST_NAME이 'J'로 시작하는 사원을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'J%';

-- 10. EMPLOYEES 테이블에서 JOB_ID가 'MAN'으로 끝나는 사원들의 MANAGER_ID를 중복을 제거하여 조회하시오.
SELECT DISTINCT MANAGER_ID
  FROM EMPLOYEES
 WHERE JOB_ID LIKE '%MAN';

-- 11. EMPLOYEES 테이블에서 전체 사원을 DEPARTMENT_ID의 오름차순으로 조회하되, 동일한 DEPARTMENT_ID 내에서는 HIRE_DATE의 오름차순으로 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID ASC, TO_DATE(HIRE_DATE, 'YY/MM/DD') ASC;

-- 12. EMPLOYEES 테이블에서 DEPARTMENT_ID가 80인 사원들을 높은 SALARY순으로 조회하시오. SALARY는 9,000처럼 천 단위 구분기호를 표기해서 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, TO_CHAR(SALARY, '99,999') AS SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 80
 ORDER BY SALARY DESC;

-- 13. EMPLOYEES 테이블에서 전체 사원의 근무 개월 수를 정수로 조회하시오. 1개월 1일을 근무했다면 2개월을 근무한 것으로 처리해서 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
     , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS 근무개월수
  FROM EMPLOYEES;

-- 14. EMPLOYEES 테이블에서 PHONE_NUMBER에 따른 지역(REGION)을 조회하시오.
-- PHONE_NUMBER가 011로 시작하면 'MOBILE', 515로 시작하면 'EAST', 590으로 시작하면 'WEST', 603으로 시작하면 'SOUTH', 650으로 시작하면 'NORTH'로 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
     , DECODE(SUBSTR(PHONE_NUMBER, 1, 3)
        , '011', 'MOBILE'
        , '515', 'EAST'
        , '590', 'WEST'
        , '603', 'SOUTH'
        , '650', 'NORTH') AS REGION
  FROM EMPLOYEES;

-- 15. EMPLOYEES 테이블에서 근무 개월 수가 240개월 이상이면 '퇴직금정산대상', 아니면 빈 문자열('')을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
     , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS 근무개월수
     , CASE
            WHEN MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240 THEN '정산대상'
            ELSE ''
       END AS 퇴직금정산대상유무
  FROM EMPLOYEES;

-- 16. EMPLOYEES 테이블에서 SALARY 평균이 10000 이상인 부서의 DEPARTMENT_ID와 SALARY 평균을 조회하시오. 평균은 정수로 내림처리하시오.
SELECT DEPARTMENT_ID
     , FLOOR(AVG(SALARY)) AS 부서평균연봉
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 10000;

-- 17. EMPLOYEES 테이블에서 DEPARTMENT_ID와 JOB_ID가 모두 같은 사원들을 그룹화하여 각 그룹의 사원수를 조회하시오. DEPARTMENT_ID가 NULL인 사원은 제외하시오.
SELECT DEPARTMENT_ID, JOB_ID
     , COUNT(*) AS 사원수
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NOT NULL
 GROUP BY DEPARTMENT_ID, JOB_ID
 ORDER BY 사원수;

-- 18. EMPLOYEES 테이블에서 전체 사원들의 부서내 연봉 순위를 조회하시오. 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
     , RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS 부서내연봉순위
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID ASC;

-- 19. DEPARTMENTS 테이블에서 LOCATION_ID로 그룹화하여 각 그룹의 부서수를 조회하시오. MANAGER_ID가 없는 지역은 제외하시오.
SELECT LOCATION_ID
     , COUNT(*) AS 부서수
  FROM DEPARTMENTS
 WHERE MANAGER_ID IS NOT NULL
 GROUP BY LOCATION_ID;

-- 20. DEPARTMENTS 테이블에서 DEPARTMENT_NAME의 첫 2글자로 그룹화하여 각 그룹의 부서수를 조회하시오. 'IT'와 'Co'인 부서만 조회하시오.
SELECT SUBSTR(DEPARTMENT_NAME, 1, 2)
     , COUNT(*) AS 부서수
  FROM DEPARTMENTS
 WHERE SUBSTR(DEPARTMENT_NAME, 1, 2) IN('IT', 'Co')
 GROUP BY SUBSTR(DEPARTMENT_NAME, 1, 2);

SELECT SUBSTR(DEPARTMENT_NAME, 1, 2)
     , COUNT(*) AS 부서수
  FROM DEPARTMENTS
 WHERE DEPARTMENT_NAME LIKE 'IT%'
    OR DEPARTMENT_NAME LIKE 'Co%'
 GROUP BY SUBSTR(DEPARTMENT_NAME, 1, 2);
