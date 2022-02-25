package com.jsp.action.pds;

import com.jsp.action.Action;

public class PdsDetailAction implements Action {

  private PdsService pdsService;
  public void setPdsService(PdsService pdsService){
    this.pdsService = pdsService;
  }

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
      String url = "/pds/detail";

      try{

        int pno = Integer.parseInt(request.getParameter("pno"));
        String from = request.getParameter("from");

        PdsVO pds = null;
        if(from != null && from.equals("from")){
          pds = pdsService.read(pno);
        }else{
          pds = pdsService.getPds(pno);
        }
        request.setAttribute("pds", pds);

      } catch (Exception e){
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        url = null;
      }

      return url;
  }

}
