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

A Docker image with Grav CMS and PHP/nginx

## Container Information

+ ej52/alpine-nginx-php image
+ Port 80 Exposed
+ No Custom Features

## Usage

```
docker create --name=grav \
--restart=always \
-p 80:80 \
dsavell/grav
docker start grav
```

You can choose between ,using tags, various branch versions of GRAV, no tag is required for grav default installation.

Add one of the tags,  if required:

+ ***Example:*** dsavell/grav:admin

#### Tags
+ **latest:** GRAV Default Installation
+ **admin:** GRAV Default Installation + [Grav-Admin-Plugin](https://github.com/getgrav/grav-plugin-admin)
+ **blog:** GRAV Default Installation + [Grav-Admin-Plugin](https://github.com/getgrav/grav-plugin-admin) + [Blog-Skeleton](http://demo.getgrav.org/blog-skeleton)

## Setting up the application
Access the webui at `http://<your-ip>`, for more information check out [GRAV](https://getgrav.org/)

## Using the container

+ Shell Access to container when it is running: `docker exec -it grav /bin/bash`

## Issues

+ CMS not usable behind reverse proxy.

## Changelog
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