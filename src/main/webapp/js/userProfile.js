let baseUrl = 'http://localhost:8080/'
function loadedScriptInit(){
    getUserDetails()
}

getUserDetails()

function getUserDetails(){
    $.ajax({
        method:'GET',
        url:baseUrl+`/user`,
        headers: {
            Authorization: "Bearer "+sessionStorage.getItem('jwt')
        },

        success:function (response) {
            console.log(response)

            setUserDetails(response.data)
        }
    })
}

function setUserDetails(data){
    document.getElementById('username').innerText = data.username
    document.getElementById('email').innerText = data.email === undefined ? '' : data.email
    document.getElementById('email-input').value = data.email === undefined ? '' : data.email
    document.getElementById('firstName').value = data.firstName
    document.getElementById('lastName').value =  data.lastName === undefined ? '' : data.lastName
    document.getElementById('tp').value = data.tp === undefined ? '' : data.tp
    document.getElementById('address').value = data.address === undefined ? '' : data.address
    document.getElementById('password').value = ''
}

function updateUserDetails(){

    let firstName = document.getElementById('firstName').value;
    let lastName = document.getElementById('lastName').value;
    let tp = document.getElementById('tp').value;
    let address = document.getElementById('address').value;
    let password = document.getElementById('password').value;
    let email = document.getElementById('email-input').value;


    $.ajax({
        method:'PUT',
        url:baseUrl+`/user`,
        contentType:'application/json',
        async:true,
        data:JSON.stringify({
            firstName:firstName,
            lastName:lastName,
            tp:tp,
            address:address,
            password:password,
            email:email
        }),
        headers: {
            Authorization: "Bearer "+sessionStorage.getItem('jwt')
        },

        success:function (response) {
            console.log(response.code == 204)

            if (response.code == 204){
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Details update successfully.',
                }).then(() => {
                    getUserDetails()
                });
            }
        },
        error:function (error){
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: error.responseJSON.message,
            });

            if (error.code == 403){
                window.location.href = 'login.jsp'
            }
        }


    })
}

function getAllOrders(){
    $.ajax({
        method:'GET',
        url:baseUrl+`/admin-order?action=by-user`,
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
            actionCell.style = 'text-align: center;'
            const actionButton = document.createElement('button');
            actionButton.textContent = 'View Details';
            actionButton.style = 'width: 110px;'
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