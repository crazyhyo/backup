SELECT COLUMN_NAME, DATA_TYPE FROM COLS WHERE TABLE_NAME='ziptb';

    insert into jdbc_board 
    (BOARD_NO, BOARD_TITLE, BOARD_WRITER, BOARD_DATE, BOARD_CONTENT)
    values (300, 'test', 'writer', SYSDATE, 'CONTENT');
    
    
     SELECT * FROM jdbc_board      WHERE 1 = 1            AND BOARD_TITLE LIKE '%' || 'a' || '%';