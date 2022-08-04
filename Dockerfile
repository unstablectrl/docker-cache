FROM python:3.7.4-alpine AS builder
COPY requirements.txt /app/
WORKDIR /app
RUN pip install -r requirements.txt --no-cache-dir

FROM python:3.7.4-alpine AS app
COPY --from=builder /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages
COPY --from=builder /usr/local/bin/flask /usr/local/bin/flask
COPY . /app
WORKDIR /app
CMD ["flask", "run"]
