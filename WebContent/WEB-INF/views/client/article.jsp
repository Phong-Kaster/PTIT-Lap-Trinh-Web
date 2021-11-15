<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi" class="no-js">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <script>(function(html){html.className = html.className.replace(/\bno-js\b/,'js')})(document.documentElement);</script>
      <title> ${ post.title } - ${ SettingsData.getSite_name() }</title>
      <meta name='robots' content='max-image-preview:large' />
      <link rel='dns-prefetch' href='//fonts.googleapis.com' />
	  <base href="${APPURL}/" />
      <link href='https://fonts.gstatic.com' rel='preconnect' />
      <link rel='stylesheet' id='wi-fonts-css' href='https://fonts.googleapis.com/css?family=Libre+Franklin%3A400%2C400italic%2C900%7CTinos%3A400%2C400italic%2C700%7CLora%3A400&#038;display=swap&#038;ver=4.6.7.1' media='all' />
      <link rel='stylesheet' href="<c:url value='./public/client/vendor/jquery/jquery.min.js'/>"/>
      <meta name="description" content="${ post.excerpt }" />
      <meta property="og:site_name" content="${ SettingsData.getSite_name() }">
      <meta property="og:type" content="website">
      <meta property="og:title" content="${ post.title } - ${ SettingsData.getSite_name() }" />
      <meta property="og:url" content="${APPURL}/article/${ post.id }-${ post.post_slug }" />
      <meta property="og:image" content="${ post.media }" />
      <meta property="og:description" content="${ post.excerpt }" />
      <link rel="icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="shortcut icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel='stylesheet' href="<c:url value='./public/client/vendor/block-library/style.min.css'/>"/>
      <link rel='stylesheet' href="<c:url value='./public/client/style.min.css'/>"/>
      <link rel='stylesheet' href="<c:url value='./public/client/style.css'/>"/>
      <script src="<c:url value='./public/client/vendor/jquery/jquery.min.js' />"></script>
      <script src="<c:url value='./public/client/vendor/jquery/jquery-migrate.min.js' />"></script>
      <script src="https://www.google.com/recaptcha/api.js?hl=vi" async defer></script>
   </head>
   <body class="post-template-default single single-post postid-1395 single-format-standard theme-fox woocommerce-js layout-wide style--dropcap-default dropcap-style-default style--dropcap-font-heading style--tag-plain style--list-widget-1 style--tagcloud-1 style--blockquote-no-icon style--single-heading-border_top style--link-2 elementor-default elementor-kit-11">
      <div id="wi-all" class="fox-outer-wrapper fox-all wi-all">
         <div id="wi-wrapper" class="fox-wrapper wi-wrapper">
            <div class="wi-container">
               <!-- HEADER FRAGMENT -->
               <jsp:include page="./fragments/header.fragment.jsp"/>
               <jsp:include page="./fragments/logo.fragment.jsp"/>
               <div id="wi-main" class="wi-main fox-main">
                  <article id="wi-content" class="wi-content wi-single single-style-1b padding-top-normal post type-post status-publish format-standard has-post-thumbnail hentry category-opinion tag-article tag-breaking-news tag-publishing tag-times tag-travel tag-wp no-sidebar">
                     <div class="single-big-section single-big-section-content">
                        <div class="container">
                           <div id="primary" class="primary content-area">
                              <div class="theiaStickySidebar">
                                 <div class="single-body single-section">
                                    <div class="single-section single-main-content allow-stretch-full allow-stretch-left allow-stretch-right allow-stretch-bigger disable-dropcap">
                                       <div class="entry-container">
                                          <div class="content-main narrow-area">
                                             <header class="hero-meta single-component">
                                                <div class="container">
                                                   <div class="header-main narrow-area">
                                                      <div class="post-item-header">
                                                         <div class="entry-categories meta-categories categories-plain standalone-categories post-header-section">
                                                            <a href="${APPURL }/category/${ post.category.slug }.htm" rel="tag">${post.category.name }</a>
                                                            
                                                         </div>
                                                         <div class="title-subtitle">
                                                            <h1 class="post-title post-item-title">${ post.title }</h1>
                                                            <div class="post-item-subtitle post-header-section">
                                                               <p>${ post.excerpt }</p>
                                                            </div>
                                                         </div>
                                                         <div class="post-item-meta wi-meta fox-meta post-header-section ">
                                                            <div class="fox-meta-author entry-author meta-author">
                                                               <span class="byline"> Bởi <span class="author vcard">
                                                               <a class="url fn" href="${APPURL}/author/${post.user.username}.htm">
                                                               <span>${post.user.firstname} ${post.user.lastname}</span></a></span></span>
                                                            </div>
                                                            <div class="entry-date meta-time machine-time time-short">
                                                               <time class="published">${dateFormat.format(post.modified_at) }</time>
                                                            </div>
                                                         </div>
                                                      </div>
                                                   </div>
                                                </div>
                                             </header>
                                             <div class="dropcap-content columnable-content entry-content single-component">
                                                
                                                  ${ post.content }
                                             </div>
                                             <p>Nguồn: <i>${ post.source }</i></p>
                                             <jsp:include page="./components/share.component.jsp"/>
                                             <jsp:include page="./components/authorbox.component.jsp"/>
                                             
                                            
                                             
                                             <c:if test="${ post.comment_status }">
                                             	<c:set var="listComments" value="${listComments}" scope="request"/>
                                             	<c:set var="post" value="${post}" scope="request"/>
                                             	<jsp:include page="./components/comment-form.component.jsp"/>
                                             </c:if>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                      <jsp:include page="./components/related.component.jsp"/>
                  </article>
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
      <jsp:include page="./fragments/progress.fragment.jsp"/>
      <script src="https://timeswriter.xyz/themes/assets/js/comment-reply.min.js" id='wi-main-js'></script>
      <script id='wi-main-js-extra'>
         var WITHEMES = {"enable_sticky_sidebar":"","enable_sticky_header":"1","tablet_breakpoint":"840","enable_lightbox":"1"};
      </script>
      <script src="<c:url value='./public/client/js/theme.min.js' />"></script>
      <jsp:include page="/WEB-INF/views/inc/javascript.jsp"/>
      <jsp:include page="/WEB-INF/views/inc/google-analytics.jsp"/>
   </body>
</html>