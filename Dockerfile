FROM docker.oa.com:8080/public/ailab-py3-torch-video:latest AS dependency

WORKDIR /nes/

COPY setup.py ./setup.py

RUN python -c "import distutils.core;s=distutils.core.run_setup('setup.py').install_requires;f=open('requirements_tmp.txt', 'w');[f.write(v+'\n') for v in s];f.close()" && cat requirements_tmp.txt

RUN pip install -r requirements_tmp.txt

FROM dependency as base

ADD . ./

RUN pip install .[all]

WORKDIR /

ENTRYPOINT ["gnes"]