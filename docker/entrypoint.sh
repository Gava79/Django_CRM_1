#!/bin/bash

# Ensure the wait-for-postgres.sh script is executable
chmod +x ./wait-for-postgres.sh

# Wait for PostgreSQL to be available
./wait-for-postgres.sh "$DBHOST" "$DBPORT"

# Collect static files
python3 manage.py collectstatic --noinput

python manage.py makemigrations

# Apply database migrations
python3 manage.py migrate

# Start the Django development server
python3 manage.py runserver 0.0.0.0:8000
