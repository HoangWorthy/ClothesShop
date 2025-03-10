<%-- 
    Document   : index
    Created on : Mar 9, 2025, 5:49:26 PM
    Author     : Nguyen Anh Khoi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="table table-secondary mb-5">
    <div class="text-center">
        <h5 class=" fs-5 fw-semibold me-4">Users</h5>
    </div>
    <tr>
        <th>No.</th>
        <th>Name</th>
        <th>Address</th>
        <th class="text-center">Email</th>
        <th class="text-center">Phone</th>
    </tr>
    <c:forEach var="acc" items="${accounts}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
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