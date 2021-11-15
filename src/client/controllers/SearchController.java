package client.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;


import entities.Posts;

@Transactional
@Controller

public class SearchController {

	@Autowired
	SessionFactory factory;
	
	@SuppressWarnings("unchecked")
	public List<Posts> getListPosts(String keyword)
	{
		Session session = factory.getCurrentSession();
		String hql = "FROM Posts p WHERE p.title LIKE :keyword AND p.post_status = :post_status ORDER BY p.id DESC"; 
		Query query = session.createQuery(hql); 
		query.setFirstResult(0);
		query.setParameter("keyword", "%" + keyword+"%");
		query.setParameter("post_status", "publish");
		return query.list();
	}
	
	
	@RequestMapping("search")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String search(HttpServletRequest request, ModelMap model)
	{
		String keyword = request.getParameter("q");
		if(keyword == null) {
			keyword = "";
		}else {
			keyword = keyword.trim();
		}
		List<Posts> posts = getListPosts(keyword);
		PagedListHolder pagedlistHolder = new PagedListHolder(posts);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedlistHolder.setPage(page);
		pagedlistHolder.setMaxLinkedPages(5);
		pagedlistHolder.setPageSize(7);
		
		model.addAttribute("pagedListHolder", pagedlistHolder);
		return "client/search";
	}
}
