FROM quay.io/jupyter/minimal-notebook

# Install tooling for Python env management
COPY --from=ghcr.io/astral-sh/uv /uv /uvx /bin/
RUN pip install nb_venv_kernels

# Configure Dark Theme override
RUN mkdir -p /opt/conda/share/jupyter/lab/settings && \
    echo '{"@jupyterlab/apputils-extension:themes":{"theme":"JupyterLab Dark"}}' \
    > /opt/conda/share/jupyter/lab/settings/overrides.json

# Set .ipynb_checkpoints/ directories to be saved in /tmp directory
RUN mkdir -p ~/.jupyter && \
    echo "c=get_config();c.FileCheckpoints.checkpoint_dir='/tmp'" \
    > ~/.jupyter/jupyter_server_config.py

USER jovyan
