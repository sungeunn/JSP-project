
(() => {
	
	const submitBtnEl = document.querySelector(".join-form-submit-btn-js"); // submit 버튼
	
﻿const checkMember = (e) => {

    const regexId = /^[a-z0-9]{4,12}$/;
	const regexPw = /^[a-zA-Z0-9]{8,16}$/;
	const regexName = /^[가-힣]+$/;
	const regexPhone = /^\d{11}$/;
    const regexEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; 

	const formEl = document.querySelector(".join-form-js")
	const idEl = formEl.querySelector("#id")
	const passEl = formEl.querySelector("#pass");
	const confirmPassEl = formEl.querySelector("#confirm-pass");
	const nameEl = formEl.querySelector("#name");
	const phoneEl = formEl.querySelector("#phone");
	const emailEl = formEl.querySelector("#email"); 
	
	console.log(!regexId.test(idEl.value));
	console.log(!regexPw.test(passEl.value));
	console.log(!regexName.test(nameEl.value));
	console.log(nameEl.value);
	console.log(phone.value);
	console.log(emailEl.value);
	
	e.preventDefault(); // submit 기능 상쇄

	if(!regexId.test(idEl.value)){ // test는 해당 정규표현식과 id의 값이 일치하는지 알아내는 역할
		alert("아이디는 4~12자의 영문 소문자와 숫자로만 입력하세요");
		idEl.focus();
		return;
		}

	if(!regexPw.test(passEl.value)){
		alert("비밀번호는 8~16자의 영문 대소문자와 숫자로만 입력하세요");
		passEl.focus();
		return;
	}
	
	if(passEl.value!=confirmPassEl.value){
		alert("비밀번호가 일치하지 않습니다");
		confirmPassEl.focus();
		return;
	}
	
	if(!regexName.test(nameEl.value)){
		alert("이름은 한글만 입력하세요");
		nameEl.focus();
		return;
	}
		
	if(!regexPhone.test(phoneEl.value)){
		alert("연락처를 입력하세요");
		phoneEl.focus();
		return;
	}
		
	if(!regexEmail.test(emailEl.value)){
		alert("이메일 입력을 확인해주세요");
		emailEl.focus();
		return;
	}

	formEl.submit();

}

submitBtnEl.addEventListener("click", checkMember);
	
})()

