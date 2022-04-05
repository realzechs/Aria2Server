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

![Heroku Config Vars](https://files.catbox.moe/3x6bb7.png)

Here `RCLONE_TOKEN` is the token from rclone config, to obtain this follow steps below

```bash
rclone config show
```

![What to copy](https://files.catbox.moe/32ujgg.png)
Copy the `token` value from the output.

The `TEAM_DRIVE_ID` is the id of the team drive where you want to store your downloads. You can copy this from the output of `rclone config show` (above) or Google Drive's team drive page.

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

Alternatively, if you have Torrentium android app you can add the above url without `/jsonrpc` and add it's functionality to the app.
