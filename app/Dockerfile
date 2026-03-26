FROM python:3.11-slim

WORKDIR /app
RUN useradd -m p41user
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY main.py .

RUN chown -R p41user:p41user /app
USER p41user

EXPOSE 8080
CMD ["python", "main.py"]
