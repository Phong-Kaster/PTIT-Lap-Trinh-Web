package admin.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Subscribers;


@Transactional
@Controller
@RequestMapping("/admin")
public class SubscribersController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	ObjectMapper mapper;
	
	
	@SuppressWarnings("unchecked")
	public List<Object[]> getListSummaryByActive(){
		Session session = factory.getCurrentSession();
		String hql = "SELECT s.is_active, COUNT(s.id) FROM Subscribers s GROUP BY s.is_active"; 
		Query query = session.createQuery(hql); 
		return query.list();
	}
	
	
	@SuppressWarnings("unchecked")
	public Subscribers getSubscriberByEmail(String email){
		Session session = factory.getCurrentSession();
		String hql = "SELECT s FROM Subscribers s WHERE s.email = :email"; 
		Query query = session.createQuery(hql); 
		query.setParameter("email", email);
		
		List<Subscribers> list = query.list();
		
		try 
		{
			return list.get(0);
		}catch(Exception ex) {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Subscribers> getSubscribers(String keyword, String active){
		Session session = factory.getCurrentSession();
		String hql = "SELECT s FROM Subscribers s WHERE s.email LIKE :keyword"; 
		
		if(active != null && active.length() > 0) {
			hql += " AND s.is_active = :active";
		}
		
		
		hql += " ORDER BY s.id DESC";
		Query query = session.createQuery(hql); 
		query.setParameter("keyword", "%"+keyword+"%");
		query.setParameter("active", Boolean.parseBoolean(active));
		try 
		{
			return query.list();
		}catch(Exception ex) {
			ex.printStackTrace();
			return new ArrayList<Subscribers>();
		}
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping( value="subscribers", method = RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap model, HttpSession session) throws UnsupportedEncodingException{	
		String successMessage = (String) session.getAttribute("successMessage");
		List<String> errorMessage = new ArrayList<String>();
		try {
			errorMessage = (List<String>) session.getAttribute("errorMessage");
		}catch(Exception ex){
			
		}
		String search = request.getParameter("search");
		if(search == null) search = "";

		
		String active = request.getParameter("active");
		if(active == null) active = "true";

		List<Subscribers> posts = getSubscribers(search, active);
		PagedListHolder pagedlistHolder = new PagedListHolder(posts);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedlistHolder.setPage(page);
		pagedlistHolder.setMaxLinkedPages(5);
		pagedlistHolder.setPageSize(15);
		
		
		// lấy tóm tắt 
		String url = request.getRequestURL().toString() + "?" + (request.getQueryString() == null ? "role=all" : request.getQueryString().toString());
		model.addAttribute("pagedListHolder", pagedlistHolder);
		model.addAttribute("successMessage", successMessage);
		model.addAttribute("errorMessage", errorMessage);
		model.addAttribute("listSummaryByActive", getListSummaryByActive());
		model.addAttribute("dataUrl", URLEncoder.encode(url, StandardCharsets.UTF_8.toString()));
		return "admin/subscribers";
	}
	
	
	@RequestMapping( value="email_active", method = RequestMethod.GET)
	public String active(HttpServletRequest request, @RequestParam Map<String, Object> params) throws UnsupportedEncodingException {	
		String url = request.getParameter("next");
		if(url == null) url = "/admin/subscribers.htm";
		else url = URLDecoder.decode(url, "UTF-8");
		
		String email = request.getParameter("email");
		
		boolean is_active = false;
		try {
			is_active = Boolean.parseBoolean(request.getParameter("active"));
		}catch(Exception ex) {
			is_active = false;
		}
		
		
		List<String> errorMessage = new ArrayList<String>();
		Subscribers subscriber = getSubscriberByEmail(email);
		if(subscriber == null) {
			errorMessage.add("Email không tồn tại !");
		}else {
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			try{   
				subscriber.setIs_active(is_active);
				session.update(subscriber);
				t.commit();
				request.getSession().setAttribute("successMessage", "Set email thành công");
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				errorMessage.add("Set email thất bại !");
			}
			finally{
				session.close();
			}
		}
		
		if(errorMessage.size() > 0) {
			return "redirect:/admin/subscribers.htm";
		}
		return "redirect:"+ url;
	}
}
