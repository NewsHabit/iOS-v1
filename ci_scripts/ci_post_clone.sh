#!/bin/bash

# ✅ 프로젝트 최상단 폴더로 이동
cd ..

# ✅ Tuist 설치
bash <(curl -Ls https://install.tuist.io)
tuist install 3.36.2

# ✅ MASTER_KEY 환경 변수의 값을 master.key 파일에 저장
echo "$MASTER_KEY" > Tuist/master.key

# ✅ 의존성 설치, 인증서 및 프로비저닝 프로파일 복호화, xcworkspace 생성
tuist clean
tuist fetch
tuist signing decrypt
tuist generate
