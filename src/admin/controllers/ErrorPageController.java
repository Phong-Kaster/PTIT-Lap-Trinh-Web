package admin.controllers;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorPageController {
	@RequestMapping("/404")
	public String index_404(){	
		return "admin/errors/404";
	}
	
	@RequestMapping("/403")
	public String index_403(){	
		return "admin/errors/403";
	}
	
	@RequestMapping("/500")
	public String index_500(){	
		return "admin/errors/500";
	}
}
