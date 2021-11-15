<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Menu - ${ SettingsData.getSite_name() }</title>
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
</head>
<body>
<div id="page-container" class="sidebar-o sidebar-dark enable-page-overlay side-scroll page-header-fixed main-content-narrow remember-theme">
      <!-- SIDEBAR FRAGMENT -->
      <jsp:include page="./fragments/sidebar.fragment.jsp"/>
      <!-- HEADER FRAGMENT -->
      <jsp:include page="./fragments/header.fragment.jsp"/>
  <main id="main-container">
<div class="content">
<div class="row">
	<div class="col-xl-4">
		<div class="block block-rounded">
		    <div class="block-header block-header-default">
		      <h3 class="block-title">Thêm menu</h3>
		    </div>
		    <div class="block-content">
			    <form class="widget-form" action="${ ADMINURL }/add-menu.htm?position=${position}" method="post">
				   <input type="hidden" name="order_widget" value="#">
				   <div class="mb-4">
				      <label for="title" class="form-label">Tiêu Đề</label>
				      <input type="text" id="title" name="title" class="form-control" name="title" placeholder="Your menu">
				   </div>
				   <div class="mb-4">
				      <label for="num_post" class="form-label">Đường dẫn</label>
				      <input type="text" id="url" name="url" class="form-control" name="num_post" placeholder="your-url">
				   </div>
				   <div class="row mb-4">
				   
				   
                  <div class="col-md-6 col-xl-5">
                    <button type="button" class="btn-add-menu btn w-100 btn-primary">
                      	Lưu lại
                    </button>
                  </div>
                </div>
				</form>
		    </div>
		  </div>
		  
		  <div class="block block-rounded">
		    <div class="block-header block-header-default">
		      <h3 class="block-title">Xóa menu</h3>
		    </div>
		    <div class="block-content">
			    <form class="widget-form" action="${ ADMINURL }/remove-menu.htm" method="post">
				   <div class="mb-4">
				      <select id="removeMenu" class="form-select" >
			            <c:forEach items="${listAllMenuModel }" var="element">
			            	<option value="${element.id }">${ element.title }</option>
			            </c:forEach>
			          </select>
				   </div>
				   
				   <div class="col-md-6 col-xl-5">
	                    <button type="button" class="btn-remove-menu btn w-100 btn-primary">
	                      	Xóa
	                    </button>
	               </div>
				</form>
		    </div>
		  </div>
	</div>
	<div class="col-xl-5">
	 <form class="js-ajax-form" action="${ ADMINURL }/menu.htm" method="post">
		
		
		<div class="block-header block-header-default">
		      <h3 class="block-title">Sắp xếp</h3>
		 </div>
		<div id="items" class="list-group col nested-sortable">
			<c:forEach var="element" items="${ listMenuModel }">
				<!-- IN RA MENU CHA -->
				<div data-sortable-id="${element.menu.id }" data-uid="${ element.menu.id }" class="list-group-item nested-1">${element.menu.title}
				<!-- IN RA MENU CON -->
				<div class="list-group nested-sortable">
					<c:if test="${ element.children.size() > 0 && element.children != null }">
							<c:forEach var="e" items="${ element.children }">
								<div data-sortable-id="${e.id }" data-uid="${ element.menu.id }" class="list-group-item nested-2"> 
									${ e.title }
									<div class="list-group nested-sortable">
									
									</div>
								</div>
							</c:forEach>
					</c:if> 
				</div>
				</div>
			</c:forEach>
			
		</div>
		
		 <button type="button" id="btn-save-menu-order" class="btn w-100 btn-primary mt-4">Lưu vị trí</button>
		 
		</form>
	</div>
	
	<div class="col-xl-3">
		<label for="example-select-floating">Chọn thanh điều hướng để sắp xếp</label>
		<div class="form-floating mb-4">
	          <select  class="selectMenu form-select" aria-label="Floating label select example">
	            <option value="${APPURL }/admin/menu.htm">Select an option</option>
	            <option ${ position == "0" ? 'selected' : '' } value="${APPURL }/admin/menu.htm">Header</option>
	            <option ${ position == "1" ? 'selected' : '' } value="${APPURL }/admin/menu.htm?position=1">Footer</a></option>
	          </select>
        </div>
	</div>
</div>
  
   
</div>
  </main>
  
  <c:remove var="successMessage" scope="session" />
  <c:remove var="errorMessage" scope="session" />
  <!-- FOOTER FRAGMENT -->
      <jsp:include page="./fragments/footer.fragment.jsp"/>
      

</div>
		<script src="./public/admin/js/oneui.app.min.js"></script>
		<script src="./public/admin/js/plugins/sortablejs/sortable.min.js"></script>
		<script src="./public/admin/js/plugins/sweetalert2/sweetalert2.min.js"></script>
		<script src="./public/admin/js/lib/jquery.min.js"></script>
		<script src="./public/admin/js/plugins/jquery-validation/jquery.validate.min.js"></script>
		<script src="./public/admin/js/pages/menu.js"></script>
		<script>
			let el = document.getElementById('items');
			
			// tao mang de gom tat ca cac element co class="nested-sortable" vao
			let nestedSortables = [].slice.call(document.querySelectorAll('.nested-sortable'));

			// dung vong lap de duyet qua tat ca cac element nay 
			for (var i = 0; i < nestedSortables.length; i++) {
				new Sortable(nestedSortables[i], {
					group: {
						name: 'nested',
						pull: function (to, from) {
		                    var toLvl = $(to.el).parents('.nested-sortable').length;
		                    console.log(toLvl);
		                    if(toLvl > 1) return false;
		                    return true;
	                    }
					},
					animation: 150,
					fallbackOnBody: true,
					swapThreshold: 0.65,
					invertSwap: true
				});
			}
			
			/*Dieu huong khi chon MENU sap xep*/
			$('.selectMenu').on('change', function(){
				   window.location = $(this).val();
			});
		</script>
  </body>
</html>