package client.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Posts;
import entities.Users;
import models.UserSettings;

@Transactional
@Controller
@RequestMapping("/author/")
public class AuthorController {

	@Autowired
	SessionFactory factory;
	
	public UserSettings getUserSettings(Users user)
	{
		ObjectMapper mapper = new ObjectMapper();
		try {
			return mapper.readValue(user.getSettings(), UserSettings.class);
		}catch(Exception ex) {
			return null;
		}
	}
	
	public void addViewer(Users user) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			user.setViewer(user.getViewer()+1);
			session.update(user);
			t.commit();
			
		}catch(Exception ex)
		{
			t.rollback();
			
		}
		finally {
			session.close();
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Posts> getPostByAuthor(int userid){
		Session session = factory.getCurrentSession();
		String hql = "SELECT p FROM Posts p WHERE p.user.id = :userid AND p.post_status = :post_status"; 
		Query query = session.createQuery(hql); 

		query.setParameter("userid", userid);
		query.setParameter("post_status", "publish");
		try 
		{
			return query.list();
		}catch(Exception ex) {
			ex.printStackTrace();
			return null;
		}
		
	}
	
	@SuppressWarnings("unchecked")
	public Users getUser(String username)
	{
		try 
		{
			/*Step 1*/
			Session session = factory.getCurrentSession();
			String hql = "FROM Users u WHERE u.username = :username";
			
			/*Step 2*/
			Query query = session.createQuery(hql);
			query.setParameter("username", username);
			
			
			/*Step 3*/
			List<Users> list = query.list();
			return list.get(0);
			
		

		}
		catch(Exception ex) 
		{
			return null;
		}
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="{username}", method=RequestMethod.GET)
	public String author(HttpServletRequest request ,ModelMap modelMap, @PathVariable("username") String username)
	{
		Users user = getUser(username);
		if(user == null) {
			return "redirect:/not-found.htm";
		}
		addViewer(user);
		List<Posts> posts = getPostByAuthor(user.getId());
		PagedListHolder pagedlistHolder = new PagedListHolder(posts);
		int page = ServletRequestUtils.getIntParameter(request, "p",0);
		pagedlistHolder.setPage(page);
		pagedlistHolder.setMaxLinkedPages(5);
		pagedlistHolder.setPageSize(7);
		
		UserSettings settings = this.getUserSettings(user);
		modelMap.addAttribute("UserSettings", settings);
		modelMap.addAttribute("pagedListHolder", pagedlistHolder);
		modelMap.addAttribute("user", user);
		return "client/author";
	}
}
