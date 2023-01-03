FROM alpine:3.16
LABEL Maintainer="Sivakumar Vunnam"

# Install dependencies
RUN apk add --no-cache bash curl jq

# Create app directory and copy the entrypoint.sh script into it
RUN mkdir /app
COPY . /app/entrypoint.sh

# Make the entrypoint.sh script executable
RUN chmod 775 /app/entrypoint.sh

# Set the entrypoint to the entrypoint.sh script
ENTRYPOINT ["/app/entrypoint.sh"]
