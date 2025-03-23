<%-- 
    Document   : ADMINlist
    Created on : Mar 8, 2025, 1:07:09 PM
    Author     : PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>

<%
    // Get revenue data from request
    List<Double> revenueLast7Days = (List<Double>) request.getAttribute("revenueLast7Days");
    if (revenueLast7Days == null) {
        revenueLast7Days = java.util.Arrays.asList(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); // Default 7 values
    }
    String selectedDate = (String) request.getAttribute("selectedDate");

    // Generate labels for the last 7 days
    LocalDate selectedLocalDate = (selectedDate != null) ? LocalDate.parse(selectedDate) : LocalDate.now();
%>



<!-- Date Picker for Selecting Date -->


<!-- Canvas for Chart -->

<!-- Include Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const ctx = document.getElementById('revenueChart').getContext('2d');

        // Labels for last 7 days
        const labels = [
    <% for (int i = 6; i >= 0; i--) {%>
            "<%= selectedLocalDate.minusDays(i)%>",
    <% } %>
        ];

        // Revenue Data for the last 7 days
        const revenueData = [
    <% for (Double revenue : revenueLast7Days) {%>
    <%= revenue%>,
    <% }%>
        ];

        // Create the chart
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                        label: 'Revenue ($)',
                        data: revenueData,
                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    });
</script>




<h1 class="text-center">DashBoard</h1>
<hr>

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
<br>
<div class="container text-center mt-4 fw-bold mb-2">
    <form action="<c:url value='/admin/revenue.do'/>">
        <input type="date" class="form-control" name="date" value="<%= selectedDate%>" onchange="this.form.submit()">
    </form>
</div>
<div class="container text-center mt-4 fw-bold mb-3">
    <div class="row justify-content-between">
        <div class="col-3 bg-body-secondary">
            Day:
            <div class="text-center fs-5">
                <fmt:formatNumber value="${revenueADay}" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" />
            </div>
        </div>
        <div class="col-3 bg-body-secondary">
            Month:
            <div class="text-center fs-5">
                <fmt:formatNumber value="${revenueAMonth}" type="currency" minFractionDigits="2" maxFractionDigits="2" />
            </div>
        </div>
        <div class="col-3 bg-body-secondary">
            Year:
            <div class="text-center fs-5">
                <fmt:formatNumber value="${revenueAYear}" type="currency" minFractionDigits="2" maxFractionDigits="2" />

            </div>
        </div>
    </div>
</div>
<canvas id="revenueChart" width="300" height="100"></canvas>


<br>

<table class="table table-secondary mb-5">
    <div class="d-flex">
        <h5 class=" me-4">Users</h5>
        <a class="text-primary-emphasis link-dark link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover" href="<c:url value="/admin/productList.do"/>">View All</a>
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
        <a class="text-primary-emphasis link-dark link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover" href="<c:url value="/admin/productList.do"/>">View All</a>
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
        <h5 class=" me-4">Orders</h5>
        <a class="text-primary-emphasis link-dark link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover" href="<c:url value="/admin/orderList.do"/>">View All</a>
    </div>
    <tr>
        <th>No.</th>
        <th>Username</th>
        <th>Create's Date</th>
        <th>Ship Address</th>
        <th>Status</th>
    </tr>
    <c:forEach var="order" items="${topOrders}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>${order.accountId}</td>
            <td>${order.date}</td>
            <td>${order.shipToAddress}</td>
            <td>${order.status}</td>
        </tr>
    </c:forEach>
</table>

<!--<script>
    function submitForm() {
        document.getElementById("dateForm").submit();
    }
</script>-->
