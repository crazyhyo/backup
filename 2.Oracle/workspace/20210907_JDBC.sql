create table jdbc_board(
    board_no number not null,                 -- ��ȣ(�ڵ�����)
    board_title varchar2(100) not null,         -- ����
    board_writer varchar2(50) not null,        -- �ۼ���
    board_date date not null,                    -- �ۼ���¥
    board_content clob,                          -- ����
    constraint pk_jdbc_board primary key (board_no)
);
create sequence board_seq
    start with 1   -- ���۹�ȣ
    increment by 1; -- ������