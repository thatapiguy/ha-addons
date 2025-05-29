# Home Assistant Add-on: Ntfy

[![Release][release-shield]][release] ![Project Stage][project-stage-shield] ![Project Maintenance][maintenance-shield]

A self-hosted pub-sub notification service for Home Assistant.

## About

Ntfy (pronounce: notify) is a simple pub-sub notification service that lets you send notifications to your phone or desktop via scripts from any computer. This add-on provides a self-hosted ntfy server that you can use with your Home Assistant installation.

## Features

- 🔔 Send notifications via HTTP PUT/POST request
- 📱 Subscribe via web app, phone app, or CLI
- 🔍 Real-time notifications via WebSocket
- 🔒 Support for access control and authentication
- 📝 Messages stored in local cache
- 📎 Support for file attachments
- 🌐 Integrates seamlessly with Home Assistant

## Installation

1. Add the repository to your Home Assistant add-on store.
2. Install the "Ntfy" add-on.
3. Configure the add-on (see configuration section below).
4. Start the add-on.
5. Check the logs to see if everything is working.

## Configuration

Example add-on configuration:

```yaml
base_url: "https://ntfy.yourdomain.com"
behind_proxy: true
listen_http: ":80"
auth_file: "/config/ntfy.yml"
auth_default_access: "deny-all"
attachment_cache_dir: "/data/attachments"
cache_file: "/data/cache.db"
log_level: "INFO"
log_format: "text"
```

### Option: `base_url`

The base URL of your ntfy instance. This is used for generating links in the web app.

### Option: `behind_proxy`

Set to `true` if you're using a reverse proxy (like the Nginx add-on).

### Option: `listen_http`

The HTTP listen port for the web interface.

### Option: `auth_file`

Path to the authentication config file. Leave empty to disable authentication.

### Option: `auth_default_access`

Default access if no matching rule is found in the access control list:
- `deny-all`: No access allowed
- `deny-subscribers`: Publishing allowed, subscribing denied
- `permit-all`: Full access allowed

### Option: `attachment_cache_dir`

Directory to store file attachments.

### Option: `cache_file`

Location of the cache database file.

### Option: `log_level`

Controls the log output detail level. One of: DEBUG, INFO, WARNING, ERROR

### Option: `log_format`

Format of the log output. One of: text, json

## Support

Got questions?

You have several options to get them answered:

- The Home Assistant [Community Forum][forum].
- The Home Assistant [Discord Chat Server][discord].
- The Ntfy [Documentation][ntfy-docs].

[discord]: https://discord.gg/c5DvZ4e
[forum]: https://community.home-assistant.io
[ntfy-docs]: https://docs.ntfy.sh/
[maintenance-shield]: https://img.shields.io/maintenance/yes/2025.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[release-shield]: https://img.shields.io/badge/version-v1.0.0-blue.svg
[release]: https://github.com/yourusername/repository/tree/main/ntfy
