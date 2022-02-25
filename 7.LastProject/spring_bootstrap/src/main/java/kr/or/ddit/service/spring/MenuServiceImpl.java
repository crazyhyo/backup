package kr.or.ddit.service.spring;

import java.sql.SQLException;
import java.util.List;

import com.jsp.dto.MenuVO;
import com.jsp.service.MenuService;

import kr.or.ddit.dao.spring.MenuDAOBean;

public class MenuServiceImpl implements MenuService{

	private MenuDAOBean menuDAOBean;
	public void setMenuDAOBean(MenuDAOBean menuDAOBean) {
		this.menuDAOBean = menuDAOBean;
	}
	@Override
	public List<MenuVO> getMainMenuList() throws SQLException {
		return menuDAOBean.selectMainMenu();
	}
	@Override
	public MenuVO getMenuByMcode(String mCode) throws SQLException {
		return menuDAOBean.selectMenuByMcode(mCode);
	}
	@Override
	public MenuVO getMenuByMname(String mName) throws SQLException {
		return menuDAOBean.selectMenuByMname(mName);
	}
	@Override
	public List<MenuVO> getSubMenuList(String mCode) throws SQLException {
		return menuDAOBean.selectSubMenu(mCode);
	}

	
}
