# Home Assistant Add-on: Ntfy

## How to use

This add-on provides a self-hosted ntfy server that you can use to send and receive notifications.

### Quick Start Example

1. Start the add-on
2. Subscribe to a topic using one of these methods:
   - Web UI: Open the add-on web interface and subscribe to a topic
   - App: Install the ntfy app and add your server
   - CLI: Use `curl -s http://localhost:80/mytopic/json` to subscribe

3. Send a notification:
```bash
curl -d "Hello from Home Assistant!" http://localhost:80/mytopic
```

### Home Assistant Integration

You can integrate ntfy with Home Assistant in several ways:

1. Using REST commands:
```yaml
rest_command:
  send_notification:
    url: http://localhost:80/mytopic
    method: POST
    payload: "{{ message }}"
```

2. Using automation:
```yaml
automation:
  - alias: "Send notification on event"
    trigger:
      - platform: state
        entity_id: binary_sensor.motion
        to: "on"
    action:
      - service: rest_command.send_notification
        data:
          message: "Motion detected!"
```

### Authentication

If you want to secure your ntfy server, you can set up authentication:

1. Create an authentication config file (e.g., `/config/ntfy.yml`):
```yaml
auth:
  users:
    - user: myuser
      pass: mypass
```

2. Update the add-on configuration to use this file:
```yaml
auth_file: "/config/ntfy.yml"
auth_default_access: "deny-all"
```

### Common Use Cases

1. System notifications
2. Script notifications
3. IoT device alerts
4. CI/CD pipeline notifications
5. Automated backups notifications

## Troubleshooting

### Common Issues

1. Can't connect to the server:
   - Check if the add-on is running
   - Verify the port configuration
   - Check your network/firewall settings

2. Authentication issues:
   - Verify your auth_file configuration
   - Check the file permissions
   - Verify the user credentials

3. Messages not being received:
   - Check the log_level setting
   - Verify the topic name
   - Check the connection status

### Logs

The add-on logs can be viewed in the Home Assistant UI:
1. Go to Settings > Add-ons
2. Click on the Ntfy add-on
3. Click on the "Logs" tab

## Support

If you need additional help, check:
- [Ntfy Documentation](https://docs.ntfy.sh/)
- [Home Assistant Community](https://community.home-assistant.io)
- [GitHub Issues](https://github.com/yourusername/repository/issues)
