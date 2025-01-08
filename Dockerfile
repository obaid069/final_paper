FROM ubuntu:latest
COPY file.txt /file.txt
CMD ["cat", "/file.txt"]
