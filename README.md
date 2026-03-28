# Neovim 설정 가이드

C/C++ 개발에 특화된 Neovim 설정입니다. **lazy.nvim** 플러그인 매니저 기반으로 LSP, 자동완성, 퍼지 파인더, tmux 연동 등이 갖춰져 있습니다.

---

## 설치

```bash
git clone <this-repo> ~/.config/nvim
nvim  # 최초 실행 시 lazy.nvim과 플러그인이 자동 설치됨
```

tmux 연동이 필요하다면:

```bash
bash setup_tmux_all.sh
```

---

## 기본 설정

| 항목 | 값 |
|------|-----|
| Leader 키 | `Space` |
| 들여쓰기 | 스페이스 2칸 |
| 줄 번호 | 절대 + 상대 번호 동시 표시 |
| 클립보드 | 시스템 클립보드 공유 (`unnamedplus`) |
| 테마 | Tokyo Night |

---

## 설치된 플러그인 목록 및 사용법

### 파일 탐색

#### nvim-tree — 파일 트리
| 단축키 | 동작 |
|--------|------|
| `<leader>e` | 파일 트리 열기/닫기 |

파일 트리 내부에서:
| 단축키 | 동작 |
|--------|------|
| `Enter` | 파일 열기 / 폴더 펼치기 |
| `a` | 파일/폴더 새로 만들기 |
| `d` | 삭제 |
| `r` | 이름 변경 |
| `c` / `p` | 복사 / 붙여넣기 |
| `q` | 파일 트리 닫기 |

#### telescope.nvim — 퍼지 파인더
| 단축키 | 동작 |
|--------|------|
| `<leader>ff` | 파일 이름으로 검색 |
| `<leader>fg` | 파일 내용 전체 grep 검색 |
| `<leader>fb` | 열려 있는 버퍼 목록 |
| `<leader>fh` | Neovim 도움말 검색 |

Telescope 창 내부에서:
| 단축키 | 동작 |
|--------|------|
| `<C-j>` / `<C-k>` | 목록 위아래 이동 |
| `Enter` | 선택 |
| `<C-x>` | 수평 분할로 열기 |
| `<C-v>` | 수직 분할로 열기 |
| `<Esc>` | 닫기 |

---

### LSP (언어 서버)

#### nvim-lspconfig — C/C++ LSP (clangd)

> `clangd`가 시스템에 설치되어 있어야 합니다. (`brew install llvm` 또는 `apt install clangd`)

| 단축키 | 동작 |
|--------|------|
| `K` | 커서 위 심볼의 문서/타입 정보 팝업 |
| `gd` | 정의(definition)로 이동 |
| `gD` | 선언(declaration)으로 이동 |
| `gr` | 참조(references) 목록 |
| `gi` | 구현(implementation)으로 이동 |
| `<leader>rn` | 심볼 이름 일괄 변경 (rename) |
| `<leader>ca` | 코드 액션 (자동 수정, include 추가 등) |

#### nvim-cmp + LuaSnip — 자동완성

| 단축키 | 동작 |
|--------|------|
| `<C-Space>` | 자동완성 목록 강제 열기 |
| `<Tab>` | 다음 항목 선택 |
| `<S-Tab>` | 이전 항목 선택 |
| `<Enter>` | 선택 확정 |

자동완성 소스 우선순위: LSP → LuaSnip 스니펫

---

### 코드 포맷팅

#### conform.nvim — 자동 포맷터

저장 시 자동으로 포맷이 적용됩니다.

| 언어 | 포맷터 |
|------|--------|
| C / C++ | `clang-format` |
| Lua | `stylua` |

| 단축키 | 동작 |
|--------|------|
| `<leader>f` | 현재 파일 즉시 포맷 |

> 포맷터가 없으면 자동으로 LSP 포맷으로 fallback 됩니다.

---

### 진단(Diagnostics)

#### trouble.nvim — 에러/경고 목록

| 단축키 | 동작 |
|--------|------|
| `<leader>xx` | 프로젝트 전체 에러/경고 목록 토글 |
| `<leader>xX` | 현재 버퍼의 에러/경고만 표시 |
| `<leader>cs` | 현재 파일의 심볼 트리 |
| `<leader>cl` | LSP 정의/참조 목록 (우측 패널) |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

---

### 버퍼 관리

#### bufferline.nvim — 탭 형태 버퍼 표시

화면 상단에 열린 파일들이 탭으로 표시되며, LSP 에러/경고 아이콘도 함께 표시됩니다.

| 단축키 | 동작 |
|--------|------|
| `<S-l>` | 다음 버퍼로 이동 |
| `<S-h>` | 이전 버퍼로 이동 |
| `<leader>bd` | 현재 버퍼 닫기 |
| `<leader>bp` | 현재 버퍼 고정(pin) |

---

### 창(Split) 관리

| 단축키 | 동작 |
|--------|------|
| `<leader>sv` | 수직 분할 |
| `<leader>sh` | 수평 분할 |
| `<leader>se` | 모든 창 크기 균등하게 |
| `<leader>sx` | 현재 창 닫기 |
| `<C-h/j/k/l>` | 창 간 이동 (tmux 패널 포함) |

---

### Git

#### gitsigns.nvim — Git 변경사항 표시

편집기 왼쪽 여백(gutter)에 Git 변경 사항이 자동으로 표시됩니다.

| 표시 | 의미 |
|------|------|
| `│` (초록) | 새로 추가된 줄 |
| `│` (주황) | 수정된 줄 |
| `_` (빨강) | 삭제된 줄 |

---

### 기타 유틸리티

#### which-key.nvim — 단축키 힌트

`<leader>`를 누르고 0.3초 기다리면 사용 가능한 단축키 목록이 팝업으로 표시됩니다. 단축키를 외우지 않아도 탐색할 수 있습니다.

그룹 구조:
- `<leader>b` — **buffer** (버퍼 관련)
- `<leader>c` — **code** (코드 관련)
- `<leader>f` — **find** (검색 관련)
- `<leader>s` — **split** (창 분할)
- `<leader>x` — **diagnostics** (에러/경고)

#### nvim-autopairs — 자동 괄호 닫기

`(`, `[`, `{`, `"`, `'` 입력 시 자동으로 닫는 괄호가 추가됩니다.

#### Comment.nvim — 주석 처리

| 단축키 | 동작 |
|--------|------|
| `gcc` | 현재 줄 주석 토글 |
| `gc` + 모션 | 범위 주석 (예: `gc3j` — 아래 3줄 주석) |
| `gc` (비주얼 모드) | 선택 영역 주석 토글 |

#### nvim-treesitter — 문법 강조

C, C++, Lua, Vim, Vimdoc에 대해 Tree-sitter 기반의 정확한 문법 강조와 들여쓰기가 적용됩니다.

---

### 기타

#### 저장 / 종료

| 단축키 | 동작 |
|--------|------|
| `<leader>w` | 파일 저장 |
| `<leader>q` | 종료 |
| `<leader>/` | 검색 하이라이트 제거 |

---

## 추천 워크플로우

### C/C++ 프로젝트 개발

```
1. 프로젝트 루트에서 nvim 실행
   → compile_commands.json이 있으면 clangd가 자동으로 인식

2. <leader>e  →  파일 트리를 열어 프로젝트 구조 파악

3. <leader>ff  →  파일명으로 빠르게 원하는 파일 열기

4. 코드 편집
   - K         →  타입/문서 확인
   - gd        →  함수 정의로 이동
   - gr        →  어디서 쓰이는지 참조 확인
   - <leader>ca →  자동 수정 (헤더 추가, 오타 수정 등)

5. <leader>xx  →  에러/경고 전체 목록 확인

6. <leader>f   →  포맷 후 <leader>w 로 저장
   (저장 시 자동 포맷도 적용됨)

7. <S-l> / <S-h>  →  열린 파일들 사이를 이동
```

### 멀티 파일 작업

```
1. <leader>sv 또는 <leader>sh  →  창 분할

2. 각 창에서 <leader>ff 로 다른 파일 열기

3. <C-h/j/k/l>  →  창 간 이동

4. <leader>fg  →  전체 코드베이스에서 키워드 grep

5. <leader>fb  →  열린 버퍼 목록에서 빠르게 전환
```

### Tmux 연동 워크플로우

```
1. bash setup_tmux_all.sh 으로 tmux 설정

2. tmux 세션 안에서 nvim 실행

3. <C-h/j/k/l>  →  nvim 창과 tmux 패널을 구분 없이 이동

4. 아래 패널에서 빌드/실행, 위 패널에서 코드 편집
   → 터미널과 에디터 사이를 키보드만으로 자유롭게 전환
```

---

## 플러그인 관리

| 명령어 | 동작 |
|--------|------|
| `:Lazy` | 플러그인 관리 UI 열기 |
| `:Lazy update` | 모든 플러그인 업데이트 |
| `:Lazy sync` | lock 파일 기준으로 동기화 |
| `:TSUpdate` | Treesitter 파서 업데이트 |

---

## 필수 외부 도구

| 도구 | 용도 | 설치 |
|------|------|------|
| `clangd` | C/C++ LSP | `brew install llvm` |
| `clang-format` | C/C++ 포맷터 | llvm에 포함 |
| `stylua` | Lua 포맷터 | `brew install stylua` |
| Nerd Font | 아이콘 렌더링 | [nerdfonts.com](https://www.nerdfonts.com) |
