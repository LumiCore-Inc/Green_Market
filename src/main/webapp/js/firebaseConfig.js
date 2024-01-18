import { initializeApp } from 'https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js';
import { getStorage, ref, uploadString, getDownloadURL } from 'https://www.gstatic.com/firebasejs/9.0.0/firebase-storage.js';



const firebaseConfig = {
    apiKey: "AIzaSyBdpVISyMSQWbAQWiJ5M9hGg2YjxK6SBYY",
    authDomain: "green-market-79d16.firebaseapp.com",
    projectId: "green-market-79d16",
    storageBucket: "green-market-79d16.appspot.com",
    messagingSenderId: "329368158583",
    appId: "1:329368158583:web:5b31107a6faf84ca27e172",
    measurementId: "G-NCVQ1N701F"
};

const app = initializeApp(firebaseConfig);
const storage = getStorage(app);
const storageRef = storage.ref();

function saveImageToFirebaseStorage(file) {
    const name = +new Date() + "-" + file.name;
    const metadata = {
        contentType: file.type
    };
    const imageRef = storageRef.child(name);

    const task = imageRef.put(file, metadata);

    task
        .then(snapshot => snapshot.ref.getDownloadURL())
        .then(url => {
            console.log(url);
            alert('Image uploaded successfully');
            document.querySelector("#image").src = url;
        })
        .catch(console.error);
}

window.saveImageToFirebaseStorage = saveImageToFirebaseStorage;

// Example usage:
// const fileInput = document.getElementById('fileInput');
//
// fileInput.addEventListener('change', (event) => {
//     const file = event.target.files[0];
//
//     if (file) {
//         saveImageToFirebaseStorage(file)
//             .then(downloadURL => {
//                 console.log("Image uploaded successfully. Download URL:", downloadURL);
//                 // Now you can use the downloadURL as needed, e.g., save it to a database or display it in your app.
//             })
//             .catch(error => {
//                 console.error("Error:", error);
//             });
//     }
// });