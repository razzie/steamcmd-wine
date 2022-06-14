FROM cm2network/steamcmd:root

RUN apt update && apt install -y wine gettext-base xvfb x11-utils
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y wine32
RUN rm -rf /var/lib/apt/lists/*
ENV DISPLAY=:99
RUN winecfg

RUN mkdir /app
COPY install.sh /app/
COPY entrypoint.sh /app/
RUN chmod +x /app/install.sh
RUN chmod +x /app/entrypoint.sh
RUN chown -R steam /app

USER steam
WORKDIR /app
ENTRYPOINT [ "/app/entrypoint.sh" ]