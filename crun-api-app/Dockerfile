# Use official Python image as base
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Set the port (Cloud Run expects 8080)
ENV PORT=8080

# Run the app using Gunicorn
CMD ["gunicorn", "-b", ":8080", "app:app"]
