FROM python:3

WORKDIR /app

COPY demosite/requirements.txt ./

RUN pip install -U pip && pip install -r requirements.txt

COPY demosite/ .
COPY docker-entrypoint.sh docker-entrypoint.sh

RUN python ./manage.py collectstatic --clear --no-input && python ./manage.py migrate --no-input && python ./manage.py initadmin

EXPOSE 8000

ENTRYPOINT ["/app/docker-entrypoint.sh"]

CMD ["gunicorn", "-b", "0.0.0.0:8000", "demosite.wsgi:application"]