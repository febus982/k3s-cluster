FROM python:3.9-slim AS builder

RUN pip install pipenv
COPY Pipfile.lock .
COPY Pipfile .
RUN pipenv install --deploy --ignore-pipfile
COPY . .
RUN pipenv run build_docs


FROM nginx:alpine
COPY --from=builder site /usr/share/nginx/html
