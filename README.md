# transip-api-ddns

A bash script that generates PHP code which updates DNS records using
the TransIP API.

## Rationale

When your ISP doesn't assign you a static IP address, but you would
like to publish servers and/or services in your local network anyhow
and you can't or don't want to use DDNS services around, this script
performs the same.

It checks your remote IP address and updates all the DNS records you
specified in the script.

## Basic usage:

1. copy `etc/transip-api-update-ddns/settings' to
    `/etc/transip-api-update-ddns/settings and modify it contents
2. modify the contents of the `dns_records' variable in the script
3. test the script by running it run from the terminal
   and repeat 1. and 2. until your satisfied:
```bash
DEBUG=true bash transip-api-update-ddns
```
4. copy the script to `/etc/cron.hourly`:
```bash
sudo cp -av transip-api-update-ddns /etc/cron.hourly
```
5. test the working of the cron job:
```bash
sudo run-parts /etc/cron.hourly -v
```

