# dsavell/grav

![grav](https://getgrav-grav.netdna-ssl.com/user/pages/media/grav-logo.svg)

Grav is a Fast, Simple, and Flexible file-based Web-platform. There is Zero installation required. Just extract the ZIP archive, and you are already up and running. Although Grav follows principles similar to other flat-file CMS platforms, it has a different design philosophy than most.

The name Grav is just a shortened version of the word Gravity. The shared name space of our platform and a movie starring Sandra Bullock is pure coincidence! More importantly, gravity is also a very important physical principle that describes the forces of attraction between objects. Frankly, the name was chosen as a temporary "codename" for the project and it just stuck.

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

Add one of the tags,  if required,  to the dsavell/grav line of the run/create command in the following format, dsavell/grav:admin

#### Tags
+ **latest:** Basic GRAV Setup
+ **admin:** Includes the [Grav-Admin-Plugin](https://github.com/getgrav/grav-plugin-admin)

## Setting up the application
Access the webui at `http://<your-ip>`, for more information check out [GRAV](https://getgrav.org/).

## Changelog

+ **21/06/2017:** Initial Release
