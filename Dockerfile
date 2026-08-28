FROM python:3.9-slim

# Configuration d'environnement
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=noethysweb.settings

WORKDIR /usr/src/app

# Dépendances système minimales
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copie de tout le code source d'abord
COPY . .

WORKDIR /usr/src/app/noethysweb
RUN chmod +x ./manage.py

# Commande de démarrage finale avec l'ajout de django-dbbackup
CMD ["/bin/bash", "-c", "pip install --no-cache-dir 'django>=3.2,<4.0' django-autocomplete-light==3.9.4 'django-crispy-forms>=1.14.0,<2.0' 'django-debug-toolbar>=3.2,<4.0' 'django-extensions>=3.1.5' 'django-import-export>=2.8.0,<3.0' 'django-q2>=1.6.2' django-datatable-view-compat==0.8.7 'django-select2>=7.10.0' 'django-summernote>=0.8.20.0' 'django-colorfield>=0.6.3' 'django-js-asset>=2.0' 'django-anymail>=8.0' 'django-formtools>=2.3' 'django-axes>=5.0,<6.0' 'django-simple-captcha>=0.5.17' 'django-bootstrap4>=22.3' 'django-mathfilters>=1.0.0' 'django-upload-form==0.5.0' 'django-dbbackup>=4.0' 'requests>=2.28.0' 'pillow>=10.0.0' 'psycopg2-binary>=2.9.3' 'gunicorn>=21.2.0' && ./manage.py collectstatic --noinput && ./manage.py migrate && gunicorn noethysweb.wsgi --bind 0.0.0.0:10000"]
