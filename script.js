const signUpBtn = document.getElementById("signup-button");
const profileBtn = document.getElementById("profile-button");

const isLoggedIn = false;

if(isLoggedIn){
    signUpBtn.style.display = 'none';
    profileBtn.style.display = 'inline-block';
}

const mainPage = document.getElementById("main-page");
const loginPage = document.getElementById("login-page");
const signUpPage = document.getElementById("sign-up-page");

signUpBtn.addEventListener("click",()=>{
    mainPage.style.display = 'none';
    signUpPage.style.display = 'flex';
})

const loginHover = document.getElementById("login-hover");

loginHover.addEventListener("click", () => {
    signUpPage.style.display = 'none';
    loginPage.style.display = 'flex';
})

const forgetPasswordMain = document.getElementById("forget-password-main-page");
const forgetPasswordCode = document.getElementById("forget-password-code-page");
const forgetPasswordBtn = document.getElementById("forget-password-login");
const requestCodeBtn = document.getElementById("request-code");
const verifyCodeBtn = document.getElementById("verify-code");

forgetPasswordBtn.addEventListener("click", () =>{
    loginPage.style.display = 'none';
    forgetPasswordMain.style.display = 'flex'; 
})

requestCodeBtn.addEventListener("click",() =>{
    forgetPasswordMain.style.display = 'none';
    forgetPasswordCode.style.display = 'flex';   
})

verifyCodeBtn.addEventListener("click", ()=>{
    forgetPasswordCode.style.display = 'none';
    mainPage.style.display = 'flex';      
})





