FROM python
# we are asking to docker that plz pull python image from docker hub 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com
# above info is optional but this is about your self 
RUN mkdir  /ashucode 
# in this image create a folder-- you can give any command 
COPY hcl.py /ashucode/hcl.py
# copy code from docker client to docker server inside image which we are building  
CMD ["python","/ashucode/hcl.py"]
# we use cmd to fix the default process of image 
