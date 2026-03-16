# JellyfinOwnCustomizations

Personal customization code, Docker image, and assets for a self-hosted [Jellyfin](https://jellyfin.org/) media server.

---

## What's included

| File / Directory | Description |
|---|---|
| `Dockerfile` | Custom Jellyfin image with extra packages and branding assets baked in |
| `docker-compose.yml` | Ready-to-use Compose stack |
| `.env.example` | Template for all configurable environment variables |
| `branding/custom.css` | Custom CSS theme (dark palette, hover effects, accent colors) |
| `branding/splash.png` | *(Provide your own)* Login-page background image |

---

## Quick start

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) ≥ 24
- [Docker Compose](https://docs.docker.com/compose/install/) ≥ 2.20 (included with Docker Desktop)

### 1 – Clone the repository

```bash
git clone https://github.com/EganStark/JellyfinOwnCustomizations.git
cd JellyfinOwnCustomizations
```

### 2 – Configure environment variables

```bash
cp .env.example .env
# Edit .env with your preferred editor and set paths, ports, TZ, UID/GID, etc.
```

### 3 – (Optional) Add a custom splash image

Drop a `1920 × 1080` PNG named **`splash.png`** into the `branding/` folder.  
See `branding/SPLASH_README.txt` for details.

### 4 – Build and start

```bash
docker compose up -d --build
```

Jellyfin will be available at **http://localhost:8096** (or the port you set in `.env`).

---

## Custom CSS theme

The file `branding/custom.css` is baked into the image and loaded automatically.  
You can also paste its contents directly into:

> **Dashboard → General → Branding → Custom CSS code**

to apply the theme without rebuilding the image.

### Theme highlights

- Dark background (`#101010` / `#1a1a1a`)
- Jellyfin-blue accent (`#00a4dc`) on nav, buttons, and scrollbars
- Subtle card hover scale + shadow animation
- Styled login form centered on the page
- Slim custom scrollbars (WebKit)

---

## Hardware acceleration (optional)

Uncomment the `devices` and `group_add` sections in `docker-compose.yml` to
enable GPU transcoding:

```yaml
devices:
  - /dev/dri:/dev/dri   # Intel / AMD VAAPI
group_add:
  - render
```

For NVIDIA, add the `deploy.resources.reservations.devices` block instead
(requires the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)).

---

## Directory layout (runtime)

```
.
├── branding/
│   ├── custom.css        # CSS theme injected into the image
│   └── splash.png        # (your custom login background)
├── config/               # Jellyfin config (created on first run)
├── cache/                # Transcode cache  (created on first run)
├── media/                # Point this at your media library
├── .env                  # Local environment overrides (not committed)
├── .env.example          # Template – commit this, not .env
├── docker-compose.yml
└── Dockerfile
```

---

## Updating

```bash
# Pull the latest official Jellyfin base image and rebuild
docker compose pull
docker compose up -d --build
```

---

## License

This customization code is released under the [MIT License](LICENSE).  
Jellyfin itself is licensed under the [GNU GPL v2](https://github.com/jellyfin/jellyfin/blob/master/LICENSE).
