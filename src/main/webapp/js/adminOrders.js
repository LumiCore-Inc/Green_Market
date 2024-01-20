// export function getAllOrders(){
//     $.ajax({
//         method:'GET',
//         url:`http://localhost:8081/green_market_war_exploded/admin-order?action=all`,
//         headers: {
//             Authorization: "Bearer "+sessionStorage.getItem('jwt')
//         },
//
//         success:function (response) {
//             loadOrderTableData(response.data)
//         }
//     })
// }
//
// getAllOrders();
//
// function loadOrderTableData(data) {
//     const tableBody = document.getElementById('ordersTableBody');
//     if (tableBody){
//         tableBody.innerHTML = "";
//
//         data.forEach(order => {
//             const row = tableBody.insertRow();
//
//             row.insertCell(0).textContent = order.id;
//             row.insertCell(1).textContent = order.orderDate;
//             row.insertCell(2).textContent = order.total;
//             row.insertCell(3).textContent = order.customer;
//
//
//             const actionCell = row.insertCell(4);
//             const actionButton = document.createElement('button');
//             actionButton.textContent = 'Edite';
//             actionButton.style = 'width: 59px'
//             actionButton.addEventListener('click', () => {
//                 // printRowValues(product);
//             });
//
//             actionCell.appendChild(actionButton);
//         });
//     }
// }