package admin.controllers;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import entities.Categories;
import entities.Posts;
import entities.Users;
import helpers.CommonHelper;
import models.CategoriesModel;

@Transactional
@Controller
@RequestMapping("/admin")
public class PostController {
	@Autowired
	SessionFactory factory;
	
	/**
	 * Lấy thông tin thể loại theo level
	 * @param parent
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Categories> getCat(int parent){
		Session session = factory.getCurrentSession();
		String hql = "FROM Categories c WHERE parent = :parent"; 
		Query query = session.createQuery(hql); 
		query.setParameter("parent", parent);
		List<Categories> list = query.list();
		return list;
	}
	
	/**
	 * Lấy 1 bài viết theo id
	 * @param postid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Posts getPostById(int postid){
		Session session = factory.getCurrentSession();
		String hql = "SELECT p FROM Posts p WHERE p.id = :postid"; 
		Query query = session.createQuery(hql); 
		query.setParameter("postid", postid);
		
		List<Posts> list = query.list();
		
		try 
		{
			return list.get(0);
		}catch(Exception ex) {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping( value={"post","post-new"}, method = RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap model, HttpSession session){	
		String successMessage = (String) session.getAttribute("successMessage");
		List<String> errorMessage = (List<String>) session.getAttribute("errorMessage");
		
		String id = request.getParameter("postid");
		Posts post = new Posts();
		try {
			int postId = Integer.parseInt(id);
			post = getPostById(postId);
			if(post == null ) post = new Posts();
			else if(post.getPost_status().contains("trash")) {
				return "redirect:/admin/posts.htm?post_status=trash";
			}
			
		}catch(Exception ex) {
			
		}
		// Lấy danh sách thể loại
		
		List<Categories> listParent = getCat(0);
		List<CategoriesModel> list = new ArrayList<CategoriesModel>();
		for(Categories item: listParent) {
			CategoriesModel cat = new CategoriesModel();
			cat.setCategory(item);
			List<Categories> listChildren = getCat( item.getId());
			if(listChildren != null && listChildren.size() > 0) {
				cat.setChildren(listChildren);
			}
			list.add(cat);
		}
		
		model.addAttribute("listCategories", list);
		model.addAttribute("post", post);
		model.addAttribute("successMessage", successMessage);
		model.addAttribute("errorMessage", errorMessage);
		return "admin/post";
	}
	
	
	@RequestMapping( value="post", method = RequestMethod.POST)
	public String save(HttpServletRequest request, ModelMap model, @RequestParam Map<String, Object> params){	
		
		Users user = (Users)request.getAttribute("AuthUser");
		
		List<String> errorMessage = new ArrayList<String>();
		Boolean error = false;
		boolean is_new = false;
		String title = (String) params.get("title");
		String post_slug = (String) params.get("post_slug");
		String post_status = (String) params.get("post_status");
		boolean comment_status = Boolean.parseBoolean((String)params.get("comment_status"));
		String media = (String) params.get("media");
		String content = (String) params.get("content");
		String excerpt = (String) params.get("excerpt");
		String cat_id = (String) params.get("cat_id");
		
		Categories category = null;
		if(title == null || title.trim().length() == 0) {
			errorMessage.add("Tiêu đề không được bỏ trống!");
			error = true;
		}
		
		if(post_slug == null || post_slug.trim().length() == 0) {
			errorMessage.add("Slug không được bỏ trống!");
			error = true;
		}
		
		
		if(media == null || media.trim().length() == 0) {
			errorMessage.add("Ảnh bìa không được bỏ trống!");
			error = true;
		}
		
		if(content == null || content.trim().length() == 0) {
			errorMessage.add("Nội dung bài viết không được bỏ trống!");
			error = true;
		}
		
		if(excerpt == null || excerpt.trim().length() == 0) {
			errorMessage.add("Trích đoạn mô tả không được bỏ trống!");
			error = true;
		}
		
		
		if(post_status == null || post_status.trim().length() == 0) {
			errorMessage.add("Tình trạng bài viết không được bỏ trống!");
			error = true;
		}else if(!CommonHelper.contains(new String[] { "pending", "publish", "draft" }, post_status)) {
			errorMessage.add("Tình trạng bài viết không hợp lệ!");
			error = true;
		}
		
		if(user.getAccount_type().equals("CONTRIBUTOR")) {
			post_status = "pending";
		}
		
		if(cat_id == null || cat_id.trim().length() == 0) {
			errorMessage.add("Thể loại không được bỏ trống!");
			error = true;
		}else {
			category = getCategory(cat_id);
			if(category == null) {
				category = getCategory("1");
			}
		}
		
		
		int postId = 0;
		Posts post = new Posts();
		try {
			postId = Integer.parseInt(request.getParameter("postid"));
			post = getPostById(postId);
			if(post == null ) post = new Posts();
		}catch(Exception ex) {
			
		}
		
		if(post.getTitle() == null || post.getTitle().length() == 0) {
			is_new = true;
		}
		
		if(error == false){
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			
			post.setCategory(category);
			post.setTitle(title);
			post.setPost_slug(post_slug);
			post.setComment_status(comment_status);
			post.setContent(content);
			post.setMedia(media);
			post.setExcerpt(excerpt);
			post.setPost_status(post_status);
			post.setComment_status(comment_status);
			
			if(!is_new) {
				post.setModified_at(new Date());
				// cập nhật - sửa
				try{   
					session.update(post);
					t.commit();
					request.getSession().setAttribute("successMessage", "Sửa bài viết thành công");
				}
				catch(Exception e){
					t.rollback();
					errorMessage.add("Cập nhật bài viết thất bại !");
					request.getSession().setAttribute("errorMessage", errorMessage);
				}
				finally{
					session.close();
				}
			}else {
			    Date date = new Date();  
				post.setModified_at(date);
				post.setCreated_at(date);
				post.setExternal_id("");
				post.setSource("");
				post.setUser(user);
				String external_id = CommonHelper.RandomString(10);
				post.setExternal_id(external_id);
				post.setFeatured(false);
				// thêm mới
				try{   
					session.save(post);
					t.commit();
					request.getSession().setAttribute("successMessage", "Thêm bài viết thành công");
				}
				catch(Exception e){
					e.printStackTrace();
					t.rollback();
					errorMessage.add("Thêm bài viết thất bại !");
				}
				finally{
					session.close();
				}
			}
		}
		request.getSession().setAttribute("errorMessage", errorMessage);
		return "redirect:/admin/post.htm?postid=" + post.getId();
	}
	
	/**
	 * Lấy thông tin thể loại theo bài viết
	 * @param cat_id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Categories getCategory(String cat_id)
	{
		try 
		{
			Session session = factory.getCurrentSession();
			String hql = "FROM Categories c "
						+ "WHERE c.id = :cat_id";
			
			Query query = session.createQuery(hql);
			query.setParameter("cat_id", Integer.parseInt(cat_id));
			List<Categories> list = query.list();
			return list.get(0);
		}
		catch(Exception ex) 
		{
			return null;
		}
	}
}
