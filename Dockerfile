# Use an official Python runtime as a parent image
FROM python:3.10

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV ODOO_USER=odoo

# Create a user for running Odoo
RUN useradd -m -d /home/${ODOO_USER} -U -r -s /bin/bash ${ODOO_USER}

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    postgresql-client \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    libpq-dev \
    libsasl2-dev \
    libldap2-dev \
    libffi-dev \
    libssl-dev \
    libjpeg62-turbo-dev \
    liblcms2-dev \
    libblas-dev \
    libatlas-base-dev \
    liblapack-dev \
    python3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy Odoo source code to /odoo
COPY . /odoo

# Set the working directory
WORKDIR /odoo

# Install Python dependencies for Odoo
RUN pip install -r requirements.txt

# Set file ownership
RUN chown -R ${ODOO_USER}:${ODOO_USER} /odoo

# Switch to the created user
USER ${ODOO_USER}

# Expose Odoo service port
EXPOSE 8069

# Run Odoo
CMD ["python", "/odoo/odoo-bin","-s", "-c", "/etc/odoo/odoo.conf"]
