
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

    saveImageToFirebaseStorage(file)

    if (file) {
        const reader = new FileReader();

        reader.onload = function (e) {
            preview.src = e.target.result;
            preview.style.display = 'block';
            noImageText.style.display = 'none';
        };

        reader.readAsDataURL(file);
    } else {
        // No file selected, reset the preview
        preview.src = '';
        preview.style.display = 'none';
        noImageText.style.display = 'block';
        container.style.border = '2px dashed #ccc';
    }
}


function addProduct() {
    var productName = document.getElementById("productName").value;
    var productPrice = document.getElementById("productPrice").value;
    var productDescription = document.getElementById("productDescription").value;
    var productQty = document.getElementById("productQty").value;
    var productImages = document.getElementById("productImage").files;

    // Validate input (you can add more validation as needed)

    // Example: Displaying the product details in the table (modify this based on your requirements)
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

    // Displaying the image names and previews (modify this based on your requirements)
    cell5.innerHTML = '<ul>';
    for (var i = 0; i < productImages.length; i++) {
        cell5.innerHTML += '<li>' + productImages[i].name + '</li>';
    }
    cell5.innerHTML += '</ul>';

    cell5.innerHTML += '<div style="display: flex;">';
    for (var i = 0; i < productImages.length; i++) {
        cell5.innerHTML += '<img src="' + URL.createObjectURL(productImages[i]) + '" style="max-width: 100px; max-height: 100px; margin-right: 10px;" alt="Image Preview">';
    }
    cell5.innerHTML += '</div>';

    // Clear the form inputs and reset the image preview
    document.getElementById("productForm").reset();
    document.getElementById("imagePreview").innerHTML = '';
}
