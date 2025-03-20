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
        <h5 class="me-4">Products</h5>
        <a class="text-success-emphasis link-dark link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover" href="<c:url value="/product/add.do"/>" data-bs-toggle="modal" data-bs-target="#addProductModal">Create</a>

    </div>
    <tr>
        <th class="text-center">No.</th>
        <th class="text-center">Image</th>
        <th class="text-center">Description</th>
        <th class="text-center">Unit Price</th>
        <th class="text-center">Discount</th>
        <th class="text-center">Discounted Price</th>
        <th class="text-center">Status</th>
        <th class="text-center">Actions</th>
    </tr>
    <c:forEach var="product" items="${products}" varStatus="loop">
        <tr>
            <td class="text-center">${loop.count}</td>
            <td class="text-center"><img src="<c:url value='/pics/products/${product.id}.jpg' />" height="80px" /></td>
            <td class="text-center">${product.description}</td>
            <td class="text-center">
                <fmt:formatNumber value="${product.price}" type="currency" />
            </td>
            <td class="text-center">
                <fmt:formatNumber value="${product.discount}" type="percent" />
            </td>
            <td class="text-center">
                <fmt:formatNumber value="${product.newPrice}" type="currency" />
            </td>
            <td class="text-center">
                ${product.status == true ? "Available" : "Unavailable"}
            </td>
            <td class="text-center">
                <!-- Add product details as data attributes -->
                <a class="text-secondary-emphasis link-underline link-underline-opacity-0 ms-3"
                   href="<c:url value="/product/update.do" />" 
                   data-bs-toggle="modal" 
                   data-bs-target="#updateProductModal"
                   data-id="${product.id}"
                   data-description="${product.description}"
                   data-price="${product.price}"
                   data-discount="${product.discount}"
                   data-category="${product.categoryId}"
                   onclick="populateModal(this)">Edit
                </a>
                <a class="text-danger link-underline link-underline-opacity-0 ms-3" 
                   href="<c:url value='/product/${product.status==true ? "delete":"active"}.do?id=${product.id}'/>"
                   onclick="return confirm('Are you sure you want to ${product.status==true ? "delete":"active"} this product?');">
                   ${product.status==true ? "Delete":"Active"}
                </a>
            </td>
        </tr>
    </c:forEach>
</table>

<!-- Update Modal -->
<div class="modal fade" data-bs-backdrop="static" id="updateProductModal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Update Product</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <form action="<c:url value='/product/update.do' />" method="POST">
                    <input type="hidden" id="modal-product-id" name="id">

                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <input type="text" id="modal-description" class="form-control" name="description">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Price</label>
                        <input type="number" step="0.01" id="modal-price" class="form-control" name="price">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Discount</label>
                        <input type="number" step="0.01" id="modal-discount" class="form-control" name="discount">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Category ID</label>
                        <input type="number" id="modal-category" class="form-control" name="categoryId">
                    </div>

                    <i class="text-danger">${message}</i>
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-success">Update</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<!-- Create Modal -->
<div class="modal fade" data-bs-backdrop="static" id="addProductModal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Add Product</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <form action="<c:url value='/product/add.do' />" method="POST">

                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <input type="text" id="modal-description" class="form-control" name="description" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Price</label>
                        <input type="number" id="modal-price" class="form-control" name="price" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Discount</label>
                        <input type="number" id="modal-discount" class="form-control" name="discount" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <select class="form-select" aria-label="Default select example" name="category">
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <i class="text-danger">${message}</i>
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">Next</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<!-- Product Picture Upload Modal -->
<div class="modal fade" data-bs-backdrop="static" id="addProductPictureModal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Product Picture</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <form action="<c:url value='/product/addPicture.do' />" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label">Product Picture</label>
                        <input type="file" id="modal-category" class="form-control" name="picture" required>
                    </div>
                    <i class="text-danger">${message}</i>
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">Add</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>


<c:if test="${not empty showUpdateProductModal}">
    <script>
        $(document).ready(function () {
            var updateProductModal = new bootstrap.Modal(document.getElementById('updateProductModal'));
            updateProductModal.show();
        });
    </script>
</c:if>
<c:if test="${not empty showAddProductPictureModal}">
    <script>
        $(document).ready(function () {
            var addProductPictureModal = new bootstrap.Modal(document.getElementById('addProductPictureModal'));
            addProductPictureModal.show();
        });
    </script>
</c:if>
<c:if test="${not empty showAddProductModal}">
    <script>
        $(document).ready(function () {
            var addProductModal = new bootstrap.Modal(document.getElementById('addProductModal'));
            addProductModal.show();
        });
    </script>
</c:if>

<script>
    function populateModal(element) {
        // Get data from the clicked link
        const productId = element.getAttribute("data-id");
        const description = element.getAttribute("data-description");
        const price = element.getAttribute("data-price");
        const discount = element.getAttribute("data-discount");
        const categoryId = element.getAttribute("data-category");

        // Set modal input fields
        document.getElementById("modal-product-id").value = productId;
        document.getElementById("modal-description").value = description;
        document.getElementById("modal-price").value = price;
        document.getElementById("modal-discount").value = discount;
        document.getElementById("modal-category").value = categoryId;
    }
</script>

