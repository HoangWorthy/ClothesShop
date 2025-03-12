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
            <div class="row">
                <div class="col-md-2 fs-5 border-end border-1 pt-4" style="position: sticky; top: 0; height: 100vh; overflow-y: auto;">
                    <div class="text-center">
                        <a href="<c:url value="/product/adminList.do"/>" class="text-primary-emphasis link-underline link-underline-opacity-0 fs-5 fw-semibold">Overview</a>
                    </div>
                    <hr/>
                    <!--1 la nhu nay-->
                    <div class="my-3">
                        <h6 class="fs-5 fw-semibold">Table</h6>
                        <div class="list-group list-group-flush list-group-item-light">
                            <a href="<c:url value="/product/userList.do" />" class="list-group-item list-group-item-action">Users</a>
                            <a href="<c:url value="/product/productList.do" />" class="list-group-item list-group-item-action">Products</a>
                            <a href="<c:url value="/order/ADMINlist.do" />" class="list-group-item list-group-item-action">Orders</a>
                        </div>
                    </div>
                    <div class="my-3">
                        <h6 class="fs-5 fw-semibold">Pages</h6>
                        <div class="list-group list-group-flush list-group-item-light">
                            <a href="<c:url value="/product/index.do" />" class="list-group-item list-group-item-action">User's Index</a>
                            <a href="<c:url value="/product/list.do" />" class="list-group-item list-group-item-action">Products List</a>
                            <a href="<c:url value="/cart/index.do" />" class="list-group-item list-group-item-action">User's Cart</a>
                            <a href="<c:url value="/account/logout.do" />" class="list-group-item list-group-item-action">Logout</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <nav class="navbar navbar-expand-lg fw-semibold border-bottom border-secondary border-4">
                        <div class="container justify-content-between mt-2">
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <a class="navbar-brand" href="<c:url value="/product/index.do"/>">Zed's</a>
                            <div>
                                <c:if test="${account.roleId == 'AD'}">
                                    Welcome ${account.username}
                                </c:if>
                                <c:if test="${account.roleId != 'AD'}">
                                    <a class="text-primary-emphasis link-underline link-underline-opacity-0 fs-5" href="<c:url value="/account/login.do" />" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
                                </c:if>
                            </div>
                        </div>
                    </nav>
                    <div class="row">
                        <div class="col-sm-12">
                            <%--content--%>
                            <jsp:include page="/WEB-INF/${controller}/${action}.jsp" />
                        </div>
                    </div>
                </div>

            </div>

            <div class="container-fluid text-center my-4 fw-semibold border-top border-secondary border-4 ">
                <%--footer--%>
                <div class="my-3">
                    Copyrights &copy; by FPT Students
                </div>
            </div>
        </div>
    </body>