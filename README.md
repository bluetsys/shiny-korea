# shiny-korea
shiny-korea


### 개발 환경
``` sh
docker build --tag {허브이름}/{저장소이름} .
docker push {허브이름}/{저장소이름}
```

### 운영 환경
``` sh
sudo docker pull {허브이름}/{저장소이름}
sudo docker run --rm -p 8077:3838 {허브이름}/{저장소이름}
```


https://hub.docker.com/r/rocker/shiny

### 카카오 개발자 콘솔
https://developers.kakao.com/console


### 카카오 지도 문서
https://apis.map.kakao.com/web/sample/basicMap/
https://apis.map.kakao.com/web/sample/basicMarker/
https://apis.map.kakao.com/web/sample/addMarkerClickEvent/

### 카카오 로그인 문서
https://developers.kakao.com/docs/latest/ko/kakaologin/common
https://developers.kakao.com/docs/latest/ko/kakaologin/common#login
https://developers.kakao.com/docs/latest/ko/kakaologin/common#user-info

