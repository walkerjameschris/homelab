FROM quay.io/jupyter/minimal-notebook:latest

# Install uv for Python project and venv management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# System utilities for REPL and programming assistance
RUN pip install nb_venv_kernels
RUN curl -fsSL https://opencode.ai/install | bash

# Apply user settings and switch to non-root user
COPY overrides.json /opt/conda/share/jupyter/lab/settings/overrides.json
USER jovyan
