# Fredagens lille avstemning 🗳️

귀여운 주말 만남 투표 페이지입니다.

## 완성되는 기능

- 남친은 링크를 열고 `❤️ JA — Vi møtes!` 또는 `🌿 NEI — Ikke denne helgen` 한 번 클릭
- 클릭 후에는 `Takk for stemmen! 🥰` 표시
- 내 Host 화면에서는 약 1.5초 안에 결과가 표시됨
  - `❤️ Han vil møte deg!`
  - `🌿 Denne helgen blir det ikke noe møte.`
- 금요일마다 Host 화면에서 `↻ Start en ny avstemning`을 눌러 초기화
- `Ingen press — bare så vi vet hva helgen blir til 😊` 문구가 메인 디자인에 포함됨
- 모바일 화면에 맞게 디자인됨

## 1. Supabase 만들기

Supabase에서 무료 프로젝트를 하나 만든 뒤 Dashboard의 SQL Editor로 `supabase-schema.sql` 전체를 실행합니다.

공식 문서:
https://supabase.com/docs/guides/database/overview
https://supabase.com/docs/guides/database/row-level-security

## 2. URL / Publishable key 넣기

Supabase Dashboard의 Connect 정보에서 Project URL과 Publishable key를 복사합니다.

`index.html` 위쪽의 두 줄을 바꿉니다.

const SUPABASE_URL = "여기에 Project URL";
const SUPABASE_KEY = "여기에 Publishable key";

브라우저에 넣는 것은 publishable key만 사용하세요. service_role/secret key는 절대 넣지 마세요.

## 3. 웹에 올리기

가장 쉬운 방법은 GitHub Pages, Netlify, Vercel 등 정적 호스팅에 이 `index.html` 하나를 올리는 것입니다.

업로드된 주소가 예를 들어:
https://example.com/index.html

라면,

### 남친에게 보내는 링크
https://example.com/index.html?poll=fredag

### 내가 보는 Host 링크
https://example.com/index.html?poll=fredag&role=host

Host 링크는 남친에게 보내지 말고 본인만 사용하세요.

## 4. 매주 금요일

1. Host 링크를 엽니다.
2. `↻ Start en ny avstemning`을 눌러 이전 결과를 지웁니다.
3. `🔗 Kopier stemmelinken`으로 투표 링크를 복사합니다.
4. 남친에게 보내면 끝!

## 보안에 대해

이 앱은 민감한 정보를 저장하는 서비스가 아니라 둘이 주말 약속을 정하는 작은 투표용입니다.

그래도 Supabase의 RLS(Row Level Security)는 켜 두었습니다. 브라우저에서는 publishable key만 사용하고, service_role/secret key는 사용하지 않습니다.

참고:
https://supabase.com/docs/guides/database/row-level-security
https://supabase.com/docs/guides/api/securing-your-api

주의: 현재 버전은 '링크를 가진 사람이 투표할 수 있는' 방식입니다. 링크가 유출되어도 큰 문제가 없는 개인용 투표를 전제로 합니다.
