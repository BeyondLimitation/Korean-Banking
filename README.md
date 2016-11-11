# Korean-Banking
[![](https://images.microbadger.com/badges/version/beyondlimitation/banking.svg)](https://microbadger.com/images/beyondlimitation/banking "Get your own version badge on microbadger.com")

한국 은행 서비스용 Docker App

## Stable 버전 배포 시작.

현 지원 은행
>현재 가능한 은행 서비스는 ✓ 표시된 것들 모두 입니다.
>나머지 은행은 준비 중 입니다.

 - [X] IBK
 - [X] KB
 - [] KEB Hana
 - [] Shinhan
 - [] Woori

## 개발자 후기
![fuck-this](https://cloud.githubusercontent.com/assets/10960326/19426459/b0a74b54-9477-11e6-80f9-fb6c384020ed.jpg)

##주의사항
최신 Image와 Dockerfile을 대조 하면 뭔가 다른걸 알 수 있습니다. Container 내부가 수정 되고 그걸 Image로 배포하는 과정에서 차이가 생긴 것이니 변경 사항은 Wiki를 참조 하시기 바랍니다.

## 개발
먼저 저장소에 있는 Dockerfile중 #Systemd 관련 내용들을 전부 복사하세요. systemd작동을 위해 필수 입니다.
그 다음 docker run -ti -P --tmpfs /run --tmpfs /tmp --tmpfs /run/lock --stop-signal SIGRTMIN+3 --cap-add=SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro --log-driver=syslog

설명: -ti 는 container에서 일어나는 일들을 stdin으로 입력받아 상세한 상황을 읽습니다.
--tmpfs 는 mount 시킬 해당 directory를 tmpfs filesystem으로써 mount 시킵니다.
--stop-signal 은 systemd로 작동되는 container로 만들기 위함 입니다. systemd를 쓰기 위해 systemd로 종료되고 시작하기 위해 종료 signal이 설정되어야 합니다.

이에 관한 전문적인 설명을 듣고 싶으시면 아래 링크를 누르시면 됩니다.
http://developers.redhat.com/blog/2016/09/13/running-systemd-in-a-non-privileged-container/
