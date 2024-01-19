
let preview = document.getElementById('image-preview');
let noImageText = document.getElementById('no-image-text');

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
        url:`http://localhost:8081/green_market_war_exploded/product`,
        contentType:'application/json',
        async:true,
        data:JSON.stringify({
            name:productName,
            price:parseInt(productPrice),
            description:productDescription,
            qty:parseInt(productQty),
            images:[img1, img2, img3, img4]
        }),
        headers: {
            Authorization: "Bearer "+sessionStorage.getItem('jwt')
        },

        success:function (response) {
            alert("Success !")
            console.log(response)
        }
    })


    // Validate input (you can add more validation as needed)

    var table = document.getElementById("productTable").getElementsByTagName('tbody')[0];
    var newRow = table.insertRow(table.rows.length);

    var cell1 = newRow.insertCell(0);
    var cell2 = newRow.insertCell(1);
    var cell3 = newRow.insertCell(2);
    var cell4 = newRow.insertCell(3);
    var cell5 = newRow.insertCell(4);

    cell1.innerHTML = productName;
    cell2.innerHTML = productPrice;
    cell3.innerHTML = productDescription;
    cell4.innerHTML = productQty;

    // // Displaying the image names and previews (modify this based on your requirements)
    // cell5.innerHTML = '<ul>';
    // for (var i = 0; i < 1; i++) {
    //     cell5.innerHTML += '<li>' + img1.name + '</li>';
    // }
    // cell5.innerHTML += '</ul>';
    //
    // cell5.innerHTML += '<div style="display: flex;">';
    // for (var i = 0; i < productImages.length; i++) {
    //     cell5.innerHTML += '<img src="' + URL.createObjectURL(productImages[i]) + '" style="max-width: 100px; max-height: 100px; margin-right: 10px;" alt="Image Preview">';
    // }
    // cell5.innerHTML += '</div>';

    // Clear the form inputs and reset the image preview
    document.getElementById("productForm").reset();
    document.getElementById("imagePreview").innerHTML = '';
}
