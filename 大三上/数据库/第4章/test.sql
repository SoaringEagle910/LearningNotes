CREATE FUNCTION count(target_score INT)
RETURNS SELECT COUNT(*) FROM SC WHERE SC.score == target_score;


CREATE PROCEDURE delete_SC(IN teacherno VARCHAR(10))
BEGIN
    DELETE FROM SC WHERE SC.tno == teacherno;
END;