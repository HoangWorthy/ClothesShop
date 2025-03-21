<%-- 
    Document   : index
    Created on : Mar 8, 2025, 12:16:10 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="mt-5">
    <table  class="table table-secondary border-top border-secondary border-2">
        <div class="text-center">
            <h5 class=" fs-5 fw-semibold me-4">Orders</h5>
        </div>
        <tr>
            <th>No.</th>
            <th>Username</th>
            <th class="text-center">Create's Date</th>
            <th class="text-center">Ship Address</th>
            <th class="text-center">Status</th>
            <th class="text-center">Actions</th>

        </tr>
        <c:forEach var="order" items="${orders}" varStatus="loop">
            <tr>
                <td>${loop.count}</td>
                <td>${order.accountId}</td>
                <td class="text-center">${order.date}</td>
                <td class="text-center">${order.shipToAddress}</td>
                <td class="text-center">
                    <form id="status-form-${order.id}" action="<c:url value='/order/changeStatus.do'/>" method="POST">
                        <input type="hidden" name="id" value="${order.id}">
                        <input type="hidden" name="status" id="status-input-${order.id}" value="${order.status}">
                        <div class="dropdown">
                            <span id="order-status-${order.id}">${order.status}</span>
                            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"></a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#" onclick="changeStatus(${order.id}, 'New', event)">New</a></li>
                                <li><a class="dropdown-item" href="#" onclick="changeStatus(${order.id}, 'Ongoing', event)">Ongoing</a></li>
                                <li><a class="dropdown-item" href="#" onclick="changeStatus(${order.id}, 'Completed', event)">Completed</a></li>
                                <li><a class="dropdown-item" href="#" onclick="changeStatus(${order.id}, 'Cancel', event)">Cancel</a></li>
                            </ul>
                        </div>
                    </form>
                </td>
                <td class="text-center">
                    <a class="text-primary-emphasis link-underline link-underline-opacity-0 ms-3" href="<c:url value='/order/selectDetailAdmin.do?orderHeaderId=${order.id}'/>">View</a>
                </td>
            </tr>
        </c:forEach>

    </table>
</div>

<div class="mt-5">
    <table class="table table-striped border-top border-secondary border-2">
        <div class="text-center">
            <h5 class="fs-5 fw-semibold me-4">Order Details</h5>
        </div>
        <tr>
            <th>No.</th>
            <th>Product ID</th>
            <th>Description</th>
            <th class="text-center">Unit Price</th>
            <th class="text-center">Quantity</th>
            <th class="text-center">Total Price</th>
        </tr>
        <c:forEach var="detail" items="${list}" varStatus="loop">
            <tr>
                <td>${loop.count}</td>
                <td><img src="<c:url value="/pics/products/${detail.productId.id}.jpg" />" height="80px" /></td>
                <td>${detail.productId.description}</td>
                <td class="text-center"><fmt:formatNumber value="${detail.newPrice}" type="currency" /></td>
                <td class="text-center">${detail.quantity}</td>
                <td class="text-center"><fmt:formatNumber value="${detail.newTotal}" type="currency" /></td>
            </tr>
        </c:forEach>
    </table>
</div>


<script>
    function changeStatus(orderId, newStatus, event) {
        event.preventDefault(); // Prevents the default link action

        // Update the hidden input field with the new status
        document.getElementById('status-input-' + orderId).value = newStatus;

        // Submit the form automatically
        document.getElementById('status-form-' + orderId).submit();
    }
</script>
