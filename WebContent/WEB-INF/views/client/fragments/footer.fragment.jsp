<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
   
<footer id="wi-footer" class="site-footer">
   <div id="footer-widgets" class="footer-widgets footer-sidebar footer-sidebar-1-1 skin-light stretch-content valign-middle">
      <div class="container">
         <div class="footer-widgets-inner footer-widgets-row">
            <aside class="widget-area footer-col col-1-2">
               <div class="footer-col-inner">
                  <div id="footer-logo-1" class="widget widget_footer_logo">
                     <div id="footer-logo" class="footer-bottom-element">
                        <a href="${HOMEURL }" rel="home">
                        <img width="900" height="140" class="attachment-full size-full" alt="" loading="lazy" srcset="${ SettingsData.getLogotype() }">
                        </a>
                     </div>
                  </div>
                  <div id="copyright-2" class="widget widget_copyright">
                     <div class="footer-copyright copyright footer-bottom-element">
                        <p>© ${ currentYear } ${ SettingsData.getSite_description() }<br>
                           ALL RIGHTS RESERVED.
                        </p>
                     </div>
                  </div>
                  <div id="footer-nav-1" class="widget footer_widget_nav">
                     <nav id="footernav" class="footernav footer-bottom-element" role="navigation">
                        <div class="menu">
                           <ul id="menu-footer" class="menu">
	                           <c:forEach var="m" items="${listMenuFooter}">
			                  		<li id="menu-item-${m.id}">
				                        <a href="${APPURL }${m.target}">${m.title}</a>
				                     </li>
								</c:forEach>
                           </ul>
                        </div>
                     </nav>
                  </div>
               </div>
            </aside>
            <aside class="widget-area footer-col col-1-2">
               <div class="footer-col-inner">
                  <div id="mc4wp_form_widget-2" class="widget widget_mc4wp_form_widget">
                     <form id="mc4wp-form-1" class="mc4wp-form mc4wp-form-491" method="POST" action="${ HOMEURL }">
                        <div class="mc4wp-form-fields">
                           <div class="fox-form-inline-wrapper">
                              <div class="fox-form-inline">
                                 <p>
                                    <input type="email" name="email" placeholder="Your email address" required>
                                 </p>
                                 <p>
                                    <input type="submit" id="submit" value="Đăng Ký Nhận Tin">
                                 </p>
                              </div>
                           </div>
                        </div>
                        <div class="mc4wp-response">
                           <div class="mc4wp-alert mc4wp-success" role="alert"></div>
                        </div>
                     </form>
                  </div>
               </div>
            </aside>
         </div>
      </div>
   </div>
</footer>