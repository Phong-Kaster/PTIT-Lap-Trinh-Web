package client.controllers;


import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import entities.*;

@Transactional
@Controller
public class InformationPageController {

	
	@Autowired
	SessionFactory factory;
	
	/**************************************************
	 * @author Phong
	 * 
	 * Step 1: khoi tao session va cau lenh truy van
	 * Step 2: gan dieu kien truy van cho cau lenh
	 * Step 3: thuc hien truy van va dung @ModelMap tra ve ket qua dau tien tim thay
	 * 
	 * @return
	 **************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="page/{slug}", method = RequestMethod.GET)
	public String retrievePageBySlug(ModelMap modelMap, @PathVariable("slug") String slug)
	{
		/*Step 1*/
		Session session = factory.getCurrentSession();
		String hql = "FROM Pages WHERE Page_Slug = :slug";
		
		/*Step 2*/
		Query query = session.createQuery(hql);
		query.setParameter("slug", slug);
		
		
		/*Step 3*/
		List<Pages> list = query.list();
		try {
			modelMap.addAttribute("page", list.get(0));
		}catch(Exception ex){
			return "redirect:../index.htm";
		}
		return "client/informationPage";
	}
}
