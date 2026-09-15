import requests

r = requests.put("http://127.0.0.1:8099/activeArchive", json={
    "archive": "1_8CH_AIQ_AS",
    "configuration": "default"
})
print(r.status_code, r.text)
