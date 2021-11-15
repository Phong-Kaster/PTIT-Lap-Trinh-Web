<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    <div class="wi-section fox-section section-layout-group-1 section-stretch-content show_on_desktop show_on_tablet show_on_mobile section-fullwidth section-has-heading">
         <div class="section-heading heading-link--inheading heading-line heading-line-2 heading-line-middle heading-line-stretch-content heading-tiny align-left">
            <div class="container">
               <div class="heading-inner">
                  <h2 class="heading-text"><a href="${ APPURL }/category/${ category.slug }.htm" target="_self">${ category.name }</a></h2>
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
                           <div class="blog-container blog-container-group blog-container-group-1">
                              <div class="wi-blog fox-blog blog-group blog-group-1 post-group-row wi-newsblock newsblock-1 big-post-left big-post-ratio-2-3 has-border v-spacing-small">
                                 <div class="post-group-col post-group-col-big article-big-wrapper">
                                 <c:forEach var="post" items="${ posts }" begin="0" end="0">
                                    <article class="wi-post post-item post-grid fox-grid-item article-big post-align-left post--thumbnail-before post-1403 post type-post status-publish format-standard has-post-thumbnail hentry category-politics tag-books tag-fashion tag-magazine tag-publishing tag-wordpress">
                                       <div class="post-item-inner grid-inner post-grid-inner">
                                          <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  grid-thumbnail thumbnail-acute  hover-none thumbnail-loading effect-fade">
                                             <div class="thumbnail-inner">
                                                <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="post-link">
                                                <span class="image-element">
                                                <img width="720" height="480" src="${post.media}" class="attachment-thumbnail-large size-thumbnail-large" alt="" loading="lazy" />
                                                </span>
                                                </a>
                                             </div>
                                          </figure>
                                          <div class="post-body post-item-body grid-body post-grid-body">
                                             <div class="post-body-inner">
                                                <div class="post-item-header">
                                                   <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-medium">
                                                      <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" rel="bookmark">${post.title } </a>
                                                   </h2>
                                                   <div class="post-item-meta wi-meta fox-meta post-header-section ">
                                                      <div class="entry-date meta-time machine-time time-short">
                                                         <time class="published">${dateFormat.format(post.modified_at) }</time>
                                                      </div>
                                                      <div class="entry-categories meta-categories categories-plain">
                                                         <a href="${ APPURL }/category/${ category.slug }.htm" rel="tag">${ category.name }</a>
                                                      </div>
                                                   </div>
                                                </div>
                                                <div class="post-item-excerpt entry-excerpt excerpt-size-normal">
                                                   ${ post.excerpt }
                                                   <a href="${APPURL}/article/${post.id}/${post.post_slug}.htm" class="readmore fox-btn btn-tiny btn-primary">Xem thêm »</a>
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </article>
                                    </c:forEach>
                                 </div>
                                 <div class="post-group-col post-group-col-small article-small-wrapper">
                                    <c:forEach var="post" items="${ posts }" begin="1">
                                    <article class="wi-post post-item post-list article-small-list post-thumbnail-align-right post-valign-top list-mobile-layout-list post-1415 post type-post status-publish format-standard has-post-thumbnail hentry category-books category-politics tag-article tag-fashion tag-newspaper tag-times tag-wp">
                                       <div class="post-list-sep" style="border-color:#eaeaea"></div>
                                       <div class="post-item-inner list-inner post-list-inner">
                                          <figure class="wi-thumbnail fox-thumbnail post-item-thumbnail fox-figure  list-thumbnail thumbnail-acute  hover-none thumbnail-loading effect-fade">
                                             <div class="thumbnail-inner">
                                                <a href="${ APPURL }/category/${ category.slug }.htm" class="post-link">
                                                <span class="image-element">
                                                <img width="480" height="384" src="${post.media}" class="attachment-thumbnail-medium size-thumbnail-medium" alt="" loading="lazy" />
                                                </span>
                                                </a>
                                             </div>
                                          </figure>
                                          <div class="post-body post-item-body list-body post-list-body">
                                             <div class="post-body-inner">
                                                <div class="post-item-header">
                                                   <h2 class="post-item-title wi-post-title fox-post-title post-header-section size-small">
                                                      <a href="${ APPURL }/category/${ category.slug }.htm" rel="bookmark">
                                                      ${post.title } </a>
                                                   </h2>
                                                </div>
                                                <div class="post-item-excerpt entry-excerpt excerpt-size-small">
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
                                 <div class="sep-border" style="color:#e0e0e0"></div>
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