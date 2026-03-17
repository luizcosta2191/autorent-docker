# AutoRent — Infrastructure as Code

> A complete local development environment for a car rental web application, containerized with **Docker + Nginx**. A single command brings up the entire infrastructure, identical for every developer.

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

> 🚀 **Performance highlight:** ~33,000 req/s with 0% error rate — measured with Apache Benchmark after Nginx tuning.

---

## Table of Contents

- [Overview](#overview)
- [What I Practiced](#what-i-practiced)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Accessing the Application](#accessing-the-application)
- [Infrastructure Details](#infrastructure-details)
- [Performance](#performance)
- [The Application](#the-application)

---

## Overview

The goal of this project is not simply to host a website — it's to create a **repeatable, resilient, and high-performance environment** where any developer runs a single command and gets the exact same setup locally.

The infamous *"it works on my machine"* problem is eliminated by design: the entire environment is defined as code, containerized, and version-controlled.

```bash
docker compose up --build
# → image built, Nginx configured, site live at http://localhost
```

> 📸 **Screenshot:** *(add a screenshot or GIF of the running application here)*

---

## What I Practiced

- **Infrastructure as Code (IaC)** — entire environment defined and version-controlled as code
- **Docker containerization** — application packaged as a portable, reproducible image
- **Nginx configuration** — custom server block inside an Alpine-based container
- **Developer Experience (DevEx)** — zero-friction setup with a single command, no VMs required
- **Async API integration** — Fetch API with JSON payload and mock backend response handling

---

## Tech Stack

| Layer | Tool | Role |
|---|---|---|
| Containerization | Docker + Docker Compose | Packages and orchestrates the application |
| Web Server | Nginx (Alpine) | Serves static files, routing |
| Base Image | nginx:alpine | Lightweight (~40 MB), production-ready |
| Frontend | HTML5 + JavaScript | Car rental UI with async booking flow |

---

## Project Structure

```
AutoRent/
├── html/
│   ├── img/
│   │   ├── carro1.jpg
│   │   ├── carro2.jpg
│   │   └── carro3.jpg
│   └── index.html
├── nginx/
│   └── autorent.conf
├── Dockerfile
└── docker-compose.yml
```

---

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) `>= 24.0`
- [Docker Compose](https://docs.docker.com/compose/install/) `>= 2.0` (included in Docker Desktop)

---

## Getting Started

**1. Clone the repository**

```bash
git clone https://github.com/luizcosta2191/autorent-docker.git
cd autorent-docker
```

**2. Build and start the container**

```bash
docker compose up --build
```

**3. Run in detached mode (background)**

```bash
docker compose up --build -d
```

**4. Stop the container**

```bash
docker compose down
```

---

## Accessing the Application

Once `docker compose up` completes, the application is available at:

| Method | URL |
|---|---|
| Local | `http://localhost` |
| Custom domain | `http://autorent.local` — add `127.0.0.1 autorent.local` to `/etc/hosts` |

---

## Infrastructure Details

### Dockerfile

Builds the application image from `nginx:alpine`:

1. Removes the default Nginx configuration
2. Copies the custom server block from `nginx/autorent.conf`
3. Copies all site files to `/usr/share/nginx/html`
4. Exposes port 80 and starts Nginx in the foreground

### docker-compose.yml

Orchestrates the service:
- Builds the image from the local `Dockerfile`
- Maps port `80` on the container to port `80` on the host
- Mounts `./html` as a bind volume for live reload during development
- Sets `restart: unless-stopped` for resilience

### Nginx Configuration (`nginx/autorent.conf`)

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name autorent.local localhost;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

---

## Performance

During stress testing with **Apache Benchmark**, after tuning Nginx's `worker_connections`:

| Metric | Result |
|---|---|
| Requests per second | **~33,000 req/s** |
| Error rate | **0%** |
| Testing tool | Apache Benchmark (`ab`) |

Using `nginx:alpine` as the base image means the container starts in seconds and the tuned configuration is baked directly into the image.

---

## The Application

**AutoRent** is a car rental web application demonstrating async API integration.

**Features:**
- Vehicle catalogue with three categories (Economy, Family SUV, Premium Sports)
- Booking modal with dynamic total calculation based on number of days
- Payment simulation via **Fetch API**, sending JSON data to a mock backend ([jsonplaceholder.typicode.com](https://jsonplaceholder.typicode.com))
- Booking confirmation code returned by the API

---

## 📄 License

MIT — feel free to use, modify, and distribute.
