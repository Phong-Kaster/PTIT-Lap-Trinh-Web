package admin.controllers;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import models.CountModel;

@Transactional
@Controller
@RequestMapping("/dashboard")
public class DashboardController {
	@Autowired
	SessionFactory factory;
		
	
	@RequestMapping( method = RequestMethod.GET)
	public String index(ModelMap model){	
		model.addAttribute("count",GetCount());
		return "admin/dashboard";
	}
	
	
	public CountModel GetCount() {
		CountModel count = new CountModel();
		count.setPost(CountData("Posts"));
		count.setCmt(CountData("Comments"));
		count.setCat(CountData("Categories"));
		count.setUser(CountData("Users"));
		return count;
	}
	
	
	public  long CountData(String name) {
		
		Session session = factory.getCurrentSession();
		String hql = String.format("SELECT COUNT(*) FROM %s ", name); 
		Query query = session.createQuery(hql); 
		try {
			return (long)query.uniqueResult();
		}
		catch(Exception e)
		{
			System.out.println(e);
			return 0;
		}
		
	}
}
