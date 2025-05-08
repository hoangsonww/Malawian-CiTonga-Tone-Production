#!/usr/bin/env bash
# Run the CiTonga tone analysis

set -euo pipefail

echo "[$(date)] Running CiTonga tone analysis..."
Rscript citonga_tone_analysis.R
echo "[$(date)] Analysis complete."
