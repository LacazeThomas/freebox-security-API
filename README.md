# freebox-security-API
A NodeJS gateway to interface the Freebox Home API and curl action, setting up a minimalist version of the Freebox Home APIs.

## 🧐 Features

- **✅ 100 % free and open-source**

- **✅ Active/Desactive alarm**

- **✅ Get status from all your devices**

- **✅ Self-hosted**

## 🔧 Endpoint availables

Few endpoint are exposed in this API such as :

| Endpoint             | Description                                                        |
| -------------------- | ------------------------------------------------------------------ |
| /api/node/{id}       | Get the status of a node by it's id.                               |
| /api/node/list       | Returns the list of the available nodes (only ids).                |
| /api/ping            | Will just if tell the server is up.                                |
| /api/fbx/rights      | Will return a boolean value to show wether the app has home acces. |
| /api/fbx/auth        | Will return a boolean value to show wether the app has been auth.  |
| /api/refresh/:id     | Update the refresh timeout for the node.                           |
| /api/alarm/main      | Will turn on primary alarm.                                        |
| /api/alarm/target    | Will return futher state of alarm.                                 |
| /api/alarm/secondary | Will turn on secondary alarm.                                      |
| /api/alarm/state     | Will return current state of alarm (strange behavior).             |
| /api/alarm/off       | Will turn off alarm.                                               |

## 🔧 Alarm States

1 = armed
0 = not armed
2 = secondary alarm
4 = Alert 


## 🛠️ Installation Steps

**IMPORTANT due to security, API allows only localhost domain. You need to use network mode host and your 8888 port available**
### 🐳 Option 1: Run from Docker run

```bash
# Run the container
$ docker run \
  -v /etc/localtime:/etc/localtime:ro \
  -v /home/thomas/freeboxAPI:/usr/src/app/credentials \
  -e "PUID=1000" \
  -e "PGID=1000" \
  --restart always \
  --name freebox-security-api \
  --network=host \
  thomaslacaze/freebox-security-api
```

### 🐳 Option 2: Run from Docker-compose

**See [here](https://github.com/LacazeThomas/freebox-security-API/blob/main/docker-compose.yml)** 

### 💻 Option 3: Run from source


🌟 You are all set!

## Configuration with homeassistant

Calls to the motion sensor API work. But my sensor doesn't work anymore 

```
switch:
  - platform: command_line
    switches:
      alarm:
        command_on: "curl -X GET http://localhost:8888/api/alarm/main"
        command_off: "curl -X GET http://localhost:8888/api/alarm/off"
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

## Limitations
The current Freebox API do not allow the request of rights for an App.
So when you start the server, make that, after having allowed the app (by taping the ✅ on the box's display), to log into freebox OS (http://mafreebox.freebox.fr/), go into "Paramètres de la Freebox" > "Gestion des accès" and allow the "Freebox-security-API" app to access *Gestion de l'alarme et maison connectée* (you can disable other unused rights).

## Dockerfile
<a href="https://github.com/LacazeThomas/freebox-security-API/blob/main/Dockerfile">Dockerfile</a>

## License
<a href="https://github.com/LacazeThomas/freebox-security-API/blob/main/LICENSE">MIT</a>