<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="tg" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html lang="vi" class="no-js">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      
      <script>(function(html){html.className = html.className.replace(/\bno-js\b/,'js')})(document.documentElement);</script>
      <title> ${ SettingsData.getSite_name() } - ${ SettingsData.getSite_slogan() }</title>
      
      <meta name='robots' content='max-image-preview:large' />
      <link rel='dns-prefetch' href='//fonts.googleapis.com' />
      
      <link rel="icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="shortcut icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      
      <link href='https://fonts.gstatic.com' crossorigin rel='preconnect' />
      <link rel='stylesheet' id='wi-fonts-css' href='https://fonts.googleapis.com/css?family=Libre+Franklin%3A400%2C400italic%2C900%7CTinos%3A400%2C400italic%2C700%7CLora%3A400&#038;display=swap&#038;ver=4.6.7.1' media='all' />
      
      <!-- Trong tep tin spring-config-mvc da dinh nghia public mac dinh -->
      <link rel='stylesheet' href="<c:url value='./public/client/style.min.css'/>" >
      <link rel='stylesheet' href="<c:url value='./public/client/style.css'/>" > 
      
      
      <script src="<c:url value='./public/client/vendor/jquery/jquery.min.js' />"></script>
      <script src="<c:url value='./public/client/vendor/jquery/jquery-migrate.min.js' />"></script>
   </head>
   <body class="home blog theme-fox has-sidebar sidebar-right layout-wide style--dropcap-default dropcap-style-default style--dropcap-font-heading style--tag-plain style--list-widget-1 style--tagcloud-1 style--blockquote-no-icon style--single-heading-border_top style--link-2 elementor-default elementor-kit-6">
      <div id="wi-all" class="fox-outer-wrapper fox-all wi-all">
      <div id="wi-wrapper" class="fox-wrapper wi-wrapper">
      <div class="wi-container">
      
      <!-- HEADER FRAGMENT -->
      <jsp:include page="/WEB-INF/views/client/fragments/header.fragment.jsp"/>
      
      <jsp:include page="/WEB-INF/views/client/fragments/logo.fragment.jsp"/>
      <div id="wi-main" class="wi-main fox-main">
      <div class="wi-content content">
      <div id="wi-bf" class="all-sections wi-homepage-builder sections-spacing-normal">
      
      
      
      <div class="wi-section fox-section section-layout-list section-stretch-content show_on_desktop show_on_tablet show_on_mobile section-has-sidebar section-sidebar-right section-has-heading">
      <div class="section-heading heading-link--inheading heading-line heading-line-2 heading-line-middle heading-line-stretch-content heading-tiny align-left">
         <div class="container">
            <div class="heading-inner">
               <h2 class="heading-text">Tìm kiếm cho "${ param.q }"</h2>
               <div class="line line-l"></div>
               <div class="line line-r"></div>
            </div>
         </div>
      </div>
      <div class="container">
         <div class="section-container">
            <div class="section-inner">
               <div class="section-primary">
                  <div class="theiaStickySidebar">
                     <div class="section-main">
                        <div class="blog-container blog-container-list">
                           <div class="wi-blog fox-blog blog-list v-spacing-small blog-card-has-shadow">
                             <!-- PAGINATION - HIEN THI BAI VIET NHUNG CO PHAN TRANG -->
				            	<jsp:useBean id="pagedListHolder" scope="request" type="org.springframework.beans.support.PagedListHolder"/>
								<c:url value="${ APPURL }/search.htm?q=${ param.q }" var="pagedLink">
									<c:param name="p" value="~" />
								</c:url>
				               
				                <c:forEach var="element" items="${ pagedListHolder.pageList }" begin="0" > 
				               
				               		<article class="wi-post post-item post-list post-thumbnail-align-left post-valign-top list-mobile-layout-list  post type-post status-publish format-standard has-post-thumbnail hentry category-books category-opinion tag-facebook tag-magazine tag-politics tag-travel tag-wordpress">
				                     	<div class="post-list-sep" style="border-color:#eaeaea"></div>
				                     	<div class="post-item-inner list-inner post-list-inner">
					                        <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  list-thumbnail thumbnail-acute  hover-none thumbnail-loading effect-fade" style="width:240px">
					                           <div class="thumbnail-inner">
					                              <a href="${APPURL}/article/${element.id}/${element.post_slug}.htm" class="post-link">
					                              <span class="image-element">
					                              <img width="480" height="384" class="attachment-thumbnail-medium size-thumbnail-medium" alt="" loading="lazy" srcset="${element.media }" />
					                              </span>
					                              </a>
					                           </div>
					                        </figure>
					                        <div class="post-body post-item-body list-body post-list-body">
					                           <div class="post-body-inner">
					                              <div class="post-item-header">
					                                 <div class="entry-categories meta-categories categories-plain standalone-categories post-header-section">
					                                    <a href="${ APPURL }/category/${category.slug}.htm" rel="tag"> ${ category.name }</a>
					                                 </div>
					                                 <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-normal">
					                                    <a href="${APPURL}/article/${element.id}/${element.post_slug}.htm" rel="bookmark">
					                                    	${ element.title } </a>
					                                 </h2>
					                              </div>
					                              <div class="post-item-excerpt entry-excerpt excerpt-size-normal">
					                                 <p> ${ element.excerpt} </p>
					                              </div>
					                              <div class="post-item-meta wi-meta fox-meta post-header-section ">
					                                 <div class="entry-date meta-time machine-time time-short">
					                                    <time class="published">${ dateFormat.format(element.modified_at) }</time>	
					                                 </div>
					                              </div>
					                           </div>
					                        </div>
				                        </div>
				                  </article>
				               </c:forEach>
                             
                             
                              </div>
                             <!-- PAGINGATION -->
				                <tg:paging pagedListHolder="${pagedListHolder}"
								pagedLink="${pagedLink}" />
				
                              </div>
                              </div>
                              <div class="clearfix"></div>
                              </div>
                              </div>
                              <jsp:include page="/WEB-INF/views/client/fragments/sidebar.fragment.jsp"/>
                              <div class="section-sep" style="color:#e0e0e0"></div>
                              </div>
                              </div>
                           </div>
                        </div>
                        <div class="clearfix"></div>
                     </div>
                  </div>
               </div>
               <!-- FOOTER FRAGMENT -->
				<jsp:include page="/WEB-INF/views/client/fragments/footer.fragment.jsp"/>
            </div>
            <div class="wrapper-bg-element"></div>
            <div class="wrapper-border-top hand-border-h wrapper-border"></div>
            <div class="wrapper-border-bottom hand-border-h wrapper-border"></div>
            <div class="wrapper-border-left hand-border-v wrapper-border"></div>
            <div class="wrapper-border-right hand-border-v wrapper-border"></div>
         </div>
      </div>
      <jsp:include page="/WEB-INF/views/client/fragments/mobilenav.fragment.jsp"/>
      <div id="offcanvas-bg" class="offcanvas-bg"></div>
      <div class="offcanvas-overlay" id="offcanvas-overlay"></div>
      <div id="backtotop" class="backtotop fox-backtotop scrollup backtotop-circle backtotop-icon">
         <span class="btt-icon"><i class="feather-chevrons-up"></i></span>
      </div>
      <script id='wi-main-js-extra'>
         var WITHEMES = {"enable_sticky_sidebar":"","enable_sticky_header":"1","tablet_breakpoint":"840","enable_lightbox":"1"};
      </script>
      
      <script src="<c:url value='./public/client/js/theme.min.js' />"></script>
      <jsp:include page="/WEB-INF/views/inc/javascript.jsp"/>
      <jsp:include page="/WEB-INF/views/inc/google-analytics.jsp"/>
   </body>
</html>