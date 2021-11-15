package client.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NotFoundController {
	@RequestMapping("not-found")
	public String search()
	{
		return "client/404";
	}
}
