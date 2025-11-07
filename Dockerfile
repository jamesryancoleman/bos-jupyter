FROM quay.io/jupyter/base-notebook:latest

USER root
RUN mkdir -p /opt/bospy/ && \
    chown -R $NB_UID:$NB_GID /opt/bospy/
RUN mkdir -p /opt/data/ && \
    chown -R $NB_UID:$NB_GID /opt/data/
USER $NB_UID

RUN python -m pip install grpcio-tools
RUN python -m pip install grpcio
RUN python -m pip install rdflib
RUN python -m pip install pandas
RUN python -m pip install matplotlib

RUN mkdir -p /opt/bospy/
WORKDIR /opt/bospy/

COPY bindings/python/bospy/ /opt/bospy/
RUN pip install -e .

# Copy application code
RUN  pip install --upgrade grpcio
RUN  pip install --upgrade protobuf

WORKDIR /opt/data/

