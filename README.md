# Jaewoong Linux Tools

재웅이의 리눅스 학습용 개인 명령어 모음입니다.

이 프로젝트는 Linux, Bash scripting, Git, GitHub 연습을 위해 만들었습니다.

## Commands

### jcheck

시스템 상태를 빠르게 확인하는 명령어입니다.

```bash
jcheck
```

확인하는 내용:

- 현재 사용자
- 호스트 이름
- 날짜
- 디스크 사용량
- 메모리 사용량
- IP 주소
- 상위 프로세스

---

### jgrep

파일 안에서 특정 단어를 대소문자 구분 없이 검색하고, 검색 결과 개수도 보여주는 명령어입니다.

```bash
jgrep error app.log
```

기능:

- 줄 번호 표시
- 대소문자 무시 검색
- 검색 결과 개수 출력

---

### jnote

터미널에서 간단히 메모를 추가, 조회, 검색할 수 있는 명령어입니다.

```bash
jnote add "리눅스 재밌다"
jnote list
jnote search 리눅스
jnote count
```

기능:

- 메모 추가
- 메모 목록 보기
- 메모 검색
- 메모 개수 확인

## What I Learned

이 프로젝트를 만들면서 배운 것들:

- Linux basic commands
- File and directory management
- Bash scripting
- chmod and PATH
- alias and .bashrc
- Git commit, branch, merge
- GitHub push and pull

## Project Goal

리눅스 명령어를 단순히 외우는 것이 아니라, 직접 작은 도구를 만들면서 익히는 것이 목표입니다.

