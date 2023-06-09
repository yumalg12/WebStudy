function falseCSS_CSS(element){
	element.classList.remove("normal");
	element.classList.remove("done");
	element.classList.add("false");
}

function doneCSS_CSS(element){
	element.classList.remove("normal");
	element.classList.remove("false");
	element.classList.add("done");
}

function falseCSS(name) {
	var element = document.Registerform[name];
	falseCSS_CSS(element);
}

function doneCSS(name) {
	var element = document.Registerform[name];
	doneCSS_CSS(element);
}

function falseCSSName(name, num) {
	var element = document.getElementsByName(name)[num];
	falseCSS_CSS(element);
}

function doneCSSName(name, num) {
	var element = document.getElementsByName(name)[num];
	doneCSS_CSS(element);
}

function checkID(uID) {
	var regex = /^[a-z0-9]{4,12}$/;

	if (regex.test(uID) && uID != "null" && uID != "undefined") {
		doneCSS("userID");
		document.getElementById("IDNotice").style.display = "none";
		document.getElementById("checkIDdup").style.display = "";
		return true;
	} else {
		falseCSS("userID");
		document.getElementById("IDNotice").style.display = "";
		document.getElementById("checkIDdup").style.display = "none";
		return false;
	}
}	

function checkPWone() {	
	var regex = /^[a-zA-Z0-9!@#$%^&*()-_=+\\|[\]{};:'",.<>/?]{4,20}$/;

	var PWone = document.Registerform.PW.value;

	if (regex.test(PWone)){
		doneCSS("PW");
		document.getElementById("PWNotice").style.display = "none";
		document.getElementsByName("PWcheck")[0].style.display = "";
		return true;
	} else {
		falseCSS("PW");
		document.getElementById("PWNotice").style.display = "";
		document.getElementsByName("PWcheck")[0].style.display = "none";	
		return false;	
	}
}

function checkPWtwo() {	
	var PWone = document.Registerform.PW.value;
	var PWtwo = document.Registerform.PWcheck.value;
	
	if (PWone != PWtwo) {
		falseCSS("PWcheck");
		return false;
	} else {
		doneCSS("PWcheck");
		return true;
	}
}


function checkName() {
	var regex = /^[가-힣]{2,5}$/;
	var name = document.Registerform.userName.value;
	
	if(regex.test(name)){
		doneCSS("userName");
		document.getElementById("nameNotice").style.display = "none";
		return true;
	} else {
		falseCSS("userName");
		document.getElementById("nameNotice").style.display = "";
		return false;
	}
}

function checkBirth() {
	var birthDateInput = document.getElementsByName("birthDate")[0].value;
	if (birthDateInput !== "") {
		var currentDate = new Date();
		currentDate.setHours(0, 0, 0, 0);
		var [year, month, day] = birthDateInput.split('-').map(Number);
		var birthDate = new Date(year, month - 1, day);

		var age = (currentDate - birthDate) / (1000 * 60 * 60 * 24 * 365);

		if (age < 14 && 0 <= age) {
			falseCSS("birthDate");
			document.getElementById("ageNotice").style.display = "";
			document.getElementById("ageNotice2").style.display = "none";
			return false;
		} else if (age < 0) {
			falseCSS("birthDate");
			document.getElementById("ageNotice").style.display = "none";
			document.getElementById("ageNotice2").style.display = "";
			return false;
		} else {
			doneCSS("birthDate");
			document.getElementById("ageNotice").style.display = "none";
			document.getElementById("ageNotice2").style.display = "none";
			return true;
		}
	} else {
		return false;
	}
}


function phoneInput() {
	if (document.getElementsByName("num1")[0].value == "input") {
		document.getElementsByName("num1")[0].style.display = "none";
		document.getElementsByName("num1")[0].disabled = true;
		document.getElementsByName("num1")[1].style.display = "";
	} else {
		document.getElementsByName("num1")[0].style.display = "";
		document.getElementsByName("num1")[0].disabled = false;
		document.getElementsByName("num1")[1].style.display = "none";
	}
}

function checkPhoneOne(){
	var regex = /^[0][1-9][0-9]$/;

	if (regex.test(document.getElementsByName("num1")[0].value) || regex.test(document.getElementsByName("num1")[1].value)) {
		doneCSSName("num1", 1);
		return true;
	} else {
		falseCSSName("num1", 1);
		return false;
	}
}

function checkPhone(name){
	if (name === "num2"){
		var regex = /^[0-9]{3,4}$/;		
	} else if (name === "num3") {
		var regex = /^[0-9]{4}$/;		
	}  else if (name === "num1") {
		var regex = /^[0][1-9][0-9]$/;
	}

	if(regex.test(document.getElementsByName(name)[0].value)) {
		doneCSS(name);
		return true;
	} else {
		falseCSS(name);
		return false;
	}
}


function emailInput() {
	if (document.getElementsByName("email2")[0].value == "input") {
		document.getElementsByName("email2")[0].style.display = "none";
		document.getElementsByName("email2")[0].disabled = true;
		document.getElementsByName("email2")[1].style.display = "";
	} else {
		document.getElementsByName("email2")[0].style.display = "";
		document.getElementsByName("email2")[0].disabled = false;
		document.getElementsByName("email2")[1].style.display = "none";
	}
}

function checkMail1() {
	var regex = /^[a-zA-Z0-9!@#$%^&*()-_=+\\|[\]{};:'",.<>/?]+$/;
	
	if(regex.test(document.Registerform["email1"].value)){
		doneCSS("email1");
		return true;
	} else {
		falseCSS("email1");
		return false;
	}
}

function checkMail2() {
	var regex = /^[a-zA-Z0-9]+[\.][a-z]+$/;
	
	if(regex.test(document.getElementsByName("email2")[0].value)
	 || regex.test(document.getElementsByName("email2")[1].value)){
		doneCSSName("email2", 1);
		return true;
	} else {
		falseCSSName("email2", 1);
		return false;
	}
}

function checkZipCode() {
	var regex = /^[0-9]{5}$/;

	if(regex.test(document.Registerform.zipcode.value)){
		doneCSS("zipcode");
		return true;
	} else {
		falseCSS("zipcode");
		return false;
	}
	
}

function checkAddress(name) {
	var len = document.Registerform[name].value.length;

	if(len > 0){
		doneCSS(name);
		return true;
	} else {
		falseCSS(name);
		return false;
	}
	
}

function validateForm() {
if (!checkID(document.Registerform.userID.value)) {
  alert("ID를 다시 입력하십시오.");
  setTimeout(function () {
    document.Registerform.userID.focus();
  }, 100);
  return false;
} else if (!document.Registerform.userID.disabled) {
  alert("ID 중복 확인이 필요합니다.");
  setTimeout(function () {
    document.Registerform.userID.focus();
  }, 100);
  return false;
} else if (!checkPWone() || !checkPWtwo()) {
  alert("비밀번호를 확인하십시오.");
  setTimeout(function () {
    document.Registerform.PWcheck.focus();
  }, 100);
  return false;
} else if (document.Registerform.PW.value == document.Registerform.userID.value) {
  alert("ID와 동일한 비밀번호는 사용할 수 없습니다.");
  falseCSS("PW");
  setTimeout(function () {
    document.Registerform.PW.focus();
  }, 100);
  return false;
} else if (!checkName()) {
  alert("올바른 이름을 입력하십시오.");
  setTimeout(function () {
    document.Registerform.userName.focus();
  }, 100);
  return false;
} else if (document.Registerform.gender.value === "") {
  alert("성별을 선택하십시오.");
  return false;
} else if (!checkBirth()) {
  alert("올바른 생년월일을 입력하십시오.");
  setTimeout(function () {
    document.Registerform.birthDate.focus();
  }, 100);
  return false;
} else if (!checkPhoneOne() || !checkPhone("num2") || !checkPhone("num3")) {
  alert("올바른 전화번호를 입력하십시오.");
  setTimeout(function () {
    var elements = document.getElementsByClassName("false");
    if (elements.length > 0) {
      elements[0].focus();
    }
  }, 100);
  return false;
} else if (!checkMail1() || !checkMail2()) {
  alert("올바른 이메일 주소를 입력하십시오.");
  setTimeout(function () {
    var elements = document.getElementsByClassName("false");
    if (elements.length > 0) {
      elements[0].focus();
    }
  }, 100);
  return false;
} else if (!checkZipCode() || (!checkAddress("roadAddress") && !checkAddress("jibunAddress"))) {
  alert("올바른 주소를 입력하십시오.");
  setTimeout(function () {
    var elements = document.getElementsByClassName("false");
    if (elements.length > 0) {
      elements[0].focus();
    }
  }, 100);
  return false;
} else {
  return true;
}

}

