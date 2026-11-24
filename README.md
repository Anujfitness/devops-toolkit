# 🛠️ DevOps Toolkit

Linux shell scripts + Docker + Git se bana ek chhota DevOps project. Ye server ki health monitor karta hai aur data ka automatic backup leta hai (purane backups rotate hote hain).

## Features
- **health_check.sh** – CPU, RAM, Disk usage check, threshold par warning, log file me record
- **backup.sh** – folder ka `.tar.gz` backup + rotation (latest N rakhta hai)
- **git_report.sh** – kisi bhi Git repo ka quick summary (commits, contributors, status)
- **Docker** – sab kuch container me chalta hai, `docker compose up` se start
- **Makefile** – short commands

## Project Structure
```
devops-toolkit/
├── scripts/
│   ├── health_check.sh
│   ├── backup.sh
│   ├── git_report.sh
│   └── entrypoint.sh
├── Dockerfile
├── docker-compose.yml
├── Makefile
├── logs/  backups/  data/
└── README.md
```

## Quick Start
```bash
git clone https://github.com/<your-username>/devops-toolkit.git
cd devops-toolkit

# Bina Docker ke (Linux)
./scripts/health_check.sh
./scripts/backup.sh ./data ./backups 5
./scripts/git_report.sh .

# Docker ke saath
docker compose up -d --build
docker compose logs -f
```

## Configuration (environment variables)
| Variable | Default | Matlab |
|---|---|---|
| `CPU_LIMIT` | 80 | CPU % warning limit |
| `MEM_LIMIT` | 80 | RAM % warning limit |
| `DISK_LIMIT` | 80 | Disk % warning limit |
| `INTERVAL` | 60 | Kitne second baad check repeat ho |
| `KEEP_BACKUPS` | 5 | Kitne latest backups rakhne hain |

## Concepts Covered
Bash scripting (functions, loops, `set -euo pipefail`), `/proc` filesystem, `tar`/`xargs`, Docker volumes & env vars, Docker Compose, Git workflow, Makefile.

## Future Ideas
- Email/Telegram alerts
- Cron based scheduling
- GitHub Actions se ShellCheck CI

## License
MIT
