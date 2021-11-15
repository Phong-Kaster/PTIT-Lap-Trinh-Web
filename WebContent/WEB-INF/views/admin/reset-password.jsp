<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
  <head>
	 <style>
	  .error {color:red;}
	</style>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Thay đổi mật khẩu</title>
    <base href="${APPURL}/" />
    <meta name="description" content="OneUI - Bootstrap 5 Admin Template &amp; UI Framework created by pixelcave and published on Themeforest | This is the demo of OneUI! You need to purchase a license for legal use! | DEMO">
    <meta name="robots" content="noindex, nofollow">
    <meta property="og:title" content="${SettingsData.getSite_name() }">
    <meta property="og:site_name" content="${SettingsData.getSite_description() }">
    <meta property="og:description" content="${SettingsData.getSite_description() }">
    <meta property="og:type" content="website">
    <meta property="og:url" content="">
    <meta property="og:image" content="">
    <link rel="icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
     <link rel="shortcut icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
    													
      <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
  <link rel="stylesheet" id="css-main" href="<c:url value='./public/admin/css/oneui.min.css' />">
  											
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-16158021-6"></script><script>window.dataLayer = window.dataLayer || [];function gtag(){dataLayer.push(arguments);}gtag('js', new Date());gtag('config', 'UA-16158021-6');</script>
</head>
<body>
<div id="page-container">
          <main id="main-container">
<div class="hero-static d-flex align-items-center">
  <div class="content">
    <div class="row justify-content-center push">
      <div class="col-md-8 col-lg-6 col-xl-4">
        <div class="block block-rounded mb-0">
          <div class="block-header block-header-default">
            <h3 class="block-title">Thay đổi mật khẩu</h3>
            
          </div>
          <div class="block-content">
            <div class="p-sm-3 px-lg-4 px-xxl-5 py-lg-5">
              <h1 class="h2 mb-1">${SettingsData.getSite_name() }</h1>
              <p class="fw-medium text-muted">
                Vui lòng nhập mật khẩu mới cho tài khoản của bạn.
              </p>
              <p class="error">
                ${message}
              </p>
              <form class="js-validation-reset" action="${APPURL }/reset-password/${hash}.htm" method="POST">
                <div class="py-3">
                  <div class="mb-4">
                    <input type="password" class="form-control form-control-alt form-control-lg" id="password" name="password" placeholder="Mật khẩu mới">
                  </div>
                  <div class="mb-4">
                    <input type="password" class="form-control form-control-alt form-control-lg" id="repeatpassword" name="repeatpassword" placeholder="Nhập lại mật khẩu mới">
                  </div>               
                </div>
                <div class="row mb-4">
                  <div class="col-md-6 col-xl-5">
                    <button type="submit" class="btn w-100 btn-alt-primary">
                      <i class="fa fa-fw fa-sign-in-alt me-1 opacity-50"></i> Xác nhận
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="fs-sm text-muted text-center">
      <strong>${SettingsData.getSite_name() }</strong> &copy; <span data-toggle="year-copy"></span>
    </div>
  </div>
</div>
  </main>
  </div>
    <c:remove var="message" scope="session" />
<script src="<c:url value='./public/admin/js/oneui.app.min.js' />"></script>
<script src="<c:url value='./public/admin/js/lib/jquery.min.js' />"></script>
<script src="<c:url value='./public/admin/js/plugins/jquery-validation/jquery.validate.min.js' />"></script>
<script  src='./public/admin/js/pages/reset_password.js'charset="UTF-8" ></script>
<script src="./public/admin/js/pages/core.js"></script>
  </body>
</html>
