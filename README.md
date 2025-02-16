# Peercoin UTXO Dump Generator

This project automates the generation of UTXO (Unspent Transaction Output) dumps for the Peercoin blockchain at specified block heights using Docker and GitHub Actions.

## Features

- Builds a custom Peercoin node with stop-at-height functionality
- Synchronizes blockchain up to a specified height
- Generates UTXO snapshots
- Automated GitHub Actions workflow
- Dockerized environment for consistency
- Taskfile-based local execution

## Prerequisites

- Docker (for local execution)
- Taskfile (optional for local execution)
- GitHub account (for CI/CD workflow)

## Getting Started

### Local Execution

1. Clone the repository:
   ```bash
   git clone https://github.com/patchcoin/peercoin-utxo-dump.git
   cd peercoin-utxo-dump
   ```

2. Build the Docker image:
   ```bash
    task build
   ```

3. Sync blockchain and generate UTXO dump (default height 1000):
   ```bash
   task sync dump-utxos
   ```

### GitHub Actions Workflow

1. Navigate to your repository's Actions tab
2. Select Peercoin UTXO Dump
3. Click Run workflow
4. Specify desired block height (default: 1000)
5. Monitor workflow execution
6. Download UTXO dump from created release

### Workflow Details

The GitHub workflow (dump-utxos.yml):
1. Builds patched Peercoin node
2. Synchronizes blockchain to specified height
3. Generates UTXO snapshot
4. Creates GitHub release with:
   - peercoin_utxos.dat file

### Customization

#### Environment Variables

|**Variable** | **Default** | **Description**               |
|-------------|-------------|-------------------------------|
|`STOP_HEIGHT`| 	1000    | Target block height for UTXOs |

#### Taskfile Commands

```bash
# Build Docker image
task build

# Sync to specific height (e.g., 50000)
env STOP_HEIGHT=50000 task sync

# Generate UTXO dump
task dump-utxos
```

### Technical Components

####  Key Files

| **File**                                 | **Purpose**                             |
|------------------------------------------|-----------------------------------------|
| `.github/workflows/dump-utxos.yml`       | GitHub Actions workflow definition      |
| `Dockerfile`                             | Container build configuration           |
| `taskfile.yml`                           | Task automation configuration           |
| `0001-enforce-stopatheight-option.patch` | Peercoin stop-at-height implementation  |

Patch Features
- Enforces -stopatheight parameter
- Prevents block processing beyond target height
- Maintains chain validity checks
- Compatible with Peercoin v0.15
