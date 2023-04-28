# Aria2Server

Aria2c JSON-RPC server exposed on `{PORT}` port. Along with Rclone for handling downloads.

## How does it work?

Aria2c RPC server is exposed on `{PORT}` port which allows controlling aria2c from any client over http.

```http
POST /jsonrpc
```

Refer to [Aria2c RPC documentation](https://aria2.github.io/manual/en/html/aria2c.html#rpc-interface) for more details.

## Deploy on heroku

```bash
git clone https://github.com/itsZECHS/Aria2Server.git
cd Aria2Server
heroku create
heroku stack:set container -a {app_name}
git push heroku main
```

## Set environment variables

 - `TEAM_DRIVE_ID`: It is the id of the team drive where you want to store your downloads.
 - `RCLONE_ACCOUNT`: Url to `service-account.json`, it can be a pastebin (raw), github gist (raw) link anything works as long as it leads to a json file.

## How to use?

Once deployed, you can call Aria2c Json-rpc via POST request like mentioned above.

### Example

```py
import uuid
import requests
 
url = f"https://{app_name}.herokuapp.com/jsonrpc"

payload = {
    "id": str(uuid.uuid4()),
    "jsonrpc": "2.0",
    "method": "aria2.getVersion",
    "params": []
}

res = requests.post(url, data=json.dumps(payload))
print(res.json())
```

### Web-UI & Android Apps

You can also use this with Aria2c Web-ui providers or Android apps. Here are some that I have tested. (Note: use `443` for port)

- https://rickylawson.github.io
- https://github.com/devgianlu/Aria2App
