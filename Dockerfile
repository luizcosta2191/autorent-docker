# Stage: serve static site with Nginx Alpine
FROM nginx:alpine

# Remove default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom Nginx server block configuration
COPY nginx/autorent.conf /etc/nginx/conf.d/autorent.conf

# Copy site files to the web root
COPY html/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx in the foreground (required for Docker)
CMD ["nginx", "-g", "daemon off;"]
