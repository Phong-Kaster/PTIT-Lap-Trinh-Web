<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
    <div class="wi-section fox-section section-layout-group-2 section-stretch-content show_on_desktop show_on_tablet show_on_mobile section-fullwidth">
         <div class="container">
            <div class="section-container">
               <div class="section-inner">
                  <div class="section-primary">
                     <div class="theiaStickySidebar">
                        <div class="section-main">
                           <div class="blog-container blog-container-group blog-container-group-2">
                              <div class="wi-blog fox-blog blog-group blog-group-2 post-group-row newsblock-2 post-group-row-3-1a-1b big-order-2 small-order-1 tall-order-3 has-border">
                                 <div class="post-group-col post-group-col-big article-col-big">
                                 <c:forEach var="post" items="${ posts }" begin="0" end="0">
                                    <article class="wi-post post-item post-grid fox-grid-item article-big post-align-center post--thumbnail-before post type-post status-publish format-standard has-post-thumbnail hentry category-opinion tag-article tag-breaking-news tag-publishing tag-times tag-travel tag-wp">
                                       <div class="post-item-inner grid-inner post-grid-inner">
                                          <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  grid-thumbnail thumbnail-acute  hover-none thumbnail-loading effect-fade">
                                             <div class="thumbnail-inner">
                                                <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="post-link">
                                                <span class="image-element">
                                                <img width="720" height="480" srcset="${ post.media }" class="attachment-thumbnail-large size-thumbnail-large" alt="" loading="lazy" />
                                                </span>
                                                </a>
                                             </div>
                                          </figure>
                                          <div class="post-body post-item-body grid-body post-grid-body">
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
                                                   <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-medium">
                                                      <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" rel="bookmark">
                                                      ${ post.title } </a>
                                                   </h2>
                                                </div>
                                                <div class="post-item-excerpt entry-excerpt excerpt-size-normal">
                                                    ${ post.excerpt }
                                                   <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="readmore fox-btn btn-tiny btn-primary">Xem thêm →</a>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </article>
                                    </c:forEach>
                                 </div>
                                 <div class="post-group-col post-group-col-tall article-col-tall">
                                  <c:forEach var="post" items="${ posts }" begin="1" end="2">
                                    <article class="wi-post post-item post-grid fox-grid-item article-tall article-medium post-align-left post--thumbnail-before post-1407 post type-post status-publish format-standard has-post-thumbnail hentry category-books tag-article tag-instagram tag-science">
                                       <div class="post-item-inner grid-inner post-grid-inner">
                                          <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  grid-thumbnail thumbnail-acute  hover-none thumbnail-loading effect-fade">
                                             <div class="thumbnail-inner">
                                                <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="post-link">
                                                <span class="image-element">
                                                <img width="207" height="300" srcset="${ post.media }" class="attachment-medium size-medium" alt=""  />
                                                </span>
                                                </a>
                                             </div>
                                          </figure>
                                          <div class="post-body post-item-body grid-body post-grid-body">
                                             <div class="post-body-inner">
                                                <div class="post-item-header">
                                                   <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-normal">
                                                      <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" rel="bookmark">
                                                      ${ post.title } </a>
                                                   </h2>
                                                </div>
                                                <div class="post-item-excerpt entry-excerpt excerpt-size-normal">
                                                   ${ post.excerpt }
                                                </div>
                                                <div class="post-item-meta wi-meta fox-meta post-header-section ">
                                                   <div class="entry-date meta-time machine-time time-short">
                                                      <time class="published">${dateFormat.format(post.modified_at) }</time>
                                                   </div>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </article>
                                   </c:forEach>
                                 </div>
                                 <div class="post-group-col post-group-col-small article-col-small">
                                 <c:forEach var="post" items="${ posts }" begin="3">
                                    <article class="wi-post post-item post-grid fox-grid-item article-small article-small-grid post-align-left post--thumbnail-before post type-post status-publish format-standard has-post-thumbnail hentry category-opinion category-politics tag-blog tag-books tag-elementor tag-gutenberg tag-wordpress tag-wp">
                                       <div class="post-item-inner grid-inner post-grid-inner">
                                          <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  grid-thumbnail thumbnail-acute  hover-none thumbnail-loading effect-fade">
                                             <div class="thumbnail-inner">
                                                <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="post-link">
                                                <span class="image-element">
                                                <img width="480" height="384" src="${post.media }" class="attachment-thumbnail-medium size-thumbnail-medium" alt="" loading="lazy" />
                                                </span>
                                                </a>
                                             </div>
                                          </figure>
                                          <div class="post-body post-item-body grid-body post-grid-body">
                                             <div class="post-body-inner">
                                                <div class="post-item-header">
                                                   <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-small">
                                                      <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" rel="bookmark">
                                                      ${ post.title } </a>
                                                   </h2>
                                                </div>
                                                <div class="post-item-excerpt entry-excerpt excerpt-size-small">
                                                    ${ post.excerpt }
                                                </div>
                                                <div class="post-item-meta wi-meta fox-meta post-header-section ">
                                                   <div class="entry-date meta-time machine-time time-short"> <time class="published">${dateFormat.format(post.modified_at) }</time></div>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </article>
                                   </c:forEach>
                                 </div>
                                 <div class="sep-border line1" style="color:#e0e0e0"></div>
                                 <div class="sep-border line2" style="color:#e0e0e0"></div>
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