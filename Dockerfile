FROM python:3.10

WORKDIR /app
COPY Requirements.txt Requirements.txt
RUN pip install -r Requirements.txt

COPY . .
CMD ["python", "app.py"]