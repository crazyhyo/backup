select A.LOD_NO as ���ҹ�ȣ, A.LOD_NM as ���Ҹ�, A.RATING as ����, A.PAVG as ����
  from V_LODGE_LIST A, LODGE B, ROOM C, RESERVATION D
 where A.LOD_NO = B.LOD_NO
       and C.LOD_NO = B.LOD_NO
       AND D.LOD_NO = B.LOD_NO
       AND C.RO_NO = D.RO_NO
       AND B.city_code = 8 and B.prov_code = 2;