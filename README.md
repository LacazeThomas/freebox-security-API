# freebox-security-API
A NodeJS gateway to interface the Freebox Home API and curl action, setting up a minimalist version of the Freebox Home APIs.

## Usage Docker version

```
freeboxapi:
  image: thomaslacaze/freebox-security-api
  container_name: freeboxAPI
  volumes:
    - $PWD/freeboxAPI:/usr/src/app/credentials
  restart: unless-stopped
  environment: 
    - TZ=${TZ}
    - PUID=1000
    - PGID=1000
  network_mode: host #IMPORTANT due to security, allow only localhost domain
```

## Configuration with homeassistant

Calls to the motion sensor API work. But my sensor doesn't work anymore 

```
switch:
  - platform: command_line
    switches:
      alarm:
        command_on: "curl -X GET http://localhost:8888/api/alarm/main"
        command_off: "curl -X GET http://localhost:8888/api/alarm/home"
        command_state: "curl -X GET http://localhost:8888/api/alarm/target"
        value_template: '{{ value == "1" }}'

binary_sensor:
  - platform: command_line
    command: "curl -X GET http://localhost:8888/api/node/59"
    name: "sensor door"
    payload_on: "1"
    payload_off: "0"
    device_class: "door"        
```

To get your node id make a `curl -X GET http://localhost:8888/api/node/list`

## The actual Freebox API
The Freebox home api is a very complex API, with many endpoints, and many data and information. These data are supposed to be used in clients for the Home features of the Freebox Delta such as the Freebox companion mobile app, used to manage and configure every aspect of the Freebox Home Security items (camera, sensors, alarm...).

The point of this project is to build a minimalist version of these endpoints to be able to simply communicate the states of your freebox items to other apps and services such as Homebridge.
The main purpose is indeed to build a bridge between Homebridge and the Freebox Home API.

## Abialable endpoints
Few endpoint are exposed in this API such as :

| Endpoint                   | Description                                                                                       |
| -------------------------- | ------------------------------------------------------------------------------------------------- |
| /api/node/{id}             | Will return the state of a specified node right now.*                                             |
| /api/homebridge/conf       | Use this endpoint to manually request a configuration file for homebridge.                        |
| /api/homebridge/conf/alarm | Use this endpoint to manually request a configuration file for homebridge that inclues the alarm. |
| /api/homebridge/restart/   | Simply restart homebridge.                                                                        |

Check the wiki for a complete documentation.

## Limitations
The current Freebox API do not allow the request of rights for an App.
So when you start the server, make that, after having allowed the app (by taping the ✅ on the box's display), to log into freebox OS (http://mafreebox.freebox.fr/), go into "Paramètres de la Freebox" > "Gestion des accès" and allow the "homebridge-freebox-home" app to access *Home* (you can disable other unused rights).