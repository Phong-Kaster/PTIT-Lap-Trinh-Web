<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
   <div class="single-component single-component-authorbox">
                                                <div class="fox-authorbox authorbox-simple authorbox-narrow">
                                                   <div class="authorbox-inner">
                                                      <div class="user-item-avatar authorbox-avatar avatar-circle">
                                                         <a href="${ APPURL }/author/${ post.user.username}">
                                                         <img alt='' srcset='${post.user.avatar ? post.user.avatar : './public/images/users/no-avatar.png 2x'}
                                                         ' class='avatar avatar-300 photo' height='300' width='300' loading='lazy' />
                                                         </a>
                                                      </div>
                                                      <div class="authorbox-text">
                                                         <div class="fox-user-item authorbox-tab active authorbox-content" data-tab="author">
                                                            <div class="user-item-body">
                                                               <h3 class="user-item-name">
                                                                  <a href="${ APPURL }/author/${ post.user.username}">${post.user.firstname} ${post.user.lastname}</a>
                                                               </h3>
                                                               <div class="user-item-description">
                                                                  <p>${post.user.bio}</p>
                                                               </div>
                                                               <div class="social-list user-item-social shape-circle style-plain">
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
                                             </div>