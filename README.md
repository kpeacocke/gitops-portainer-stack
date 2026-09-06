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

## Watchtower policy

Watchtower is monitor-only and label-scoped. It reports newer images but never
replaces a Git-managed container. Apply updates by pulling and redeploying the
relevant Git stack so running state continues to match Git and remains
rollbackable.

`WATCHTOWER_NOTIFICATION_URL` accepts a Shoutrrr notification URL. If empty,
reports remain in the Watchtower container logs. A Watchtower instance sees
only its local Docker engine; deploy another monitor-only instance on a Pi only
if update reporting is required for that host.

## Backup and recovery

Portainer state is under `/volume1/dkrcfg/portainer`. Include that directory in
NAS snapshots and the off-NAS mirror. Also schedule an encrypted export from
**Settings > Backup Portainer** and retain it outside the live data directory.

Recovery does not require Portainer:

1. Restore `/volume1/dkrcfg/portainer`.
2. Restore `stack/.env` from the secret store.
3. Run `docker compose up -d` over SSH.
4. Verify the Synology proxy and reconnect agents if their shared secret changed.

For a filesystem copy without an atomic snapshot, briefly stop Portainer first.
Watchtower has no persistent state requiring backup.
