package admin.controllers;

import java.util.ArrayList;
import java.util.Date;
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
import helpers.CommonHelper;
import models.UserSettings;

@Transactional
@Controller
@RequestMapping("/admin")
public class UserController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	ObjectMapper mapper;
	
	public Users getUserById(int userid){
		Session session = factory.openSession();
		String hql = "SELECT u FROM Users u WHERE u.id = :userid"; 
		Query query = session.createQuery(hql); 
		query.setParameter("userid", userid);
		
		Users ret = new Users();
		try 
		{
			ret = (Users) query.list().get(0);
		}catch(Exception ex) {
			ret = new Users();
		}
		session.close();
		return ret;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping( value={"user","user-new"}, method = RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap model, HttpSession session) {
		
		String successMessage = (String) session.getAttribute("successMessage");
		List<String> errorMessage = (List<String>) session.getAttribute("errorMessage");
		
		String id = request.getParameter("userid");
		Users user = new Users();
		try {
			int userId = Integer.parseInt(id);
			user = getUserById(userId);
		}catch(Exception ex) {
			user = new Users();
		}
		model.addAttribute("user", user);
		model.addAttribute("successMessage", successMessage);
		model.addAttribute("errorMessage", errorMessage);
		return "admin/user";
	}
	
	@RequestMapping( value="user", method = RequestMethod.POST)
	public String update(HttpServletRequest request, ModelMap model, @RequestParam Map<String, Object> params) throws JsonProcessingException {
		
		Users authUser = (Users)request.getAttribute("AuthUser");
		List<String> errorMessage = new ArrayList<String>();
		Boolean error = false;
		boolean is_new = false;
		String id = request.getParameter("userid");
		Users user = new Users();
		try {
			int userId = Integer.parseInt(id);
			user = getUserById(userId);
			if(user.getId() == authUser.getId()) {
				errorMessage.add("Kh??ng th??? s???a t??i kho???n ch??nh m??nh ??? ????y! H??y truy c???p profile ????? ch???nh s???a!");
				error = true;
			}
		}catch(Exception ex) {
			user = new Users();
		}
		
		
		if(user.getUsername() == null || user.getUsername().length() == 0) {
			is_new = true;
		}
		if(error) {
			request.getSession().setAttribute("errorMessage", errorMessage);
			return "redirect:/admin/user.htm?userid=" + user.getId();
		}
		
		String firstname = (String) params.get("firstname");
		String lastname = (String) params.get("lastname");
		String email = (String) params.get("email");
		String username = (String) params.get("username");
		String password = (String) params.get("password");
		String password_confirm = (String) params.get("password_confirm");
		String account_type = (String) params.get("account_type");
		Boolean is_active = Boolean.parseBoolean((String) params.get("is_active"));
		
		if(firstname == null || firstname.trim().length() == 0) {
			errorMessage.add("H??? kh??ng ???????c b??? tr???ng!");
			error = true;
		}
		
		if(lastname == null || lastname.trim().length() == 0) {
			errorMessage.add("T??n kh??ng ???????c b??? tr???ng!");
			error = true;
		}
		
		if(account_type == null || account_type.trim().length() == 0) {
			errorMessage.add("Vai tr?? kh??ng ???????c b??? tr???ng!");
			error = true;
		}else if(!CommonHelper.contains(new String[] { "ADMIN", "EDITOR", "CONTRIBUTOR" }, account_type)) {
			errorMessage.add("Vai tr?? kh??ng h???p l???!");
			error = true;
		}
		if(is_new) {
			if(email == null || email.trim().length() == 0) {
				errorMessage.add("Email kh??ng ???????c b??? tr???ng!");
				error = true;
			}
			if(username == null || username.trim().length() == 0) {
				errorMessage.add("T??n ????ng nh???p kh??ng ???????c b??? tr???ng!");
				error = true;
			}
			
			if(password == null || password.trim().length() == 0) {
				errorMessage.add("M???t kh???u kh??ng ???????c b??? tr???ng!");
				error = true;
			}
			
			if(password_confirm == null || password_confirm.trim().length() == 0) {
				errorMessage.add("M???t kh???u kh??ng ???????c b??? tr???ng!");
				error = true;
			}
			
			if(password.compareTo(password_confirm) != 0)
			{
				errorMessage.add("M???t kh???u v?? m???t kh???u x??c nh???n kh??ng tr??ng nhau!");
				error = true;
			}
			
		}else {
			if(password != null && password.trim().length() > 0) {
				if(password_confirm != null && password_confirm.trim().length() > 0) {
					if(password.compareTo(password_confirm) != 0)
					{
						errorMessage.add("M???t kh???u v?? m???t kh???u x??c nh???n kh??ng tr??ng nhau!");
						error = true;
					}else {
						String encryptedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
						user.setPassword(encryptedPassword);
					}
				}
			}
		}
		
		
		
		if(error) {
			request.getSession().setAttribute("errorMessage", errorMessage);
			return "redirect:/admin/user.htm?userid=" + user.getId();
		}
		
		user.setFirstname(firstname);
		user.setLastname(lastname);
		user.setAccount_type(account_type);
		user.setIs_active(is_active);
		
		
		Session session = factory.openSession();
		Transaction t =  session.beginTransaction();
		if(is_new) {
			String encryptedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
			user.setPassword(encryptedPassword);
			Date date = new Date();  
			user.setDate(date);
			user.setData("{}");
			
			UserSettings setting = new UserSettings();
			user.setSettings(mapper.writeValueAsString(setting));
			user.setBio("");
			user.setAvatar("");
			user.setViewer(0);
			user.setEmail(email);
			user.setUsername(username);
			
			try{   
				session.save(user);
				t.commit();
				request.getSession().setAttribute("successMessage", "Th??m ng?????i d??ng th??nh c??ng");
			}
			catch(Exception e){
				e.printStackTrace();
				t.rollback();
				errorMessage.add("Th??m ng?????i d??ng th???t b???i !");
				request.getSession().setAttribute("errorMessage", errorMessage);
			}
			finally{
				session.close();
			}
		}else {
			try{   
				session.update(user);
				t.commit();
				request.getSession().setAttribute("successMessage", "S???a ng?????i d??ng th??nh c??ng");
			}
			catch(Exception e){
				t.rollback();
				errorMessage.add("C???p nh???t ng?????i d??ng th???t b???i !");
				request.getSession().setAttribute("errorMessage", errorMessage);
			}
			finally{
				session.close();
			}
		}
		
		
		return "redirect:/admin/user.htm?userid=" + user.getId();
	}
}
