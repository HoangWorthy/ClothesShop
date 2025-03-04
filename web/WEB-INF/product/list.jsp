<%-- 
    Document   : index
    Created on : Feb 17, 2025, 9:08:03 AM
    Author     : PHT
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--<div class="container text-center mt-4 fw-bold">-->
    <div>
        <div>
            <h1 class="best-seller-title">BEST SELLER</h1>
        </div>
        <div class="row row-cols-md-5">
            <c:forEach var="product" items="${list}">
                <div class="col ms-auto my-3">
                    <div class="card border border-secondary border-4" style="width: 18rem;">
                        <img src="<c:url value="/products/${product.id}.jpg" />" width="286px" height="382px"  class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title fw-semibold">${product.description}</h5>
                            <h6 class="card-title text-danger fw-semibold"><fmt:formatNumber value="${product.newPrice}" type="currency" /> | <fmt:formatNumber value="-${product.discount}" type="percent" /></h6>
                            <div class="d-grid gap-2 d-md-flex justify-content-center">
                                <a href="" class="btn btn-secondary">View</a>
                                <a href="<c:url value="/cart/add.do?id=${product.id}&quantity=1"/>" class="btn btn-secondary"><i class="bi bi-cart-plus"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    <!--</div>-->
<div class="row">
    <div class="col-sm-12">  
        <div style="float:right;">
            <a href="<c:url value="/product/list.do?page=1" />" class="btn btn-primary ${page==1?"disabled":""}" title="First"><i class="bi bi-caret-left"></i></a>
            <a href="<c:url value="/product/list.do?page=${page-1}" />" class="btn btn-primary ${page==1?"disabled":""}" title="Previous"><i class="bi bi-caret-left-fill"></i></a>
            <a href="<c:url value="/product/list.do?page=${page+1}" />" class="btn btn-primary ${page==total_page?"disabled":""}" title="Next"><i class="bi bi-caret-right-fill"></i></a>
            <a href="<c:url value="/product/list.do?page=${total_page}" />" class="btn btn-primary ${page==total_page?"disabled":""}" title="Last"><i class="bi bi-caret-right"></i></a>
            Page ${page}/${total_page}
        </div>
    </div>
</div>
        
        <!--        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <h1><a class="text-primary-emphasis" href="<c:url value="/" />" style="text-decoration: none;">Clothes Shop</a></h1>
                    <p class="float-end">
                        <a class="text-primary-emphasis" href="<c:url value="/account/create.do" />" data-bs-toggle="modal" data-bs-target="#createModal">Create</a>  |  
                        <a class="text-primary-emphasis" href="<c:url value="/account/login.do" />" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>  |  
                        <a class="text-primary-emphasis" href="<c:url value="/cart/index.do" />">
                            <c:if test="${cart.total==0}">
                                <i class="bi bi-cart"></i>
                            </c:if>
                            <c:if test="${cart.total!=0}">
                                <i class="bi bi-cart-fill"></i>
                            </c:if>
                            <fmt:formatNumber value="${cart.total}" type="currency" />
                        </a>
                    </p>
                    <br/>
                    <hr/>
                </div>
            </div>-->