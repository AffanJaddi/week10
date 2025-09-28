# syntax=docker/dockerfile:1

# ===== Build static assets =====
FROM node:20 AS build
WORKDIR /app

# Install deps
COPY package*.json ./
RUN npm ci

# Copy sources and build
COPY . .
# Change this if your build command differs
RUN npm run build

# ===== Serve with nginx =====
FROM nginx:1.27-alpine
# If your build output directory is not "dist", change the next line
COPY --from=build /app/dist/ /usr/share/nginx/html/

# Optional: custom nginx default.conf (uncomment if you add one)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget -qO- http://localhost/ >/dev/null 2>&1 || exit 1

CMD ["nginx","-g","daemon off;"]
