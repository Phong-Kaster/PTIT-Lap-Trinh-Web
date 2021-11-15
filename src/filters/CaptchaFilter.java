package filters;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.web.filter.OncePerRequestFilter;


import lib.Recaptcha;


/**
 * Filter for capturing Captcha fields.
 * It's purpose is to store these values internally
 */
public class CaptchaFilter extends OncePerRequestFilter {
	 private String failureUrl;

	 private SimpleUrlAuthenticationFailureHandler failureHandler = new SimpleUrlAuthenticationFailureHandler();
	 @Override
	 public void doFilterInternal(HttpServletRequest request, HttpServletResponse resonse, FilterChain chain) throws IOException, ServletException {
		Recaptcha recaptcha = new Recaptcha();
		String recaptcha_response = request.getParameter("g-recaptcha-response");		
		if(request.getParameter("username") != null && request.getParameter("password") != null) {
			if(recaptcha_response != null && !recaptcha_response.trim().isEmpty()) {
				if(!recaptcha.verification(recaptcha_response)) {
					failureHandler.setDefaultFailureUrl(failureUrl);
				    failureHandler.onAuthenticationFailure(request, resonse, new BadCredentialsException("Captcha không hợp lệ!"));
					return;
				}
			}else {
				failureHandler.setDefaultFailureUrl(failureUrl);
				   failureHandler.onAuthenticationFailure(request, resonse, new BadCredentialsException("Vui lòng chọn captcha!"));
				return;
			}
		}
		
		// Proceed with the remaining filters
		chain.doFilter(request, resonse);
	 }
 
	 public String getFailureUrl() {
	  return failureUrl;
	 }

	 public void setFailureUrl(String failureUrl) {
	  this.failureUrl = failureUrl;
	 }
}
