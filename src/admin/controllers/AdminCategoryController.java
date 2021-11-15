package admin.controllers;

import java.util.ArrayList;
import java.util.List;

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


@Transactional
@Controller
@RequestMapping("/admin")
public class AdminCategoryController {
	
	@Autowired
	SessionFactory factory;
	
	/***********************************************************************************************/
	/****************************************** CONTROLLER *****************************************/
	/***********************************************************************************************/
	
	
	/**************************************************
	 * @author Phong
	 * 
	 * PAGINATION
	 * setMaxLinkedPages(3) ngoai trang hien tai thi co 3 trang khac duoc hien thi
	 * setPageSize(8) coi 8 bai viet o moi trang
	 * 
	 * Step 1: khoi tao cau truy van
	 * Step 2: thuc hien cau truy van
	 * Step 3: tra ve ket qua
	 * 
	 * @return liet ke tat cac cac the loai
	 **************************************************/
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("categories")
	public String retrieveCategory(HttpServletRequest request, ModelMap modelMap )
	{
		/*Step 1*/
		Session session = factory.getCurrentSession();
		String hql = "FROM Categories";
		
		
		/*Step 2*/
		Query query = session.createQuery(hql);
		List<Categories> list = query.list();
		
		
		
		/*PAGINATION*/
		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(8);
		
		
		
		/*Step 3*/
		modelMap.addAttribute("category", list);
		modelMap.addAttribute("pagedListHolder", pagedListHolder);
		return "admin/category";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * 
	 * Step 1: khoi tao bien new Categories();
	 * Step 2: truyen bien vao ModelMap & goi view
	 * 
	 * GET: add-category
	 * 
	 * @return mo form them moi the loai
	 **************************************************/
	@RequestMapping(value="add-category", method=RequestMethod.GET)
	public String addCategory(ModelMap modelMap)
	{
		/*Step 1*/
		Categories category = new Categories();
		
		
		/*Step 2*/
		modelMap.addAttribute("category", category);
		return "admin/categoryAdd";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * 
	 * Step 1: khoi tao phien lam viec voi du lieu. 
	 * Do phai thay doi co so du lieu nen dung beginTransaction() thay vi getCurrentSession()
	 * Step 2: kiem tra du lieu dau vao. Su dung flag error.
	 * 		Neu error == false thi them moi tiep tuc
	 * 		Neu error == true thi tra ra loi luon
	 * Step 3: neu error == false thi openSession() de save() doi tuong moi lai
	 * 
	 * 
	 * POST: add-category
	 * 
	 * @return mo form them moi the loai
	 **************************************************/
	@RequestMapping(value="add-category", method=RequestMethod.POST)
	public String addCategory(HttpServletRequest request,ModelMap modelMap, @ModelAttribute("category") Categories category)
	{
		/*Step 1*/
		List<String> errorMessage = new ArrayList<String>();
		boolean error = false;
		
		String name = category.getName();
		String slug = category.getSlug();
		int parent = category.getParent();
		
		/*Step 2*/
		if( name.trim().length() == 0 || name == null)
		{
			errorMessage.add("Thiếu tên thể loại");
			error = true;
		}
		if( slug.trim().length() == 0 || slug == null)
		{
			errorMessage.add("Thiếu đường dẫn thể loại");
			error = true;
		}
		if( parent < 0)
		{
			errorMessage.add("Thể loại cha không hợp lệ");
			error = true;
		}
		
		/*Step 3*/
		if( error == false)
		{
			
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			
			try 
			{
				session.save(category);
				t.commit();
				request.getSession().setAttribute("successMessage", "Thêm thể loại thành công");
			}
			catch(Exception ex)
			{
				t.rollback();
				System.out.println(ex);
				errorMessage.add("Thêm thể loại thất bại");
				request.getSession().setAttribute("errorMessage", errorMessage);
			}
			finally
			{
				session.close();
			}
			
		}

		request.getSession().setAttribute("errorMessage", errorMessage);
		return "redirect:/admin/add-category.htm";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * 
	 * @ResponseBody nói cho MVC biết không render một view nào cả
	 * mà phải trả về đối tượng vào trong body. Spring sẽ tự động convert đối tượng này sang JSON
	 * 
	 * Step 1: khoi tao cac bien cuc bo
	 * Step 2: kiem tra du lieu dau vao
	 * Step 3: cap nhat lai cac bai viet thuoc @param ID thanh Uncategoried
	 * Step 4: xoa the loai co @param ID nay va tra ve ket qua la "success"
	 * 
	 * @return xoa the loai bang id duoc gui toi tu AJAX
	 **************************************************/
	@RequestMapping(value="/remove-category", method=RequestMethod.GET)
	public @ResponseBody String removeCategory(HttpServletRequest request)
	{
		try 
		{
			/*Step 1*/
			Session session = factory.openSession();
			String hql = "";
			Query query = null;
			String id = request.getParameter("id");

			
			/*Step 2*/
			if( id == "")
			{
				return "fail";
			}
			
			
			/*Step 3*/
			hql = "UPDATE Posts SET cat_id = 1 WHERE cat_id = " + id;
			query = session.createQuery(hql);
			query.executeUpdate();
			
			
			/*Step 4*/
			hql = "DELETE FROM Categories WHERE id = " + id ;
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
	 * 
	 * GET method - chinh sua the loai
	 * 
	 * Step 1: lay the loai va so luong bai biet thuoc the loai nay
	 * Step 2: nap vao ModelMap de in ra view
	 * Step 3: goi ra view can do du lieu
	 * 
	 * @return lay thong tin category hien tai va do ra view
	 **************************************************/
	@RequestMapping(value ="/edit-category-{id}", method = RequestMethod.GET)
	public String editCategory(ModelMap modelMap, @PathVariable("id") String id) {
		
		/*Step 1*/
		Categories category = retrieveByID(id); 
		long quantityPost = retrieveNumberPostByCategory(id);
		 
		
		/*Step 2*/
		modelMap.addAttribute("category", category);
		modelMap.addAttribute("quantity", quantityPost);
		 
		return "admin/categoryEdit";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * 
	 * POST method - chinh sua du lieu
	 * Step 1: kiem tra du lieu dau vao
	 * Step 2: cap nhat du lieu
	 * @return
	 **************************************************/
	@RequestMapping(value ="/edit-category-{id}", method = RequestMethod.POST)
	public @ResponseBody String editCategory(@ModelAttribute("category") Categories category,
			@PathVariable("id") int id)
	{
		try 
		{
			
		
		String name = category.getName();
		String slug = category.getSlug();
		int parent = category.getParent();
		String description = category.getDescription();
		
		
		/*Step 1*/
		
		if( name == "" || parent < 0 || slug == "" || id < 0)
		{
			return "fail";
		}
		
		/*Step 2*/
		Session session = factory.openSession();
		/*
		String hql = "UPDATE Categories "
				+ "SET name = '" + name + "', "
				+ "slug = '" + slug + "', "
				+ "parent = " + parent + ", "
				+ "description = '" + description + "' "
				+ "WHERE id = " + id;
		*/
		String hql = "UPDATE Categories SET name =:name, slug =:slug, parent =:parent, description =:description WHERE id =:id";
		
		Query query = session.createQuery(hql);
		query.setParameter("name", name);
		query.setParameter("slug", slug);
		query.setParameter("parent", parent);
		query.setParameter("description", description);
		query.setParameter("id", id);
		query.executeUpdate();
		return "success";
		} 
		catch (Exception e) 
		{
			System.out.println(e);
			return "fail";
		}
		
		

	
		
	}
	
	/***********************************************************************************************/
	/****************************************** FUNCTION *******************************************/
	/***********************************************************************************************/
	

	
	/**************************************************
	 * @author Phong
	 * @return tra ve doi tuong categories
	 **************************************************/
	public Categories retrieveByID(String id)
	{
		Session session = factory.getCurrentSession();
		String hql = "FROM Categories WHERE id = " + id;
		
		
		Query query = session.createQuery(hql);
		
		
		@SuppressWarnings("unchecked")
		List<Categories> list = query.list();
		return list.get(0);
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * @return tra ve so luong bai viet thuoc the loai theo ID
	 **************************************************/
	public long retrieveNumberPostByCategory(String id)
	{
		Session session = factory.getCurrentSession();
		String hql = "SELECT count(p.id) "
				+ "FROM Categories as c, "
				+ "Posts as p "
				+ "WHERE c.id = p.category.id "
				+ "AND c.id = " + id;
		
		
		Query query = session.createQuery(hql);
		
		
		long quantity = (long) query.uniqueResult();
		return quantity;
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * lay toan bo the loai nham phuc vu chuc nang chuyen muc goc
	 * @return mot @ModelAttribute de in tat ca the loai ra
	 **************************************************/
	 @SuppressWarnings("unchecked")
	 @ModelAttribute("categories")
	 public List<Categories> retrieveAllCategories(ModelMap modelMap)
	 {
		 Session session = factory.getCurrentSession();
		 String hql = "FROM Categories";
		 
		 Query query = session.createQuery(hql);
		 
		 List<Categories> list = query.list();
		 return list;
	 }
}
