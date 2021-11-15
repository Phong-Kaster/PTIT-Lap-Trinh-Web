package admin.controllers;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import entities.Posts;
import entities.Users;


@Transactional
@Controller
@RequestMapping("/admin")
public class PostActionController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	ObjectMapper mapper;
	
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
	
	@RequestMapping( value="post_trash", method = RequestMethod.GET)
	public String trash(HttpServletRequest request, ModelMap model) throws UnsupportedEncodingException{
		List<String> errorMessage = new ArrayList<String>();
		
		String url = request.getParameter("next");
		if(url == null) url = "/admin/posts.htm";
		else url = URLDecoder.decode(url, "UTF-8");
		
		int postId = 0;
		try {
			postId = Integer.parseInt(request.getParameter("postid"));
		}catch(Exception ex) {
			postId = 0;
		}
		
		if(postId == 0) {
			return "redirect:" + url;
		}
		
		Users user = (Users)request.getAttribute("AuthUser");
		if(user.getAccount_type().equals("CONTRIBUTOR")) {
			errorMessage.add("Bạn ko có quyền xóa bài viết!");
			request.getSession().setAttribute("errorMessage", errorMessage);
			return "redirect:" + url;
		}
		
		Posts post = getPostById(postId);
		if(post == null) {
			errorMessage.add("Bài viết không tồn tại !");
		}else {
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			try{   
				post.setPost_status("trash");
				session.update(post);
				t.commit();
				request.getSession().setAttribute("successMessage", "Xóa bài viết thành công");
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				errorMessage.add("Xóa bài viết thất bại !");
			}
			finally{
				session.close();
			}
		}
		
		request.getSession().setAttribute("errorMessage", errorMessage);
		if(errorMessage.size() > 0) {
			return "redirect:/admin/post.htm?postid=" + postId;
		}
		request.getSession().setAttribute("successMessage", "Xóa bài viết thành công");
		return "redirect:"+ url;
	}
	
	@RequestMapping( value="post_delete", method = RequestMethod.GET)
	public String delete(HttpServletRequest request, ModelMap model) throws UnsupportedEncodingException{
		List<String> errorMessage = new ArrayList<String>();
		String url = request.getParameter("next");
		if(url == null) url = "/admin/posts.htm";
		else url = URLDecoder.decode(url, "UTF-8");
		
		int postId = 0;
		try {
			postId = Integer.parseInt(request.getParameter("postid"));
		}catch(Exception ex) {
			postId = 0;
		}
		
		if(postId == 0) {
			return "redirect:" + url;
		}
		
		Users user = (Users)request.getAttribute("AuthUser");
		if(user.getAccount_type().equals("CONTRIBUTOR")) {
			errorMessage.add("Bạn ko có quyền xóa bài viết!");
			request.getSession().setAttribute("errorMessage", errorMessage);
			return "redirect:" + url;
		}
		
		
		
		
		Posts post = getPostById(postId);
		if(post == null) {
			errorMessage.add("Bài viết không tồn tại !");
		}else {
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			try{   
				session.delete(post);
				t.commit();
				request.getSession().setAttribute("successMessage", "Xóa bài viết thành công");
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				errorMessage.add("Xóa bài viết thất bại !");
			}
			finally{
				session.close();
			}
		}
		request.getSession().setAttribute("errorMessage", errorMessage);
		if(errorMessage.size() > 0) {
			return "redirect:" + url;
		}
		return "redirect:"+ url;
	}
	
	
	@RequestMapping( value="post_featured", method = RequestMethod.POST)
	public ResponseEntity<JsonNode> featured(HttpServletRequest request, @RequestParam Map<String, Object> params) {	
		int postId = 0;
		try {
			postId = Integer.parseInt((String) params.get("id"));
		}catch(Exception ex) {
			postId = 0;
		}
		ObjectNode objectNode = mapper.createObjectNode();
		
		if(postId == 0) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Bài viết không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		
		Posts post = getPostById(postId);
		if(post == null) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Bài viết không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}else {
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			try{   
				post.setFeatured(!post.isFeatured());
				session.update(post);
				t.commit();
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				objectNode.put("result", 0);
				objectNode.put("msg", "Lỗi! Hãy thử lại!");
				return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
			}
			finally{
				session.close();
			}
		}
		
		if(post.isFeatured()) {
			objectNode.put("result", 1);
			objectNode.put("html", "<i class='fas fa-star text-warning'></i>");
		}else {
			objectNode.put("html", "<i class='far fa-star'></i>");
		}
		return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
	}
	
	
	
	@RequestMapping( value="post_bulk", method = RequestMethod.POST)
	public ResponseEntity<JsonNode> bulk(HttpServletRequest request, @RequestParam("action") String action, @RequestParam("ids[]") List<Integer> ids) throws IOException {	
		Session session = factory.openSession();
		ObjectNode objectNode = mapper.createObjectNode();
		if(action == null || action == "") {
			objectNode.put("result", 0);
			objectNode.put("msg", "Hành động không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		
		if(ids == null || ids.size() == 0) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Danh sách không hợp lệ!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		
		String values = "";
		 int i = 0;
		for(Integer item: ids) {
			if(i++ == ids.size() - 1){
				values += "id = " + item;
			}else {
				values += "id = " + item + " OR ";
			}
		}
		
		Users user = (Users)request.getAttribute("AuthUser");
		if(user.getAccount_type().equals("CONTRIBUTOR")) {
			objectNode.put("result", 0);
			objectNode.put("msg", "Bạn không có quyền thực hiện hành động!");
			return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
		}
		
		Transaction t =  session.beginTransaction();
		if(action.equals("trash")) {
			
			try{   
				String hql = "UPDATE Posts SET post_status = :post_status WHERE " + values; 
				Query query = session.createQuery(hql); 
				query.setParameter("post_status", "trash");
				query.executeUpdate();
				t.commit();
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				objectNode.put("result", 0);
				objectNode.put("msg", "Lỗi! Hãy thử lại!");
				return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
			}
			finally{
				session.close();
			}
			request.getSession().setAttribute("successMessage", "Cho vào rác danh sách bài viết thành công!");
		}
		else if(action.equals("restore")) {
			try{   
				String hql = "UPDATE Posts SET post_status = :post_status WHERE " + values; 
				Query query = session.createQuery(hql); 
				query.setParameter("post_status", "pending");
				query.executeUpdate();
				t.commit();
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				objectNode.put("result", 0);
				objectNode.put("msg", "Lỗi! Hãy thử lại!");
				return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
			}
			finally{
				session.close();
			}
			request.getSession().setAttribute("successMessage", "Khôi phục bài viết thành công!");
		}
		else if(action.equals("delete")) {
			try{   
				String hql = "DELETE FROM Posts WHERE " + values; 
				Query query = session.createQuery(hql); 
				query.executeUpdate();
				t.commit();
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				objectNode.put("result", 0);
				objectNode.put("msg", "Lỗi! Hãy thử lại!");
				return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
			}
			finally{
				session.close();
			}
			request.getSession().setAttribute("successMessage", "Xóa vĩnh viễn bài viết thành công!");
		}
		objectNode.put("result", 1);
		return new ResponseEntity<JsonNode>(objectNode, HttpStatus.OK);
	}
}
