<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<base href="${pageContext.servletContext.contextPath}/">
    <div id="offcanvas" class="offcanvas offcanvas-light">
         <div class="offcanvas-inner">
            <div class="offcanvas-search offcanvas-element">
               <div class="searchform">
                  <form role="search" method="get" action="${ APPURL }/search.htm" class="form">
                     <input type="text" name="q" class="s search-field" value="" placeholder="Nhập và enter" />
                     <button class="submit" role="button" title="Go">
                     <i class="fa fa-search"></i>
                     </button>
                  </form>
               </div>
            </div>
            <nav id="mobilenav" class="offcanvas-nav offcanvas-element">
               <div class="menu">
                  <ul id="menu-primary-1" class="menu">
                  	
                  	<c:forEach var="element" items="${ listMenuHeader }">
                  	
                  		<!-- MENU PARENT -->
                  		<li class="menu-item menu-item-${ element.menu.id } ${element.children != null && element.children.size() > 0 ? 'menu-item-has-children' : ''}">
                        	<a href="${ APPURL }${element.menu.target}"> ${ element.menu.title } </a>
                        	<span class="indicator"><i class="indicator-ic"></i></span>
                        	<!-- MENU CHILDREN -->
		                  		<c:if test="${ element.children != null && element.children.size() > 0}">
		                  			<span class="indicator"><i class="indicator-ic"></i></span>
		                  			<ul class="sub-menu">
		                  				<c:forEach var="e" items="${ element.children }">
			                  				<li id="menu-item-${ e.id }" class="menu-item-object-category menu-item menu-item-${ e.id }">
			                              		<a href="${APPURL }${e.target}">${ e.title }</a>
			                           		</li>
		                  				</c:forEach>
		                  			</ul>
		                  		</c:if>
                        	
                     	</li>
                  		
	                  			
	                  		
                  	</c:forEach>
                  		
                     
                     
                  </ul>
               </div>
            </nav>
            <div class="social-list offcanvas-element style-plain shape-circle align-left icon-size-bigger icon-spacing-small style-none">
               <ul>
                  <li class="li-facebook">
                     <a href="#" target="_blank" rel="noopener" title="Facebook">
                     <i class="fab fa-facebook-f"></i>
                     </a>
                  </li>
                  <li class="li-twitter">
                     <a href="#" target="_blank" rel="noopener" title="Twitter">
                     <i class="fab fa-twitter"></i>
                     </a>
                  </li>
                  <li class="li-instagram">
                     <a href="#" target="_blank" rel="noopener" title="Instagram">
                     <i class="fab fa-instagram"></i>
                     </a>
                  </li>
                  <li class="li-youtube">
                     <a href="#" target="_blank" rel="noopener" title="YouTube">
                     <i class="fab fa-youtube"></i>
                     </a>
                  </li>
                  <li class="li-vkontakte">
                     <a href="#" target="_blank" rel="noopener" title="VKontakte">
                     <i class="fab fa-vk"></i>
                     </a>
                  </li>
               </ul>
            </div>
         </div>
      </div>