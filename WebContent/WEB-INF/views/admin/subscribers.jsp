<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Email đăng ký nhận tin - ${ SettingsData.getSite_name() }</title>
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
<div class="bg-body-light">
  <div class="content content-full">
    <div class="d-flex flex-column flex-sm-row justify-content-sm-between align-items-sm-center py-2">
      <div class="flex-grow-1">
        <h1 class="h3 fw-bold mb-0">
          Email đăng ký nhận tin 
        </h1>
      </div>
    </div>
  </div>
</div>
<div class="content">
<div class="sub mb-3 fs-sm">              
		
        
        <c:forEach items="${listSummaryByActive}" var="summary">
			<c:if test="${ summary[0] == 'true' }">
			  		<c:choose>
					    <c:when test="${  param.active == 'true' }">
					    	<a class=" link-fx text-primary-darker" href="${ ADMINURL }/subscribers.htm?active=true">
					    		<strong>Đang hoạt động (${ summary[1] })</strong>
					  		</a>
					    </c:when>    
					    <c:otherwise>
					    	<a class=" link-fx" href="${ ADMINURL }/subscribers.htm?active=true">
					    		Đang hoạt động (${ summary[1] })
					  		</a>
					    </c:otherwise>
					</c:choose>
	            |
            </c:if>
        </c:forEach>
					
					
        <c:forEach items="${listSummaryByActive}" var="summary">
			<c:if test="${ summary[0] == 'false' }">
			  		<c:choose>
					    <c:when test="${ param.active == 'false' }">
					    	<a class=" link-fx text-primary-darker" href="${ ADMINURL }/subscribers.htm?active=false">
					    		<strong>Chặn hoạt động (${ summary[1] })</strong>
					  		</a>
					    </c:when>    
					    <c:otherwise>
					    	<a class=" link-fx" href="${ ADMINURL }/subscribers.htm?active=false">
					    		 Chặn hoạt động (${ summary[1] })
					  		</a>
					    </c:otherwise>
					</c:choose>
            </c:if>
        </c:forEach>
  	
  	</div>
  <div class="block block-rounded">
    <div class="block-header block-header-default">
      
		<div class="row">
			
		</div>
      <div class="block-options">
        <button type="button" class="btn btn-sm btn-alt-secondary" data-toggle="class-toggle" data-target="#one-search" data-class="d-none">
          <i class="fa fa-search"></i>
        </button>
      </div>
    </div>
    <div id="one-search" class="block-content border-bottom d-none">
      <form action="${ADMINURL }/subscribers.htm" method="GET">
        <div class="push">
          <div class="input-group">
            <input type="text" class="form-control form-control-alt" id="search" value="${ param.search }" name="search" placeholder="Tìm email">
            <span class="input-group-text bg-body border-0">
              <i class="fa fa-search"></i>
            </span>
          </div>
        </div>
      </form>
    </div>
    <div class="block-content">
    	<c:if test="${successMessage != null && successMessage.trim().length() > 0 }">
			<div class="alert alert-success alert-dismissible" role="alert">
		     	<p class="mb-0">
		        	${ successMessage }
		     	</p>
		    	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	      	</div>
		</c:if>
      <table class="table table-striped table-borderless table-vcenter">
        <thead class="border-bottom">
          <tr>
            <th class="d-none d-md-table-cell">Email</th>
            <th class="d-none d-md-table-cell" style="width: 250px;">Tình trạng hoạt động</th>
            <th class="d-none d-md-table-cell text-center">Hành động</th>
          </tr>
        </thead>
        <tfoot class="border-bottom">
          <tr>
            <th class="d-none d-md-table-cell">Email</th>
            <th class="d-none d-md-table-cell" style="width: 250px;">Tình trạng hoạt động</th>
            <th class="d-none d-md-table-cell text-center">Hành động</th>
          </tr>
        </tfoot>
        <tbody>
        	<jsp:useBean id="pagedListHolder" scope="request" type="org.springframework.beans.support.PagedListHolder"/>
			<c:url value="${ ADMINURL }/subscribers.htm?search=${ param.search }" var="pagedLink">
				<c:param name="p" value="~" />
			</c:url>
			<c:forEach var="email" items="${ pagedListHolder.pageList }" begin="0" > 			
	          <tr>
	          
	            <td class="d-none d-md-table-cell">
	               <a class="fw-semibold" href="mailto:${ email.email  }">${ email.email  }</a>
	               <p class="fs-sm fw-medium text-muted mb-0">${ email.created_at }</p>
	            </td>
	            <td class="d-none d-md-table-cell">
	               <c:choose>
					    <c:when test="${ email.is_active == 'true' }">
					    	<span class="fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-success-light text-success">Active</span>
					    </c:when>    
					    <c:otherwise>
					        <span class="fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-warning-light text-warning">Suspend</span>
					    </c:otherwise>
					</c:choose>
	            </td>
	            <td class="text-center">
                   <c:choose>
					    <c:when test="${ email.is_active == 'true' }">
					    	 <a class="btn btn-sm btn-alt-danger" href="${ADMINURL }/email_active.htm?email=${email.email}&next=${dataUrl}&active=false" data-bs-toggle="tooltip" title="Delete">
			                    <i class="fa fa-fw fa-times"></i>
			                  </a>
					    </c:when>    
					    <c:otherwise>
					         <a class="btn btn-sm btn-alt-success" href="${ADMINURL }/email_active.htm?email=${email.email}&next=${dataUrl}&active=true" data-bs-toggle="tooltip" title="Active">
			                    <i class="fa fa-fw fa-check"></i>
			                  </a>
					    </c:otherwise>
					</c:choose>
                </td>
	          </tr>
          </c:forEach>
         
        </tbody>
      </table>
       <tg:paging_admin pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}" />
    </div>
  </div>
</div>
  </main>
  <c:remove var="successMessage" scope="session" />
  <c:remove var="errorMessage" scope="session" />
  <!-- FOOTER FRAGMENT -->
      <jsp:include page="./fragments/footer.fragment.jsp"/>
      

</div>
		<script src="./public/admin/js/lib/jquery.min.js"></script>
		<script src="./public/admin/js/oneui.app.min.js"></script>
		<script src="./public/admin/js/plugins/sweetalert2/sweetalert2.min.js"></script>
		<script src="./public/admin/js/pages/user.js"></script>
		<script src="./public/admin/js/pages/core.js"></script>
		<script>
			$( document ).ready(function() {
				
				TimesWriter.CheckAll();
				
			});
		</script>
  </body>
</html>