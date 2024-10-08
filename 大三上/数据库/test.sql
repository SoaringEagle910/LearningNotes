-- 假设有⼀张表Student (sno, cno, score, avgscore), 请设计⼀个触发器来使当更新某⼀个学⽣的成绩时，自动更新其平均成绩。

CREATE TRIGGER update_avgscore
AFTER UPDATE OF score ON Student
REFERENCING NEW x
FOR EACH ROW
BEGIN
    UPDATE Student 
    SET avgscore = (
        SELECT AVG(score) 
        FROM Student 
        WHERE sno = x.sno
        ) 
    WHERE sno = x.sno;
END;



-- 假设有三张表Student (sno, sname, dno, tot_cred), SC (sno, cno, grade),
-- grade 等级分为A,B,C,F, NULL, Course (cno, cname, credit), 请设计⼀个触发器来使Student元组的tot_cred保持最新。

CREATE TRIGGER update_tot_cred
AFTER UPDATE OF grade ON SC
REFERENCING NEW x
FOR EACH ROW 
BEGIN 
    UPDATE Student
    SET tot_cred = (SELECT SUM(credit) FROM Course, SC WHERE Course.cno = SC.cno AND SC.grade != 'NULL' AND SC.grade != 'F')
    WHERE sno = x.sno;
END;



CREATE TRIGGER update_tot_cred
AFTER UPDATE OF grade ON SC
REFERENCING NEW x, OLD y
FOR EACH ROW 
WHEN 
BEGIN 