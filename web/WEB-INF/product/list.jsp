<%-- 
    Document   : index
    Created on : Feb 17, 2025, 9:08:03 AM
    Author     : PHT
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 fw-normal fs-5" style="position: sticky; top: 0; height: 100vh; overflow-y: auto;">
            <div>
                <h4> <span><img style="width: 50px; height: 50px" src="<c:url value="/pics/sortBy/sort.PNG"/>" /></span>Sort by</h4>
                <form action="<c:url value="/product/list.do"/>" method="get" id="sortForm">
                    <div class="d-flex ">
                        <input class="form-control me-4" type="search" placeholder="Search" aria-label="Search" name="search" value="${param.search}">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </div>
                    <hr>
                    <div class="container">
                        <div class="form-check my-2" onclick="submitForm()">
                            <input class="form-check-input" type="radio" name="filter" value="lowestPrice" id="flexRadioDefault2" ${lowestPrice}>
                            <label class="form-check-label" for="flexRadioDefault2">Lowest Price</label>
                        </div>
                        <div class="form-check my-2" onclick="submitForm()">
                            <input class="form-check-input" type="radio" name="filter" value="highestPrice" id="flexRadioDefault3" ${highestPrice}>
                            <label class="form-check-label" for="flexRadioDefault3">Highest Price</label>
                        </div>
                        <hr>
                        <div class="me-5 my-3">
                            <select name="category" class="form-select" onchange="submitForm()">
                                <option value="" ${empty categoryFilter ? 'selected' : ''}>Category</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}" ${(category.id == categoryFilter) ? "selected" : ""}>${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <hr>
                    </div>
                </form>
                <a class="btn btn-outline-danger d-flex p-2 fw-semibold justify-content-center" role="button" href="<c:url value="/product/list.do"/>">Reset All Filters</a>
            </div>
        </div>
        <div class="col-md-10 mt-3">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">
                <c:forEach var="product" items="${list}">
                    <div class="col">
                        <div class="card border border-secondary border-4 h-100">
                            <img src="<c:url value='/pics/products/${product.id}.jpg?v=<%= System.currentTimeMillis() %>'/>" class="card-img-top" style="width: 100%; height: 60%;">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title fw-semibold">${product.description}</h5>
                                <h6 class="card-title text-danger fw-semibold">
                                    <fmt:formatNumber value="${product.newPrice}" type="currency" /> | 
                                    <fmt:formatNumber value="-${product.discount}" type="percent" />
                                </h6>
                                <div class="mt-auto d-grid gap-2">
                                    <a href="<c:url value="/cart/add.do?productId=${product.id}&quantity=1"/>" class="btn btn-secondary"><i class="bi bi-cart-plus"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col-md-2"></div>
        <div class="col-md-10 text-center">
            <a href="<c:url value='/product/list.do?page=1&search=${search}&filter=${filter}&category=${categoryFilter}' />" class="btn btn-dark ${page==1?'disabled':''}"><i class="bi bi-caret-left"></i></a>
            <a href="<c:url value='/product/list.do?page=${page-1}&search=${search}&filter=${filter}&category=${categoryFilter}' />" class="btn btn-secondary ${page==1?'disabled':''}"><i class="bi bi-caret-left-fill"></i></a>
            <a href="<c:url value='/product/list.do?page=${page+1}&search=${search}&filter=${filter}&category=${categoryFilter}' />" class="btn btn-secondary ${page==total_page?'disabled':''}"><i class="bi bi-caret-right-fill"></i></a>
            <a href="<c:url value='/product/list.do?page=${total_page}&search=${search}&filter=${filter}&category=${categoryFilter}' />" class="btn btn-dark ${page==total_page?'disabled':''}"><i class="bi bi-caret-right"></i></a>
            Page ${page}/${total_page}
        </div>
    </div>
</div>
<script>
    function submitForm() {
        document.getElementById("sortForm").submit();
    }
</script>


