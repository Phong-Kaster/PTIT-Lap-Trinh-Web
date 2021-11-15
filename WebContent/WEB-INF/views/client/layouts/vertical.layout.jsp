<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
    <div style="background-color:#083868;color:#ffffff" class="wi-section fox-section section-layout-vertical has-background custom-color section-stretch-content show_on_desktop show_on_tablet show_on_mobile section-fullwidth">
         <div class="container">
            <div class="section-container">
               <div class="section-inner">
                  <div class="section-primary">
                     <div class="theiaStickySidebar">
                        <div class="section-main">
                           <div class="blog-container blog-container-vertical">
                              <div class="wi-blog fox-blog blog-vertical">
                              <c:forEach var="post" items="${ posts }" begin="0">
                                 <article class="wi-post post-item post-vertical post-thumbnail-align-left post type-post status-publish format-standard has-post-thumbnail hentry category-nature category-physics tag-amazing tag-nature">
                                    <div class="post-item-inner vertical-inner post-vertical-inner">
                                       <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure vertical-thumbnail thumbnail-acute hover-logo hover-dark thumbnail-loading effect-fade inview">
                                          <div class="thumbnail-inner">
                                             <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="post-link">
                                             <span class="image-element">
                                             <img width="1024" height="682" src="${post.media }" class="attachment-large size-large" alt="" loading="lazy" srcset="${post.media }">
                                             </span>
                                             <span class="image-overlay"></span><span class="image-logo" style="width:40%"><img width="900" height="140" src="${ SettingsData.getLogotype() }" class="attachment-large size-large" alt="" loading="lazy" srcset="${ SettingsData.getLogotype() }"></span>
                                             </a>
                                          </div>
                                       </figure>
                                       <div class="post-body post-item-body vertical-body post-vertical-body">
                                          <div class="post-body-inner">
                                             <div class="post-item-header">
                                                <div class="post-item-meta wi-meta fox-meta post-header-section ">
                                                   <div class="entry-date meta-time machine-time time-short">
                                                      <time class="published">${dateFormat.format(post.modified_at) }</time>
                                                   </div>
                                                   <div class="entry-categories meta-categories categories-plain">
                                                      <a href="${ APPURL }/category/${ category.slug }.htm" rel="tag">${ category.name }</a>
                                                   </div>
                                                </div>
                                                <h2 class="post-item-title wi-post-title fox-post-title post-header-section post-vertical-title size-large">
                                                  <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" rel="bookmark">
                                                      ${ post.title } </a>
                                                </h2>
                                             </div>
                                             <div class="post-item-excerpt entry-excerpt excerpt-size-medium post-vertical-content">
                                                ${ post.excerpt }
                                                <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="readmore fox-btn btn-tiny btn-outline">Đọc Tiếp»</a>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </article>
                                 </c:forEach>
                              </div>
                           </div>
                        </div>
                        <div class="clearfix"></div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>