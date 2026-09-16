FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]