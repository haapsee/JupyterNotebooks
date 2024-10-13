FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04

COPY requirements.txt requirements.txt

RUN apt-get update && \
    apt-get install -y python3-pip python3-dev python-is-python3 graphviz && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install -r requirements.txt
RUN pip install --upgrade scikit-learn jupyterlab ipywidgets voila transformers accelerate torch pandas numpy matplotlib tensorflow[and-cuda] pydot

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter

EXPOSE 80

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--notebook-dir=/home/jupyter/projects"]
