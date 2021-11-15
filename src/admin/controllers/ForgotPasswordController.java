package admin.controllers;

import java.io.IOException;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import bean.Mailer;
import entities.Users;

@Controller
@RequestMapping("/forgot-password")
public class ForgotPasswordController {
	@Autowired
	SessionFactory factory;
	@Autowired
	Mailer mailer;
	@Autowired
	ObjectMapper mapper;
	
	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model){	
		
		
		return "admin/forgot-password";
	}
	
	@Transactional
	@RequestMapping(method = RequestMethod.POST)
	public String ForgotPassword(ModelMap model, @ModelAttribute("email") String email)
	{
		email = email.trim();
		if(email.isEmpty())
		{
			model.addAttribute("message", "Không được để trống email");
			return "admin/forgot-password";
		}
		if(email.length()<15)
		{
			model.addAttribute("message", "Email không hợp lệ");
			return "admin/forgot-password";
		}
		
		Session session = factory.getCurrentSession();
		String hql = "SELECT u FROM Users u WHERE u.email = :email"; 
		Query query = session.createQuery(hql); 
		query.setParameter("email", email);
		
		try {
			Users user = (Users)query.uniqueResult();
			String userEmail = user.getEmail();
			if(userEmail == null) {
				model.addAttribute("message", "Email không tồn tại");
			}
			else
			{
				String recoveryhash = "";
				recoveryhash = updateToken(user);	
				if(recoveryhash != "") {
					recoveryhash = user.getId()+"_"+recoveryhash;
					mailer.send(mailer.from(),userEmail,mailer.retrievePasswordSubject(), mailer.bodyRP(recoveryhash));	
					model.addAttribute("message", "Vui lòng xác nhận cấp lại mật khẩu trong Email");
				}
			}
		}catch(Exception ex){	
			ex.printStackTrace();
			return "admin/errors/404";
		}
		return "admin/forgot-password";
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
