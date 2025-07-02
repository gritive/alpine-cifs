# Alpine CIFS Docker Image

[![Build and Push Docker Image](https://github.com/YOUR_USERNAME/alpine-cifs/actions/workflows/docker-build.yml/badge.svg)](https://github.com/YOUR_USERNAME/alpine-cifs/actions/workflows/docker-build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/YOUR_USERNAME/alpine-cifs)](https://hub.docker.com/r/YOUR_USERNAME/alpine-cifs)
[![Docker Image Size](https://img.shields.io/docker/image-size/YOUR_USERNAME/alpine-cifs/latest)](https://hub.docker.com/r/YOUR_USERNAME/alpine-cifs)

Alpine Linux 기반의 CIFS (Common Internet File System) 유틸리티가 설치된 Docker 이미지입니다.

## 포함된 패키지
- `cifs-utils`: CIFS/SMB 네트워크 파일 시스템 마운트 도구
- `ca-certificates`: SSL/TLS 인증서
- `tzdata`: 타임존 데이터

## 설치 방법

### Docker Hub에서 가져오기
```bash
docker pull YOUR_USERNAME/alpine-cifs:latest
```

### 로컬 빌드
```bash
docker build -t alpine-cifs:latest .
```

## 사용 방법

### 기본 실행
```bash
docker run -it --cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH alpine-cifs:latest
```

### CIFS 볼륨 마운트 예제
```bash
docker run -it --cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH \
  alpine-cifs:latest \
  mount -t cifs //server/share /mnt/cifs -o username=user,password=pass
```

### docker-compose 예제
```yaml
version: '3'
services:
  cifs-client:
    image: alpine-cifs:latest
    cap_add:
      - SYS_ADMIN
      - DAC_READ_SEARCH
    command: >
      sh -c "mount -t cifs //nas.example.com/share /mnt/cifs 
      -o username=$$CIFS_USER,password=$$CIFS_PASS,domain=$$CIFS_DOMAIN
      && tail -f /dev/null"
    environment:
      - CIFS_USER=username
      - CIFS_PASS=password
      - CIFS_DOMAIN=WORKGROUP
```

## GitHub Actions 설정

이 저장소를 fork하거나 사용하려면 다음 secrets를 설정해야 합니다:

1. GitHub 저장소의 Settings → Secrets and variables → Actions로 이동
2. 다음 secrets 추가:
   - `DOCKER_USERNAME`: Docker Hub 사용자명
   - `DOCKER_PASSWORD`: Docker Hub 액세스 토큰 (비밀번호 대신 토큰 사용 권장)

## 주의사항
- CIFS 마운트를 위해서는 `SYS_ADMIN` 및 `DAC_READ_SEARCH` 권한이 필요합니다
- 보안을 위해 환경변수나 Docker secrets를 사용하여 인증 정보를 관리하세요
- README.md의 `YOUR_USERNAME`을 실제 Docker Hub 사용자명으로 변경하세요