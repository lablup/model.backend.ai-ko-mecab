# ko-mecab RESTful API Service
FROM hephaex/ubuntu
MAINTAINER Mario Cho <m.cho@lablup.com>

# Build essentials
RUN apt-get update \
  && apt-get install -y autotools-dev autoconf automake \
  && apt-get install -y python3 python3-pip curl git sudo cron \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# build mecab
WORKDIR /opt
RUN git clone https://github.com/hephaex/mecab.git
WORKDIR /opt/mecab/mecab
RUN ./configure  --enable-utf8-only \
  && make \
  && make check \
  && make install \
  && ldconfig

# build mecab-ko-dic
WORKDIR /opt/mecab
RUN curl -fsSL https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.0.3-20170922.tar.gz |tar xvz && \
    mv mecab-ko-dic-2.0.3-20170922 mecab-ko-dic
WORKDIR /opt/mecab/mecab-ko-dic
RUN ./autogen.sh \
 && ./configure --with-charset=utf8 \
 && make  \
 && make install

RUN echo "dicdir = /usr/local/lib/mecab/dic/mecab-ko-dic" > /usr/local/etc/mecabrc

# ready mecab service
ADD ko-mecap.py /opt/mecab/api
WORKDIR /opt/mecab/api
RUN pip3 install -U pip setuptools  \
 && pip3 install -r requirements.txt

CMD ["python3", "ko-mecab.py"]