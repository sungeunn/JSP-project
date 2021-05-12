(() => {
	
	const postcodebt = document.querySelector("#postcode_bt");
	const postcode = document.querySelector("#postcode");
	const address = document.querySelector("#address");
	const detailAddress = document.querySelector("#detailAddress");
	
function DaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {

			var addr = ''; // 주소 변수
              
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                document.getElementById("detailAddress").focus();
		}
	}).open();
}

postcodebt.addEventListener("click",DaumPostcode);

})();

