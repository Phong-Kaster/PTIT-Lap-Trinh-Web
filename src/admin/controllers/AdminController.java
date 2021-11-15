package admin.controllers;

import java.security.Principal;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Transactional
@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	SessionFactory factory;
		
	
	@RequestMapping( method = RequestMethod.GET)
	public String index(HttpSession session, ModelMap model, Principal principal){	
		if(principal != null) {
			return "redirect:./dashboard.htm";
		}
		String successMessage = (String) session.getAttribute("successMessage");
		model.addAttribute("successMessage", successMessage);
		return "admin/index";
	}
}
