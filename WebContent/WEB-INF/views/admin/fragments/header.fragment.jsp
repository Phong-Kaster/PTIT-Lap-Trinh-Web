<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<header id="page-header">
  <div class="content-header">
    <div class="d-flex align-items-center">
      <button type="button" class="btn btn-sm btn-alt-secondary me-2 d-lg-none" data-toggle="layout" data-action="sidebar_toggle">
        <i class="fa fa-fw fa-bars"></i>
      </button>
      <button type="button" class="btn btn-sm btn-alt-secondary me-2 d-none d-lg-inline-block" data-toggle="layout" data-action="sidebar_mini_toggle">
        <i class="fa fa-fw fa-ellipsis-v"></i>
      </button>
    </div>
    <div class="d-flex align-items-center">
      <div class="dropdown d-inline-block ms-2">
        <button type="button" class="btn btn-sm btn-alt-secondary d-flex align-items-center" id="page-header-user-dropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <img class="rounded-circle" src="${AuthUser.avatar }" alt="Header Avatar" style="width: 21px;">
          <span class="d-none d-sm-inline-block ms-2">${AuthUser.lastname }</span>
          <i class="fa fa-fw fa-angle-down d-none d-sm-inline-block opacity-50 ms-1 mt-1"></i>
        </button>
        <div class="dropdown-menu dropdown-menu-md dropdown-menu-end p-0 border-0" aria-labelledby="page-header-user-dropdown">
          <div class="p-3 text-center bg-body-light border-bottom rounded-top">
            <img class="img-avatar img-avatar48 img-avatar-thumb" src="${AuthUser.avatar }" alt="">
            <p class="mt-2 mb-0 fw-medium">${AuthUser.firstname } ${AuthUser.lastname }</p>
            <p class="mb-0 text-muted fs-sm fw-medium">${AuthUser.account_type } </p>
          </div>
          <div class="p-2">
            <a class="dropdown-item d-flex align-items-center justify-content-between" href="${ ADMINURL }/profile.htm">
              <span class="fs-sm fw-medium">Hồ sơ</span>
            </a>
            <c:if test="${ AuthUser.account_type == 'ADMIN' }"> 
	            <a class="dropdown-item d-flex align-items-center justify-content-between" href="${ ADMINURL }/settings/site.htm">
	              <span class="fs-sm fw-medium">Cài đặt</span>
	            </a>
            </c:if>
          </div>
          <div role="separator" class="dropdown-divider m-0"></div>
          <div class="p-2">
            <a class="dropdown-item d-flex align-items-center justify-content-between" href="${ APPURL }/logout.htm">
              <span class="fs-sm fw-medium">Đăng xuất</span>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div id="page-header-loader" class="overlay-header bg-body-extra-light">
    <div class="content-header">
      <div class="w-100 text-center">
        <i class="fa fa-fw fa-circle-notch fa-spin"></i>
      </div>
    </div>
  </div>
</header>