FROM quay.io/jupyter/base-notebook:latest

USER root
RUN mkdir -p /opt/bospy/ && \
    chown -R $NB_UID:$NB_GID /opt/bospy/
# RUN mkdir -p /opt/data/ && \
#     chown -R $NB_UID:$NB_GID /opt/data/
USER $NB_UID

# bospy dependancies and extras
COPY apps/jupyter/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# bospy
RUN mkdir -p /opt/bospy/
WORKDIR /opt/bospy/

COPY bindings/python/bospy/ /opt/bospy/
RUN pip install -e .

COPY apps/jupyter/overrides.json /opt/conda/share/jupyter/lab/settings/overrides.json

ENV SYSMOD_ADDR=nuc.local:2821
ENV DEVCTRL_ADDR=nuc.local:2822 
ENV HISTORY_ADDR=nuc.local:2823
ENV FORECAST_ADDR=nuc.local:2825 
ENV SCHEDULER_ADDR=nuc.local:2824

WORKDIR /opt/data/

