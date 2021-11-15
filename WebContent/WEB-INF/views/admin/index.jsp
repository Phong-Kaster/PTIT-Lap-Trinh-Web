<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> ${ SettingsData.getSite_name() } - ${ SettingsData.getSite_slogan() }</title>
    <meta name="description" content="${ SettingsData.getSite_description() }">
    <meta name="author" content="pixelcave">
    <meta name="robots" content="noindex, nofollow">
    <meta property="og:site_name" content="${ SettingsData.getSite_name() }">
    <meta property="og:type" content="website">
    <meta property="og:title" content="${ SettingsData.getSite_name() } - ${ SettingsData.getSite_slogan() }" />
    <meta property="og:url" content="${HOMEURL}" />
    <meta property="og:description" content="${ post.excerpt }" />
    <base href="${APPURL}/" />
    <link rel="icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="shortcut icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
  <link rel="stylesheet" id="css-main" href="./public/admin/css/oneui.min.css">
  <script src="https://www.google.com/recaptcha/api.js?hl=vi" async defer></script>
  
</head>
<body>
<div id="page-container">
          <main id="main-container">
<div class="bg-image" style="background-image: url('./public/admin/media/photos/photo28@2x.jpg');">
  <div class="row g-0 bg-primary-dark-op">
    <div class="hero-static col-lg-4 d-none d-lg-flex flex-column justify-content-center">
      <div class="p-4 p-xl-5 flex-grow-1 d-flex align-items-center">
        <div class="w-100">
          <a class="link-fx fw-semibold fs-2 text-white" href="${HOMEURL }">
             ${ SettingsData.getSite_name() }
          </a>
          <p class="text-white-75 me-xl-8 mt-2">
           ${ SettingsData.getSite_slogan() }
          </p>
        </div>
      </div>
      <div class="p-4 p-xl-5 d-xl-flex justify-content-between align-items-center fs-sm">
        <p class="fw-medium text-white-50 mb-0">
          <strong>${ SettingsData.getSite_name() }</strong> &copy; <span data-toggle="year-copy"></span>
        </p>
      </div>
    </div>
    <div class="hero-static col-lg-8 d-flex flex-column align-items-center bg-body-light">
      <div class="p-3 w-100 d-lg-none text-center">
        <a class="link-fx fw-semibold fs-3 text-dark" href="${HOMEURL }">
         ${ SettingsData.getSite_name() }
        </a>
      </div>
      <div class="p-4 w-100 flex-grow-1 d-flex align-items-center">
        <div class="w-100">
          <div class="text-center mb-5">
            <p class="mb-3">
              <i class="fa fa-2x fa-circle-notch text-primary-light"></i>
            </p>
            <h1 class="fw-bold mb-2">
              Xin chào
            </h1>
            <p class="fw-medium text-muted">
              Vui lòng đăng nhập.
            </p>
          </div>
          
          <div class="row g-0 justify-content-center">
            <div class="col-sm-8 col-xl-4">
            
            		<c:if test="${param.error == 'true' && sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message.length() > 0}">
			            <div class="alert alert-danger alert-dismissible" role="alert">
						   <p class="mb-0">
						              ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
						</p>
						  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					 </div>
				    </c:if>
				    
				    <c:if test="${param.logout == 'true'}">
			            <div class="alert alert-success alert-dismissible" role="alert">
						   <p class="mb-0">
						             Bạn đã đăng xuất!
							</p>
						  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					 </div>
			    	</c:if>
			    	
			    	<c:if test="${successMessage != null && successMessage.trim().length() > 0 }">
						<div class="alert alert-success alert-dismissible" role="alert">
				            <p class="mb-0">
				              ${ successMessage } 
				            </p>
				            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			          	</div>
					</c:if>
	          
              <form class="js-validation-signin" name="f" action="${APPURL }/login.htm" method="POST">
                <div class="mb-4">
                  <input type="text" class="form-control form-control-lg form-control-alt py-3" id="username" name="username" value="${email}" placeholder="Tên đăng nhập">
                </div>
                <div class="mb-4">
                  <input type="password" class="form-control form-control-lg form-control-alt py-3" id="password" name="password" placeholder="Mật khẩu">
                </div>
                
                <div class="mb-4">
					<div class="mb-40 recaptcha">
						<div class="g-recaptcha" data-sitekey="${ Recaptcha.getSiteKey() }"></div>
						<div class="recaptcha-error"></div>
					</div>
				</div>
               
                <div class="mb-4">
                    <div class="form-check">
                      <input class="form-check-input" type="checkbox" value="" id="remember" name="remember">
                      <label class="form-check-label" for="remember">Nhớ mật khẩu</label>
                    </div>
                 </div>
                <div class="d-flex justify-content-between align-items-center mb-4">
                  <div>
                    <a class="text-muted fs-sm fw-medium d-block d-lg-inline-block mb-1" href="forgot-password.htm">
                      Quên mật khẩu?
                    </a>
                  </div>
                  <div>
                    <button type="submit" class="btn btn-lg btn-alt-primary">
                      <i class="fa fa-fw fa-sign-in-alt me-1 opacity-50"></i> Đăng nhập
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <div class="px-4 py-3 w-100 d-lg-none d-flex flex-column flex-sm-row justify-content-between fs-sm text-center text-sm-start">
        <p class="fw-medium text-black-50 py-2 mb-0">
          <strong>${ SettingsData.getSite_name() }</strong> &copy; <span data-toggle="year-copy"></span>
        </p>
      </div>
    </div>
  </div>
</div>
<c:remove var="successMessage" scope="session" />
  </main>
  </div>
<script src="./public/admin/js/oneui.app.min.js"></script>
<script src="./public/admin/js/lib/jquery.min.js"></script>
<script src="./public/admin/js/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="./public/admin/js/pages/signin.min.js"></script>
  </body>
</html>
   