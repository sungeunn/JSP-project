(() => {
	// star span 전체 선택 (리스트로 받음)
	const allStarEl = document.querySelectorAll("#star_grade span");
	
	// input hidden 요소 가져오기
	const starScoreEl = document.querySelector(".star-score-js");
	
	// 클릭 시 실행 될 메소드
	const handleStarClick = (e) => {
		const star = e.target; // 클릭한 요소 가져오기
		const starScore = star.dataset.score // data-score에 적은 값 가져오기
		starScoreEl.value =starScore ; // input hidden에 값 세팅하기
		
		// on 클래스 전부 지우기 
		for(const starEl of allStarEl) {
			starEl.classList.remove("on");
		}
		
		// 선택한 곳 이하 on 클래스 추가하기
		for(let i = 0; i < starScore; ++i) {
			allStarEl[i].classList.add("on");
		}
		
	}
	
	// 초기화 메소드
	const init = () => {
		// 가져온 span이 여러개니까 for문 돌려서 각각 click 이벤트 넣어주기
		for(const starEl of allStarEl) {
			// 클릭 이벤트 넣는 방법
			// 1번째는 문자열로 이벤트 종류를 적으면 됩니다. 지금은 click
			// 2번째는 실행할 메소드.
			starEl.addEventListener("click", handleStarClick);
		}
	}
	
	// 초기화 메소드 실행 
	init();
})();