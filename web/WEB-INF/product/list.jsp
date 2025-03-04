<%-- 
    Document   : index
    Created on : Feb 17, 2025, 9:08:03 AM
    Author     : PHT
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--<div class="container text-center mt-4 fw-bold">-->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 fw-normal fs-5" style="position: sticky; top: 0; height: 100vh; overflow-y: auto;">
            <h4> <span><img style="width: 50px; height: 50px" src="<c:url value="/pics/sortBy/sort.PNG"/>" /></span>Sort by</h4>
            <form action="#" method="post">
                <div class="d-flex">
                    <input class="form-control me-4" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </div>
                <div class="container">
                    <div class="form-check my-2">
                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
                        <label class="form-check-label" for="flexRadioDefault1">Best Price</label>
                    </div>
                    <div class="form-check my-2">
                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
                        <label class="form-check-label" for="flexRadioDefault2">Lowest Price</label>
                    </div>
                    <div class="form-check my-2">
                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault3">
                        <label class="form-check-label" for="flexRadioDefault3">Highest Price</label>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-10 row row-cols-md-5 text-center">
            <c:forEach var="product" items="${list}">
                <div class="col ms-auto my-3">
                    <div class="card border border-secondary border-4" style="width: 18rem;">
                        <img src="<c:url value="/pics/products/${product.id}.jpg" />" width="286px" height="382px"  class="card-img-top">
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
    </div>
            <div class="container-fluid text-center" style="margin-left: 190px">
<!--        <div style="">-->
            <a href="<c:url value="/product/list.do?page=1" />" class="btn btn-dark ${page==1?"disabled":""}" title="First"><i class="bi bi-caret-left"></i></a>
            <a href="<c:url value="/product/list.do?page=${page-1}" />" class="btn btn-secondary ${page==1?"disabled":""}" title="Previous"><i class="bi bi-caret-left-fill"></i></a>
            <a href="<c:url value="/product/list.do?page=${page+1}" />" class="btn btn-secondary ${page==total_page?"disabled":""}" title="Next"><i class="bi bi-caret-right-fill"></i></a>
            <a href="<c:url value="/product/list.do?page=${total_page}" />" class="btn btn-dark ${page==total_page?"disabled":""}" title="Last"><i class="bi bi-caret-right"></i></a>
            Page ${page}/${total_page}
        <!--</div>-->
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