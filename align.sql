CREATE OR REPLACE FUNCTION ALIGN
    (first_string IN varchar2, desired_length IN NUMBER, direction IN varchar2)
    RETURN varchar2
IS
    output varchar2(255);
    characters_to_add NUMBER;
    add_to_left NUMBER;
    add_to_right NUMBER;
    counter NUMBER;
BEGIN
output := first_string;
IF NOT (direction = 'left' OR direction = 'right' OR direction = 'center') THEN
    RETURN output;
ENd IF;
IF LENGTH(first_string) >= desired_length THEN
    RETURN output;
END IF;

IF direction = 'left' THEN
    WHILE LENGTH(output) < desired_length
    LOOP
        output := output || ' ';
    END LOOP;
ELSIF direction = 'right' THEN
    WHILE LENGTH(output) < desired_length
    LOOP
        output := ' ' || output;
    END LOOP;
ELSIF direction = 'center' THEN
    characters_to_add := desired_length - LENGTH(first_string);
    add_to_left := ROUND(characters_to_add / 2);
    add_to_right := characters_to_add - add_to_left;

    counter := 0;
    WHILE counter < add_to_left
    LOOP
        output := ' ' || output;
        counter := counter + 1;
    END LOOP;

    counter := 0;
    WHILE counter < add_to_right
    LOOP
        output := output || ' ';
        counter := counter + 1;
    END LOOP;
END IF;

RETURN output;
END;
/
COMMIT;
