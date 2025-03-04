<%-- 
    Document   : index
    Created on : Feb 24, 2025, 9:05:17 AM
    Author     : PHT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table class="table table-striped">
    <tr>
        <th>No.</th>
        <th>Image</th>
        <th>Id</th>
        <th>Description</th>
        <th style="text-align: right;">Old Price</th>
        <th style="text-align: right;">New Price</th>
        <th style="text-align: right;">Quantity</th>
        <th style="text-align: right;">Cost</th>
        <th>Operations</th>
    </tr>
    <c:forEach var="item" items="${cart.items}" varStatus="loop" >
        <tr>
            <td>${loop.count}</td>
            <td><img src="<c:url value="/products/${item.id}.jpg" />" height="80px" /></td>
            <td>${item.id}</td>
            <td>${item.product.description}</td>
            <td style="text-align: right;">
                <fmt:formatNumber value="${item.product.price}" type="currency" />
            </td>
            <td style="text-align: right;">
                <fmt:formatNumber value="${item.product.newPrice}" type="currency" />
            </td>
            <td style="text-align: right;">
                <input type="number" name="quantity" id="quantity" value="${item.quantity}" style="width:60px;" />
            </td>
            <td style="text-align: right;">
                <fmt:formatNumber value="${item.cost}" type="currency" />
            </td>
            <td>
                <a href="#" id="lnkUpdate" >Update</a> | 
                <a href="<c:url value="/cart/remove.do?id=${item.id}" />">Remove</a>
            </td>
        </tr>
    </c:forEach>
    <tr>
        <th style="text-align: right;" colspan="7">Total</th>
        <th style="text-align: right;">
            <fmt:formatNumber value="${cart.total}" type="currency" />                
        </th>
        <th>
            <a href="<c:url value="/cart/empty.do" />">Empty Cart</a>
        </th>
    </tr>
</table>
<script>
    $("#lnkUpdate").click(function(){
        alert($("#quantity").val())
    })
</script>