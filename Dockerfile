FROM python:3.11

RUN apt-get update && apt-get install -y \
    python3-distutils \
    python3-dev \
    build-essential

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn

COPY . .

RUN python manage.py makemigrations && \
    python manage.py migrate && \
    python manage.py test

# Use Gunicorn to serve the Django application
CMD ["gunicorn", "school_app.wsgi:application", "--bind", "0.0.0.0:8000"]

EXPOSE 8000
