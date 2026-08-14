FROM quay.io/jupyter/minimal-notebook:latest
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN pip install nb_venv_kernels
COPY overrides.json /opt/conda/share/jupyter/lab/settings/overrides.json
USER jovyan
