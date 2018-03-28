# transip-api-ddns

A bash script that generates and runs PHP code which updates DNS
records using the [TransIP API](https://api.transip.nl/docs/transip.nl/package-Transip.html).


## Rationale

When your ISP doesn't assign you a static IP address, but you would
like to publish servers and/or services in your local network and you
can't or don't want to use DDNS services around, this script achieves
the same goal; it checks your remote IP address and updates all the
DNS records you specified in the script.

So another usage scenario is to just use it as an easy and convenient
way to mamage your TransIP DNS settings from the command line /
terminal, for any domain you manage.


## Basic usage:

1. copy `etc/transip-api-update-ddns/settings` to
    `/etc/transip-api-update-ddns/settings` and modify it contents
2. modify the contents of the `dns_records` variable in the script
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

