var LoginForm = document.getElementById("loginForm");
var RegForm = document.getElementById("regForm");
var AdminForm = document.getElementById("adminForm");
var Indicator = document.getElementById("indicator");

function register () {
    RegForm.style.transform = "translateX(0px)";
    LoginForm.style.transform = "translateX(0px)";
    Indicator.style.transform = "translateX(100px)";
    AdminForm.style.transform = "translateX(0px)";
}

function login () {
    RegForm.style.transform = "translateX(330px)";
    LoginForm.style.transform = "translateX(330px)";
    Indicator.style.transform = "translateX(0px)";
    AdminForm.style.transform = "translateX(330px)";
}

function admin () {
    RegForm.style.transform = "translateX(-330px)";
    LoginForm.style.transform = "translateX(-330px)";
    AdminForm.style.transform = "translateX(-330px)";
    Indicator.style.transform = "translateX(200px)";
}