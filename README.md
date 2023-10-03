# dsavell/grav

![grav](https://getgrav.org/user/pages/media/grav-logo.svg)

Grav is a Fast, Simple, and Flexible file-based Web-platform. There is Zero installation required. Although Grav follows principles similar to other flat-file CMS platforms, it has a different design philosophy than most.

The underlying architecture of Grav is built using well established and best-in-class technologies. This is to ensure that Grav is simple to use and easy to extend. Some of these key technologies include:

- Twig Templating: for powerful control of the user interface
- Markdown: for easy content creation
- YAML: for simple configuration
- Parsedown: for fast Markdown and Markdown Extra support
- Doctrine Cache: for performance
- Pimple Dependency Injection Container: for extensibility and maintainability
- Symfony Event Dispatcher: for plugin event handling
- Symfony Console: for CLI interface
- Gregwar Image Library: for dynamic image manipulation

## Supported Architectures

We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list).

Simply pulling `dsavell/grav:admin` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Available | Tag                     |
| :----------: | :-------: | ----------------------- |
|    x86-64    |    ✅     | amd64-\<version tag\>   |
|    arm64     |    ❌     | arm64v8-\<version tag\> |
|    armhf     |    ❌     | arm32v7-\<version tag\> |

## Version Tags

This image provides various versions that are available via tags.

|              Tag               | Available | Description                                     |
| :----------------------------: | :-------: | ----------------------------------------------- |
|             admin              |    ✅     | Stable Grav Core + Admin plugin releases        |
|              core              |    ✅     | Stabe Grav Core releases                        |
|         admin-\<date\>         |    ✅     | Stable Grav Core + Admin plugin releases + date |
|         core-\<date\>          |    ✅     | Stabe Grav Core releases + date                 |
|     admin-\<version tag\>      |    ✅     | Pinned Grav Core + Admin plugin releases        |
|      core-\<version tag\>      |    ✅     | Pinned Grav Core releases                       |
| admin-\<version tag\>-\<date\> |    ✅     | Pinned Grav Core + Admin plugin releases + date |
| core-\<version tag\>-\<date\>  |    ✅     | Pinned Grav Core releases + date                |

## Application Setup

WebUI can be found at `http://<your-ip>`

More information can be found on the official documentation [here](https://learn.getgrav.org/17/basics/installation#webservers)

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose
```yaml
---
version: '2.1'
services:
  grav:
    image: dsavell/grav:<TAG>
    container_name: grav
    restart: unless-stopped
    environment:
      - DUID=1000
      - DGID=1000
      - GRAV_MULTISITE=subdirectory # optional
      - ROBOTS_DISALLOW=false # optional
    volumes:
      - /data/containers/grav/backup:/var/www/grav/backup
      - /data/containers/grav/logs:/var/www/grav/log
      - /data/containers/grav/user:/var/www/grav/user
    ports:
      - 80:80
```

### docker cli ([click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker create \
  --name=grav \
  --restart unless-stopped \
  -e DUID=1000 \
  -e DGID=1000 \
  -p 80:80 \
  -e GRAV_MULTISITE=subdirectory `# optional` \
  -e ROBOTS_DISALLOW=false `# optional` \
  -v /data/containers/grav/backup:/var/www/grav/backup \
  -v /data/containers/grav/logs:/var/www/grav/logs \
  -v /data/containers/grav/user:/var/www/grav/user \
  dsavell/grav:<TAG>
docker start grav
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

|               Parameter               | Function                                                         |
| :-----------------------------------: | ---------------------------------------------------------------- |
|                `-p 80`                | Http webUI                                                       |
|            `-e DUID=1000`             | for UserID - see below for explanation                           |
|            `-e DGID=1000`             | for GroupID - see below for explanation                          |
| `-e TZ-e GRAV_MULTISITE=subdirectory` | Deploy a Grav multisite (subdirectory) installation.             |
|      `-e ROBOTS_DISALLOW=false`       | Replace default /robots.txt file with one discouraging indexers. |
|      `-e TZ=Europe/London`            | Set your timezone                                                |
|   `-e GRAV_PLUGINS=devtools,precache` | Install extra plugins automaticall (must be comma separated)     |
|         `-v /var/www/backup`          | Contains your location for Grav backups                          |
|          `-v /var/www/logs`           | Contains your location for your Grav log files                   |
|          `-v /var/www/user`           | Contains your Grav content                                       |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Issues

- Scheduler mentions cron is not available in the UI, however it works. issue has been raised `https://github.com/getgrav/grav-plugin-admin/issues/1744`

## Changelog

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
  - Fix permissions on startup because of topic names with whitespaces. Thanks to [Miroka96](https://github.com/Miroka96) [#22](https://github.com/dsavell/docker-grav/pull/23)
  - Added support for multisite subdirectory. Thanks to [hughbris](https://github.com/hughbris) [#21](https://github.com/dsavell/docker-grav/pull/21)
  - Fixed uploading to the CMS using a tmp directory this is now /var/www/grav/tmp.
- **11/10/2020:**
  - Updated to Grav 1.6.28
- **02/08/2020:**
  - Updated to Grav 1.6.26
- **01/06/2020:**
  - Updated to Grav 1.6.25
- **22/04/2020:**
  - Fix permissions for cron & GRAV Scheduler. Thanks to [SykieChen](https://github.com/SykieChen) [#19](https://github.com/dsavell/docker-grav/pull/19)
- **12/04/2020:**
  - Updated to Grav 1.6.23
- **20/02/2020:**
  - Updated to Grav 1.6.21
- **09/12/2019:**
  - Fixed missing php7.3-mbstring on admin tag. Thanks to [Miroka96](https://github.com/Miroka96) [#13](https://github.com/dsavell/docker-grav/pull/13)
- **08/12/2019:**
  - Updated to Grav 1.6.19
  - Fixed crontab schedules. Thanks to [coldestheart](https://github.com/coldestheart) [#11](https://github.com/dsavell/docker-grav/pull/11)
- **30/11/2019:**
  - Updated baseimage from stretch to buster. Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
  - Added cron & added cronjob allows jobs to be run on a periodic basic, GRAV relies on this. Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
  - Added php7.3-intl for Multilang support for twig tools. Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
  - Enabled caching in Nginx for tools that analyze speed performance (like gtmetrix) Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
  - Startup scripts now enable cron. Thanks to [coldestheart](https://github.com/coldestheart) [#10](https://github.com/dsavell/docker-grav/pull/10)
- **15/11/2019:**
  - Fixed working directory this is now set to /var/ww/grav, now commands like bin/grav & bin/gpm can be used directly. Thanks to [aptonline](https://github.com/aptonline) [#9](https://github.com/dsavell/docker-grav/issues/9)
- **10/08/2019:**
  - Fixed GRAV user directory being overwritten when rebuilding container. Thanks to [Miroka96](https://github.com/Miroka96) [#6](https://github.com/dsavell/docker-grav/issues/6)
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
  - Fixed nginx configuration thanks to [esapy](https://github.com/esapy) [#1](https://github.com/dsavell/docker-grav/issues/1)
- **10/04/2018:** The Volume Release
  - The /var/www volume can now be mounted.
- **02/01/2018:** The 2018 Release
  - Improved Code
  - Now using github API to pull latest GRAV release
- **27/07/2017:** The Automated Release
  - Updated tag "blog" to now use github API to download latest [Blog-Skeleton](http://demo.getgrav.org/blog-skeleton) zip file
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
