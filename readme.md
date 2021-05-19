# 국비지원 웹애플리케이션 

- 회원가입 + 카카오톡 로그인 API 적용
- 게시판 CRUD 기능 구현 
- 댓글 기능 AJAX로 구현 
  - 답글 기능 구현 ( 최신 댓글이 아래로)
- 파일 업로드/다운로드 
- 갤러리 게시판 기능 
- 우편번호 API 
- 아이디 찾기/비밀번호 재발급 : 이메일 보내기 기능 적용

- 회원 탈퇴/ 게시글 삭제/ 댓글 삭제 : 외래키 처리. 
  - 3가지 방식으로 구현 
    1) 외래키 먼저 삭제 (게시글 삭제)
    2) 삭제 여부를 관리할 컬럼 추가 (댓글 삭제)
    3) 새로운 컬럼을 넣고, 해당 컬럼으로 FK를 update후 삭제 (회원탈퇴)

- [PPT](https://docs.google.com/presentation/d/1tCH_S4Dj-LJbffTJgzC5ETcTaV-iLMwKudvKMH-ot_c/edit?usp=sharing)
