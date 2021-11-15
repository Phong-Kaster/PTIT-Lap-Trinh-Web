package admin.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Menu;
import models.MenuModel;
import models.MenuOrder;

@Transactional
@Controller
@RequestMapping("admin")
public class AdminMenuController {
	
	@Autowired
	SessionFactory factory;
	
	@Autowired
	ObjectMapper mapper;
	
	
	
	/**************************************************
	 * @author Phong
	 * position = 0 - tuc menu header
	 * position = 1 - tuc menu footer
	 * @return
	 **************************************************/
	public List<Menu> retrieveMenu(String position, int parent)
	{
		/*Step 1*/
		Session session = factory.getCurrentSession();
		String hql = "FROM Menu WHERE position = " + position + " AND parent = " + parent + " ORDER BY order_menu ASC";
		
		
		/*Step 3*/
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<Menu> list = query.list();
		return list;
	}
	
	
	
	public List<Menu> retrieveAllMenu(String position)
	{
		/*Step 1*/
		Session session = factory.getCurrentSession();
		String hql = "FROM Menu WHERE position = " + position + " ORDER BY order_menu ASC";
		
		
		/*Step 3*/
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<Menu> list = query.list();
		return list;
	}
	
	
	/**************************************************
	 * @author Phong
	 * position = 0 - tuc menu header
	 * position = 1 - tuc menu footer
	 * 
	 * menuParent - la menu cha hay parent = 0
	 * menuModel la mot mang cac menu trong do co menu cha va menu con
	 * @return
	 **************************************************/
	@RequestMapping(value="menu", method=RequestMethod.GET)
	public String menu(ModelMap modelMap, HttpServletRequest request)
	{
		/*Step 1*/
		String position = ( request.getParameter("position") == null ? "0" : "1" );
		int parent = 0;
		
		
		/*Step 2*/
		List<Menu> menuParent = retrieveMenu(position,parent);
		List<MenuModel> listMenuModel = new ArrayList<>();
		List<Menu> listAllMenuModel = retrieveAllMenu( position);
		for(Menu element : menuParent)
		{
			MenuModel menuModel = new MenuModel();
			menuModel.setMenu(element);
			List<Menu> listMenuChildren = retrieveMenu(position, element.getId() );
			if( listMenuChildren != null && listMenuChildren.size() > 0)
			{
				menuModel.setChildren(listMenuChildren);
			}
			
			listMenuModel.add(menuModel);
		}
		
		/*Step 3*/
		modelMap.addAttribute("listMenuModel", listMenuModel);
		modelMap.addAttribute("listAllMenuModel", listAllMenuModel);
		modelMap.addAttribute("position", position);
		return "admin/menu";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * @return
	 **************************************************/
	public void saveMenuParentPosition(String menuID, int orderMenu )
	{
		try 
		{
			/*Step 1*/
			Session session = factory.openSession();
			String hql = "UPDATE Menu SET order_menu = " + orderMenu + ", parent = 0"
					+ " WHERE id = " + menuID;
			System.out.println(hql);
			
			/*Step 2*/
			Query query = session.createQuery(hql);
			query.executeUpdate();
		} 
		catch (Exception e) 
		{
			System.out.println(e);
		}
	}
	
	
	

	/**************************************************
	 * @author Phong
	 * menuParentID: id cua menu cha
	 * list: danh sach menu con thuoc @menuParentID
	 * @return luu vi tri cua menuChildren
	 **************************************************/
	public void saveMenuChildrenPosition(String menuParentID, List<MenuOrder> list)
	{
		try 
		{
			for(MenuOrder element : list)
			{
				Session session = factory.openSession();
				String hql = "UPDATE Menu SET parent = " + menuParentID + " WHERE id = " + element.getId();
				
				Query query = session.createQuery(hql);
				query.executeUpdate();
			}
			
		} 
		catch (Exception e) 
		{
			System.out.println(e);
		}
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * Step 1: lay du lieu JSON ra va mapping voi MenuOrder
	 * Step 2: duyet vong lap de cap nhat vi tri cua menu co parent = 0 - tuc menu cha
	 * Step 3: duyet vong lap de cap nhat vi tri cua menu co children > 0 - tuc menu con
	 * Step 4: gui @ResponseBody thong bao lai cho ajax la thanh cong hay that bai
	 * @return luu thu tu menu gom cac order va menu con
	 **************************************************/
	@RequestMapping(value="save-menu-order", method=RequestMethod.POST)
	public @ResponseBody String saveMenuOrder(HttpServletRequest request)
	{
		try 
		{
			/*Step 1*/
			String order = request.getParameter("order");
			MenuOrder[] result = mapper.readValue(order, MenuOrder[].class);
			
			/*Step 2*/
			for(int i = 0 ; i < result.length ; i ++ )
			{
				MenuOrder element = result[i];
				int position = i;
				
				saveMenuParentPosition( element.getId(), position);
			}
			
			
			/*Step 3*/
			for(MenuOrder element : result)
			{
				if( element.getChildren().size() > 0 )
				{
					saveMenuChildrenPosition( element.getId() , element.getChildren() );
				}
			}
			return "success";
		} 
		catch (Exception e) 
		{
			System.out.println(e);
			return "fail";
		}
		
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * @return lay tong so menu cha hien co
	 **************************************************/
	public long retrieveTotalMenuParent(String position)
	{
		Session session = factory.getCurrentSession();
		String hql = "SELECT count(*) FROM Menu WHERE parent = 0 AND position = " + position;
		
		Query query = session.createQuery(hql);
		return (long) query.uniqueResult();
	}
	
	
	
	
	/**************************************************
	 * @author Phong
	 * @return tao mot menu header| footer moi
	 **************************************************/
	@RequestMapping(value="add-menu", method=RequestMethod.POST)
	public @ResponseBody String addMenu(HttpServletRequest request)
	{
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try 
		{
			/*Step 1*/
			String title = request.getParameter("title");
			String url = request.getParameter("url");
			
			if( title.length() < 0 || title == null || url.length() < 0 || url == null)
			{
				return "fail";
			}
			
			String position = request.getParameter("position");
			//System.out.println("position : " +position);
			
			
			/*Step 2*/
			Menu menu = new Menu();
			menu.setTitle(title);
			menu.setTarget("/category/"+url+".htm");
			
			
			long menuPosition = retrieveTotalMenuParent(position);// vi tri cua menu moi luon o sau cung so voi menu parent khac
			menu.setOrder_menu( (int) menuPosition );	
			menu.setParent(0);
			menu.setPosition( Integer.parseInt(position));
			
			
			
			
			/*Step 3*/
			session.save(menu);
			t.commit();
			
			return "success";
		} 
		catch (Exception e) 
		{
			System.out.println(e);
			t.rollback();
			return "fail";
		}
	}
	
	@RequestMapping(value="remove-menu", method=RequestMethod.POST)
	public @ResponseBody String removeMenu(HttpServletRequest request)
	{
		try 
		{
			String id = request.getParameter("id");
			
			if( id.length() < 0 || id == null)
			{
				return "fail";
			}
			
			Session session = factory.openSession();
			String hql = "";
			Query query = null;
			
			
			hql = "UPDATE Menu SET parent = 0 WHERE parent = " +  id;
			query = session.createQuery(hql);
			query.executeUpdate();
			
			hql = "DELETE Menu Where id = " + id;
			query = session.createQuery(hql);
			query.executeUpdate();
			
			return "success"; 
		} 
		catch (Exception e) 
		{
			return "fail";
		}
	}
}
