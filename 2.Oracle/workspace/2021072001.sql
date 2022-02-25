2021-0720-01)
  3. MAX(column��), MIN(column��)
   - MAX : �־��� �÷��� �� �ִ� ���� ��ȯ
   - MIN : �־��� �÷��� �� �ּ� ���� ��ȯ
   - �����Լ��� �ٸ� �����Լ��� ���� �� �� ����.
   
��뿹)2005�� ���� ���Ծ� �� �ִ���Ծ�, �ּҸ��Ծ�
      Alias�� ��, �ִ���Ծ�, �ּҸ��Ծ�

    SELECT EXTRACT(MONTH FROM BUY_DATE) AS  "��",
           MAX(BUY_QTY * BUY_COST)      AS  "�ִ���Ծ�",
           MIN(BUY_QTY * BUY_COST)      AS  "�ּҸ��Ծ�"
      FROM BUYPROD
     WHERE EXTRACT(YEAR FROM BUY_DATE) = 2005
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
     ORDER BY 1;

�Ⱓ�� �Ϲ��������� ó�����־�� �Ѵ�, WHERE���� �ٷ�

��뿹)2005�� 5�� �ִ뱸�� �������� ��ȸ�Ͻÿ�.
      Alias�� ȸ����ȣ, ȸ����, ���űݾ�

    SELECT B.MEM_ID             AS  "ȸ����ȣ",
           B.MEM_NAME           AS  "ȸ����",
           SUM(A.CART_QTY * C.PROD_PRICE)   AS  "���űݾ�"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO,1,6) = '200505'
     GROUP BY B.MEM_ID, B.MEM_NAME;
     ORDER BY 3 DESC;

�ִ뱸�űݾ��� ������ ȸ���� �������� ���� ������ �������� ���̴� �Ұ���
    
    (SUBQUERY)
SELECT  A.MID               AS  "ȸ����ȣ",
        A.MNAME             AS  "ȸ����",
        A.AMT               AS  "���űݾ�"
  FROM  (SELECT B.MEM_ID             AS  MID,
               B.MEM_NAME           AS  MNAME,
               SUM(A.CART_QTY * C.PROD_PRICE)   AS  AMT
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) A
 WHERE ROWNUM = 1;         

SELECT  D.MID               AS  "ȸ����ȣ",
        D.MNAME             AS  "ȸ����",
        E.MEM_ADD1 ||' ' || E.MEM_ADD2               AS  "�ּ�",
        E.MEM_HP AS "����ó",
        D.AMT               AS  "���űݾ�"
  FROM  (SELECT B.MEM_ID             AS  MID,
               B.MEM_NAME           AS  MNAME,
               SUM(A.CART_QTY * C.PROD_PRICE)   AS  AMT
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) D, MEMBER E
 WHERE D.MID = E.MEM_ID
       AND ROWNUM = 1;
         
������ ����� ���� �ĺ��ڰ����̰� ������ ����� ���� ��ĺ��� �����̴�
�θ���� �¾�� ����Ƽ�� Ű����Ƽ Ȥ�� DB�𵨷����� ���ھư� �߳�����
�Խñ۹�ȣ �׳��� ���ʴ�� ���ںο��ϰ� Ư������ ���� ���ڷθ� ������ ���ڿ��� �����ϰ� MAX + 1�� ������Ʈ�ض�(�������ε� �ذᰡ�� �� �ɷ��� �ȴٸ�)
Ư�� ������ ���ӵ� ����Ƽ : �׼� ����Ƽ, �θ� ����Ƽ�� ���ӵ�
�����ͺ��̽��� 1�̸� �ȴ�
���������� ���̺� ��Ī�� �ٱ����� ���̺� ��Ī�� ���ĵ� �������.

Ŀ����� ���� ���� �� PL/SQL���� ���

ROWNUM�� ���� �̿��ؼ� �ϳ��� �̾Ƴ��°� ������ �ϳ�

