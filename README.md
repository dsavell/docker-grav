# Docker dsavell/docker-grav

![grav](https://getgrav.org/user/pages/media/grav-logo.svg)

## Usage

### Docker Compose

```yaml
version: '3'
services:
  grav:
    image: dsavell/grav:latest
    container_name: grav
    restart: unless-stopped
    ports:
      - 80:80
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - ./grav/backup:/grav/backup
      - ./grav/user:/grav/user
```

### Docker Run

```bash
docker run -d \
  --name=grav \
  --restart unless-stopped \
  -p 80:80/tcp \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -v ./grav/backup:/grav/backup
  -v ./grav/user:/grav/user
  dsavell/grav:latest
```

## Server Environment Variables

## Nginx Environment Variables

## Grav Environment Variables

## Known Issues

- Nothing

## Changelog

- **XX/XX/2024: UPCOMING BREAKING CHANGE**
  - Consolidated Dockerfiles.
  - Plugins such as the admin UI should be installed via the GRAV_PLUGINS environment variable.
  - Complete overhaul on how Grav is installed.
  - Added update plugins functionality directly with `docker exec`.
  - Grav Scheduler should now work and not error within the admin UI.
- **03/10/2023:**
  - Removed cumbersome DevOps steps.
  - Updated GitHub workflows with nodejs 20.x
  - Updated pre-commit hooks.
  - Updated OS from bullseye to bookworm.
  - Updated PHP 7.4 to 8.2. Thanks to [funilrys](https://github.com/funilrys) [#56](https://github.com/dsavell/docker-grav/pull/56)
  - Updated some documentation regarding installation steps.
  - Added ability to install plugins. Thanks to [tyzbit](https://github.com/tyzbit) [#64](https://github.com/dsavell/docker-grav/pull/64)
- **24/07/2022:**
  - Added moved from `master branch` to `main` branch.
  - Added `commitlint` function to verify proper commit messages.
  - Added `.editorconfig` to ensure standards across IDE's.
  - Added `.gitattributes` to ensure standards across git CLI.
  - Added build to NPM/YARN to locally verify code & commit messages.
  - removed build shell script.
  - Added GitHub Actions CI/CD workflows
    - 1:00am everyday builds.
    - Build on any new change to main branch.
    - Code standards check.
    - Docker lint check.
    - Docker build check.
  - Added prettier codebase formatting.
  - Added pre-commit yaml to validate code syntax / format.
  - Added MIT license.
  - Added pre-commit husky utility to trigger pre-commit & commitlint with prettier for local development.
  - Correct hadolint errors in the Dockerfiles.
- **18/05/2022:**
  - Added `subdomain` as an option for `GRAV_MULTISITE`
  - Added `NGINX_CLIENT_MAX_BODY_SIZE` to specify the nginx config client_max_body_size
  - Updated to Grav 1.7.33
- **16/10/2021:**
  - Updated to Grav 1.7.23
  - Updated curl script in Docker file to correctly pull latest version of grav.
  - Updated to Debian 11.x (bullseye)
  - Changed crontab logic, however it works, just complains in the UI, known bug in admin plugin above.
  - Added check for `bin/grav/ scheduler -i` to startup output.
  - Added check for `crontab -l` to startup output.
- **15/04/2021:**
  - Updated to Grav 1.7.12
  - Added nano text editor to the image.
- **10/04/2021:**
  - Updated to Grav 1.7.10
  - Updated to PHP 7.4.x
  - Fix permissions on startup because of topic names with whitespaces.
    - Thanks to [Miroka96](https://github.com/Miroka96) [#22](https://github.com/dsavell/docker-grav/pull/23)
  - Added support for multisite subdirectory.
    - Thanks to [hughbris](https://github.com/hughbris) [#21](https://github.com/dsavell/docker-grav/pull/21)
  - Fixed uploading to the CMS using a tmp directory this is now /var/www/grav/tmp.
- **11/10/2020:**
  - Updated to Grav 1.6.28
- **02/08/2020:**
  - Updated to Grav 1.6.26
- **01/06/2020:**
  - Updated to Grav 1.6.25
- **22/04/2020:**
  - Fix permissions for cron & GRAV Scheduler.
    - Thanks to [SykieChen](https://github.com/SykieChen) [#19](https://github.com/dsavell/docker-grav/pull/19)
- **12/04/2020:**
  - Updated to Grav 1.6.23
- **20/02/2020:**
  - Updated to Grav 1.6.21
- **09/12/2019:**
  - Fixed missing php7.3-mbstring on admin tag.
    - Thanks to [Miroka96](https://github.com/Miroka96) [#13](https://github.com/dsavell/docker-grav/pull/13)
- **08/12/2019:**
  - Updated to Grav 1.6.19
  - Fixed crontab schedules.
    - Thanks to [coldestheart](https://github.com/coldestheart) [#11](https://github.com/dsavell/docker-grav/pull/11)
- **30/11/2019:**
  - Updated baseimage from stretch to buster.
    - Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
  - Added cron & added cronjob allows jobs to be run on a periodic basic, GRAV relies on this.
    - Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
  - Added php7.3-intl for Multilang support for twig tools.
    - Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
  - Enabled caching in Nginx for tools that analyze speed performance (like gtmetrix)
    - Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
  - Startup scripts now enable cron.
    - Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
- **15/11/2019:**
  - Fixed working directory this is now set to /var/ww/grav, now commands like bin/grav & bin/gpm can be used directly.
    - Thanks to [aptonline](https://github.com/aptonline) [#9](https://github.com/dsavell/docker-grav/issues/9)
- **10/08/2019:**
  - Fixed GRAV user directory being overwritten when rebuilding container.
    - Thanks to [Miroka96](https://github.com/Miroka96) [#6](https://github.com/dsavell/docker-grav/issues/6)
- **18/06/2019:** The Better Release?
  - Better File/Volume control
  - Better tagging / versioning of GRAV Core.
  - Better User/Group management.
  - Better Documentation.
- **10/06/2019:** The Refactor Release
  - Converted to minideb for better package management.
  - Updated to PHP 7.3.
  - Better logic to pull latest version when building.
  - Better logging.
  - blog image removed.
  - GRAV Core & GRAV Core + Admin Plugin only images for now.
  - Smaller Docker layering.
  - Fixed nginx configuration.
    - Thanks to [esapy](https://github.com/esapy) [#1](https://github.com/dsavell/docker-grav/issues/1)
- **10/04/2018:** The Volume Release
  - The /var/www volume can now be mounted.
- **02/01/2018:** The 2018 Release
  - Improved Code
  - Now using github API to pull latest GRAV release
- **27/07/2017:** The Automated Release
  - Updated tag "blog" to now use github API to download latestvBlog-Skeleton
  - Improved code on all tags
  - Typo corrections on the README.md
- **29/06/2017:** The Blog Release
  - added tag **blog** This is a skeleton of [Blog-Skeleton](http://demo.getgrav.org/blog-skeleton)
- **28/06/2017:** The Even Smaller Release
  - Now uses image from ej52/alpine-nginx-php
  - Size has reduced from 657 to 267mb & with admin plugin 277mb
- **22/06/2017:** The Better Release
  - Now uses image from php:7.0-apache
  - Size has reduced from 1.2gb to 657mb & with admin plugin 682mb
  - Corrected GRAV permissions
  - Less packages installed during Docker build + cleanup
- **21/06/2017:** Initial Release
  - First Initial Release
  - No Optimization
  - Full Operating System of centos used
  - No Custom Features
