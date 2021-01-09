# dsavell/grav

![grav](https://getgrav-grav.netdna-ssl.com/user/pages/media/grav-logo.svg)

Grav is a Fast, Simple, and Flexible file-based Web-platform. There is Zero installation required. Although Grav follows principles similar to other flat-file CMS platforms, it has a different design philosophy than most.

The underlying architecture of Grav is built using well established and best-in-class technologies. This is to ensure that Grav is simple to use and easy to extend. Some of these key technologies include:

* Twig Templating: for powerful control of the user interface
* Markdown: for easy content creation
* YAML: for simple configuration
* Parsedown: for fast Markdown and Markdown Extra support
* Doctrine Cache: for performance
* Pimple Dependency Injection Container: for extensibility and maintainability
* Symfony Event Dispatcher: for plugin event handling
* Symfony Console: for CLI interface
* Gregwar Image Library: for dynamic image manipulation

## What is dsavell/grav?

A Docker image based on minideb:buster linux with Grav CMS and PHP7.4/nginx.

## Container Information

+ bitnami/minideb:buster
+ php7.4 + FPM
+ nginx
+ GRAV Core
+ GRAV Admin Plugin
+ optional [multisite installation](https://learn.getgrav.org/16/advanced/multisite-setup) using subdirectories

## Usage

```
docker create \
  --name=grav \
  --restart unless-stopped \
  -p 80:80 \
  -e DUID=1000 \
  -e DGID=1000 \
  -v /data/containers/grav/backup:/var/www/grav/backup \
  -v /data/containers/grav/logs:/var/www/grav/logs \
  -v /data/containers/grav/user:/var/www/grav/user \
  dsavell/grav
docker start grav
```

> Use the `-e GRAV_MULTISITE=dir` flag for a Grav multisite installation using subdirectories (see below). Multisite using subdomains is not yet supported.

## Tags

[latest, core, 1.6.31, core-1.6.31 (Dockerfile)](https://github.com/dsavell/docker-grav/blob/master/Dockerfile.gravcore)

[admin, admin-1.6.31 (Dockerfile)](https://github.com/dsavell/docker-grav/blob/master/Dockerfile.gravcoreadmin)

## Tag usage
You can choose between ,using tags, no tag is required for grav default installation.

Add one of the tags,  if required:

+ ***Example:*** dsavell/grav:admin

#### Tag information
+ **latest:** GRAV Core
+ **admin:** GRAV Core + [Grav-Admin-Plugin](https://github.com/getgrav/grav-plugin-admin)

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | http |
| `-e DUID=1000` | for UserID - see below for explanation |
| `-e DGID=1000` | for GroupID - see below for explanation |
| `-e GRAV_MULTISITE=dir` | Deploy a Grav multisite (subdirectory) installation |
| `-v /var/www/backup` | Contains your location for Grav backups |
| `-v /var/www/logs` | Contains your location for your Grav log files |
| `-v /var/www/user` | Contains your Grav content |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `DUID` and group `DGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `DUID=1000` and `DGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Accessing the application
Access the webui at `http://<your-ip>`, for more information check out [GRAV](https://getgrav.org/)

## Using the container

+ Shell Access to container when it is running: `docker exec -it grav /bin/bash`
+ To monitor the logs of the container in realtime: `docker logs -f grav`

## Issues

+ N/A.

## Changelog
+ **UNRELEASED:**
	- Updated to Grav 1.6.31
	- Updated to PHP 7.4.x
	- Fix permissions on startup because of topic names with whitespaces. Thanks to [Miroka96](https://github.com/Miroka96) [#22](https://github.com/dsavell/docker-grav/pull/23)
+ **11/10/2020:**
	- Updated to Grav 1.6.28
+ **02/08/2020:**
	- Updated to Grav 1.6.26
+ **01/06/2020:**
	- Updated to Grav 1.6.25
+ **22/04/2020:**
	- Fix permissions for cron & GRAV Scheduler. Thanks to [SykieChen](https://github.com/SykieChen) [#19](https://github.com/dsavell/docker-grav/pull/19)
+ **12/04/2020:**
	- Updated to Grav 1.6.23
+ **20/02/2020:**
	- Updated to Grav 1.6.21
+ **09/12/2019:**
	- Fixed missing php7.3-mbstring on admin tag. Thanks to [Miroka96](https://github.com/Miroka96) [#13](https://github.com/dsavell/docker-grav/pull/13)
+ **08/12/2019:**
	- Updated to Grav 1.6.19
	- Fixed crontab schedules. Thanks to [coldestheart](https://github.com/coldestheart) [#11](https://github.com/dsavell/docker-grav/pull/11)
+ **30/11/2019:**
	- Updated baseimage from stretch to buster. Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
	- Added cron & added cronjob allows jobs to be run on a periodic basic, GRAV relies on this. Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
	- Added php7.3-intl for Multilang support for twig tools. Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
	- Enabled caching in Nginx for tools that analyze speed performance (like gtmetrix) Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
	- Startup scripts now enable cron. Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
+ **15/11/2019:**
	- Fixed working directory this is now set to /var/ww/grav, now commands like bin/grav & bin/gpm can be used directly. Thanks to [aptonline](https://github.com/aptonline) [#9](https://github.com/dsavell/docker-grav/issues/9)
+ **10/08/2019:**
	- Fixed GRAV user directory being overwritten when rebuilding container. Thanks to [Miroka96](https://github.com/Miroka96) [#6](https://github.com/dsavell/docker-grav/issues/6)
+ **18/06/2019:** The Better Release?
	- Better File/Volume control
	- Better tagging / versioning of GRAV Core.
	- Better User/Group management.
	- Better Documentation.
+ **10/06/2019:** The Refactor Release
	- Converted to minideb for better package management.
	- Updated to PHP 7.3.
	- Better logic to pull latest version when building.
	- Better logging.
	- blog image removed.
	- GRAV Core & GRAV Core + Admin Plugin only images for now.
	- Smaller Docker layering.
	- Fixed nginx configuration thanks to [esapy](https://github.com/esapy) [#1](https://github.com/dsavell/docker-grav/issues/1)
+ **10/04/2018:** The Volume Release
	- The /var/www volume can now be mounted.
+ **02/01/2018:** The 2018 Release
	- Improved Code
	- Now using github API to pull latest GRAV release
+ **27/07/2017:** The Automated Release
	- Updated tag "blog" to now use github API to download latest [Blog-Skeleton](http://demo.getgrav.org/blog-skeleton) zip file
	- Improved code on all tags
	- Typo corrections on the README.md
+ **29/06/2017:** The Blog Release
	- added tag **blog** This is a skeleton of [Blog-Skeleton](http://demo.getgrav.org/blog-skeleton)
+ **28/06/2017:** The Even Smaller Release
	- Now uses image from ej52/alpine-nginx-php
	- Size has reduced from 657 to 267mb & with admin plugin 277mb
+ **22/06/2017:** The Better Release
	- Now uses image from php:7.0-apache
	- Size has reduced from 1.2gb to 657mb & with admin plugin 682mb
	- Corrected GRAV permissions
	- Less packages installed during Docker build + cleanup
+ **21/06/2017:** Initial Release
	- First Initial Release
	- No Optimization
	- Full Operating System of centos used
	- No Custom Features
