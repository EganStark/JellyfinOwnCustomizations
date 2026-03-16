Place your custom splash / login background image here.

File name : splash.png
Recommended size : 1920 × 1080 px  (PNG or JPEG)

This file is copied by the Dockerfile into the Jellyfin web assets directory,
replacing the default dark banner on the login page:

    /jellyfin/jellyfin-web/assets/img/banner-dark.png

Steps
-----
1. Create or export your custom image and save it as  branding/splash.png
2. Rebuild the Docker image:

       docker compose build --no-cache

3. Restart the container:

       docker compose up -d

The login page will now display your custom background.
