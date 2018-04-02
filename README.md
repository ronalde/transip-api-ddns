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

## Preparation
1. As root, create a secure settings directory:
```bash
mkdir /etc/transip-api-update-ddns
chmod 0700 /etc/transip-api-update-ddns
```
2. Copy the settings template file to the settings directory created above:
```bash
cp etc/transip-api-update-ddns/settings /etc/transip-api-update-ddns/settings
```
3. Modify the contents of the settings file
4. Enable the TRansIP API and generate a keypair through the
   [control panel](https://www.transip.nl/cp/mijn-account/#api)
5. Copy the key, save it to
   `/etc/transip-api-update-ddns/transip-api-key` and secure it:
```bash
chmod 0600 /etc/transip-api-update-ddns/transip-api-key
```
6. Modify the contents of the `dns_records` variable in the script
7. Test the script and settings by running it in debugging mode from
   the terminal;
   repeat 3. and 6. until your satisfied:
```bash
DEBUG=true bash transip-api-update-ddns
```

## Basic usage

1. copy the script to `/etc/cron.hourly`:
```bash
sudo cp -av transip-api-update-ddns /etc/cron.hourly
```
2. test the working of the cron job:
```bash
sudo run-parts /etc/cron.hourly -v
```

## Requirements

* `curl`: to get the current remote address
* `php` (cli): to communicate with the TransIP API services.
* a local copy of the TransIP API PHP library
