-- 전달된 부서번호의 부서를 삭제하는 프로시저를 작성하시오.
-- 전달된 부서에 근무하는 모든 사원을 함께 삭제하시오.
CREATE OR REPLACE PROCEDURE DELETE_PROC(DEPTNO IN DEPARTMENT_TBL.DEPT_NO%TYPE) --이번 시험에서는 OUT 안나옴
IS          -- 변수가 필요하면 IS밑에서 선언
BEGIN       --사원먼저지움// 외래키 가진 놈부터 지움 // 부서 1:M 사원// 일대 다 관계에서는 다 먼저 지움
    DELETE 
      FROM EMPLOYEE_TBL 
     WHERE DEPART = DEPTNO;
    DELETE 
      FROM DEPARTMENT_TBL
     WHERE DEPT_NO = DEPTNO;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE);  --예외코드
        DBMS_OUTPUT.PUT_LINE(SQLERRM);  --에러메시지
        ROLLBACK;
END;

--프로시저 실행
-- 부서번호가 1인 부서를 지워라
EXECUTE DELETE_PROC(1);     
