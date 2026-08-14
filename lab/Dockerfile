# Pull minimal JupyterLab IDE
FROM quay.io/jupyter/minimal-notebook:latest

# Add tools to manage Python versions, venvs, and kernels 
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN pip install nb_venv_kernels

# Apply settings and switch to non-root user
COPY overrides.json /opt/conda/share/jupyter/lab/settings/overrides.json
COPY jupyter_server_config.py /home/jovyan/.jupyter/jupyter_server_config.py
USER jovyan
