FROM ubuntu:18.04
LABEL maintainer="https://github.com/kirilldenisov"

RUN mkdir /app; mkdir /app/Data
WORKDIR /app
COPY . /app
RUN chmod +x /app/run_snake.py

RUN ls -la Data
RUN ls -la 
RUN ls -la /app

RUN apt-get -qq update && apt-get -qq -y install curl build-essential

RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && conda install -y python=3.6.10 snakemake=3.13.3 plink=1.90b4 -c bioconda

RUN curl -L http://gusevlab.org/projects/germline/release/germline-1-5-3.tar.gz > germlinedir.tar.gz \
    && tar xzvf germlinedir.tar.gz && cd germline-1-5-3 && make all && mv germline .. && cd .. \
    && chmod +x germline 

# RUN rm -rf /tmp/miniconda.sh \
#     && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
#     && conda clean --all --yes \
#     && rm -rf germline-1-5-3 germlinedir.tar.gz \
#     && apt-get -qq -y remove curl build-essential \
#     && apt-get -qq -y autoremove \
#     && apt-get autoclean

ENTRYPOINT ["python", "/app/run_snake.py"]