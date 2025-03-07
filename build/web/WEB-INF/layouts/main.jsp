<%-- 
    Document   : main
    Created on : Feb 10, 2025, 9:00:56 AM
    Author     : PHT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" scope="session" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <%--header--%>
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg fw-semibold border-bottom border-secondary border-4">
                <div class="container justify-content-center mt-2">
                    <a class="navbar-brand" href="<c:url value="/product/index.do"/>">Zed's</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Men's Clothes
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">Shirts</a></li>
                                    <li><a class="dropdown-item" href="#">Pants</a></li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Women's Clothes
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">Shirts</a></li>
                                    <li><a class="dropdown-item" href="#">Pants</a></li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Unisex
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">Shirts</a></li>
                                    <li><a class="dropdown-item" href="#">Pants</a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value="/product/list.do"/>">View All</a>
                            </li>
                        </ul>


                        <div>
                            <c:if test="${account == null}">
                                <a class="text-primary-emphasis link-underline link-underline-opacity-0 fs-5" href="<c:url value="/account/login.do" />" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
                            </c:if>
                            <c:if test="${account != null}">
                                Welcome ${account.username} |
                                <a class="text-primary-emphasis link-underline link-underline-opacity-0 fs-5 ms-3" href="<c:url value="/cart/index.do" />"><i class="bi bi-cart"></i></a>
                                </c:if>
                        </div>
                    </div>
                </div>
            </nav>
            <div class="row">
                <div class="col-sm-12">
                    <%--content--%>
                    <jsp:include page="/WEB-INF/${controller}/${action}.jsp" />
                </div>
            </div>

            <div class="container-fluid text-center my-4 fw-semibold border-top border-secondary border-4 ">
                <%--footer--%>
                <div class="my-3">
                    Copyrights &copy; by FPT Students
                </div>
            </div>


            <!-- Login Modal -->
            <div class="modal fade" data-bs-backdrop="static" id="loginModal">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">Login</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">
                            <form action="<c:url value="/account/login.do" />">
                                <div class="mb-3">
                                    <label class="form-label">Username</label>
                                    <input type="text" class="form-control" name="username">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Password</label>
                                    <input type="password" class="form-control" name="password">
                                </div>
                                <i class="text-danger">${message}</i>
                                <div class="d-flex justify-content-between">
                                    <a class="btn btn-success" href="<c:url value="/account/register.do" />" data-bs-toggle="modal" data-bs-target="#registerModal">Register</a>
                                    <button type="submit" class="btn btn-success" name="action" value="login">Login</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Register Modal -->
            <div class="modal fade" data-bs-backdrop="static" id="registerModal">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">Register</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">
                            <form action="<c:url value="/account/register.do" />">
                                <div class="mb-3">
                                    <label class="form-label">Username</label>
                                    <input type="text" class="form-control" name="username">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Password</label>
                                    <input type="password" class="form-control" name="password">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">RoleId</label>
                                    <input type="text" class="form-control" name="roleid">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Name</label>
                                    <input type="text" class="form-control" name="name">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Address</label>
                                    <input type="text" class="form-control" name="address">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" class="form-control" name="email">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Phone</label>
                                    <input type="text" class="form-control" name="phone">
                                </div>

                                <i class="text-danger">${message}</i>
                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn-success" name="action" value="register">Register</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${not empty showLoginModal}">
            <script>
                $(document).ready(function () {
                    var loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
                    loginModal.show();
                });
            </script>
        </c:if>
        <c:if test="${not empty showRegisterModal}">
            <script>
                $(document).ready(function () {
                    var registerModal = new bootstrap.Modal(document.getElementById('registerModal'));
                    registerModal.show();
                });
            </script>
        </c:if>
    </body>
</html>





