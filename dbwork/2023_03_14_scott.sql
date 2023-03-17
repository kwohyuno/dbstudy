--emp ���̺� ��ü Į�� ��ȸ
select * from emp;
--emp ���̺� �ִ� ������ ������ ��� (���� ������ �ѹ���) 
select DISTINCT job from emp;
--�÷��� ��Ī�� ����
select ename as "�����" ,job as "����" from emp;
--��Ī�� ���� �߰��� ������ ���� �� " ���� ���� 
select ename �����, job ���� from emp;



--���� : empno�� 7369,7566 �� ���� �����͸� Ȯ�� 
select * from emp where empno=7369 or empno=7566;
--SMITH,WARD�� ����Ÿ ��� 
SELECT * FROM EMP WHERE ENAME='SMITH' OR ENAME='WARD';

--IN ������(OR �����ڷ� ��ȸ�ϴ� ��� IN ���� ����) 
SELECT * FROM EMP WHERE ENAME IN ('SMITH','WARD','SCOTT','FORD'); 
SELECT * FROM EMP WHERE EMPNO IN (7369,7654,7788,7876); 
--AND �������� ��ȸ�ϴ� ��� 
SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE SAL>=1500 AND SAL<=3000;
--���� SQL���� BETWEEN���ε� ��ȸ�� ���� 
SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE SAL BETWEEN 1500 AND 3000;
--������ MANAGER�� ����� SAL�� 2õ �̻��λ�� 
SELECT * FROM EMP WHERE JOB='MANAGER' AND SAL>=2000;
--COMM�� NULL�� ��츸 ��� 
SELECT * FROM EMP WHERE COMM IS NULL;
--COMM�� NULL�� �ƴ� ��츸 ��� 
SELECT * FROM EMP WHERE COMM IS NOT NULL;
--ENAME�� A�� �����ϴ� ����Ÿ ��ȸ 
SELECT * FROM EMP WHERE ENAME LIKE 'A%';
--ENAME�� S�� ������ ����Ÿ ��ȸ
SELECT * FROM EMP WHERE ENAME LIKE '%S';
--ENAME�� A�� S�� �����ϴ� ����Ÿ ��ȸ 
SELECT * FROM EMP WHERE ENAME LIKE 'A%' OR ENAME LIKE 'S%';
--ENAME�� 2��°�� 3��° ���ڰ� A�� ��� ��ȸ 
SELECT * FROM EMP WHERE ENAME LIKE '_A%' OR ENAME LIKE '__A%';
--JOB�� MANAGER�� ANALYST �߿� SAL�� 2500 �̻��� ����� ��ȸ
SELECT * FROM EMP WHERE (JOB='MANAGER' OR JOB='ANALYST') AND SAL>=2500;
--IN���� ���� 
SELECT * FROM EMP WHERE JOB IN ('MANAGER','ANALYST') AND SAL>=2500;
--SCOTT�� ������ ���� ������ �޴� ����� ��ȸ 
SELECT * FROM EMP WHERE SAL=(SELECT SAL FROM EMP WHERE ENAME='SCOTT');
--ALLEN�� ������ ���� ������ ���� ����� ��ȸ�ϱ� 
SELECT * FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE ENAME='ALLEN');
--CONSOLE�� ��½� ���̺���� DUAL
--PPT 48������ �����Լ�- �����Լ� 
SELECT ABS(-6),ABS(6) FROM DUAL; --ABS:���밪, ������ ����� ���
SELECT CEIL(2.75),CEIL(2.11) FROM DUAL;  --������ �ø��� �� ������ ��ȯ 
SELECT FLOOR(2.75),FLOOR(2.11) FROM DUAL; --������ ������ �� ������ ��ȯ 
SELECT ROUND(2.356,1),ROUND(2.22,1) FROM DUAL; --�Ҽ��� ù° �ڸ����� ���Ѵ�(�ݿø�)
SELECT TRUNC(2.356,1),TRUNC(2.22,1) FROM DUAL; --�Ҽ��� 1°�ڸ����� ���Ѵ�(�ݳ���)
SELECT ROUND(235678,-1),ROUND(235678,-2) FROM DUAL; --235680,235700 
SELECT POWER(2,3),POWER(3,4) FROM DUAL; --8,81   �����±��ϱ�
SELECT MOD(7,2),MOD(10,2) FROM DUAL; --������ ���ϱ� 

--49������ ���ڿ� �Լ� 
SELECT CONCAT('JAVA','SPRING') FROM DUAL; --���ڿ���ġ��
--���ڿ��� ��ĥ��� ||�̰ŷε� �����ϴ�
SELECT 'JAVA'||'SPRING' FROM DUAL;
--table emp�� �غ��� 
select ename||'���� ������ '||job||'�Դϴ�' message from emp; --mesage�� �÷��� 
select ename||'���� ������ '||sal||'�Դϴ�' sal from emp;
select initcap(ename) from emp; --ù���ڸ� �빮�ڷ� ��� 
select upper(ename),lower(ename) from emp; --�빮��,�ҹ��ڷ� ��ȯ�� ��� 
--lpad,rad: Ư�� ���ڷ� ä���
select lpad('happy',10,'*') from dual; 
select rpad('happy',10,'*') from dual;
select ename,lpad(sal,10,'0') sal from emp;    
--substr: ���ڿ� ����
select substr('HAPPY DAY',3,3), substr('Happy Day',-3,3) from dual; 
--ename���� �� 2���ڸ� ����� * 3�� �ٿ��� ����ϱ�
select substr(ename,1,2)||'***'ename from emp;
select rpad(substr(ename,1,2),5,'*')from emp;
--length ���̱��ϱ�
select ename||'���� �̸����� ���̴� '||length(ename)||'�����Դϴ�' �޼��� from emp;
--replace : ��ġ
select replace('Hello Kitty','t','*') from dual;
--instr: Ư�����ڿ��� ��ġ ���ϱ� 
select instr('Good Day','Day') from dual; --6 :6��°���� �߰� 
select instr('Good Day','happy') from dual; --0:������� 0 
--trim : ���� ���� ���� 
select '*'||trim('     hello    ')||'*'from dual; 
select '*'||ltrim('     hello    ')||'*'from dual; --���� ���鸸 ����
select '*'||rtrim('     hello    ')||'*'from dual; --������ ���鸸 ���� 

--sysdate�� ���糯¥ ���ϱ� 
select sysdate from dual;
--���� ��¥ ���ϱ� 
select sysdate+1 from dual;
--�����ϵ�
select sysdate+7 from dual;
select to_char(sysdate,'yyyy-mm-dd') today from dual;
select to_char(sysdate,'yyyy-mm-dd am hh:mm:ss') today from dual; --2023-03-14 ���� 03:22:04 
select to_char(sysdate,'yyyy-mm-dd hh24:mm:ss') today from dual; --2023-03-14 ���� 15:22:04
select to_char(2345678,'L999,999,999') from dual; --��2,345,678
select to_char(2345678,'L000,000,000') from dual; --��002,345,678
select to_char(2345678,'$999,999,999') from dual; --$2,345,678
select to_char(2.3,'0.00') from dual; --2.30

--NVL : �ΰ��� ��� Ư�������� ���(Mysql ������ ifnull)
select NVL(mgr,1000),NVL(comm,0) from emp;     --mgr�� nul�� ��� 1000���� �ٲٰ� comm�� null�� ��� 0���� �ٲٱ� 
select sal+comm from emp;  --comm�� null�ϰ�� ���ϸ� ����� null 
--comm�� null�� ��� 10���� ���
select sal+NVL(comm,10) pay from emp;    --������ pay�� 
--decode:���� ���� ���� �ٸ� �� ���
select ename, deptno, decode(deptno,10,'����',20,'������',30,'��⵵',40,'���ֵ�') city from emp; 
--order ������� ���
select ename,sal from emp order by ename asc; --ename�� ��������(asc ��������) 
select ename,sal from emp order by sal desc; --sal�� �������� 
--������ ���, ���� �����ϰ�� ������ ��������
select ename,job,sal from emp order by job,sal desc;
--sal�� �������� ��½� sal�� 3��° ����ϹǷ� ����ȣ 3���� ���� 
select ename,job,sal from emp order by 3;
--���� 1500~3000 ������ ����ϴµ� �̸��� �������� 
select ename,sal from emp where sal between 1500 and 3000 order by ename;

--�׷��Լ� : ppt 57 
--count,max,min,sum,avg 
select count(*) from emp; --emp�� ����Ÿ ���� 
select max(sal) from emp; --�ְ�޿�
select min(sal) from emp; --�ְ�޿� 
select sum(sal) from emp; --�޿��� �� 
select avg(sal) from emp; --�޿��� ���
select round(avg(sal),-1) from emp; --�޿��� ���, �Ͽ��������� �ݿø�

--group�� �Լ� ���� 
--�� ������ sal�� ����� ���غ���
select job ����,count(*) �ο���,round(avg(sal),-1) ��տ��� from emp group by job order by �ο���; 
--���� Ŀ�������� ������ �ο����� 3�� �̻��� ����Ÿ�� ���
select job ����,count(*) �ο���,round(avg(sal),-1) ��տ��� from emp group by job having count(*)>=3 order by �ο���; 

--�� �������� �ο����� �ְ���, ���������� ���(������ ��������) 
select job ����,count(*) �ο���,max(sal) �ְ���,min(sal) ��������, round(avg(sal),-2) �������
        from emp group by job order by 1;
--���� �������� �ݾ׾տ� ȭ������� ���̰� 3�ڸ� �޸� �߰��Ϸ���
select job ����,count(*) �ο���,to_char(max(sal),'L999,999') �ְ���,to_char(min(sal),'L999,999') ��������
        from emp group by job order by 1;



--emp���̺��� ename a�� s�� �����ϴ»�� ���(��ҹ��� �������)
SELECT * FROM EMP WHERE UPPER(ENAME) LIKE 'A%' OR UPPER(ENAME) LIKE 'S%';
--emp���̺��� ename ���� �ι�° ���ڰ� 'A' �λ�� ���
SELECT * FROM EMP WHERE ENAME LIKE '_A%';
--job ���� ���� �������ϰ�� �ѹ����� ����Ͻÿ�
select DISTINCT job from emp;
--job �������� �ο����� ���Ͻÿ�
select job,count(*) �ο��� from emp group by job;
--job �������� sal �� ��ձ޿��� ���Ͻÿ�
select job,round(avg(sal),0) ��ձ޿� from emp group by job;
--job �������� sal �� �ִ밪�� �ּҰ��� ���Ͻÿ�
select job,max(sal) �ִ밪, min(sal) �ּҰ� from emp group by job;
--deptno �� 10�ΰ�� 'ȫ����'
-- 20 �ΰ�� '���ߺ�' 30�ΰ�� '������' �μ��� ���Ͽ�
-- ename, �μ� �� ����Ͻÿ�
select ename, deptno, decode(deptno,10,'ȫ����',20,'���ߺ�',30,'������') �μ� from emp; 
-- �޿�(sal)�� sal �� ��պ��� �� ���� ����� ename �� sal �� ����Ͻÿ�
select ename �̸�, sal ���� from emp where sal>(SELECT AVG(SAL) FROM EMP);
--hiredate ���� ���� 5���� ����� ename �� hiredate �� ����Ͻÿ�
select ename, hiredate from emp where to_char(hiredate,'MM')='05';
select ename, hiredate from emp where to_char(hiredate,'MM')=5;
-- SCOTT �� �޿��� �����ϰų� �� ���� �޴� ������ �޿��� ����϶�
SELECT ENAME,SAL FROM EMP WHERE SAL>=(SELECT SAL FROM EMP WHERE ENAME='SCOTT');
