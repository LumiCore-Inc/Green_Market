
let baseUrl = 'http://localhost:8081/green_market_war_exploded'

let addBtn = document.getElementById('add-btn');
let updateBtn = document.getElementById('update-btn');
updateBtn.style = 'display: none'

let preview = document.getElementById('image-preview');
let noImageText = document.getElementById('no-image-text');

let selectedProductID = 0;

function selectImage(x,y) {
    document.getElementById('image-input').click();
    preview = document.getElementById(y);
    noImageText = document.getElementById(x);
}

function previewImage() {
    const input = document.getElementById('image-input');
    const container = document.getElementById('image-container');

    const file = input.files[0];

    if (file) {
        let promise = uploadImage(file);
        promise.then(value => {
            console.log(value)

            if (value){
                preview.src = value;
                preview.style.display = 'block';
                noImageText.style.display = 'none';
            }else {
                preview.src = '';
                preview.style.display = 'none';
                noImageText.style.display = 'block';
                container.style.border = '2px dashed #ccc';
            }

        })
    } else {
        console.log('No file selected');
    }

}

function uploadImage(file)  {
    return new Promise((resolve, reject) => {
        if (file) {
            var formData = new FormData();
            formData.append('file', file);

            fetch('/green_market_war_exploded/upload', {
                method: 'POST',
                body: formData
            })
                .then(response => response.text())
                .then(data => {
                    resolve(data);
                    // You can perform additional actions or handling here if needed
                })
                .catch(error => {
                    reject(error);
                    console.error('Error uploading image:', error);
                });
        } else {
            reject('No file selected.');
            console.warn('No file selected.');
        }
    });
}

function addProduct() {
    var productName = document.getElementById("productName").value;
    var productPrice = document.getElementById("productPrice").value;
    var productDescription = document.getElementById("productDescription").value;
    var productQty = document.getElementById("productQty").value;
    let img1 = document.getElementById("image-preview1").src;
    let img2 = document.getElementById("image-preview2").src;
    let img3 = document.getElementById("image-preview3").src;
    let img4 = document.getElementById("image-preview4").src;

    console.log(img1)

    $.ajax({
        method:"POST",
        url:baseUrl+`/admin-product`,
        contentType:'application/json',
        async:true,
        data:JSON.stringify({
            name:productName,
            price:parseInt(productPrice),
            description:productDescription,
            qty:parseInt(productQty),
            images:[
                img1 === "" ? null : img1,
                img2 === "" ? null : img2,
                img3 === "" ? null : img3,
                img4 === "" ? null : img4]
        }),
        headers: {
            Authorization: "Bearer "+sessionStorage.getItem('jwt')
        },

        success:function (response) {
            if (response.code == 201){
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Product created successfully.',
                }).then(() => {
                    getAllProduct();
                    clearForm()
                });

            }
        }
    })
}

function editRowValues(product) {

    document.getElementById('add-btn').style = 'display: none';
    document.getElementById('update-btn').style = 'display: block';


    selectedProductID = product.id

    // Set row values to specified elements
    document.getElementById("productName").value = product.name;
    document.getElementById("productPrice").value = product.price;
    document.getElementById("productDescription").value = product.description;
    document.getElementById("productQty").value = product.qty;

    // Set image URLs to specified elements
    for (let i = 0; i < product.productHasImages.length; i++) {
        const imgElement = document.getElementById(`image-preview${i + 1}`);
        const npImageElement = document.getElementById(`no-image-text${i + 1}`);

        imgElement.style = 'display: block'
        npImageElement.style = 'display: none'

        console.log(product.productHasImages[i].url !== baseUrl+'/admin')

        if (imgElement) {
            if (product.productHasImages[i].url !== baseUrl+'/admin'){
                imgElement.src = product.productHasImages[i].url;
            }
        }
    }


}

function updateProduct() {
    var productName = document.getElementById("productName").value;
    var productPrice = document.getElementById("productPrice").value;
    var productDescription = document.getElementById("productDescription").value;
    var productQty = document.getElementById("productQty").value;
    let img1 = document.getElementById("image-preview1").src;
    let img2 = document.getElementById("image-preview2").src;
    let img3 = document.getElementById("image-preview3").src;
    let img4 = document.getElementById("image-preview4").src;

    $.ajax({
        method:"PUT",
        url:baseUrl+`/admin-product`,
        contentType:'application/json',
        async:true,
        data:JSON.stringify({
            id:selectedProductID,
            name:productName,
            price:parseInt(productPrice),
            description:productDescription,
            qty:parseInt(productQty),
            images:[
                img1 === "" ? null : img1,
                img2 === "" ? null : img2,
                img3 === "" ? null : img3,
                img4 === "" ? null : img4]
        }),
        headers: {
            Authorization: "Bearer "+sessionStorage.getItem('jwt')
        },

        success:function (response) {
            if (response.code == 204){

                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Product updated successfully.',
                }).then(() => {
                    getAllProduct();
                    addBtn.style = 'display: block'
                    updateBtn.style = 'display: none'
                    clearForm()
                });

            }
        }
    })
}

function deleteProduct(productID){
    Swal.fire({
        icon: 'warning',
        title: 'Are you sure?',
        text: 'You are about to update the product.',
        showCancelButton: true,
        confirmButtonText: 'Yes, update it!',
        cancelButtonText: 'No, cancel!',
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                method:"DELETE",
                url:baseUrl+`/admin-product?id=`+productID,
                contentType:'application/json',
                async:true,
                headers: {
                    Authorization: "Bearer "+sessionStorage.getItem('jwt')
                },

                success:function (response) {
                    if (response.code == 203){
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: 'Product deleted successfully.',
                        }).then(() => {
                            getAllProduct();
                        });
                    }
                },
                error:function (error){
                    console.log(error)
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: error.responseJSON.message,
                    });
                }
            })
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            // User clicked "No, cancel!"
            Swal.fire('Cancelled', 'Product delete was cancelled.', 'info');
        }
    })

}

function clearForm(){
    document.getElementById("productForm").reset();

    document.getElementById("image-preview1").src  = "";
    document.getElementById("image-preview2").src  = "";
    document.getElementById("image-preview3").src  = "";
    document.getElementById("image-preview4").src  = "";

    document.getElementById("image-preview1").style  = "display : none";
    document.getElementById("image-preview2").style  = "display : none";
    document.getElementById("image-preview3").style  = "display : none";
    document.getElementById("image-preview4").style  = "display : none";

    document.getElementById("no-image-text1").style  = "display : block;font-size: 8px;";
    document.getElementById("no-image-text2").style  = "display : block;font-size: 8px;";
    document.getElementById("no-image-text3").style  = "display : block;font-size: 8px;";
    document.getElementById("no-image-text4").style  = "display : block;font-size: 8px;";
}

function loadedScriptInit() {
    let updateBtn = document.getElementById('update-btn');
    if (updateBtn){
        updateBtn.style = 'display: none'
    }
    getAllProduct();
    getAllOrders();
}

function getAllProduct(){
    $.ajax({
        method:'GET',
        url:baseUrl+`/admin-product?action=all`,
        headers: {
            Authorization: "Bearer "+sessionStorage.getItem('jwt')
        },

        success:function (response) {
            if (response.code === 200){
                // console.log(response.data)
                // const tableBody = document.getElementById('productTableBody');
                // if (tableBody){
                //     tableBody.innerHTML = "";
                // }
                loadProductTableData(response.data)

            }
        }
    })
}

getAllProduct();

function loadProductTableData(data) {
    const tableBody = document.getElementById('productTableBody');
    if (tableBody){
        tableBody.innerHTML = "";

        data.forEach(product => {
            const row = tableBody.insertRow();

            row.insertCell(0).textContent = product.name;
            row.insertCell(1).textContent = product.price;
            row.insertCell(2).textContent = product.description;
            row.insertCell(3).textContent = product.qty;

            const imagesCell = row.insertCell(4);
            product.productHasImages.forEach(image => {
                const img = document.createElement('img');
                img.src = image.url;
                // img.alt = 'Product Image';
                imagesCell.appendChild(img);
                img.style = 'width: 100px;'
            });

            const actionCell = row.insertCell(5);
            const actionButton = document.createElement('button');
            const deleteButton = document.createElement('button');
            actionButton.textContent = 'Edite';
            actionButton.style = 'width: 59px'
            deleteButton.textContent = 'Delete';
            deleteButton.style = 'background-color: #eb3535'
            actionButton.addEventListener('click', () => {
                editRowValues(product);
            });

            deleteButton.addEventListener('click', () => {
                deleteProduct(product.id);
            });
            actionCell.appendChild(actionButton);
            actionCell.appendChild(deleteButton);
        });
    }
}

function getAllOrders(){
    $.ajax({
        method:'GET',
        url:baseUrl+`/admin-order?action=all`,
        headers: {
            Authorization: "Bearer "+sessionStorage.getItem('jwt')
        },

        success:function (response) {
            loadOrderTableData(response.data)
        }
    })
}

getAllOrders();

function loadOrderTableData(data) {
    const tableBody = document.getElementById('ordersTableBody');
    if (tableBody){
        tableBody.innerHTML = "";

        data.forEach(order => {
            const row = tableBody.insertRow();

            row.insertCell(0).textContent = order.id;
            row.insertCell(1).textContent = order.orderDate;
            row.insertCell(2).textContent = order.total;
            row.insertCell(3).textContent = order.customer;


            const actionCell = row.insertCell(4);
            const actionButton = document.createElement('button');
            actionButton.textContent = 'View Details';
            actionButton.style = 'width: 110px'
            // actionButton.style = 'background-color: #eb3535'
            actionButton.addEventListener('click', () => {
                viewOrderDetail(order.id)
            });

            actionCell.appendChild(actionButton);
        });
    }
}

function viewOrderDetail(orderId){

    $.ajax({
        method:'GET',
        url:baseUrl+`/admin-order?action=`+orderId,
        headers: {
            Authorization: "Bearer "+sessionStorage.getItem('jwt')
        },

        success:function (response) {
            if (response.data.length == 0){
                Swal.fire({
                    icon: 'error',
                    title: 'Error!',
                    text: 'Details Empty!',
                });
            }else {
                openModal();
                showOrderDetails(response.data);
            }
        }
    })


}

function openModal() {
    document.getElementById('orderModal').style.display = 'flex';
}

function closeModal() {
    document.getElementById('orderModal').style.display = 'none';
}

function showOrderDetails(data) {

    const orderDetailsContainer = document.getElementById('orderDetails');
    orderDetailsContainer.innerHTML = ''; // Clear previous content
    orderDetailsContainer.style = 'display: flex;flex-wrap: wrap;width: 100%;'

    data.forEach(detail => {
        const detailElement = document.createElement('div');
        detailElement.innerHTML = `
            <img style="width: 140px;margin-top: 15px;" src="${detail.img}" alt="${detail.productName}" />
            <div>
            <p>Product Name: ${detail.productName}</p>
            <p>Quantity: ${detail.qty}</p>
            <p>Unit Price: ${detail.unitPrice}</p>
            </div>
            <hr>
        `;

        detailElement.style = 'width: 48%;display: flex;flex-direction: column;align-items: center;border: 1px solid #a5a5a5;margin: 5px;'
        orderDetailsContainer.appendChild(detailElement);
    });
}
