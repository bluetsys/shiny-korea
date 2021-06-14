Shiny.addCustomMessageHandler("roadviewshow",
  function(message) {
    map.addOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);  
  }
);

Shiny.addCustomMessageHandler("roadviewhide",
  function(message) {
    map.removeOverlayMapTypeId(kakao.maps.MapTypeId.ROADVIEW);  
  }
);

Shiny.addCustomMessageHandler("panto",
  function(message) {
    // 이동할 위도 경도 위치를 생성합니다 
        var moveLatLon = new kakao.maps.LatLng(message.lat, message.long);
        map.panTo(moveLatLon);
  }
);

var count = 0;
Shiny.addCustomMessageHandler("markershow",
  function(message) {
        // 마커가 표시될 위치입니다 
        var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 

        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });

        // 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function() {
            Shiny.onInputChange("count", count++);
        });
  }
);