FROM python:3.9-slim AS builder

RUN pip install pipenv
COPY Pipfile.lock .
COPY Pipfile .
RUN pipenv install --deploy --ignore-pipfile
COPY . .
RUN pipenv run build_docs
RUN pwd

# Python image to use.
FROM nginx

COPY --from=builder site /usr/share/nginx/html