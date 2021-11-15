<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags" %>


<!doctype html>
<html lang="en">
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
      <title>Thêm thể loại - ${ SettingsData.getSite_name() }</title>
      <meta name="description" content="${ SettingsData.getSite_description() }">
      <meta name="author" content="pixelcave">
      <meta name="robots" content="noindex, nofollow">
      <meta property="og:site_name" content="${ SettingsData.getSite_name() }">
      <meta property="og:type" content="website">
      <meta property="og:title" content="${ SettingsData.getSite_name() } - ${ SettingsData.getSite_slogan() }" />
      <meta property="og:url" content="${HOMEURL}" />
      <meta property="og:description" content="${ SettingsData.getSite_description() }" />
      <base href="${APPURL }/"/>
      <link rel="icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="shortcut icon" href="${ SettingsData.getLogomark() != '' ? SettingsData.getLogomark() : './public/images/favicon.ico' }" type="image/x-icon">
      <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
      <link rel="stylesheet" id="css-main" href="./public/admin/css/oneui.min.css">
      <link rel="stylesheet" href="./public/admin/js/plugins/sweetalert2/sweetalert2.min.css">
      <link rel='stylesheet' id='wi-fonts-css' href='https://fonts.googleapis.com/css?family=Libre+Franklin%3A400%2C400italic%2C900%7CTinos%3A400%2C400italic%2C700%7CLora%3A400&#038;display=swap&#038;ver=4.6.7.1' media='all' />
   		
   		<style>
		.container { 
		  height: 50px;
		  position: relative;
		}
		
		.center {
		  margin: 0;
		  position: absolute;
		  top: 20%;
		  left: 60%;
		}
		</style>
   		
   </head>
   <body>
      <!-- AMIND CATEGORY EDIT -->
      <div id="page-container" class="sidebar-o sidebar-dark enable-page-overlay side-scroll page-header-fixed main-content-narrow remember-theme">
      <!-- SIDEBAR FRAGMENT -->
      <jsp:include page="./fragments/sidebar.fragment.jsp"/>
      <!-- HEADER FRAGMENT -->
      <jsp:include page="./fragments/header.fragment.jsp"/>
      <main id="main-container">
         <div class="content">
            <div class="block block-rounded">
               <div class="block-header block-header-default">
                  <h3 class="block-title">Thể loại <b style="color:red;"> mới </b> </h3>
               </div>
               <div class="block-content block-content-full">
               
                  <form:form action="${APPURL }/admin/add-category.htm" method="POST" modelAttribute="category">
                  
                  	<c:if test="${successMessage != null && successMessage.trim().length() > 0 }">
						<div class="alert alert-success alert-dismissible" role="alert">
				            <p class="mb-0">
				              ${ successMessage }
				            </p>
				            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			          	</div>
					</c:if>
                  	
                  
                  	<c:if test="${errorMessage != null && errorMessage.size() > 0 }">
						<c:forEach var="error" items="${ errorMessage }">
							<div class="alert alert-danger alert-dismissible" role="alert">
					            <p class="mb-0">
					              ${ error }
					            </p>
					            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				          	</div>
						</c:forEach>
					</c:if>
                  
                     <div class="row">
                        <div class="col-lg-4">
                           <p class="fs-sm text-muted">
                              <p>Tên: Tên riêng sẽ hiển thị trên trang mạng của bạn.</p>
                              <p>Đường dẫn: Đường dẫn (URL). Chuỗi này bao gồm chữ cái thường, số và dấu gạch ngang (-). Ví dụ: https://www.fb.com/game-online123</p>
                              <p>Chuyên mục: Chuyên mục khác với thẻ, bạn có thể sử dụng nhiều cấp chuyên mục. Ví dụ: Trong chuyên mục nhạc, bạn có chuyên mục con là nhạc Pop, nhạc Jazz.</p>
                              <p>Mô tả: đoạn văn bản mô tả khái quát nội dung của thể loại.</p>
                           </p>
                        </div>
                        <div class="col-lg-8 col-xl-5">
                           <div class="form-floating mb-4">
                              <form:input path="name" class="form-control" id="example-text-input-floating" name="example-text-input-floating" placeholder="John Doe"/>
                              <label for="example-text-input-floating">Tên</label>
                           </div>
                           <div class="form-floating mb-4">
                              <form:input path="slug" class="form-control" id="example-email-input-floating" name="example-email-input-floating" placeholder="john.doe@example.com"/>
                              <label for="example-email-input-floating">Đường dẫn</label>
                           </div>
                           
                          <div class="form-floating mb-4">
                              <form:select path="parent" class="form-select" id="example-select-floating" name="example-select-floating" aria-label="Floating label select example">
                              	<c:forEach var="element" items="${ categories }" varStatus="status">
                              	
                              		<c:if test="${ category.parent == element.id }">
                              			<option selected value="${ element.id }">${ element.name }</option>
                              		</c:if>
                              		
                              		<c:if test="${ category.parent != element.id }">
                              			<option value="${ element.id }">${ element.name }</option>
                              		</c:if>
                              		
                              		
                              	</c:forEach>
                                 
                              </form:select>
                              <label for="example-select-floating">Chuyên mục</label>
                           </div>
                           
                          
                           
                           <div class="form-floating mb-4">
                              <form:textarea path="description" class="form-control" id="example-textarea-floating" name="example-textarea-floating" style="height: 200px" placeholder="Leave a comment here" />
                              <label for="example-textarea-floating">Mô tả</label>
                           </div>
                        </div>
                     </div>
                     
                      
                      <div class="container">
						  <div class="center">
						    	<input type="submit" class="btn btn-primary" value="Lưu lại">
						    	<input type="button" id="btn-add-category-cancel" class="btn btn-danger" value="Hủy bỏ">
						  </div>
					 </div>
						                      
                     
                  </form:form>
               </div>
            </div>
         </div>
      </main>
      <c:remove var="successMessage" scope="session" />
  	  <c:remove var="errorMessage" scope="session" />
      <!-- FOOTER FRAGMENT -->
      <jsp:include page="./fragments/footer.fragment.jsp"/>
      
      <!-- MY OWN LIBRARY -->
      
		<script src="./public/admin/js/lib/jquery.min.js"></script>
		<script src="./public/admin/js/oneui.app.min.js"></script>
		<script src="./public/admin/js/plugins/sweetalert2/sweetalert2.min.js"></script>
		<script src="./public/admin/js/pages/core.js"></script>
		<script>
      		let URL = "${APPURL}";
      	</script>
		<script src="./public/admin/js/pages/category.js"></script>