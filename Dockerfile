FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04

COPY requirements.txt requirements.txt

RUN apt-get update && \
    apt-get install -y nvidia-cuda-toolkit python3-pip python3-dev python-is-python3 graphviz wget unzip zip pkg-config cmake && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    echo "done"
RUN pip install --upgrade scikit-learn jupyterlab ipywidgets transformers accelerate torch pandas numpy matplotlib tensorflow[and-cuda] pydot

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter

RUN export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

EXPOSE 80

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--notebook-dir=/home/jupyter/projects", "--debug"]
