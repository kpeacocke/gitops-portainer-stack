# Portainer host bootstrap

Portainer must remain recoverable when Portainer itself is unavailable. Run
this compose project from the NAS shell, not as a Portainer-managed Git stack.

## Install or update

```sh
git clone https://github.com/kpeacocke/gitops-portainer-stack.git
cd gitops-portainer-stack
cp stack/.env.sample stack/.env
# Fill the license and existing agent secret in stack/.env.
cd stack
docker compose pull
docker compose up -d
```

The Synology reverse proxy must target `http://127.0.0.1:9080`. The public entry
point remains `https://portainer.ambitiouscake.com`; port 9080 is loopback-only.

## Backup and recovery

Portainer state is under `/volume1/dkrcfg/portainer`. Include that directory in
NAS snapshots and the off-NAS mirror. Portainer's native **Scheduled local
backup** runs daily at `02:30` (`30 2 * * *`) with 30-day retention. These
backups remain inside Portainer's mapped `/data` storage, so the off-NAS mirror
must include the entire host directory above.

The local schedule protects against Portainer database corruption and operator
error. It does not protect against loss of the NAS until the mirror completes.

Recovery does not require Portainer:

1. Restore `/volume1/dkrcfg/portainer`.
2. Restore `stack/.env` from the secret store.
3. Run `docker compose up -d` over SSH.
4. Verify the Synology proxy and reconnect agents if their shared secret changed.

For a filesystem copy without an atomic snapshot, briefly stop Portainer first.

Image-update monitoring is deliberately separated into
[`gitops-watchtower-stack`](https://github.com/kpeacocke/gitops-watchtower-stack).

## Portainer configuration baseline

The following settings are stored in Portainer's database rather than Compose.
They are documented here so a restore can be audited against the intended
state:

- Environment `alexandria` is assigned to group `production-nas` with tags
  `production` and `nas`.
- Environments `pi-harmony`, `pi-mdns`, and `pi-terror` are assigned to group
  `infrastructure-pi` with tags `infrastructure` and `raspberry-pi`.
- `pi-mdns` also has the `mdns` role tag.
- Policy `production-change-protection` covers both groups, highlights them as
  sensitive environments, and requires confirmation before changes.
- Fleet Governance should report `100%` with all five checks passing.
