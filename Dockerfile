FROM codeberg.org/forgejo/forgejo:16.0.3

# Disable SSH to allow Render's SSH proxy to work
RUN rm -rf /etc/s6/openssh && \
    apk del --no-cache openssh openssh-server openssh-client 2>/dev/null || true
RUN apk add nano
