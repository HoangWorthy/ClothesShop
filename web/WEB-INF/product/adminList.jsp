<%-- 
    Document   : ADMINlist
    Created on : Mar 8, 2025, 1:07:09 PM
    Author     : PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container text-center mt-4 fw-bold mb-3">
    <div class="row justify-content-between">
        <div class="col-4 bg-body-secondary">
            Total Users:
            <div class="text-center fs-5">
                ${totalAccounts}
            </div>
        </div>
        <div class="col-4 bg-body-secondary">
            Total Products:
            <div class="text-center fs-5">
                ${totalProducts}
            </div>
        </div>
    </div>
</div>

<table class="table table-secondary mb-5">
    <div class="d-flex">
        <h5 class=" me-4">Users</h5>
        <a class="text-primary-emphasis link-dark link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover" href="<c:url value="/product/userList.do"/>">View All</a>
    </div>
    <tr>
        <th>No.</th>
        <th>Username</th>
        <th>Name</th>
        <th>Address</th>
        <th class="text-center">Email</th>
        <th class="text-center">Phone</th>
    </tr>
    <c:forEach var="acc" items="${topAccounts}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>${acc.username}</td>
            <td>${acc.name}</td>
            <td>${acc.address}</td>
            <td class="text-center">
                ${acc.email}
            </td>
            <td class="text-center">
                ${acc.phone}
            </td>
        </tr>
    </c:forEach>
</table>

<table class="table table-secondary">
    <div class="d-flex">
        <h5 class=" me-4">Products</h5>
        <a class="text-primary-emphasis link-dark link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover" href="<c:url value="/product/productList.do"/>">View All</a>
    </div>
    <tr>
        <th>No.</th>
        <th>Image</th>
        <th>Description</th>
        <th class="text-center">Unit Price</th>
        <th class="text-center">Discount</th>
        <th class="text-center">Discounted Price</th>
    </tr>
    <c:forEach var="product" items="${topProducts}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td><img src="<c:url value="/pics/products/${product.id}.jpg" />" height="80px" /></td>
            <td>${product.description}</td>
            <td class="text-center">
                <fmt:formatNumber value="${product.price}" type="currency" />
            </td>
            <td class="text-center">
                <fmt:formatNumber value="${product.discount}" type="percent" />
            </td>
            <td class="text-center">
                <fmt:formatNumber value="${product.newPrice}" type="currency" />
            </td>
        </tr>
    </c:forEach>
</table>

<table class="table table-secondary mb-5">
    <div class="d-flex">
        <h5 class=" me-4">Carts</h5>
        <a class="text-primary-emphasis link-dark link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover" href="<c:url value="/product/cartList.do"/>">View All</a>
    </div>
    <tr>
        <th>No.</th>
        <th>Username</th>
        <th>Product's Description</th>
        <th>Quantity</th>
    </tr>
    <c:forEach var="cart" items="${topCarts}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>${cart.accountId}</td>
            <td>${cart.product.description}</td>
            <td>${cart.quantity}</td>
        </tr>
    </c:forEach>
</table>