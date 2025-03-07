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
        <th>Description</th>
        <th class="text-center">Unit Price</th>
        <th class="text-center">Quantity</th>
        <th class="text-center">Total Price</th>
        <th class="text-center">Actions</th>
    </tr>
    <c:forEach var="item" items="${carts}" varStatus="loop" >
        <tr>
            <td>${loop.count}</td>
            <td><img src="<c:url value="/pics/products/${item.productId}.jpg" />" height="80px" /></td>
            <td>${item.product.description}</td>

            <td class="text-center">
                <span class="text-decoration-line-through"><fmt:formatNumber value="${item.product.price}" type="currency" /></span> | <fmt:formatNumber value="${item.product.newPrice}" type="currency" />
            </td>
            <td class="text-center">
                <div class="btn-group" role="group" aria-label="Basic example">
                    <form action="<c:url value='/cart/update.do'/>" method="post" class="d-flex align-items-center">
                        <input type="hidden" name="productId" value="${item.productId}"/>
                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changeQuantity(-1, ${item.productId})">-</button>
                        <input type="number" min="0" name="quantity" id="quantity_${item.productId}" value="${item.quantity}" style="width:60px;text-align:center;" />
                        <button type="button" class="btn btn-outline-secondary btn-sm   " onclick="changeQuantity(1, ${item.productId})">+</button>
                    </form>
                </div>
            </td>
            <td class="text-center text-danger">
                <fmt:formatNumber value="${item.newTotal}" type="currency" />
            </td>
            <td class="text-center">
                <a href="<c:url value="/cart/remove.do?productId=${item.productId}"/>">Remove</a>
                <a href="<c:url value="/cart/empty.do"/>">Empty Cart</a>
            </td>

        </tr>
    </c:forEach>
</table>










<script>
    function changeQuantity(x, productId) {
        const input = document.getElementById('quantity_' + productId);
        let quantity = parseInt(input.value) + x;

        if (quantity < 0)
            quantity = 0; // Optional guard, if you don't want negatives

        // Update the hidden form field and submit the form
        input.value = quantity;

        // Directly submit the form to update in backend
        const form = input.closest('form');
        form.submit();
    }
</script>
<style>
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
</style>