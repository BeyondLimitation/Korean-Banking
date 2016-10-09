#기반 이미지로 부터 이미지 생성 시작. 14.04.1 LTS를 사용, 래거시 프로그램의 원활한 작동 보장
FROM ubuntu:14.04.1

#기본 환경변수 설정
ENV TERM xterm

#개발자
MAINTAINER leeheechan <leeheechan1@gmail.com>

#필수 보안(망할...)패키지들 /korea-shit폴더와 함깨 추가
COPY korea-shit /korea-shit

#Firefox 설치
RUN apt-get update && apt-get install -y firefox

#Container에 한글 관련 패키지들 설치
RUN apt-get install -y fonts-nanum fcitx-hangul
RUN localedef -f UTF-8 -i ko_KR ko_KR.UTF-8
ENV LANG="ko_KR.UTF-8"

#보안 패키지들의 의존성들 미리 설치
RUN apt-get update && apt-get install -y gksu \
    libgksu2-0 \
    libice6 \
    libsm6 \
    libnss3-tools \
    ca-certificates \
    curl \
    libasound2 \
    libdbus-glib-1-2 \
    libgtk2.0-0 \
    libxrender1 \
    libxt6 \
    apt-utils \
    ethtool \
    sysv-rc-conf \
    libjpeg62 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*
# 작업 디랙토리 이동
WORKDIR /korea-shit
#패키지 설치 작업 준비
RUN apt-get update

#사용자 계정 설정
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/korean && \
    echo "korean:x:${uid}:${gid}:korean,,,:/home/korean:/bin/bash" >> /etc/passwd && \
    echo "korean:x:${uid}:" >> /etc/group && \
    echo "korean ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/korean && \
    chmod 0440 /etc/sudoers.d/korean && \
    chown ${uid}:${gid} -R /home/korean

USER korean
ENV HOME /home/korean
