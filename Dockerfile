# Use an official Python image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY src/requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy the app files
COPY src/ .

# Expose port 5000
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
