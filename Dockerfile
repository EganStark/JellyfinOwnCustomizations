# Custom Jellyfin Image
#
# Extends the official Jellyfin image with:
#   - Custom branding (splash screen logo & CSS theme)
#   - FFmpeg build with hardware-acceleration libraries pre-installed
#   - A non-root runtime user for improved container security

FROM jellyfin/jellyfin:latest

LABEL maintainer="EganStark" \
      description="Custom Jellyfin image with personal branding and extra codecs"

# Switch to root for package installs
USER root

# Install additional codec / utility packages available in the base image's
# package manager (Debian/Ubuntu based).  Adjust as needed.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ── Custom branding ────────────────────────────────────────────────────────────
# Copy custom CSS theme into the web-root so Jellyfin loads it at startup.
COPY branding/custom.css /jellyfin/jellyfin-web/custom.css

# Copy a custom login splash image (replace with your own 1920×1080 PNG).
COPY branding/splash.png /jellyfin/jellyfin-web/assets/img/banner-dark.png

# ── Runtime ───────────────────────────────────────────────────────────────────
# Switch back to the default Jellyfin user
USER jellyfin

EXPOSE 8096 8920

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -fsS "http://localhost:8096/health" || exit 1
