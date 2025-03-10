<%-- 
    Document   : cartList
    Created on : Mar 9, 2025, 8:34:16 PM
    Author     : Nguyen Anh Khoi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <c:forEach var="cart" items="${carts}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>${cart.accountId}</td>
            <td>${cart.product.description}</td>
            <td>${cart.quantity}</td>
        </tr>
    </c:forEach>
</table>