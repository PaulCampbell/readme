FROM stackbrew/ubuntu:raring

RUN apt-get update
RUN apt-get install -y --force-yes git-core

# -------- Install Tesseract OCR and dependencies ---------
RUN apt-get install -y --force-yes libpng-dev libjpeg-dev libtiff-dev zlib1g-dev
RUN apt-get install -y --force-yes gcc g++
RUN apt-get install -y --force-yes autoconf automake libtool wget checkinstall

# Install Leptonica
RUN wget http://www.leptonica.org/source/leptonica-1.69.tar.gz
RUN tar -zxvf leptonica-1.69.tar.gz
RUN ./leptonica-1.69/configure
RUN make
RUN checkinstall
RUN ldconfig

# man. there's quite a lot oh this stuff
# Install Tesseract OCR
RUN wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.02.tar.gz
RUN tar -zxvf tesseract-ocr-3.02.02.tar.gz
RUN cd tesseract-ocr; ./autogen.sh
RUN ./tesseract-ocr/configure
RUN make
RUN make install
RUN ldconfig

# Give Tesseract some training data.
RUN wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.eng.tar.gz
RUN tar xf tesseract-ocr-3.02.eng.tar.gz
RUN cp tesseract-ocr/tessdata/*.* /usr/local/share/tessdata/
RUN export TESSDATA_PREFIX=/usr/local/share
# -------- Thank the lord ---------

# application bits
RUN apt-get -y install software-properties-common

RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -y install nodejs
RUN npm config set registry http://registry.npmjs.org/

# add the app and run it up
Add ./src ./read-me
RUN cd /read-me ; npm install
EXPOSE  8080
CMD ["node", "/read-me/app.js"]
