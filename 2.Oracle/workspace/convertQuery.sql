select A.LOD_NO as 숙소번호, A.LOD_NM as 숙소명, A.RATING as 평점, A.PAVG as 가격
  from V_LODGE_LIST A, LODGE B, ROOM C, RESERVATION D
 where A.LOD_NO = B.LOD_NO
       and C.LOD_NO = B.LOD_NO
       AND D.LOD_NO = B.LOD_NO
       AND C.RO_NO = D.RO_NO
       AND B.city_code = 8 and B.prov_code = 2;