<%-- 
    Document   : products
    Created on : Mar 9, 2025, 8:33:14 PM
    Author     : Nguyen Anh Khoi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="table table-secondary">
    <div class="d-flex">
        <h5 class=" me-4">Products</h5>
    </div>
    <tr>
        <th>No.</th>
        <th>Image</th>
        <th>Description</th>
        <th class="text-center">Unit Price</th>
        <th class="text-center">Discount</th>
        <th class="text-center">Discounted Price</th>

    </tr>
    <c:forEach var="product" items="${products}" varStatus="loop">
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
