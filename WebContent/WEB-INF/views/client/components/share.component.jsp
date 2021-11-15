<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
   <div class="single-component single-component-share">
                                                <div class="fox-share share-style-custom  color-custom background-custom hover-color-custom hover-background-custom share-icons-shape-circle size-small share-layout-stack">
                                                   <span class="share-label"><i class="fa fa-share-alt"></i>Share this</span>
                                                   <ul>
                                                      <li class="li-share-facebook">
                                                         <a href="https://www.facebook.com/sharer/sharer.php?u=${APPURL}/article/${ post.id }/${ post.post_slug }.htm" title="Facebook" class="share share-facebook">
                                                         <i class="fab fa-facebook-f"></i>
                                                         <span>Facebook</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-messenger">
                                                         <a href="https://www.facebook.com/dialog/send?app_id=794927004237856&#038;link=${APPURL}/article/${ post.id }/${ post.post_slug }.htm&#038;redirect_uri=${APPURL}" title="Messenger" class="share share-messenger">
                                                         <i class="fab fa-facebook-messenger"></i>
                                                         <span>Messenger</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-twitter">
                                                         <a href="https://twitter.com/intent/tweet?url=${APPURL}/article/${ post.id }/${ post.post_slug }.htm&#038;text=${ post.title }" title="Twitter" class="share share-twitter">
                                                         <i class="fab fa-twitter"></i>
                                                         <span>Twitter</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-pinterest">
                                                         <a href="https://pinterest.com/pin/create/button/?url=${APPURL}/article/${ post.id }/${ post.post_slug }.htm&#038;description=${ post.title }" title="Pinterest" class="share share-pinterest">
                                                         <i class="fab fa-pinterest-p"></i>
                                                         <span>Pinterest</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-linkedin">
                                                         <a href="https://www.linkedin.com/shareArticle?mini=true&#038;url=${APPURL}/article/${ post.id }/${ post.post_slug }.htm&#038;title=${ post.title }" title="Linkedin" class="share share-linkedin">
                                                         <i class="fab fa-linkedin-in"></i>
                                                         <span>Linkedin</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-whatsapp">
                                                         <a href="https://api.whatsapp.com/send?phone=&#038;text=${APPURL}/article/${ post.id }/${ post.post_slug }.htm" title="Whatsapp" class="share share-whatsapp">
                                                         <i class="fab fa-whatsapp"></i>
                                                         <span>Whatsapp</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-reddit">
                                                         <a href="https://www.reddit.com/submit?url=${APPURL}/article/${ post.id }/${ post.post_slug }.htm&#038;title=${ post.title }" title="Reddit" class="share share-reddit">
                                                         <i class="fab fa-reddit-alien"></i>
                                                         <span>Reddit</span>
                                                         </a>
                                                      </li>
                                                      <li class="li-share-email">
                                                         <a href="mailto:?subject=${ post.title }&amp;body=${APPURL}/article/${ post.id }/${ post.post_slug }.htm" title="Email" class="email-share">
                                                         <i class="feather-mail"></i>
                                                         <span>Email</span>
                                                         </a>
                                                      </li>
                                                   </ul>
                                                </div>
                                             </div>