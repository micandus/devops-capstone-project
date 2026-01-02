FROM python:3.9-slim

#Create container enviorment
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

#Copy app contents
COPY service/ ./service/

#Create user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

#Start service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]