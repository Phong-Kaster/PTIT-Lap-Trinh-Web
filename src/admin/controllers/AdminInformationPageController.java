package admin.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import entities.Categories;
import entities.Pages;
import entities.Users;

@Transactional
@Controller
@RequestMapping("admin")
public class AdminInformationPageController {
	@Autowired
	SessionFactory factory;
	
	/**************************************************
	 * @author Phong
	 * @return Phan nay xu ly cho muc "Trang thong tin"
	 **************************************************/
	
	
	
	/**************************************************
	 * @author Phong
	 * @return lay toan bo trang thong tin ra
	 **************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="information-pages",method = RequestMethod.GET)
	public String retrieveInformationPage(HttpServletRequest request, ModelMap modelMap )
	{
		/*Step 1*/
		Session session = factory.getCurrentSession();
		String hql = "FROM Pages";
		
		
		/*Step 2*/
		Query query = session.createQuery(hql);
		List<Categories> list = query.list();
		
		
		
		/*PAGINATION*/
		@SuppressWarnings({ "rawtypes" })
		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(8);
		
		
		
		/*Step 3*/
		modelMap.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/informationPage";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * @return xoa trang thong tin theo ID
	 **************************************************/
	@RequestMapping(value="remove-information-page", method = RequestMethod.GET)
	public @ResponseBody String removeInformationPage(HttpServletRequest request)
	{
		try 
		{
			/*Step 1*/
			Session session = factory.openSession();
			String hql = "";
			Query query = null;
			String id = request.getParameter("id");

			
			/*Step 2*/
			if( id == "" || id.trim().length() == 0)
			{
				return "fail";
			}
			
			
			/*Step 3*/
			hql = "DELETE FROM Pages WHERE id = " + id ;
			query = session.createQuery(hql);
			query.executeUpdate();
			
			
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
	 * @return mo form chinh sua doi tuong
	 **************************************************/
	@RequestMapping(value="edit-information-page-{id}", method=RequestMethod.GET)
	public String editInformationPage(@PathVariable("id") String id,ModelMap modelMap)
	{
		Pages page = retrieveByID(id);
		modelMap.addAttribute("page", page);
		return "admin/informationPageEdit";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * Step 1: khoi tao bien cuc bo
	 * Step 2: kiem tra du lieu dau vao
	 * Step 3: thuc hien cau lenh va ket thuc
	 * @return
	 **************************************************/
	@RequestMapping(value="edit-information-page-{id}", method=RequestMethod.POST)
	public @ResponseBody String addInformationPage(HttpServletRequest request, @ModelAttribute("page") Pages page, @PathVariable("id") String id)
	{
		/*Step 1*/
		String title = page.getTitle();
		String excerpt = page.getExcerpt();
		
		String slug = page.getPage_slug();
		String content = page.getContent();
		
		String status = page.getPage_status();
		
		
		/*Step 2*/
		if( title == "" || excerpt == "" || 
			slug == "" || content == "" || 
			!this.insideOut(new String[] { "publish", "pending"}, status))
		{
			return "fail";
		}
		
		
		
		/*Step 3*/
		try 
		{
			Session session = factory.openSession();
			String hql = "UPDATE Pages "
					+ "SET title = '" + title + "',"
					+ "excerpt = '" + excerpt + "',"
					+ "page_slug = '" + slug + "',"
					+ "content = '" + content + "',"
					+ "page_status = '" + status + "' "
					+ "WHERE id = " + id;
			
			Query query = session.createQuery(hql);
			int x = query.executeUpdate();
			System.out.println("AFFECTED ROWS :" +x);		
		    return "success";
		} 
		catch (Exception e) 
		{
			System.out.println(e);
			return "fail";
		}
		
	}
	
	
	
	@RequestMapping(value="add-information-page", method=RequestMethod.GET)
	public String addInformationPage(ModelMap modelMap)
	{
		Pages page = new Pages();
		modelMap.addAttribute("page", page);
		
		return "admin/informationPageAdd";
	}
	
	
	/**************************************************
	 * @author Phong
	 * @return xu ly viec them moi trang thong tin
	 **************************************************/
	@RequestMapping(value="add-information-page", method=RequestMethod.POST)
	public String addInformationPage(HttpServletRequest request, @ModelAttribute("page") Pages page)
	{
		@SuppressWarnings("unused")
		List<String> errorMessage = new ArrayList<String>();
		
		@SuppressWarnings("unused")
		boolean error = false;
		
		
		/*Step 1*/
		String title = page.getTitle();
		String excerpt = page.getExcerpt();
		
		String slug = page.getPage_slug();
		String content = page.getContent();
		
		String status = page.getPage_status();
		
		Date date = new Date();
		page.setModified_at(date);
		page.setCreated_at(date);
		page.setViewer(0);
		page.setUser((Users)request.getAttribute("AuthUser"));
		
		/*Step 2*/
		if( title.trim().length() == 0)
		{
			errorMessage.add("Thiếu tiêu đề");
			error = true;
		}
		if( excerpt.trim().length() == 0)
		{
			errorMessage.add("Thiếu mô tả rút gọn");
			error = true;
		}
		if( slug.trim().length() == 0)
		{
			errorMessage.add("Thiếu đường dẫn");
			error = true;
		}
		if( content.trim().length() == 0)
		{
			errorMessage.add("Thiếu mô tả đầy đủ");
			error = true;
		}
		if(!this.insideOut(new String[] { "pending", "publish"}, status)) {
			errorMessage.add("Trạng thái bài viết không hợp lệ!");
			error = true;
		}
		
		/*Step 3*/
		if( error == false)
		{
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try 
			{
				session.save(page);
				t.commit();
				request.getSession().setAttribute("successMessage", "Thêm trang thông tin thành công");
			} 
			catch (Exception ex) 
			{
				t.rollback();
				System.out.println(ex);
				errorMessage.add("Thêm trang thông tin thất bại");
				request.getSession().setAttribute("errorMessage", errorMessage);
			}
			finally 
			{
				session.close();
			}
		}
		request.getSession().setAttribute("errorMessage", errorMessage);
		return "redirect:/admin/add-information-page.htm";
	}
	
	/***********************************************************************************************/
	/****************************************** FUNCTION *******************************************/
	/***********************************************************************************************/
	

	/**************************************************
	 * @author Phong
	 * @return kiem tra xem doi tuong element co nam trong array khong
	 **************************************************/
	public <type> boolean insideOut(final type[] array, final type element) {
	    if (element == null) 
	    {
	        for (final type e : array)
	            if (e == null)
	                return true;
	    } 
	    else 
	    {
	        for (final type e : array)
	            if (e == element || element.equals(e))
	                return true;
	    }

	    return false;
	}
	
	
	/**************************************************
	 * @author Phong
	 * @return lay ra page theo id
	 **************************************************/
	private Pages retrieveByID(String id)
	{
		/*Step 1*/
		Session session = factory.getCurrentSession();
		String hql = "FROM Pages WHERE id = " +id;
		
		/*Step 2*/
		Query query = session.createQuery(hql);
		
		/*Step 3*/
		@SuppressWarnings("unchecked")
		List<Pages> list = query.list();
		return list.get(0);
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * @return in ra trang thái xuất bản của trang thông tin
	 **************************************************/
	@ModelAttribute("publishStatus")
	public Map<String, String> retrievePublishStatus()
	{
		Map<String, String> status = new HashMap<>();
		
		status.put("publish", "Xuất bản");
		status.put("pending", "Chờ duyệt");
		
		return status;
	}
}
