<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
     <title>500 - ${ SettingsData.getSite_name() }</title>
    <meta name="description" content="${ SettingsData.getSite_description() }">
    <meta name="author" content="pixelcave">
    <meta name="robots" content="noindex, nofollow">
    <meta property="og:title" content="${ SettingsData.getSite_name() }">
    <meta property="og:site_name" content="${ SettingsData.getSite_description() }">
    <meta property="og:description" content="${ SettingsData.getSite_description() }">
    <meta property="og:type" content="website">
    <meta property="og:url" content="${ APPURL }">
    <base href="${APPURL }/"/>
    <link rel="icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
     <link rel="shortcut icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      
     <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
  	<link rel="stylesheet" id="css-main" href="./public/admin/css/oneui.min.css">
</head>
<body>
<div id="page-container">
          <main id="main-container">
<div class="hero">
  <div class="hero-inner text-center">
    <div class="bg-body-extra-light">
      <div class="content content-full overflow-hidden">
        <div class="py-4">
          <h1 class="display-1 fw-bolder text-modern">
            500
          </h1>
          <h2 class="h4 fw-normal text-muted mb-5">
            We are sorry but our server encountered an internal error..
          </h2>
          <form action="be_pages_generic_search.html" method="POST">
            <div class="row justify-content-center mb-4">
              <div class="col-sm-6 col-xl-3">
                <div class="input-group input-group-lg">
                  <input class="form-control form-control-alt" type="text" placeholder="Search application..">
                  <button type="button" class="btn btn-dark">
                    <i class="fa fa-search opacity-75"></i>
                  </button>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="content content-full text-muted fs-sm fw-medium">
      <p class="mb-1">
        Would you like to let us know about it?
      </p>
      <a class="link-fx" href="${ HOMEURL }">Go Home</a> or <a class="link-fx" href="${ ADMINURL }/dashboard.htm">Go Back to Dashboard</a>
    </div>
  </div>
</div>
  </main>
  </div>
<script src="./public/admin/js/oneui.app.min.js"></script>
  </body>
</html>
