<%-- 
    Document   : index
    Created on : Feb 17, 2025, 9:08:03 AM
    Author     : PHT
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--Carousel-->
<div id="carouselExample" class="carousel slide">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="<c:url value="/pics/advertise/1.jpg" />" class="d-block w-100 h-100">
            <div class="carousel-caption d-none d-md-block">
                <a class="btn btn-dark btn-lg" href="<c:url value="/product/list.do"/>" role="button">Explore Now</a>
            </div>

        </div>
        <div class="carousel-item">
            <img src="<c:url value="/pics/advertise/2.jpg" />" class="d-block w-100 h-100">
            <div class="carousel-caption d-none d-md-block">
                <a class="btn btn-dark btn-lg" href="<c:url value="/product/list.do"/>" role="button">Explore Now</a>
            </div>
        </div>
        <div class="carousel-item">
            <img src="<c:url value="/pics/advertise/3.jpg" />" class="d-block w-100 h-100">
            <div class="carousel-caption d-none d-md-block">
                <a class="btn btn-dark btn-lg" href="<c:url value="/product/list.do"/>" role="button">Explore Now</a>
            </div>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>
<!--Best Seller-->
<div class="container text-center mt-4 fw-bold">
    <div>
        <div>
            <h1 class="best-seller-title">BEST SELLER</h1>
        </div>
        <div class="row row-cols-md-4">
            <c:forEach var="product" items="${top}">
                <div class="col my-3">
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

    <div class="container text-center mt-4 fw-bold">
        <div>
            <div>
                <h1 class="best-seller-title">About Us</h1>
            </div>
            <div class="position-relative mx-auto border border-secondary border-4 rounded" style="width: 640px; height: 440px;">
                <img src="<c:url value='/advertise/AboutUs.jpg' />" class="img-fluid w-100 h-100">
                <a href="<c:url value='/product/list.do' />" class="btn btn-secondary position-absolute" 
                   style="top: 90%; left: 50%; transform: translate(-50%, -50%);">Click Here</a>
            </div>
        </div>
    </div>


</div>
