#!/usr/bin/env make

## Makefile to download and unpack the current TransIP API PHP
## Library, to install the settings file for the `transip-api-ddns'
## script and to copy the script to `/etc/cron.hourly'.
##
## The paths are fixed:
##  php library:   /opt/transip-api-ddns
##  settings file: /etc/transip-api-ddns/settings
##  cronjob:       /etc/cron.hourly/transip-api-ddns
## If you want to customize the names or paths also do so in the
## `./transip-api-ddns' script
##
## Usage:
## 1. Prepare the installation in `./build':
##  make
## -or-
## make build
## 2. Clean the result of 1.:
##  make clean
## 3. Perform the complete installation (you should have root or sudo
##    power):
##  sudo su
##  make install
## -or, to preview what woould happen -
##  make -n install
## 
## 4. Uninstall (undo 3.):
##  sudo su	
##  make realclean
##
## For convenience you can use the update-phplib make target to just
## download and unpack the most recent version of the php library to
## `/opt/transip-api-ddns':
##  make update-api-phplib

SHELL			:=/bin/bash

app_name		=  transip-api-ddns
build_dir		:= build
## when changing `api_phplib_install_dir' also change CONF_TRANSIP_API_LIB_DIR in settings file
api_phplib_install_dir	:= /opt/${app_name}-phplib
## when changing `settings_install_dir' also change `APP_CONF_DIR' in script file
settings_install_dir	:= /etc/${app_name}
cron_install_dir	:= /etc/cron.hourly
api_phplib_download_dir	:= /tmp

api_phplib_build_dir	:= ${build_dir}${api_phplib_install_dir}
api_phplib_tarball_url	:= $(shell bash get_current_tarball)
api_phplib_tarball_name	:= $(shell bash get_current_tarball "name")
api_phplib_tarball_path	:= ${api_phplib_download_dir}/${api_phplib_tarball_name}

settings_filename	:= settings.example
settings_build_dir	:= ${build_dir}${settings_install_dir}
settings_source_dir	:= etc/${app_name}
settings_source_file	:= ${settings_source_dir}/${settings_filename}
settings_build_target	:= ${settings_build_dir}/${settings_filename}
settings_install_target	:= ${settings_install_dir}/${settings_filename}

cron_source		:= ${app_name}
cron_build_dir		:= ${build_dir}${cron_install_dir}
cron_build_target 	:= ${cron_build_dir}/${app_name}
cron_install_target	:= ${cron_install_dir}/${app_name}

.PHONY: build install clean realclean update-api-phplib 

build: ${settings_build_dir} ${api_phplib_build_dir} ${cron_build_dir} ${settings_build_target} ${cron_build_target}

install: ${settings_install_dir} ${api_phplib_install_dir} ${settings_install_target} ${cron_install_target}

update-api-phplib: ${api_phplib_build_dir}

${settings_build_dir} ${cron_build_dir}:
	mkdir -p $@

${settings_install_dir}:
	mkdir -p $@

${api_phplib_tarball_path}: ${api_phplib_download_dir}
	curl -so $@ ${api_phplib_tarball_url}

${api_phplib_build_dir}: ${api_phplib_tarball_path}
	mkdir -p $@
	tar -C $@ -xzvf $<

${api_phplib_install_dir}: ${api_phplib_build_dir}
	cp -av $< $@

${settings_build_target}: ${settings_source_file}
	cp -av $< $@

${settings_install_target}: ${settings_build_target}
	cp -av $< $@


${app_settings_file_target}: ${app_settings_file_src}
	mkdir -p ${settings_build_dir}
	cp -av $< $@ 

${cron_build_target}: ${cron_source}
	cp -av $< $@	

${cron_install_target}: ${cron_build_target}
	cp -av $< $@

clean:
	rm -rf ${build_dir}

realclean: clean
	rm -rf ${api_install_dir} ${cron_target}
