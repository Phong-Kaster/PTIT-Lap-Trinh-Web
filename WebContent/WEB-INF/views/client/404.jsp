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
      <title>Không tìm thấy trang -  ${ SettingsData.getSite_name() }</title>
      
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
   <body class="error404 logged-in admin-bar theme-fox woocommerce-js no-sidebar layout-wide style--dropcap-default dropcap-style-default style--dropcap-font-heading style--tag-plain style--list-widget-1 style--tagcloud-1 style--blockquote-no-icon style--single-heading-border_top style--link-2 elementor-default elementor-kit-11 customize-support">
      <div id="wi-all" class="fox-outer-wrapper fox-all wi-all">
      <div id="wi-wrapper" class="fox-wrapper wi-wrapper">
      <div class="wi-container">
      
      <!-- HEADER FRAGMENT -->
      <jsp:include page="/WEB-INF/views/client/fragments/header.fragment.jsp"/>
      
      <jsp:include page="/WEB-INF/views/client/fragments/logo.fragment.jsp"/>
      <div id="wi-main" class="wi-main fox-main">
     	<div id="titlebar" class="headline wi-titlebar post-header align-left">
			<div class="container">
			<div class="title-area">
			<h1 class="archive-title" itemprop="headline">
			<span>
			Trang không tìm thấy
			</span>
			</h1>
			
			</div>
			
			</div>
			
			</div>
			<div class="container">
<div class="page-404-content">
<div class="notfound-text">
<p>Có vẻ như chúng tôi không thể tìm thấy những gì bạn đang tìm kiếm.</p>
</div>
 
<div class="searchform">
<form role="search" method="get" action="${ APPURL }/search.htm" class="form">
<input type="text" name="q" class="s search-field" value="" placeholder="Nhập và nhấn enter">
<button class="submit" role="button" title="Go">
<i class="fa fa-search"></i>
</button>
</form>

</div>

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