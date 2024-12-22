-- IN PostgreSQL

BEGIN;

CREATE INDEX id_index ON proj3.dim_product(product_id);
DO $$
DECLARE
    i INT;
    actionType INT;
BEGIN
    FOR i IN 1..200000 LOOP
        actionType := FLOOR(RANDOM() * 3);  -- 随机选择 0, 1, 2 对应 INSERT, UPDATE, DELETE

        IF actionType = 0 THEN
            -- INSERT
            INSERT INTO proj3.dim_product (product_id, product_name) VALUES (i, 'value' || i);
        ELSIF actionType = 1 THEN
            -- UPDATE
            UPDATE proj3.dim_product SET product_name = 'update' || i  WHERE product_id = i;
        ELSE
            -- DELETE
            DELETE FROM proj3.dim_product WHERE product_id = i;
        END IF;
    END LOOP;
END $$;

ROLLBACK ;

-- IN openGauss

BEGIN;

CREATE INDEX id_index ON gaussdb.dim_product_2(product_id);
DO $$
DECLARE
    i INT;
    actionType INT;
BEGIN
    FOR i IN 1..200000 LOOP
        actionType := FLOOR(RANDOM() * 3);  -- 随机选择 0, 1, 2 对应 INSERT, UPDATE, DELETE

        IF actionType = 0 THEN
            -- INSERT
            INSERT INTO gaussdb.dim_product_2 (product_id, product_name) VALUES (i, 'value' || i);
        ELSIF actionType = 1 THEN
            -- UPDATE
            UPDATE gaussdb.dim_product_2 SET product_name = 'update' || i  WHERE product_id = i;
        ELSE
            -- DELETE
            DELETE FROM gaussdb.dim_product_2 WHERE product_id = i;
        END IF;
    END LOOP;
END $$;

ROLLBACK ;
