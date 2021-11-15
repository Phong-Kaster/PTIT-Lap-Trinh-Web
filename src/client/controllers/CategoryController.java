package client.controllers;

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

import entities.Categories;
import entities.Posts;

@Transactional
@Controller
public class CategoryController {

	@Autowired
	SessionFactory factory;
	
	/*************************************************
	 * @author Phong
	 * Step 1: khoi tao cau truy van
	 * Step 2: gan dieu kien cho cau truy van
	 * Step 3: tra ket qua ve
	 * Step 4: gan ket qua vao @ModelMap de tra ra view
	 * 
	 * PAGINATION
	 * setMaxLinkedPages(3) ngoai trang hien tai thi co 3 trang khac duoc hien thi
	 * setPageSize(8) coi 8 bai viet o moi trang
	 * @return lay ra cac bai viet theo theo loai @param slug
	 *************************************************/
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="category/{slug}", method=RequestMethod.GET)
	public String retrieveArticlesByCategory(HttpServletRequest request ,ModelMap modelMap, @PathVariable("slug") String slug)
	{
		/*Step 1*/
		Session session = factory.getCurrentSession();
		
		/*Step 2*/
		Categories category = retrieveCategory(slug);
		if(category == null) {
			return "redirect:/not-found.htm";
		}
		
		/*Step 3*/
		String hql = "FROM Posts p WHERE p.category.id = :catId AND p.post_status = :post_status";
		
		Query query = session.createQuery(hql);
		query.setParameter("catId", category.getId());
		query.setParameter("post_status", "publish");
		List<Posts> list = query.list();
		
		/*PAGINATION*/
		PagedListHolder pagedListHolder = new PagedListHolder(list);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(8);
		
		/*Step 4*/
		modelMap.addAttribute("pagedListHolder", pagedListHolder);
		modelMap.addAttribute("category", category);
		return "client/category";
	}
	
	
	
	/*********************************************
	 * @author Phong
	 * @param slug | String | ten cua the loai dang SEO. Vi du: the-gioi, am-nhac,..
	 * @return tra ve ban ghi chua day du thong tin cua the loai co @param slug
	 * 
	 * Step 1: khoi tao cau truy van
	 * Step 2: gan dieu kien
	 * Step 3: tra ve ket qua voi du lieu la phan tu o vi tri so 0
	 * 
	 * du lieu do vao /WEB-INF/views/client/category.jsp
	 *********************************************/
	
	@SuppressWarnings("unchecked")
	@ModelAttribute("category")
	public Categories retrieveCategory(String slug)
	{
		try 
		{
			/*Step 1*/
			Session session = factory.getCurrentSession();
			String hql = "FROM Categories c WHERE c.slug = :slug";
			
			
			/*Step 2*/
			Query query = session.createQuery(hql);
			query.setParameter("slug", slug);
			
			
			/*Step 3*/
			List<Categories> list = query.list();
			return list.get(0);
		}
		catch(Exception ex) 
		{
			return null;
		}
	}
	
	
	
	
}
