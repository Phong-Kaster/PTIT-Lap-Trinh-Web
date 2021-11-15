package admin.controllers;

import java.io.IOException;
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

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import bean.Mailer;
import entities.Users;


@Transactional
@Controller
@RequestMapping("/admin")
public class UsersController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	ObjectMapper mapper;
	
	@Autowired
	Mailer mailer;
	
	@SuppressWarnings("unchecked")
	public List<Object[]> getListSummary(){
		Session session = factory.getCurrentSession();
		String hql = "SELECT u.account_type, COUNT(u.id) FROM Users u GROUP BY u.account_type"; 
		Query query = session.createQuery(hql); 
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object[]> getListSummaryByActive(){
		Session session = factory.getCurrentSession();
		String hql = "SELECT u.is_active, COUNT(u.id) FROM Users u GROUP BY u.is_active"; 
		Query query = session.createQuery(hql); 
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public Users getUserById(int userid){
		Session session = factory.getCurrentSession();
		String hql = "SELECT u FROM Users u WHERE u.id = :userid"; 
		Query query = session.createQuery(hql); 
		query.setParameter("userid", userid);
		
		List<Users> list = query.list();
		
		try 
		{
			return list.get(0);
		}catch(Exception ex) {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Users> getUsers(String keyword, String role, String active){
		Session session = factory.getCurrentSession();
		String hql = "SELECT u FROM Users u WHERE u.username LIKE :keyword"; 
		
		if(role != null && role.length() > 0 ) {
			if(role.contains("all")) {
				hql += " AND u.account_type != :role";
			}else {
				hql += " AND u.account_type = :role";
			}
		}
		
		if(active != null && active.length() > 0) {
			hql += " AND u.is_active = :active";
		}
		
		
		hql += " ORDER BY u.id DESC";
		Query query = session.createQuery(hql); 
		query.setParameter("keyword", "%"+keyword+"%");
		query.setParameter("role", role);
		query.setParameter("active", Boolean.parseBoolean(active));
		try 
		{
			return query.list();
		}catch(Exception ex) {
			ex.printStackTrace();
			return new ArrayList<Users>();
		}
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping( value="users", method = RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap model, HttpSession session) throws UnsupportedEncodingException{	
		String successMessage = (String) session.getAttribute("successMessage");
		List<String> errorMessage = new ArrayList<String>();
		try {
			errorMessage = (List<String>) session.getAttribute("errorMessage");
		}catch(Exception ex){
			
		}
		String search = request.getParameter("search");
		if(search == null) search = "";
		
		String role = request.getParameter("role");
		if(role == null) role = "all";
		
		String active = request.getParameter("active");
		if(active == null) active = "true";

		List<Users> posts = getUsers(search, role, active);
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
		model.addAttribute("listSummary", getListSummary());
		model.addAttribute("listSummaryByActive", getListSummaryByActive());
		model.addAttribute("dataUrl", URLEncoder.encode(url, StandardCharsets.UTF_8.toString()));
		return "admin/users";
	}
	
	
	@RequestMapping( value="user_active", method = RequestMethod.GET)
	public String active(HttpServletRequest request, @RequestParam Map<String, Object> params) throws UnsupportedEncodingException {	
		String url = request.getParameter("next");
		if(url == null) url = "/admin/users.htm";
		else url = URLDecoder.decode(url, "UTF-8");
		
		int userId = 0;
		try {
			userId = Integer.parseInt(request.getParameter("userid"));
		}catch(Exception ex) {
			userId = 0;
		}
		
		boolean is_active = false;
		try {
			is_active = Boolean.parseBoolean(request.getParameter("active"));
		}catch(Exception ex) {
			is_active = false;
		}
		
		
		List<String> errorMessage = new ArrayList<String>();
		Users user = getUserById(userId);
		if(user == null) {
			errorMessage.add("Người dùng không tồn tại !");
		}else {
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			try{   
				user.setIs_active(is_active);
				session.update(user);
				t.commit();
				request.getSession().setAttribute("successMessage", "Set người dùng thành công");
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				errorMessage.add("Set người dùng thất bại !");
			}
			finally{
				session.close();
			}
		}
		
		if(errorMessage.size() > 0) {
			return "redirect:/admin/users.htm";
		}
		return "redirect:"+ url;
	}
	
	@RequestMapping( value="user_recovery", method = RequestMethod.GET)
	public String recovery(HttpServletRequest request, @RequestParam Map<String, Object> params) throws UnsupportedEncodingException {	
		String url = request.getParameter("next");
		if(url == null) url = "/admin/users.htm";
		else url = URLDecoder.decode(url, "UTF-8");
		
		int userId = 0;
		try {
			userId = Integer.parseInt(request.getParameter("userid"));
		}catch(Exception ex) {
			userId = 0;
		}
		
		List<String> errorMessage = new ArrayList<String>();
		Users user = getUserById(userId);
		if(user == null) {
			errorMessage.add("Người dùng không tồn tại !");
		}else {
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			try{   
				
				String recoveryhash = "";
				recoveryhash = updateToken(user);	
				if(recoveryhash != "") {
					recoveryhash = user.getId()+"_"+recoveryhash;
					mailer.send(mailer.from(), user.getEmail(), mailer.retrievePasswordSubject(), mailer.bodyRP(recoveryhash));	
				}
				t.commit();
				request.getSession().setAttribute("successMessage", "Gửi mail khôi phục thành công");
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				errorMessage.add("Gửi mail khôi phục thất bại !");
			}
			finally{
				session.close();
			}
		}
		
		if(errorMessage.size() > 0) {
			return "redirect:/admin/users.htm";
		}
		return "redirect:"+ url;
	}
	
	public String updateToken(Users user) throws IOException
	{
		JsonNode jsonNode = mapper.readTree(user.getData());
		String token = Long.toHexString(Double.doubleToLongBits(Math.random())); // HÀM TẠO RANDOM HASH ĐỂ LẤY LẠI MẬT KHẨU
		((ObjectNode)jsonNode).put("recoveryhash", token);
		user.setData(mapper.writeValueAsString(jsonNode));
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(user);
			t.commit();
		}catch (Exception ex)
			{
				t.rollback();
				return "";
			}
		return token;
	}
}
