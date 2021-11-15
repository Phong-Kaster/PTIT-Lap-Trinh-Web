<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="vi" class="no-js">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta name="description" content="test thôi" />
      <script>(function(html){html.className = html.className.replace(/\bno-js\b/,'js')})(document.documentElement);</script>
      <title>${user.firstname} ${user.lastname}, Tác Giả Tại ${ SettingsData.getSite_name() }</title>
      <base href="${APPURL}/" />
      <meta name="description" content="${user.firstname} ${user.lastname}" />
      <meta property="og:site_name" content="${ SettingsData.getSite_name() }">
      <meta property="og:type" content="website">
      <meta property="og:title" content="${user.firstname} ${user.lastname}" />
      <meta property="og:url" content="${ APPURL }/author/${user.username}.htm" />
      <meta property="og:image" content="" />
      <meta property="og:description" content="${user.firstname} ${user.lastname}" />
      <link rel='dns-prefetch' href='//fonts.googleapis.com' />
      
      <link rel="icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="shortcut icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      
      <link href='https://fonts.gstatic.com' crossorigin rel='preconnect' />
      <link rel='stylesheet' id='wi-fonts-css' href='https://fonts.googleapis.com/css?family=Libre+Franklin%3A400%2C400italic%2C900%7CTinos%3A400%2C400italic%2C700%7CLora%3A400&#038;display=swap&#038;ver=4.6.7.1' media='all' />
      <link rel='stylesheet' href="<c:url value='./public/client/style.min.css'/>"/>
      <link rel='stylesheet' href="<c:url value='./public/client/style.css'/>"/>
      <script src="<c:url value='./public/client/vendor/jquery/jquery.min.js' />"></script>
      <script src="<c:url value='./public/client/vendor/jquery/jquery-migrate.min.js' />"></script>
   </head>
   <body class="home blog theme-fox woocommerce-no-js has-sidebar sidebar-right layout-wide style--dropcap-default dropcap-style-default style--dropcap-font-heading style--tag-plain style--list-widget-1 style--tagcloud-1 style--blockquote-no-icon style--single-heading-border_top style--link-2 elementor-default elementor-kit-6">
      <div id="wi-all" class="fox-outer-wrapper fox-all wi-all">
      <div id="wi-wrapper" class="fox-wrapper wi-wrapper">
      <div class="wi-container">
      <!-- HEADER FRAGMENT -->
      <jsp:include page="./fragments/header.fragment.jsp"/>
      <jsp:include page="./fragments/logo.fragment.jsp"/>
      <div id="wi-main" class="wi-main fox-main">
      <div id="titlebar" class="headline wi-titlebar post-header align-left">
         <div class="container">
            <div class="title-area">
               <div class="fox-user-item fox-author fox-user titlebar-user">
                  <div class="user-item-avatar avatar-circle">
                     <a href="${ APPURL }/author/${user.username}.htm">
                        <picture class="avatar avatar-300 photo" loading="lazy">
                           <img alt="" src="${user.avatar}" srcset=" 2x" height="300" width="300" loading="lazy">
                        </picture>
                     </a>
                  </div>
                  <div class="user-item-body">
                     <div class="user-item-header">
                        <div class="user-item-name-wrapper">
                           <h1 class="user-item-name">${user.firstname} ${user.lastname}</h1>
                        </div>
                     </div>
                     <div class="user-item-description">
                        <p>${user.bio} </p>
                     </div>
                     <div class="social-list user-item-social shape-circle style-plain user-item-name-meta">
                        <ul>
                           <li class="li-facebook">
                              <a href="${ UserSettings.facebook }" target="_blank" rel="noopener" class="tooltipstered">
                              <i class="fab fa-facebook-square"></i>
                              </a>
                           </li>
                           <li class="li-pinterest">
                              <a href="${ UserSettings.pinterest }" target="_blank" rel="noopener" class="tooltipstered">
                              <i class="fab fa-pinterest-p"></i>
                              </a>
                           </li>
                           <li class="li-tumblr">
                              <a href="${ UserSettings.tumblr }" target="_blank" rel="noopener" class="tooltipstered">
                              <i class="fab fa-tumblr"></i>
                              </a>
                           </li>
                           <li class="li-vkontakte">
                              <a href="${ UserSettings.vkontakte }" target="_blank" rel="noopener" class="tooltipstered">
                              <i class="fab fa-vk"></i>
                              </a>
                           </li>
                           <li class="li-whatsapp">
                              <a href="${ UserSettings.whatsapp }" target="_blank" rel="noopener" class="tooltipstered">
                              <i class="fab fa-whatsapp"></i>
                              </a>
                           </li>
                           <li class="li-telegram">
                              <a href="${ UserSettings.telegram }" target="_blank" rel="noopener" class="tooltipstered">
                              <i class="fab fa-telegram"></i>
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div class="wi-content">
      <div class="container">
      <div class="content-area primary" id="primary" role="main">
      <div class="theiaStickySidebar">
         <div class="blog-container blog-container-list">
            <div class="wi-blog fox-blog blog-list v-spacing-small blog-card-has-shadow">
            
            <jsp:useBean id="pagedListHolder" scope="request"
				type="org.springframework.beans.support.PagedListHolder" />
				<c:url value="${ APPURL }/author/${user.username}.htm" var="pagedLink">
					<c:param name="p" value="~" />
				</c:url>
           <%--  <c:forEach var="post" items="${ posts }"> --%>
            <c:forEach var="post" items="${ pagedListHolder.pageList }">
             	<article class="wi-post post-item post-list post-thumbnail-align-left post-valign-top list-mobile-layout-list  post type-post status-publish format-standard has-post-thumbnail hentry category-books category-opinion tag-facebook tag-magazine tag-politics tag-travel tag-wordpress">
                  <div class="post-list-sep" style="border-color:#eaeaea"></div>
                  	<div class="post-item-inner list-inner post-list-inner">
                     <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  list-thumbnail thumbnail-acute  hover-none thumbnail-loading effect-fade" style="width:240px">
                        <div class="thumbnail-inner">
                           <a href="${APPURL }/article/${post.id }/${post.post_slug }.htm" class="post-link">
                           <span class="image-element">
                           <img width="480" height="384" src="${post.media }" class="attachment-thumbnail-medium size-thumbnail-medium" alt="" loading="lazy" />
                           </span>
                           </a>
                        </div>
                     </figure>
                     <div class="post-body post-item-body list-body post-list-body">
                        <div class="post-body-inner">
                           <div class="post-item-header">
                              <div class="entry-categories meta-categories categories-plain standalone-categories post-header-section">
                                 <a href="${APPURL }/category/${post.category.slug}.htm" rel="tag">${post.category.name }</a>
                              </div>
                              <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-normal">
                                 <a href="${APPURL }/article/${post.id }/${post.post_slug }.htm" rel="bookmark">
                                 ${post.title } </a>
                              </h2>
                           </div>
                           <div class="post-item-excerpt entry-excerpt excerpt-size-normal">
                              ${post.excerpt } 
                           </div>
                           <div class="post-item-meta wi-meta fox-meta post-header-section ">
                              <div class="entry-date meta-time machine-time time-short">
                                 <time class="published">${ dateFormat.format(post.modified_at) }</time>
                              </div>
                           </div>
                        </div>
                     </div>
               </article>
               
            </c:forEach>
              
              
              
              
               </div>
               <div class="pagination">
	               	<tg:paging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
				</div>
               </div>
               </div>
               </div>
               
 				<jsp:include page="./fragments/sidebar.fragment.jsp"/>
 </div>
               </div>
               </div>
               <!-- FOOTER FRAGMENT -->
               <jsp:include page="./fragments/footer.fragment.jsp"/>
            </div>
            <div class="wrapper-bg-element"></div>
            <div class="wrapper-border-top hand-border-h wrapper-border"></div>
            <div class="wrapper-border-bottom hand-border-h wrapper-border"></div>
            <div class="wrapper-border-left hand-border-v wrapper-border"></div>
            <div class="wrapper-border-right hand-border-v wrapper-border"></div>
         </div>
      </div>
      <jsp:include page="./fragments/mobilenav.fragment.jsp"/>
      <jsp:include page="./fragments/topup.fragment.jsp"/>
      <script id='wi-main-js-extra'>
         var WITHEMES = {"enable_sticky_sidebar":"","enable_sticky_header":"1","tablet_breakpoint":"840","enable_lightbox":"1"};
      </script>
      <script src="<c:url value='./public/client/js/theme.min.js' />"></script>
      <jsp:include page="/WEB-INF/views/inc/javascript.jsp"/>
      <jsp:include page="/WEB-INF/views/inc/google-analytics.jsp"/>
   </body>
</html>