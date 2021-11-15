<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    
 <div class="header-stack3-left header-stack3-part">
               <a class="toggle-menu hamburger hamburger-btn">
               <i class="fa fa-bars ic-hamburger"></i> <i class="feather-x"></i>
               </a>
               <div class="header-search-wrapper header-search-modal">
                  <span class="search-btn search-btn-modal">
                  <i class="fa fa-search"></i> </span>
                  <div class="modal-search-wrapper modal-showing-slide-right">
                     <div class="container">
                        <div class="modal-search-container">
                           <div class="searchform">
                              <form role="search" method="get" action="${ APPURL }/search.htm" class="form">
                                 <input type="text" name="q" class="s search-field" value="" placeholder="Nhập và enter" />
                                 <button class="submit" role="button" title="Go">
                                 <i class="fa fa-search"></i>
                                 </button>
                              </form>
                           </div>
                           <h3 class="search-nav-heading small-heading">Đề Xuất</h3>
                           <nav id="search-menu" role="navigation">
                              <div class="menu">
                                 <ul id="menu-suggestions" class="menu">
	                                 <c:forEach var="m" items="${listMenuHeader}">
		                                 <li class="menu-item">
		                                 	 <a href="${APPURL}${m.menu.target}">${m.menu.title}</a>
		                                 </li>
		                                 
				                  		<c:if test = "${m.children != null && m.children.size() > 0}">
											<c:forEach var="c" items="${m.children}">
											    <li id="menu-item-${c.id}">
							                    	<a href="${APPURL}${c.target}">${c.title}</a>
							                    </li>
						                    </c:forEach>
										</c:if>
									</c:forEach>
 
                                 </ul>
                              </div>
                           </nav>
                        </div>
                     </div>
                     <span class="close-modal"><i class="feather-x"></i></span>
                  </div>
               </div>
            </div>