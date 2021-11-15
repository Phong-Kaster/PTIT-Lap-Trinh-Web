package admin.controllers;

import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;


import entities.Comments;
import entities.Users;

@Transactional
@Controller
@RequestMapping("admin")
public class AdminCommentController {

	@Autowired
	SessionFactory factory;
	
	/*************************************COMMENT*************************************/
	
	
	/**************************************************
	 * @author Phong
	 * @return lay ra cac trang thai cua comment va so luong binh luan
	 **************************************************/
	public List<Object[]> retrieveStatus()
	{
		Session session = factory.getCurrentSession();
		String hql = "SELECT comment_status, count(id) FROM Comments GROUP BY comment_status";
		
		Query query = session.createQuery(hql);
		@SuppressWarnings("unchecked")
		List<Object[]> list = query.list();
		
		return list;
	}
	
	/**************************************************
	 * @author Phong
	 * @return tra ve tong so comment
	 **************************************************/
	public long retrieveTotalComment()
	{
		Session session = factory.getCurrentSession();
		String hql = "SELECT count(*) FROM Comments";
		
		Query query = session.createQuery(hql);
		
		
		return (long) query.uniqueResult();
	}
	
	
	/**************************************************
	 * @author Phong
	 * @return tim kiem comments theo id cua no
	 **************************************************/
	public Comments retrieveCommentByID(String id)
	{
		Session session = factory.getCurrentSession();
		String hql = "FROM Comments WHERE id = " + id;
		
		Query query = session.createQuery(hql);
		
		@SuppressWarnings("unchecked")
		List<Comments> list = query.list();
		
		return list.get(0);
	}
	
	
	/**************************************************
	 * @author Phong
	 * @return truy van lay ra comment theo dieu kien voi LIKE
	 **************************************************/
	@SuppressWarnings("unchecked")
	public List<Comments> retrieveComment(String keyword, String author, String commentStatus)
	{
		/*Step 1*/
		Session session = factory.getCurrentSession();
		String hql = "FROM Comments as c ";
		
		//System.out.println("===>TRONG HAM RETRIEVE COMMENT");
		//System.out.println("KEYWORD = " + keyword);
		
		
		/*Step 2*/
		if( keyword.trim().length() > 0)
		{
			hql +="WHERE comment_content LIKE '%" + keyword + "%' "
					+ "OR comment_author LIKE '%" + keyword + "%' "
					+ "OR comment_status LIKE '%" + keyword + "%' ";
		}
		if( author.trim().length() > 0)
		{
			hql += "WHERE comment_author = '" + author + "' ";
		}
		
		if( commentStatus.trim().length() > 0 && commentStatus != "all")
		{
			hql += "WHERE comment_status = '" + commentStatus + "' ";
		}
		//System.out.println(hql);
		
		
		
		/*Step 3*/
		Query query = session.createQuery(hql);
		
		
		
		
		return query.list();
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * @commentStatusNow: cho biet trang thai comment dang xem la loai nao ? Bao gom 4 loai: tat ca, chap thuan, dang cho, thung rac
	 * List<Object[]> status: mang chua ten trang thai va so luong binh luan thuoc trang thai do
	 * @keyword: tu khoa duoc nhap tu thanh tim kiem. Tuy nhien, phan nay duoc xu ly rieng biet
	 * @commentAuthor: kieu loc comment theo ten nguoi binh luan
	 * @commentStatus: trang thai comment: approved, pending, trash
	 * 
	 * Step 1: lay cac gia tri can thiet de truyen ve view
	 * Step 2: truy van comment theo dieu kien loc bao gom @keyword, @commentAuthor, @commentStatus.
	 * Dong thoi lay ra ten cac trang thai va so luong comment thuoc trang thai do
	 * Step 3: phan trang voi @pagedListHolder
	 * Step 4: tra ket qua ve view voi @modelMap
	 * @return lay binh luan
	 **************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="comment", method = RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap modelMap)
	{
		/*Step 1*/
		String commentStatusNow = request.getParameter("commentStatus") == null ? "all" : request.getParameter("commentStatus");
		long totalComment = retrieveTotalComment();
		/* String keyword = request.getParameter("keyword"); */
		String keyword = "";
				
		
		String commentAuthor = request.getParameter("commentAuthor");
		if( commentAuthor == null) commentAuthor = "";
		
		String commentStatus = request.getParameter("commentStatus");
		if( commentStatus == null || commentStatus == "all") commentStatus = "";
		
		
		
		/*Step 2*/
		List<Comments> comment = retrieveComment(keyword,commentAuthor, commentStatus);
		List<Object[]> listStatus = retrieveStatus();
		
		
		
		/*PAGINATION*/
		@SuppressWarnings("rawtypes")
		PagedListHolder pagedListHolder = new PagedListHolder(comment);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(7);
		
		
		
		/*Step 4*/
		modelMap.addAttribute("commentStatusNow", commentStatusNow);
		modelMap.addAttribute("totalComment", totalComment);
		modelMap.addAttribute("pagedListHolder", pagedListHolder);
		modelMap.addAttribute("listStatus", listStatus);
		return "admin/comment";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * Step 1: khai bao bien 
	 * Step 2: cap nhat nhung comment co comment_parent la ID
	 * Step 3: xoa comment theo id
	 * Step 4: tra ket qua "sucess" cho AJAX
	 * @return xu ly xoa hoan toan mot comment.
	 **************************************************/
	@RequestMapping(value="remove-comment", method = RequestMethod.GET)
	public @ResponseBody String removeComment(HttpServletRequest request)
	{
		try 
		{
			/*Step 1*/
			String id = request.getParameter("id");
			Session session = factory.openSession();
			Query query = null ;
			String hql = "";
			
			/*Step 2*/
			hql = "UPDATE Comments SET comment_parent = 0 WHERE comment_parent = " + id;
			query = session.createQuery(hql);
			query.executeUpdate();
			
			/*Step 3*/
			hql = "DELETE Comments WHERE id = " + id;
			query = session.createQuery(hql);
			query.executeUpdate();
			
			/*Step 4*/
			return "success";
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return "fail";
		}
		
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * @return khoi phuc comment tu trash thanh pending
	 **************************************************/
	@RequestMapping(value="restore-comment", method = RequestMethod.GET)
	public @ResponseBody String restoreComment(HttpServletRequest request)
	{
		try 
		{
			/*Step 1*/
			String id = request.getParameter("id");
			Session session = factory.openSession();
			Query query = null ;
			String hql = "";
			
			
			
			/*Step 2*/
			hql = "UPDATE Comments SET comment_status = 'pending' WHERE id = " + id;
			
			
			
			/*Step 3*/
			query = session.createQuery(hql);
			query.executeUpdate();
			
			
			
			/*Step 4*/
			return "success";
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return "fail";
		}
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * @return chuyen comment tu trang thai approved | pending sang trang thai trash
	 **************************************************/
	@RequestMapping(value="trash-comment", method = RequestMethod.GET)
	public @ResponseBody String trashComment(HttpServletRequest request)
	{
		try 
		{
			/*Step 1*/
			String id = request.getParameter("id");
			Session session = factory.openSession();
			Query query = null ;
			String hql = "";
			
			
			/*Step 2*/
			hql = "UPDATE Comments SET comment_status = 'trash' WHERE id = " + id;
			
			
			/*Step 3*/
			query = session.createQuery(hql);
			query.executeUpdate();
			
			
			/*Step 4*/
			return "success";
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return "fail";
		}
	}
	
	@RequestMapping(value="response-comment-{id}", method = RequestMethod.GET)
	public String responseComment(HttpServletRequest request, ModelMap modelMap, @PathVariable("id") String id)
	{
		Comments comment = retrieveCommentByID(id);
		
		/*
		 * System.out.println("DU LIEU NHAN DUOC " + id);
		 * System.out.println("DU LIEU TU COMMENT : " + comment.getComment_content());
		 */
		/*Step 2*/
		String commentStatusNow = request.getParameter("commentStatus") == null ? "all" : request.getParameter("commentStatus");
		long totalComment = retrieveTotalComment();
		
		/*Step 3*/
		List<Object[]> listStatus = retrieveStatus();
		
		/*Step 4*/
		modelMap.addAttribute("commentStatusNow", commentStatusNow);
		modelMap.addAttribute("totalComment", totalComment);
		modelMap.addAttribute("listStatus", listStatus);
		modelMap.addAttribute("comment", comment);
		return "admin/commentResponse";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * Step 1: lay ra thong tin ve comment parent va nguoi dung dang nhap
	 * @return
	 **************************************************/
	@RequestMapping(value="response-comment", method = RequestMethod.POST)
	public @ResponseBody String responseComment(HttpServletRequest request)
	{
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try 
		{
			
			/*Step 1*/
			String id = request.getParameter("id");
			Comments commentParent = retrieveCommentByID(id);
			Users user = (Users) request.getAttribute("AuthUser");
			String content = request.getParameter("content");
			
			
			if( content.length() < 0 || content == "" || id.length() < 0) 
			{ 
				return"fail"; 
			}
			 
			
			
			/*Step 2*/
			
			  Comments comment = new Comments(); 
			  comment.setPost( commentParent.getPost() ); 
			  comment.setComment_author( user.getUsername() );
			  comment.setComment_author_email( user.getEmail() );
			 
			  
			 String IP = request.getHeader("X-FORWARDED-FOR"); 
			 if (IP == null) IP = request.getRemoteAddr(); 
			 comment.setComment_author_ip(IP);
			  
			  
			 comment.setComment_date( new Date() ); comment.setComment_content( content );
			  
			  
			 String status = ( user.getAccount_type() == "ADMIN") ? "pending" : "approved";
			 comment.setComment_status(status);
			 
			 
			 String userAgent = request.getHeader("User-Agent");
			 comment.setComment_agent(userAgent);
			 
			 
			 comment.setComment_parent( commentParent.getId() ); 
			 comment.setUser_id(user.getId() );
			 
			
			/*Step 3*/
			
			session.save(comment); 
			t.commit();
			 
			return "success";
		} 
		catch (Exception e) 
		{
			t.rollback();
			System.out.println(e.getMessage());
			e.printStackTrace();
			return "fail";
		}
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * Step 1: khai bao 3 tham so cho retrieveComment() truoc
	 * Step 2: lay trang thai commentStatus dang xem va tong so luong comment
	 * Step 3: lay comment theo dieu kien va danh sach trang trai co trong may
	 * Step 4: do du lieu ra view
	 * @return tim kiem bang keyword
	 **************************************************/
	@RequestMapping(value="search-comment-by-keyword", method=RequestMethod.POST)
	public String search(HttpServletRequest request,ModelMap modelMap)
	{
		/*Step 1*/
		String keyword = request.getParameter("keyword");
		String commentAuthor = "";
		String commentStatus = "";
		
		
		/*Step 2*/
		String commentStatusNow = request.getParameter("commentStatus") == null ? "all" : request.getParameter("commentStatus");
		long totalComment = retrieveTotalComment();
		
		/*Step 3*/
		List<Comments> comment = retrieveComment(keyword,commentAuthor, commentStatus);
		List<Object[]> listStatus = retrieveStatus();
		
		
		/*PAGINATION*/
		@SuppressWarnings({ "rawtypes", "unchecked" })
		PagedListHolder pagedListHolder = new PagedListHolder(comment);
		int page = ServletRequestUtils.getIntParameter(request, "p", 0);
		pagedListHolder.setPage(page);
		pagedListHolder.setMaxLinkedPages(3);
		pagedListHolder.setPageSize(7);
		
		
		
		/*Step 4*/
		modelMap.addAttribute("commentStatusNow", commentStatusNow);
		modelMap.addAttribute("totalComment", totalComment);
		modelMap.addAttribute("pagedListHolder", pagedListHolder);
		modelMap.addAttribute("listStatus", listStatus);
		return "admin/comment";
	}
	
	
	
	/**************************************************
	 * @author Phong
	 * @return chuyen trang thai comment tu pending len approved
	 **************************************************/
	@RequestMapping(value="approve-comment", method = RequestMethod.GET)
	public @ResponseBody String approveComment(HttpServletRequest request)
	{
		/*Step 1*/
		String id = request.getParameter("id");
		Session session = factory.openSession();
		
		/*Step 2*/
		String hql = "UPDATE Comments SET comment_status = 'approved' WHERE id = " + id;
		Query query = session.createQuery(hql);
		
		/*Step 3*/
		query.executeUpdate();
		return "success";
	}
}
