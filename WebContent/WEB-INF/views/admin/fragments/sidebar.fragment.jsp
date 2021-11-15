<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav id="sidebar" aria-label="Main Navigation">
   <div class="content-header">
      <a class="fw-semibold text-dual" href="${HOMEURL }">
      <span class="smini-visible">
      <i class="fa fa-circle-notch text-primary"></i>
      </span>
      <span class="smini-hide fs-5 tracking-wider">${ SettingsData.getSite_name() }</span>
      </a>
      <div>
         <button type="button" class="btn btn-sm btn-alt-secondary" data-toggle="layout" data-action="dark_mode_toggle">
         <i class="far fa-moon"></i>
         </button>
         <div class="dropdown d-inline-block ms-1">
            <button type="button" class="btn btn-sm btn-alt-secondary" id="sidebar-themes-dropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="far fa-circle"></i>
            </button>
            <div class="dropdown-menu dropdown-menu-end fs-sm smini-hide border-0" aria-labelledby="sidebar-themes-dropdown">
               <a class="dropdown-item d-flex align-items-center justify-content-between fw-medium" data-toggle="theme" data-theme="default" href="#">
               <span>Default</span>
               <i class="fa fa-circle text-default"></i>
               </a>
               <a class="dropdown-item d-flex align-items-center justify-content-between fw-medium" data-toggle="theme" data-theme="./public/admin/css/themes/amethyst.min.css" href="#">
               <span>Amethyst</span>
               <i class="fa fa-circle text-amethyst"></i>
               </a>
               <a class="dropdown-item d-flex align-items-center justify-content-between fw-medium" data-toggle="theme" data-theme="./public/admin/css/themes/city.min.css" href="#">
               <span>City</span>
               <i class="fa fa-circle text-city"></i>
               </a>
               <a class="dropdown-item d-flex align-items-center justify-content-between fw-medium" data-toggle="theme" data-theme="./public/admin/css/themes/flat.min.css" href="#">
               <span>Flat</span>
               <i class="fa fa-circle text-flat"></i>
               </a>
               <a class="dropdown-item d-flex align-items-center justify-content-between fw-medium" data-toggle="theme" data-theme="./public/admin/css/themes/modern.min.css" href="#">
               <span>Modern</span>
               <i class="fa fa-circle text-modern"></i>
               </a>
               <a class="dropdown-item d-flex align-items-center justify-content-between fw-medium" data-toggle="theme" data-theme="./public/admin/css/themes/smooth.min.css" href="#">
               <span>Smooth</span>
               <i class="fa fa-circle text-smooth"></i>
               </a>
               <div class="dropdown-divider"></div>
               <a class="dropdown-item fw-medium" data-toggle="layout" data-action="sidebar_style_light" href="javascript:void(0)">
               <span>Sidebar Light</span>
               </a>
               <a class="dropdown-item fw-medium" data-toggle="layout" data-action="sidebar_style_dark" href="javascript:void(0)">
               <span>Sidebar Dark</span>
               </a>
               <div class="dropdown-divider"></div>
               <a class="dropdown-item fw-medium" data-toggle="layout" data-action="header_style_light" href="javascript:void(0)">
               <span>Header Light</span>
               </a>
               <a class="dropdown-item fw-medium" data-toggle="layout" data-action="header_style_dark" href="javascript:void(0)">
               <span>Header Dark</span>
               </a>
            </div>
         </div>
         <a class="d-lg-none btn btn-sm btn-alt-secondary ms-1" data-toggle="layout" data-action="sidebar_close" href="javascript:void(0)">
         <i class="fa fa-fw fa-times"></i>
         </a>
      </div>
   </div>
   <div class="js-sidebar-scroll">
      <div class="content-side">
         <ul class="nav-main">
         
         	
            <li class="nav-main-item">
               <a class="nav-main-link dashboard" href="${APPURL }/dashboard.htm">
               <i class="nav-main-link-icon si si-speedometer"></i>
               <span class="nav-main-link-name">Dashboard</span>
               </a>
            </li>
            
            <li class="nav-main-heading">Post</li>
            
            <li class="nav-main-item">
               <a class="nav-main-link nav-main-link-submenu" data-toggle="submenu" aria-haspopup="true" aria-expanded="false" href="#">
               		<i class="nav-main-link-icon si si-note"></i>
               		<span class="nav-main-link-name"> Bài viết </span>
               </a>
               
               <ul class="nav-main-submenu">
               		<li class="nav-main-item">
	                     <a class="nav-main-link posts post" href="${ ADMINURL }/posts.htm">
	                     	<span class="nav-main-link-name"> Xem tất cả</span>
	                     </a>
                  	</li>
                  	
                  	<li class="nav-main-item">
	                     <a class="nav-main-link post-new" href="${ ADMINURL }/post-new.htm">
	                     	<span class="nav-main-link-name"> Thêm mới</span>
	                     </a>
                  	</li>
               </ul>
            </li>
             <c:if test="${ AuthUser.account_type != 'CONTRIBUTOR' }"> 
            
            <li class="nav-main-item">
               <a class="nav-main-link nav-main-link-submenu" data-toggle="submenu" aria-haspopup="true" aria-expanded="false" href="${APPURL }/admin/category.htm">
               		<i class="nav-main-link-icon si si-tag"></i>
               		<span class="nav-main-link-name"> Thể loại </span>
               </a>
               
               <ul class="nav-main-submenu">
               		<li class="nav-main-item">
	                     <a class="nav-main-link categories edit-category" href="${APPURL }/admin/categories.htm">
	                     	<span class="nav-main-link-name"> Xem tất cả</span>
	                     </a>
                  	</li>
                  	
                  	<li class="nav-main-item">
	                     <a class="nav-main-link add-category" href="${APPURL }/admin/add-category.htm">
	                     	<span class="nav-main-link-name"> Thêm mới</span>
	                     </a>
                  	</li>
               </ul>
            </li>
               </c:if>
             <c:if test="${ AuthUser.account_type == 'ADMIN' }"> 
	             <li class="nav-main-item">
               <a class="nav-main-link nav-main-link-submenu" data-toggle="submenu" aria-haspopup="true" aria-expanded="false" href="${APPURL }/admin/information-page.htm">
               		<i class="nav-main-link-icon si si-docs"></i>
               		<span class="nav-main-link-name"> Trang thông tin </span>
               </a>
               
               <ul class="nav-main-submenu">
               		<li class="nav-main-item">
	                     <a class="nav-main-link information-pages edit-information-page" href="${APPURL }/admin/information-pages.htm">
	                     	<span class="nav-main-link-name"> Xem tất cả</span>
	                     </a>
                  	</li>
                  	
                  	<li class="nav-main-item">
	                     <a class="nav-main-link add-information-page" href="${APPURL }/admin/add-information-page.htm">
	                     	<span class="nav-main-link-name"> Thêm mới</span>
	                     </a>
                  	</li>
               </ul>
            </li>
            </c:if>
            
           <c:if test="${ AuthUser.account_type != 'CONTRIBUTOR' }"> 
            
            <li class="nav-main-item">
               <a class="nav-main-link comment" aria-haspopup="true" aria-expanded="false" href="${APPURL }/admin/comment.htm">
               		<i class="nav-main-link-icon si si-badge"></i>
               		<span class="nav-main-link-name"> Bình luận </span>
               </a>
            </li>
             </c:if>
            
            <li class="nav-main-heading">MEDIA</li>
            <li class="nav-main-item">
               <a class="nav-main-link media" aria-haspopup="true" aria-expanded="false" href="${ ADMINURL }/media.htm">
               		<i class="nav-main-link-icon si si-picture"></i>
               		<span class="nav-main-link-name"> Media </span>
               </a>
            </li>
            
            
           <c:if test="${ AuthUser.account_type == 'ADMIN' }"> 
            
            <li class="nav-main-heading">ADMINSTRATOR</li>
            
            <li class="nav-main-item">
               <a class="nav-main-link nav-main-link-submenu" data-toggle="submenu" aria-haspopup="true" aria-expanded="false" href="#">
               <i class="nav-main-link-icon si si-users"></i>
               <span class="nav-main-link-name">Thành viên</span>
               </a>
               <ul class="nav-main-submenu">
                  <li class="nav-main-item">
                     <a class="nav-main-link users user" href="${ ADMINURL }/users.htm">
                     <span class="nav-main-link-name">Tất cả người dùng</span>
                     </a>
                  </li>
                  <li class="nav-main-item">
                     <a class="nav-main-link user-new" href="${ ADMINURL }/user-new.htm">
                     <span class="nav-main-link-name">Thêm mới</span>
                     </a>
                  </li>
                  <li class="nav-main-item">
                     <a class="nav-main-link profile" href="${ ADMINURL }/profile.htm">
                     <span class="nav-main-link-name">Hồ sơ</span>
                     </a>
                  </li>
               </ul>
            </li>
            <li class="nav-main-item">
               <a class="nav-main-link subscribers"  href="${ ADMINURL }/subscribers.htm">
               <i class="nav-main-link-icon si si-flag"></i>
               		<span class="nav-main-link-name">Đăng ký nhận tin</span>
               </a>
            </li>
            <li class="nav-main-item">
               <a class="nav-main-link nav-main-link-submenu" data-toggle="submenu" aria-haspopup="true" aria-expanded="false" href="#">
               <i class="nav-main-link-icon si si-magic-wand"></i>
               		<span class="nav-main-link-name">Giao diện</span>
               </a>
               <ul class="nav-main-submenu">
               	  <li class="nav-main-item">
                     <a class="nav-main-link widget" href="${ ADMINURL}/widget.htm">
                     <span class="nav-main-link-name">Widget</span>
                     </a>
                  </li>
                  <li class="nav-main-item">
                     <a class="nav-main-link menu" href="${ ADMINURL}/menu.htm">
                     <span class="nav-main-link-name">Menu</span>
                     </a>
                  </li>
               </ul>
            </li>
            <!-- CAI DAT CHUNG -->
            <li class="nav-main-item">
               <a class="nav-main-link nav-main-link-submenu" data-toggle="submenu" aria-haspopup="true" aria-expanded="false" href="#">
               <i class="nav-main-link-icon si si-settings"></i>
               <span class="nav-main-link-name">Cài đặt chung</span>
               </a>
               <ul class="nav-main-submenu">
                  <li class="nav-main-item">
                     <a class="nav-main-link site" href="${ ADMINURL }/settings/site.htm">
                     <span class="nav-main-link-name">Cài đặt trang</span>
                     </a>
                  </li>
                  <li class="nav-main-item">
                     <a class="nav-main-link logo" href="${ ADMINURL }/settings/logo.htm">
                     <span class="nav-main-link-name">Logo</span>
                     </a>
                  </li>
                  <li class="nav-main-item">
                     <a class="nav-main-link social" href="${ ADMINURL }/settings/social.htm">
                     <span class="nav-main-link-name">Social</span>
                     </a>
                  </li>
               </ul>
            </li>
            
            <li class="nav-main-item">
               <a class="nav-main-link nav-main-link-submenu" data-toggle="submenu" aria-haspopup="true" aria-expanded="false" href="#">
               <i class="nav-main-link-icon si si-puzzle"></i>
               <span class="nav-main-link-name">Tích hợp</span>
               </a>
               <ul class="nav-main-submenu">
                  <li class="nav-main-item">
                     <a class="nav-main-link google-analytics" href="${ ADMINURL }/integrations/google-analytics.htm">
                     <span class="nav-main-link-name">Google Analytics</span>
                     </a>
                  </li>
                  <li class="nav-main-item">
                     <a class="nav-main-link recaptcha" href="${ ADMINURL }/integrations/recaptcha.htm">
                     <span class="nav-main-link-name">Recaptcha</span>
                     </a>
                  </li>
               </ul>
            </li>
            
           
            
        </c:if>
            
         
         </ul>
      </div>
   </div>
</nav>