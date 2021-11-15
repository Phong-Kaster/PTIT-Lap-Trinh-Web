<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
   
<header id="masthead" class="site-header header-classic header-sticky-style-border submenu-light">
   <div id="masthead-mobile-height"></div>
   <div class="header-container header-stack3 header-nav-top-1 header-nav-bottom-1">
      <div class="header-classic-row header-row-branding header-row-main header-stack3-main">
         <div class="container">
            <div id="logo-area" class="fox-logo-area fox-header-logo site-branding">
               <div id="wi-logo" class="fox-logo-container">
                  <h1 class="wi-logo-main fox-logo logo-type-image" id="site-logo">
                     <a href="${HOMEURL}" rel="home">
                     <img width="744" height="90" class="main-img-logo" alt="" loading="lazy" srcset="${ SettingsData.getLogotype() }" />
                     </a>
                  </h1>
               </div>
               <h3 class="slogan site-description">${ SettingsData.getSite_slogan() }</h3>
            </div>
           <jsp:include page="searchform.fragment.jsp"/>
            <jsp:include page="social.fragment.jsp"/>
         </div>
      </div>
      <div class="row-nav-light row-nav-style-active-3 header-classic-row header-row-nav header-sticky-element">
         <div class="container">
            <nav id="wi-mainnav" class="navigation-ele wi-mainnav" role="navigation">
               <div class="menu style-indicator-plus">
                  <ul id="menu-primary" class="menu">
                  		<c:forEach var="m" items="${listMenuHeader}">
	                  		<li id="menu-item-${m.menu.id}" class="${m.children != null && m.children.size() > 0 ? 'menu-item-has-children' : ''}">
		                        <a href="${APPURL}${m.menu.target}">${m.menu.title}</a>
		                        	<c:if test = "${m.children != null && m.children.size() > 0}">
							          	<ul class="sub-menu">
									      	<c:forEach var="c" items="${m.children}">
									      		<li id="menu-item-${c.id}">
					                              <a href="${APPURL}${c.target}">${c.title}</a>
					                           </li>
					                      	</c:forEach>
							          	</ul>
							      	</c:if>
		                     </li>
						</c:forEach>
                  </ul>
               </div>
            </nav>
         </div>
      </div>
   </div>
</header>