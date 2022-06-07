FROM openjdk:8 
LABEL email=ashutoshh@linux.com
RUN mkdir /javacode/
COPY hcl.java /javacode/hcl.java
WORKDIR /javacode
# use of WORKDIR is to change folder location for this image
RUN javac hcl.java
# compiling code
CMD ["java","hcl"]
# defining parent process for docker image 
