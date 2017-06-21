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

## Container Information

+ centos:latest container
+ httpd (apache)
+ php7.0
+ Port 80 Exposed
+ No Optimization
+ No Custom Features

## Usage

```
docker create --name=grav \
--restart=always \
-p 80:80 \
-v /etc/localtime:/etc/localtime:ro \
dsavell/grav
docker start grav
```

You can choose between ,using tags, various branch versions of GRAV, no tag is required for grav default installation.

Add one of the tags,  if required:

+ ***Example:*** dsavell/grav:admin

#### Tags
+ **latest:** GRAV Default Installation
+ **admin:** GRAV Default Installation + [Grav-Admin-Plugin](https://github.com/getgrav/grav-plugin-admin)

## Setting up the application
Access the webui at `http://<your-ip>`, for more information check out [GRAV](https://getgrav.org/).

## Using the container

+ Shell Access to container when it is running: docker exec -i -t grav /bin/bash

## Changelog

+ **21/06/2017:** Initial Release
	- First Initial Release
	- No Optimization
	- Full Operating System of centos used
	- No Custom Features
