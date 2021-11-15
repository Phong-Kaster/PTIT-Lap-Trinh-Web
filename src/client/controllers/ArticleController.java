package client.controllers;


import java.io.IOException;
import java.net.MalformedURLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Comments;
import entities.Posts;
import entities.Users;
import lib.Recaptcha;
import models.CommentModel;
import models.IntegrationsData;
import models.UserSettings;

@Transactional
@Controller
@RequestMapping("/article/")
public class ArticleController {
	@Autowired
	SessionFactory factory;
	
	public Posts getPost(int post_id)
	{
		Session session = factory.getCurrentSession();
		String hql = "FROM Posts WHERE id = :id AND post_status = :post_status"; 
		Query query = session.createQuery(hql); 
		query.setParameter("id", post_id);
		query.setParameter("post_status", "publish");
		try 
		{
			Posts post = (Posts) query.list().get(0);
			return post;
		}catch(Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	public UserSettings getUserSettings(Users user)
	{
		ObjectMapper mapper = new ObjectMapper();
		try {
			return mapper.readValue(user.getSettings(), UserSettings.class);
		}catch(Exception ex) {
			return null;
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Posts> getRelatedPost(int postId, int limitPost){
		Session session = factory.getCurrentSession();
		String hql = "SELECT p FROM Posts p WHERE p.id != :postId AND p.post_status = :post_status ORDER BY RAND()"; 
		Query query = session.createQuery(hql); 
		query.setFirstResult(0);
		query.setMaxResults(limitPost);
		query.setParameter("postId", postId);
		query.setParameter("post_status", "publish");
		try 
		{
			return query.list();
		}catch(Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	// lấy danh sách thep post_id và  comment_status = approved
	

	@RequestMapping(value = "{post_id}/{post_slug}", method = RequestMethod.GET)
	public String article(ModelMap model, @PathVariable("post_id") int post_id, @PathVariable("post_slug") String post_slug){	
		Posts post = this.getPost(post_id);
		if(post == null) {
			return "redirect:/not-found.htm";
		}
		addViewer(post);
		model.addAttribute("post", post);
		
		UserSettings settings = this.getUserSettings(post.getUser());
		model.addAttribute("UserSettings", settings);
		model.addAttribute("ListRelatedPost", this.getRelatedPost(post.getId(), 4));
		model.addAttribute("CountComments",CountComments(post_id));
		setComment(model, post_id);
		return "client/article";
	}
	
	// COMMENT------------
	public long CountComments(int post_id)
	{
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Comments c WHERE c.post.id = :post_id"; 
		Query query = session.createQuery(hql); 
		query.setParameter("post_id", post_id);
		return (long)query.uniqueResult();
	}
	
	public void addViewer(Posts post) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			post.setViewer(post.getViewer()+1);
			session.update(post);
			t.commit();
			
		}catch(Exception ex)
		{
			t.rollback();
			
		}
		finally {
			session.close();
		}
	}
	
	public boolean Insertcomment(Comments cmt) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.save(cmt);
			t.commit();
			return true;
			
		}catch(Exception ex)
		{
			t.rollback();
			
		}
		finally {
			session.close();
		}
		return false;
	}
	
	@RequestMapping(value = "{post_id}/{post_slug}", method = RequestMethod.POST)
	public String CommentController(HttpServletRequest request, ModelMap model, 
			@PathVariable("post_id") int post_id, 
			@PathVariable("post_slug") String post_slug, 
			@RequestParam("comment") String comment, 
			@RequestParam(value = "author", required = false) String author,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam("comment_parent") int parent,
			@RequestParam(value = "g-recaptcha-response", required = false) String recaptcha_response
		) throws MalformedURLException, IOException{	
		Posts post = getPost(post_id);
		if(post == null) {
			return "redirect:/not-found.htm";
		}
		
		
		
		
		String id = String.valueOf(post_id); 
		int user_id = 0;
		Users authUser = (Users)request.getAttribute("AuthUser");
		IntegrationsData integrations = (IntegrationsData)request.getAttribute("IntegrationsData");
		Recaptcha recaptcha = (Recaptcha)request.getAttribute("Recaptcha");
		
		if(integrations.isComment_recaptcha()) {
			if(recaptcha_response != null && !recaptcha_response.trim().isEmpty()) {
				if(!recaptcha.verification(recaptcha_response)) {
					request.getSession().setAttribute("error", "Captcha không hợp lệ!");
					return "redirect:/article/"+id+"/"+post_slug+".htm#respond";
				}
			}else {
				request.getSession().setAttribute("error", "Vui lòng check chọn captcha");
				return "redirect:/article/"+id+"/"+post_slug+".htm#respond";
			}
		}
		
		
		
		Comments cmt = new Comments();
		
		if(authUser == null) {
			if(author == null || author.trim().length() == 0) {
				request.getSession().setAttribute("error", "Không được bỏ trống tên");
				return "redirect:/article/"+id+"/"+post_slug+".htm#respond";
			}
			
			if(email == null || email.trim().length() == 0) {
				request.getSession().setAttribute("error", "Không được bỏ trống email");
				return "redirect:/article/"+id+"/"+post_slug+".htm#respond";
			}
			cmt.setComment_author(author);
			cmt.setComment_author_email(email); 
		}else {
			user_id = authUser.getId();
			cmt.setComment_author(authUser.getFirstname() + " " + authUser.getLastname());
			cmt.setComment_author_email(authUser.getEmail()); 
		}
		//SET USER_ID
		cmt.setUser_id(user_id);
		
		//SET POST cho comment
		cmt.setPost(post);
		
		//SET PARENT
		cmt.setComment_parent(parent);
		
		// set agent
		String userAgent = request.getHeader("User-Agent");
		cmt.setComment_agent(userAgent);
		
		// set ip
		String ipAddress = request.getHeader("X-FORWARDED-FOR");  
		if (ipAddress == null) {  
		    ipAddress = request.getRemoteAddr();  
		}
		cmt.setComment_author_ip(ipAddress);
		
		// set date
		cmt.setComment_content(comment);
		LocalDateTime now = LocalDateTime.now(); 
		Date current = java.sql.Timestamp.valueOf(now); 
		cmt.setComment_date(current);
		
		
		if(authUser != null && authUser.getAccount_type().equals("ADMIN")) {
			//Set status
			cmt.setComment_status("approved");
			if(Insertcomment(cmt))
			request.getSession().setAttribute("success", "Bình luận hoàn tất");
			else
			request.getSession().setAttribute("error", "Bình luận không thành công");
		}else {
			cmt.setComment_status("moderated");
			if(Insertcomment(cmt))
				request.getSession().setAttribute("primary", "Bình luận đang chờ phê duyệt");
			else
			request.getSession().setAttribute("error", "Bình luận không thành công");
		}

		return "redirect:/article/"+id+"/"+post_slug+".htm#respond";
	}
	
	
	//GET LIST COMMENT 
	@SuppressWarnings("unchecked")
	public List<Comments> getComments(int post_id,int parent){
		Session session = factory.getCurrentSession();
		String hql = "FROM Comments c WHERE c.comment_parent = :parent AND c.post.id = :post_id ORDER BY c.comment_date ASC"; 
		Query query = session.createQuery(hql); 
		query.setParameter("parent", parent);
		query.setParameter("post_id", post_id);
		List<Comments> list = query.list();
		return list;
	}
	
	
	
	/**************************************************
	 * @author Hau
	 * 
	 * @return tra ve cac menu o duoi cung cua trang web
	 * bao gom ABOUT, HELP, PRIVACY, TERMS, CONTACT
	 **************************************************/
	public void setComment(ModelMap model,int post_id) 
	{
		// get Menu
		List<Comments> listParent = getComments(post_id, 0);
		
		List<CommentModel> list = new ArrayList<CommentModel>();
		
		for(Comments item: listParent) {
			CommentModel comments = new CommentModel();
			comments.setComment(item);
			List<Comments> listChildren = getComments(post_id, item.getId());
			if(listChildren != null && listChildren.size() > 0) {
				comments.setList_children(listChildren);
			}
			list.add(comments);
		}
		model.addAttribute("listComments", list);
	}
}
