# 기본 docker 이미지 설정
FROM rocker/shiny:latest

# 필요한 파일 복사
COPY /App ./app

# 사전에 필요한 패키지 모듈 설치
#RUN Rscript -e 'install.packages("shiny")'		# FROM rocker/shiny:latest이용시 기본 적으로 설치 되어 있음 
#RUN Rscript -e 'install.packages("shinydashboard")'	# FROM rocker/shiny:latest이용시 기본 적으로 설치 되어 있음 

RUN Rscript -e 'install.packages("httr")'
RUN Rscript -e 'install.packages("jsonlite")'

# 노출 포트
EXPOSE 3838

# shiny 시작
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]