# Use official R image
FROM r-base:4.3.2

# Install system deps for LaTeX
RUN apt-get update && apt-get install -y \
    texlive-latex-base texlive-fonts-recommended texlive-latex-extra \
    libcurl4-openssl-dev libssl-dev libxml2-dev

# Install R packages
RUN R -e "install.packages(c('ggplot2','ggmosaic'), repos='https://cloud.r-project.org/')"

WORKDIR /app
COPY . .

# Default: run analysis and build PDF report
CMD ["bash", "-lc", "bash scripts/run_citonga.sh && make report"]
