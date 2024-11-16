FROM python:3.11

RUN apt-get update && apt-get install -y \
    python3-distutils \
    python3-dev \
    build-essential \
    && apt-get clean

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN python manage.py makemigrations && \
    python manage.py migrate && \
    python manage.py test

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

EXPOSE 8000
