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
NAS snapshots and the off-NAS mirror. Also schedule an encrypted export from
**Settings > Backup Portainer** and retain it outside the live data directory.

Recovery does not require Portainer:

1. Restore `/volume1/dkrcfg/portainer`.
2. Restore `stack/.env` from the secret store.
3. Run `docker compose up -d` over SSH.
4. Verify the Synology proxy and reconnect agents if their shared secret changed.

For a filesystem copy without an atomic snapshot, briefly stop Portainer first.

Image-update monitoring is deliberately separated into
[`gitops-watchtower-stack`](https://github.com/kpeacocke/gitops-watchtower-stack).
