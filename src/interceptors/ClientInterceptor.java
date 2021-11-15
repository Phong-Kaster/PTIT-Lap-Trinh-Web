package interceptors;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


import entities.Menu;
import entities.Posts;
import models.MenuModel;

@Transactional
public class ClientInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	SessionFactory factory;
	
	@SuppressWarnings("unchecked")
	public List<Menu> getMenu(int position, int parent){
		Session session = factory.getCurrentSession();
		String hql = "FROM Menu m WHERE parent = :parent AND position = :position ORDER BY m.order_menu ASC"; 
		Query query = session.createQuery(hql); 
		query.setParameter("parent", parent);
		query.setParameter("position", position);
		List<Menu> list = query.list();
		return list;
	}
	
	
	
	/**************************************************
	 * @author Hau
	 * 
	 * @return tra ve cac menu o duoi cung cua trang web
	 * bao gom ABOUT, HELP, PRIVACY, TERMS, CONTACT
	 **************************************************/
	public void setMenu(HttpServletRequest request) 
	{
		// get Menu
		List<Menu> listParent = getMenu(0, 0);
		
		List<MenuModel> list = new ArrayList<MenuModel>();
		
		for(Menu item: listParent) {
			MenuModel menu = new MenuModel();
			menu.setMenu(item);
			List<Menu> listChildren = getMenu(0, item.getId());
			if(listChildren != null && listChildren.size() > 0) {
				menu.setChildren(listChildren);
			}
			list.add(menu);
		}
		request.setAttribute("listMenuHeader", list);
		
		
		List<Menu> listMenuFooter = getMenu(1, 0);
		request.setAttribute("listMenuFooter", listMenuFooter);
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * 
	 * Step 1: khoi tao cau truy van
	 * Step 2: gan dieu kien
	 * Step 3: tra ve ket qua
	 * 
	 * @return lay ra nhung bai viet co nhieu luot xem nhat
	 * 
	 * du lieu nay do vao /WEB-INF/views/client/fragment/sidebar.fragment.jsp
	 **************************************************/
	@SuppressWarnings("unchecked")
	public void retriveMostPopularArticle(HttpServletRequest request)
	{
		/*Step 1*/
		Session session = factory.getCurrentSession();
		String hql = "FROM Posts p "
				+ "ORDER BY p.viewer DESC";
		
		/*Step 2*/
		Query query = session.createQuery(hql);
		List<Posts> list = query.list();
		
		/*Step 3*/
		request.setAttribute("mostPopularArticle", list);
	}
	
	/**
	 * Hàm để khai báo một biến Date Format chung cho toàn bộ web
	 * @param request
	 */
	public void setDateFormat(HttpServletRequest request) {
		DateFormat dateFormat = new SimpleDateFormat("dd MMMM, yyyy", new Locale("vi", "VN"));
		request.setAttribute("dateFormat", dateFormat);
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object Handler) throws Exception{
		setMenu(request);
		retriveMostPopularArticle(request);
		setDateFormat(request);	
		return true;
	}
}
