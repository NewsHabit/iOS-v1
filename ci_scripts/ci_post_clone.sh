#!/bin/bash

# Tuist 3.36.2 설치
bash <(curl -Ls https://install.tuist.io)
tuist install 3.36.2

# ci_scripts 디렉토리를 나와 프로젝트 경로인 NewsHabit로 진입
cd ..

# MASTER_KEY 환경 변수의 값을 master.key 파일에 저장
echo "$MASTER_KEY" > Tuist/master.key

# Tuist
tuist clean
tuist fetch
tuist signing decrypt
tuist generate
