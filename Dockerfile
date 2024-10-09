#FROM nvidia/cuda:12.6.1-cudnn-runtime-ubuntu20.04
FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04
#FROM python:3.10
#FROM tensorflow/tensorflow:latest-gpu-jupyter

#USER root
RUN apt-get update && \
    apt-get install -y python3-pip python3-dev python-is-python3 && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install jupyterlab && \
    pip install ipywidgets && \
    pip install voila && \
    pip install transformers && \
    pip install accelerate && \
    pip install torch && \
    pip install pandas && \
    pip install numpy && \
    pip install matplotlib && \
    pip install "tensorflow[and-cuda]"

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter

#RUN jupyter lab --generate-config

EXPOSE 80

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--notebook-dir=/home/jupyter/projects"]
