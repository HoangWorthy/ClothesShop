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
                    <div class="d-flex">
                        <input class="form-control me-4" type="search" placeholder="Search" aria-label="Search" name="search" value="${param.search}">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </div>
                    <div class="container">
                        <div class="form-check my-2" onclick="submitForm()">
                            <input class="form-check-input" type="radio" name="filter" value="lowestPrice" id="flexRadioDefault2" ${lowestPrice}>
                            <label class="form-check-label" for="flexRadioDefault2">Lowest Price</label>
                        </div>
                        <div class="form-check my-2" onclick="submitForm()">
                            <input class="form-check-input" type="radio" name="filter" value="highestPrice" id="flexRadioDefault3" ${highestPrice}>
                            <label class="form-check-label" for="flexRadioDefault3">Highest Price</label>
                        </div>
                        <div class="form-check my-2" onchange="submitForm()">
                            <label class=   "form-check-label" for="flexRadioDefault3">Category</label><br>
                            <select name="category" onchange="submitForm()">
                                <c:if test="${categoryFilter==null}">
                                    <option value="skip">Choose category</option>
                                </c:if>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}" ${(category.id == categoryFilter)?"selected":""}>${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <br>
                    </div>
                </form>
                <a href="<c:url value="/product/list.do"/>"><button>Clear Filter</button></a>
            </div>
        </div>
        <div class="col-md-10">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">
                <c:forEach var="product" items="${list}">
                    <div class="col">
                        <div class="card border border-secondary border-4 h-100">
                            <img src="<c:url value="/pics/products/${product.id}.jpg" />" class="card-img-top" style="width: 100%; height: 60%;">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title fw-semibold">${product.description}</h5>
                                <h6 class="card-title text-danger fw-semibold">
                                    <fmt:formatNumber value="${product.newPrice}" type="currency" /> | 
                                    <fmt:formatNumber value="-${product.discount}" type="percent" />
                                </h6>
                                <div class="mt-auto d-grid gap-2">
                                    <a href="" class="btn btn-secondary">View</a>
                                    <a href="<c:url value="/cart/add.do?productId=${product.id}&quantity=1"/>" class="btn btn-secondary"><i class="bi bi-cart-plus"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="row">
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


