FROM python:3.9

RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH \
    POETRY_VERSION=1.1.13 \
    POETRY_HOME=/home/user/.poetry \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false
WORKDIR $HOME/app

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Add PATH for the Poetry and Poetry's bin directory
ENV PATH="$POETRY_HOME/bin:$PATH"

# Copy the project files to the container
COPY --chown=user . $HOME/app

# Install project dependencies
RUN poetry install --no-dev

# Command to run the application
CMD ["streamlit", "run", "app.py", "--server.port", "7860"]