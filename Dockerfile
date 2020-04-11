FROM tiangolo/uwsgi-nginx:python2.7-alpine3.8

LABEL maintainer="Sebastian Ramirez <tiangolo@gmail.com>"

RUN sudo apt-get install pkg-config python-opencv

RUN pip install --no-cache-dir flask flask_sqlalchemy flask_httpauth

RUN pip install --no-cache-dir redis natsort psutil werkzeug itsdangerous passlib numpy requests  matplotlib scikit-image scipy scikit-learn


# URL under which static (not modified by Python) files will be requested
# They will be served by Nginx directly, without being handled by uWSGI
ENV STATIC_URL /static
# Absolute path in where the static files wil be
ENV STATIC_PATH /app/static

# If STATIC_INDEX is 1, serve / with /static/index.html directly (or the static URL configured)
# ENV STATIC_INDEX 1
ENV STATIC_INDEX 0

# Make /app/* available to be imported by Python globally to better support several use cases like Alembic migrations.
ENV PYTHONPATH=/app

# Run the start script provided by the parent image tiangolo/uwsgi-nginx.
# It will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Supervisor, which in turn will start Nginx and uWSGI
CMD ["python"]
