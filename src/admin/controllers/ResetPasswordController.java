package admin.controllers;


import java.io.IOException;

import javax.servlet.http.HttpServletRequest;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import entities.Users;


@Controller
public class ResetPasswordController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ObjectMapper mapper;
	
	@RequestMapping(value="/reset-password/{hash}")
	public String retrievePassword(@PathVariable("hash") String hash,ModelMap model) throws IOException
	{
		String array[] = hash.split("_");
		String id = array[0];
		String token = array[1];
		Users user = getUser(id);
		String recoveryhash = "";
		if(user == null) {
			return "admin/errors/404";
		}
		
		JsonNode jsonNode = mapper.readTree(user.getData());
		if(jsonNode.get("recoveryhash") == null) {
			return "admin/errors/404";
		}
		recoveryhash = jsonNode.get("recoveryhash").asText();
		
		if(recoveryhash.compareTo(token) == 0)
		{
			return "admin/reset-password";
		}
		return "admin/errors/404";
		
	}
	
	@RequestMapping(value="/reset-password/{hash}", method=RequestMethod.POST)
	public String changePassword(
			HttpServletRequest request,
			ModelMap model,
			@RequestParam("password") String password,
			@RequestParam("repeatpassword") String repeatpassword, 
			ModelMap modelMap, 
			@PathVariable("hash") String hash) throws IOException
	{
		if(password.compareTo(repeatpassword) != 0)
		{
			request.getSession().setAttribute("message", "Mật khẩu và mật khẩu nhập lại không trùng nhau!");
			return "redirect:/reset-password/"+hash+".htm";
		}
		
		String array[] = hash.split("_");
		if(array.length != 2) {
			return "redirect:/404.htm";
		}
		
		String id = array[0];
		String token = array[1];
		Users user = getUser(id);
		
		if(user == null) {
			return "redirect:/404.htm";
		}
		
		JsonNode jsonNode = mapper.readTree(user.getData());
		if(jsonNode.get("recoveryhash") == null) {
			return "redirect:/404.htm";
		}
		String recoveryhash = jsonNode.get("recoveryhash").asText();

		if(recoveryhash.compareTo(token) == 0) {
			String encryptedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
			user.setPassword(encryptedPassword);
			((ObjectNode)jsonNode).remove("recoveryhash");
			user.setData(mapper.writeValueAsString(jsonNode));
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				session.update(user);
				t.commit();
			}
			catch (Exception ex)
			{
				t.rollback();
				System.out.println(ex);
				return "redirect:/404.htm";
			}
		}
		
		request.getSession().setAttribute("successMessage", "Thay đổi mật khẩu thành công! Hãy đăng nhập lại!");
		modelMap.addAttribute("email",user.getUsername());
		return "redirect:/admin.htm";
	}
	
	
	public Users getUser(String userid)
	{
		try 
		{
			/*Step 1*/
			Session session = factory.openSession();
			String hql = "SELECT u FROM Users u "
						+ "WHERE u.id = :userid";
			
			/*Step 2*/
			Query query = session.createQuery(hql);
			query.setParameter("userid", Integer.parseInt(userid));
			
			
			/*Step 3*/
			Users user = (Users)query.uniqueResult();
			return user;

		}
		catch(Exception ex) 
		{
			System.out.println(ex);
			return null;
		}
	}
}
