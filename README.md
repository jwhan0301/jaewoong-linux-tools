# Jaewoong Linux Tools

[![Test](https://github.com/jwhan0301/jaewoong-linux-tools/actions/workflows/test.yml/badge.svg)](https://github.com/jwhan0301/jaewoong-linux-tools/actions/workflows/test.yml)

재웅이의 리눅스 학습용 개인 명령어 모음입니다.

이 프로젝트는 Linux, Bash scripting, Git, GitHub 연습을 위해 만들었습니다.

## Installation

이 프로젝트의 명령어들을 `~/bin`에 설치하려면 아래 명령어를 실행합니다.

```bash
./install.sh
```

설치 후 아래 명령어들을 어디서든 사용할 수 있습니다.

```bash
jcheck
jgrep
jnote
```

설치 확인:

```bash
which jcheck
which jgrep
which jnote
```

## Uninstallation

설치된 명령어들을 `~/bin`에서 제거하려면 아래 명령어를 실행합니다.

```bash
./uninstall.sh
```

확인 질문 없이 제거하려면 아래처럼 실행할 수 있습니다.

```bash
./uninstall.sh --yes
```

## Testing

프로젝트가 정상적으로 동작하는지 확인하려면 아래 명령어를 실행합니다.

```bash
./test.sh
```

테스트 내용:

- 스크립트 문법 검사
- 설치 테스트
- jgrep 검색 테스트
- jnote 메모 테스트
- 삭제 테스트

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
추가 기능:

```bash
jnote delete 1
jnote clear
jnote clear --yes
jnote export notes-backup.txt
```

- `jnote delete NUMBER`: 해당 번호의 메모를 삭제합니다.
- `jnote clear`: 모든 메모를 비웁니다. 실행 전 확인을 받습니다.
- `jnote clear --yes`: 확인 없이 모든 메모를 비웁니다.
- `jnote export FILE`: 현재 메모를 지정한 파일로 내보냅니다.
추가 기능:

```bash
jnote show 1
jnote edit 1 "수정된 메모 내용"
jnote delete 1
jnote clear
jnote clear --yes
jnote export notes-backup.txt
```

- `jnote show NUMBER`: 해당 번호의 메모만 보여줍니다.
- `jnote edit NUMBER MESSAGE`: 해당 번호의 메모를 새 내용으로 수정합니다.
- `jnote delete NUMBER`: 해당 번호의 메모를 삭제합니다.
- `jnote clear`: 모든 메모를 비웁니다. 실행 전 확인을 받습니다.
- `jnote clear --yes`: 확인 없이 모든 메모를 비웁니다.
- `jnote export FILE`: 현재 메모를 지정한 파일로 내보냅니다.

### Import notes

백업 파일의 메모를 현재 메모 뒤에 추가합니다.

```bash
jnote import notes-backup.txt
```

백업 및 복구 예시:

```bash
jnote export notes-backup.txt
jnote clear --yes
jnote import notes-backup.txt
jnote list
```

같은 파일을 여러 번 import하면 메모가 중복될 수 있습니다.

### Convenience commands

오늘 작성한 메모만 확인합니다.

```bash
jnote today
```

최근 메모를 확인합니다. 숫자를 생략하면 최근 5개를 보여줍니다.

```bash
jnote recent
jnote recent 3
```

날짜와 시간이 포함된 파일명으로 메모를 자동 백업합니다.

```bash
jnote backup
```

백업 파일은 아래 폴더에 저장됩니다.

```text
~/linux-quest/notes/backups
```

### Archive commands

메모를 삭제하지 않고 보관함으로 이동합니다.

```bash
jnote archive 2
```

보관된 메모 목록을 확인합니다.

```bash
jnote archived
```

보관함의 메모를 현재 메모 목록으로 복원합니다.

```bash
jnote restore 1
```

## What I Learned

이 프로젝트를 만들면서 배운 것들:

- Linux basic commands
- File and directory management
- grep and find
- Bash scripting
- chmod and PATH
- alias and .bashrc
- Git commit, branch, merge
- GitHub push and pull

## Changelog

버전별 변경 내역은 [CHANGELOG.md](CHANGELOG.md)에서 확인할 수 있습니다.

## Project Goal

리눅스 명령어를 단순히 외우는 것이 아니라, 직접 작은 도구를 만들면서 익히는 것이 목표입니다.
