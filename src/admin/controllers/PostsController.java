package admin.controllers;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
import org.springframework.web.bind.annotation.RequestMethod;

import entities.Posts;


@Transactional
@Controller
@RequestMapping("/admin")
public class PostsController {
	@Autowired
	SessionFactory factory;
		
	/**
	 * Lấy danh sách bài viết theo 4 thuộc tính lọc
	 * @param keyword từ khóa tìm kiếm
	 * @param user_id
	 * @param cat_id
	 * @param post_status
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Posts> getPosts(String keyword, int user_id, int cat_id, String post_status){
		Session session = factory.getCurrentSession();
		String hql = "SELECT p FROM Posts p WHERE p.title LIKE :keyword"; 
		if(user_id > 0) {
			hql += " AND p.user.id = :user_id";
		}
		
		if(cat_id > 0) {
			hql += " AND p.category.id = :cat_id";
		}
		
		hql += " AND p.post_status = :post_status ORDER BY p.id DESC";
		
		Query query = session.createQuery(hql); 
		query.setParameter("keyword", "%"+keyword+"%");
		query.setParameter("post_status", post_status);
		
		if(user_id > 0) {
			query.setParameter("user_id", user_id);
		}
		if(cat_id > 0) {
			query.setParameter("cat_id", cat_id);
		}
		
		try 
		{
			return query.list();
		}catch(Exception ex) {
			ex.printStackTrace();
			return new ArrayList<Posts>();
		}
	}
	
	/**
	 * Lấy tóm tắt tình trạng của bài viết và số bài viết theo tình trạng đó
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object[]> getListSummary(){
		Session session = factory.getCurrentSession();
		String hql = "SELECT p.post_status, COUNT(p.id) FROM Posts p GROUP BY p.post_status"; 
		Query query = session.createQuery(hql); 
		return query.list();
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping( value="posts", method = RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap model, HttpSession session) throws UnsupportedEncodingException{	
		String successMessage = (String) session.getAttribute("successMessage");
		List<String> errorMessage = new ArrayList<String>();
		try {
			errorMessage = (List<String>) session.getAttribute("errorMessage");
		}catch(Exception ex){
			
		}
		
		String search = request.getParameter("search");
		if(search == null) search = "";
		int user_id = 0;
		int cat_id = 0;
		try {
			user_id = Integer.parseInt(request.getParameter("user_id"));
		}catch(Exception ex) {
			user_id = 0;
		}
		
		try {
			cat_id = Integer.parseInt(request.getParameter("cat_id"));
		}catch(Exception ex) {
			cat_id = 0;
		}
		
		String post_status = request.getParameter("post_status");
		if(post_status == null) post_status = "publish";
		
		List<Posts> posts = getPosts(search, user_id, cat_id, post_status);
		PagedListHolder pagedlistHolder = new PagedListHolder(posts);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedlistHolder.setPage(page);
		pagedlistHolder.setMaxLinkedPages(5);
		pagedlistHolder.setPageSize(15);
		
		
		// lấy tóm tắt 
		List<Object[]> listSummary  = getListSummary();
		String url = request.getRequestURL().toString() + "?" + (request.getQueryString() == null ? "post_status=publish" : request.getQueryString().toString());
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm aa", new Locale("vi", "VN"));
		model.addAttribute("dateFormatPost", dateFormat);
		model.addAttribute("pagedListHolder", pagedlistHolder);
		model.addAttribute("successMessage", successMessage);
		model.addAttribute("errorMessage", errorMessage);
		model.addAttribute("listSummary", listSummary);
		model.addAttribute("dataUrl", URLEncoder.encode(url, StandardCharsets.UTF_8.toString()));
		return "admin/posts";
	}
}
