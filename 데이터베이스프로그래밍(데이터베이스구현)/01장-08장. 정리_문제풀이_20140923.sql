-- 01
select ENAME, SAL, sal+300
from emp;

--02
select ENAME, SAL, sal*12+100
from emp
order by 3;

--03
select ENAME, SAL
from emp
where  SAL > 2000
order by sal desc;

--04
select ENAME, DEPTNO
from emp
where EMPNO=7788;

--05
select ENAME, sal
from emp
where sal not BETWEEN 2000 and 3000;

--06
select ENAME, job, HIREDATE
from emp
where HIREDATE BETWEEN '81/02/20' and '81/05/01';

--07
select ENAME, DEPTNO
from emp
where DEPTNO in(20,30)
order by ENAME;

--08
select ENAME, SAL, DEPTNO
from emp
where SAL BETWEEN 2000 and 3000
and DEPTNO in(20,30)
order by ENAME;

--09
select ENAME, HIREDATE
from emp
where HIREDATE like '81%';

--10
select ENAME, JOB
from emp
where MGR is NULL;

--11
select ENAME, SAL, COMM
from emp
where COMM IS NOT NULL
order by SAL, COMM;

--12
select ENAME
from emp
where ENAME like'__R%';

--13
select ENAME
from emp
where ENAME like '%A%'
and ENAME like '%E%';

--14
select ENAME, JOB, SAL
from emp
where JOB IN ('CLERK', 'SALESMAN')
and SAL NOT IN (1600, 950, 1300);

--15
select ENAME, SAL, COMM
from emp
where COMM >= 500;

--16  01
select SUBSTR(HIREDATE,1,2) ³âµµ, SUBSTR(HIREDATE,4,2)
from emp;

--17  02
select *
from emp
where SUBSTR(HIREDATE,4,2)=04;

--18  03
select *
from emp
where MOD(EMPNO,2)=0;

--19  04
select HIREDATE,TO_CHAR(HIREDATE, 'YY/MON/DD DY')
from emp;

--20  05
select TRUNC(SYSDATE - TO_DATE('2014/01/01', 'YY/MM/DD'))
from dual;

--21  06
select EMPNO, ENAME, NVL(MGR,0)
from emp;

--22  07
select EMPNO, ENAME, JOB, SAL,
        DECODE(JOB, 'ANALYST',sal+200,
                    'SALESMAN',sal+180,
                    'MANAGER',sal+150,
                    'CLERK',sal+100,
                    sal) as UPDate_SALARY
from emp;

--23  01
select MAX(SAL),MIN(SAL), SUM(SAL), ROUND(avg(sal))
from emp;

--24  02
select JOB, MAX(SAL),MIN(SAL), SUM(SAL), ROUND(avg(sal))
from emp
GROUP BY JOB;

--25  03
select JOB, COUNT(*)
from emp
GROUP BY JOB;

--26  04
select COUNT(MGR)
from emp;

--27  05
select MAX(SAL)-MIN(SAL)
from emp;

--28  06
select JOB, MIN(SAL)
from emp
GROUP BY JOB
HAVING NOT MIN(SAL)<2000
order by MIN(SAL) DESC
;

--29  07
select EMPNO, COUNT(*),ROUND(AVG(SAL),2)
from emp
group by EMPNO
order by EMPNO
;

--30  08
SELECT DECODE(DEPTNO, 10, 'A',
                      20, 'R',
                      30, 'S',
                      40, 'O'),
       DECODE(DEPTNO, 10, 'N',
                      20, 'D',
                      30, 'C',
                      40, 'B'),
        COUNT(*), ROUND(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;

--31  09
SELECT JOB, DEPTNO,
       DECODE(DEPTNO, 10, SUM(SAL)),
       DECODE(DEPTNO, 20, SUM(SAL)),
       DECODE(DEPTNO, 30, SUM(SAL)),
       SUM(SAL)
FROM EMP
GROUP BY JOB, DEPTNO
order by DEPTNO
;

--32  01
SELECT e.ENAME, e.DEPTNO, d.DNAME
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO
AND e.ENAME = 'SCOTT';

--33  02
SELECT e.ENAME, e.DEPTNO, d.LOC
FROM EMP e INNER JOIN DEPT d
ON e.DEPTNO = d.DEPTNO;

--34  03
SELECT DEPTNO, JOB, LOC
FROM EMP e INNER JOIN DEPT d
USING(DEPTNO)
WHERE DEPTNO=10;

--35  04
SELECT ENAME, DNAME, LOC
FROM EMP NATURAL JOIN DEPT 
WHERE COMM>0;

--36  05
SELECT ENAME, DNAME
FROM EMP e, DEPT d
WHERE e.DEPTNO=d.DEPTNO
and e.ENAME like '%A%'
;

--37  06
SELECT ENAME, JOB, DEPTNO, DNAME
FROM EMP NATURAL JOIN DEPT 
WHERE LOC='NEW YORK'
;

--38  07
SELECT e.ENAME, e.MGR, m.EMPNO, m.ENAME
FROM EMP e, EMP m
WHERE e.MGR=m.EMPNO;

--39  08
SELECT e.ENAME, e.MGR, m.EMPNO, m.ENAME
FROM EMP e, EMP m
WHERE e.MGR=m.EMPNO(+)
order by e.EMPNO
;

--40  09
SELECT e.ENAME, m.EMPNO, m.ENAME
FROM EMP e, EMP m
WHERE e.DEPTNO=m.DEPTNO
and e.ENAME = 'SCOTT'
and m.ENAME != 'SCOTT'
;

--41  10
SELECT m.ENAME, m.HIREDATE
FROM EMP e, EMP m
WHERE m.HIREDATE > e.HIREDATE
and e.ENAME = 'WARD'
order by HIREDATE
;


--42  11
SELECT m.ENAME, m.HIREDATE, e.ENAME, e.HIREDATE
FROM EMP e, EMP m
WHERE m.MGR = e.EMPNO
and m.HIREDATE <= e.HIREDATE
;

--43  01
select ename, job
from emp
where job = ( select job from emp where empno=7788);

--44  02
select ename, job
from emp
where sal > ( select sal from emp where empno=7499);


--45  03
select ename, job, sal
from emp
where sal = ( select min(sal) from emp );

--46  04
select job, ROUND(avg(sal),1)
from emp
group by job
having round(avg(sal),1) = (select min(round(avg(sal),1)) from emp group by job);


--47  05
select ENAME, SAL, DEPTNO, JOB
from emp
where sal in(
    select min(sal) from emp group by DEPTNO
)
;

--48  06
select EMPNO, ENAME, JOB, SAL 
from emp
where sal < any (select sal from emp where job='ANALYST')
and job<>'ANALYST'
;

--49  07
select ENAME, MGR
from emp
where EMPNO NOT IN (select MGR from emp where MGR IS NOT NULL)
;

--50  08
select ENAME, JOB
from emp
where EMPNO IN (select DISTINCT MGR from emp where MGR IS NOT NULL)
;

--51  09
select ENAME, HIREDATE
from emp
where DEPTNO = (select DEPTNO from emp where ENAME='BLAKE')
and ENAME <>'BLAKE'
;

--52  10
select EMPNO, ENAME
from emp
where SAL > (select AVG(SAL) from emp )
order by sal
;

--53  11
select EMPNO, ENAME
from emp
where DEPTNO IN (select DEPTNO from emp where ENAME like '%K%')
;

--54  12
select ENAME, DEPTNO, JOB
from emp
where DEPTNO IN (select DEPTNO from DEPT where LOC = 'DALLAS')
;
select DEPTNO from DEPT where LOC = 'DALLAS';

--55  13
select ENAME, SAL
from emp
where MGR = (select EMPNO from emp where ENAME = 'KING')
;

--56  14
select ENAME, job
from emp
where DEPTNO = (select DEPTNO from DEPT where DNAME = 'RESEARCH')
;
select DEPTNO from DEPT where DNAME = 'RESEARCH';

--57  15
select EMPNO, ENAME, SAL
from emp
where sal > (select avg(sal) from emp )
and DEPTNO in (select DEPTNO from emp where ENAME like '%M%' )
;

--58  16
select JOB, avg(SAL)
from emp
group by JOB
HAVING avg(sal) = (select min(avg(sal)) from emp group by job )
;

select min(avg(sal)) from emp group by job;

--59  17
select ENAME
from emp
where EMPNO IN (select MGR from emp )
;
