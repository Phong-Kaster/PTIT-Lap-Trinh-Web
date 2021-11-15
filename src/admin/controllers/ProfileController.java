package admin.controllers;


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
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Users;
import models.UserSettings;


@Transactional
@Controller
@RequestMapping("/admin")
public class ProfileController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	ObjectMapper mapper;
		
	/**
	 * Get a number post that user write
	 * @param userId
	 * @return long
	 */
	public long getPostSummary(int userId){
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Posts p WHERE p.user.id = :user_id"; 
		Query query = session.createQuery(hql); 
		query.setParameter("user_id", userId);
		
		long summary = (long) query.uniqueResult();
		return summary;
	}
	
	/**
	 * Get a number comment that user write
	 * @param userId
	 * @return long
	 */
	public long getCommentSummary(int userId){
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Comments c WHERE c.user_id = :user_id"; 
		Query query = session.createQuery(hql); 
		query.setParameter("user_id", userId);
		
		long summary = (long) query.uniqueResult();
		return summary;
	}
	
	/**
	 * Lấy thông tin User bằng id
	 * @param userId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Users getUserById(int userId)
	{
		Session session = factory.openSession();
		String hql = "FROM Users WHERE id = :user_id";
		
		Query query = session.createQuery(hql);
		query.setParameter("user_id", userId);
		Users user = null;
		try {
			List<Users> list = query.list();
			user= list.get(0);
		}catch(Exception ex) {
			user = null;
		}
		session.close();
		return user;
	}
	/**
	 * chuyển đổi settings của User thành json
	 * @param user
	 * @return
	 */
	public UserSettings getUserSettings(Users user)
	{
		try {
			return mapper.readValue(user.getSettings(), UserSettings.class);
		}catch(Exception ex) {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping( value="profile", method = RequestMethod.GET)
	public String index(ModelMap model, HttpServletRequest request, HttpSession session){	
		Users authUser = (Users) request.getAttribute("AuthUser");
				
		String successMessage = (String) session.getAttribute("successMessage");
		List<String> errorMessage = (List<String>) session.getAttribute("errorMessage");

		
		// lấy settings user
		UserSettings settings = this.getUserSettings(authUser);
		model.addAttribute("UserSettings", settings);
		
		
		//set model thông báo
		model.addAttribute("successMessage", successMessage);
		model.addAttribute("errorMessage", errorMessage);
		
		model.addAttribute("postSummary", getPostSummary(authUser.getId()));
		model.addAttribute("commentSummary", getCommentSummary(authUser.getId()));
		model.addAttribute("user", authUser);
		return "admin/profile";
	}
	
	@RequestMapping( value="profile_info", method = RequestMethod.POST)
	public String update(ModelMap model, HttpServletRequest request,  @RequestParam Map<String, Object> params){	
		boolean error = false;
		List<String> errorMessage = new ArrayList<String>();
		
		Users user = (Users) request.getAttribute("AuthUser");
		String firstname = (String) params.get("firstname");
		String lastname = (String) params.get("lastname");
		String bio = (String) params.get("bio");
		String avatar = (String) params.get("avatar");
		
		if(bio == null)
		{
			bio = "";
		}
		
		if(avatar == null)
		{
			avatar = "";
		}
		
		if(firstname == null || firstname.trim().length() == 0)
		{
			errorMessage.add("Không để trống họ");
			error = true;
		}
		
		if(lastname == null || lastname.trim().length() == 0)
		{
			errorMessage.add("Không để trống tên");
			error = true;
		}
		
		if(!error) {
			user.setFirstname(firstname);
			user.setLastname(lastname);
			user.setAvatar(avatar);
			user.setBio(bio);
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			try{   
				session.update(user);
				t.commit();
				request.getSession().setAttribute("successMessage", "Lưu thông tin thành công");
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				errorMessage.add("Lưu thông tin thất bại !");
			}
			finally{
				session.close();
			}
		}
		request.getSession().setAttribute("errorMessage", errorMessage);
		return "redirect:/admin/profile.htm";
	}
	
	@RequestMapping( value="profile_social", method = RequestMethod.POST)
	public String update_social(ModelMap model, HttpServletRequest request,  @RequestParam Map<String, Object> params){	
		boolean error = false;
		List<String> errorMessage = new ArrayList<String>();
		
		Users user = (Users) request.getAttribute("AuthUser");
		UserSettings settings = this.getUserSettings(user);
		
		String facebook = (String) params.get("facebook");
		String pinterest = (String) params.get("pinterest");
		String tumblr = (String) params.get("tumblr");
		String vkontakte = (String) params.get("vkontakte");
		String whatsapp = (String) params.get("whatsapp");
		String telegram = (String) params.get("telegram");
		
		
		String settingsString = null;
		try {
			settings.setFacebook(facebook);
			settings.setPinterest(pinterest);
			settings.setTelegram(telegram);
			settings.setTumblr(tumblr);
			settings.setVkontakte(vkontakte);
			settings.setWhatsapp(whatsapp);
			settingsString = mapper.writeValueAsString(settings);
		} catch (JsonProcessingException e1) {
			errorMessage.add("Lưu thông tin thất bại !");
			error = true;
		}
		
		if(!error) {
			user.setSettings(settingsString);
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			try{   
				session.update(user);
				t.commit();
				request.getSession().setAttribute("successMessage", "Lưu mạng xã hội thành công");
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				errorMessage.add("Lưu thông tin thất bại !");
			}
			finally{
				session.close();
			}
		}
		
		request.getSession().setAttribute("errorMessage", errorMessage);
		return "redirect:/admin/profile.htm";
	}
	
	@RequestMapping( value="profile_password", method = RequestMethod.POST)
	public String update_password(ModelMap model, HttpServletRequest request,  @RequestParam Map<String, Object> params){	
		boolean error = false;
		List<String> errorMessage = new ArrayList<String>();
		
		Users user = (Users) request.getAttribute("AuthUser");
		
		String password_current = (String) params.get("password_current");
		String password_new = (String) params.get("password_new");
		String password_confirm = (String) params.get("password_confirm");
		
		
		
		if(password_current == null || password_current.trim().length() == 0) {
			errorMessage.add("Mật khẩu hiện tại chưa nhập!");
			error = true;
		}
		
		if(password_new == null || password_new.trim().length() == 0) {
			errorMessage.add("Mật khẩu mới chưa nhập!");
			error = true;
		}
		
		if(password_confirm == null || password_confirm.trim().length() == 0) {
			errorMessage.add("Mật khẩu xác nhận chưa nhập!");
			error = true;
		}
		
		if(!password_new.trim().equals(password_confirm.trim())) {
			errorMessage.add("Mật khẩu xác nhận không trùng!");
			error = true;
		}
		
		if(error) {
			request.getSession().setAttribute("errorMessage", errorMessage);
			return "redirect:/admin/profile.htm";
		}
		
		boolean valuate = BCrypt.checkpw(password_current, user.getPassword());
		if(!valuate) {
			errorMessage.add("Mật khẩu hiện tại không đúng!");
			error = true;
		}
		
		
		if(!error) {
			String hash = BCrypt.hashpw(password_new, BCrypt.gensalt(12));
			user.setPassword(hash);
			Session session = factory.openSession();
			Transaction t =  session.beginTransaction();
			try{   
				session.update(user);
				t.commit();
				request.getSession().setAttribute("successMessage", "Thây đổi mật khẩu thành công");
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				errorMessage.add("Thay đổi mật khẩu thất bại !");
			}
			finally{
				session.close();
			}
		}
		
		request.getSession().setAttribute("errorMessage", errorMessage);
		return "redirect:/admin/profile.htm";
	}
}
