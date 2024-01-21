function closeModal() {
    document.getElementById('orderModal').style.display = 'none';
}

function logout(){
    sessionStorage.clear()
    window.location.href = 'login.jsp'
}