<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi" class="no-js">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <script>(function(html){html.className = html.className.replace(/\bno-js\b/,'js')})(document.documentElement);</script>
      <title> ${ page.title } &#8211; ${ SettingsData.getSite_name() }</title>
      <meta name='robots' content='max-image-preview:large' />
      <link rel='dns-prefetch' href='//fonts.googleapis.com' />
      <link href='https://fonts.gstatic.com' rel='preconnect' />
      <link rel='stylesheet' id='wi-fonts-css' href='https://fonts.googleapis.com/css?family=Libre+Franklin%3A400%2C400italic%2C900%7CTinos%3A400%2C400italic%2C700%7CLora%3A400&#038;display=swap&#038;ver=4.6.7.1' media='all' />
      <script src="<c:url value='./public/client/vendor/jquery/jquery.min.js' />"></script>
      <meta name="description" content="${ page.excerpt }" />
      <base href="${APPURL}/" />
      <link rel="icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="shortcut icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      
      <link rel='stylesheet' href="<c:url value='/public/client/vendor/block-library/style.min.css'/>"/>
      <link rel='stylesheet' href="<c:url value='/public/client/style.min.css'/>"/>
      <link rel='stylesheet' href="<c:url value='/public/client/style.css'/>"/>
      
      <script src="<c:url value='./public/client/vendor/jquery/jquery.min.js' />"></script>
      <script src="<c:url value='./public/client/vendor/jquery/jquery-migrate.min.js' />"></script>
   </head>
   <body class="post-template-default single single-post single-format-standard theme-fox woocommerce-js layout-wide style--dropcap-default dropcap-style-default style--dropcap-font-heading style--tag-plain style--list-widget-1 style--tagcloud-1 style--blockquote-no-icon style--single-heading-border_top style--link-2 elementor-default elementor-kit-11">
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
                                 <header class="single-header post-header entry-header page-header align-center single-section">
                                    <div class="container">
                                       <div class="header-main">
                                          <div class="post-item-header">
                                             <div class="title-subtitle">
                                                <h1 class="post-title post-item-title"> ${ page.title }</h1>
                                                <div class="post-item-subtitle post-header-section">
                                                   <p> ${ page.excerpt }</p>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </header>
                                 <div class="single-body single-section">
                                    <div class="single-section single-main-content allow-stretch-full disable-dropcap">
                                       <div class="entry-container">
                                          <div class="content-main">
                                             <div class="dropcap-content columnable-content entry-content single-component">
                                                <p>${ page.content }</p>
                                             </div>
                                             <div class="single-component single-component-share">
                                                <div class="fox-share share-style-custom  color-custom background-custom hover-color-custom hover-background-custom share-icons-shape-circle size-small share-layout-stack">
                                                   <span class="share-label"><i class="fa fa-share-alt"></i>Share this</span>
                                                   <ul>
                                                      <li class="li-share-facebook">
                                                         <a href="https://www.facebook.com/sharer/sharer.php?u=${APPURL }/page/${ page.page_slug }.htm" title="Facebook" class="share share-facebook">
                                                         <i class="fab fa-facebook-f"></i>
                                                         <span>Facebook</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-messenger">
                                                         <a href="https://www.facebook.com/dialog/send?app_id=794927004237856&#038;link=${APPURL }/page/${ page.page_slug }.htm&#038;redirect_uri=${APPURL}" title="Messenger" class="share share-messenger">
                                                         <i class="fab fa-facebook-messenger"></i>
                                                         <span>Messenger</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-twitter">
                                                         <a href="https://twitter.com/intent/tweet?url=${APPURL }/page/${ page.page_slug }.htm&#038;text=${page.title}" title="Twitter" class="share share-twitter">
                                                         <i class="fab fa-twitter"></i>
                                                         <span>Twitter</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-pinterest">
                                                         <a href="https://pinterest.com/pin/create/button/?url=${APPURL }/page/${ page.page_slug }.htm&#038;description=${page.title}" title="Pinterest" class="share share-pinterest">
                                                         <i class="fab fa-pinterest-p"></i>
                                                         <span>Pinterest</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-linkedin">
                                                         <a href="https://www.linkedin.com/shareArticle?mini=true&#038;url=${APPURL }/page/${ page.page_slug }.htm&#038;title=${page.title}" title="Linkedin" class="share share-linkedin">
                                                         <i class="fab fa-linkedin-in"></i>
                                                         <span>Linkedin</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-whatsapp">
                                                         <a href="https://api.whatsapp.com/send?phone=&#038;text=${APPURL }/page/${ page.page_slug }.htm" title="Whatsapp" class="share share-whatsapp">
                                                         <i class="fab fa-whatsapp"></i>
                                                         <span>Whatsapp</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-reddit">
                                                         <a href="https://www.reddit.com/submit?url=${APPURL }/page/${ page.page_slug }.htm&#038;title=${page.title}" title="Reddit" class="share share-reddit">
                                                         <i class="fab fa-reddit-alien"></i>
                                                         <span>Reddit</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-email">
                                                         <a href="mailto:?subject=${ post.title }&amp;body=${APPURL}/article/${ page.id }/${ page.page_slug }.htm" title="Email" class="email-share">
                                                         <i class="feather-mail"></i>
                                                         <span>Email</span>
                                                         </a>
                                                      </li>
                                                   </ul>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </article>
               </div>
               
               <!-- SIDE BAR FRAGMENT -->
      			<%-- <jsp:include page="./fragments/sidebar.fragment.jsp"/> --%>
               
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
      <jsp:include page="./fragments/topup.fragment.jsp"/>
      <jsp:include page="./fragments/progress.fragment.jsp"/>
      
      <script id='wi-main-js-extra'>
         var WITHEMES = {"enable_sticky_sidebar":"","enable_sticky_header":"1","nonce":"5af06dfff4","tablet_breakpoint":"840","enable_lightbox":"1"};
      </script>
      <script src="<c:url value='./public/client/js/theme.min.js' />"></script>
      <jsp:include page="/WEB-INF/views/inc/javascript.jsp"/>
      <jsp:include page="/WEB-INF/views/inc/google-analytics.jsp"/>
   </body>
</html>