FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04

COPY requirements.txt requirements.txt

RUN apt-get update && \
    apt-get install -y nvidia-cuda-toolkit python3-pip python3-dev python-is-python3 graphviz wget unzip zip pkg-config cmake libcairo2-dev && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    echo "done"
RUN pip install --upgrade scikit-learn jupyterlab ipywidgets transformers accelerate torch pandas numpy matplotlib tensorflow[and-cuda] tensorflow_hub pydot tensorflow-datasets

RUN useradd -ms /bin/bash jupyter
RUN mkdir -p /home/jupyter/.jupyter/lab/user-settings/
RUN chown -R jupyter /home/jupyter/.jupyter/

USER jupyter
WORKDIR /home/jupyter

RUN export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

EXPOSE 80
EXPOSE 6006

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--notebook-dir=/home/jupyter/projects", "--debug", "--ServerApp.iopub_msg_rate_limit=1000000"]
