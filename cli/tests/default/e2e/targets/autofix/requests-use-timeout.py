import requests

url = "www.github.com"

# ruleid: use-timeout
r = requests.get(url, timeout=60)

# ruleid: use-timeout
r = requests.post(url, timeout=60)

# ruleid: use-timeout
r = requests.request("GET", url, timeout=60)

def return_url():
    return url

# ruleid: use-timeout
r = requests.request("GET", return_url(), timeout=60)

# ok
r = requests.get(url, timeout=50)

def from_import_test1(url):
    from requests import get, post
    # ok
    r = get(url, timeout=3)

    # ruleid: use-timeout
    r = post(url, timeout=60)

def test2():
    """Perform a requests.get and default headers set"""
    headers = {**_get_default_headers(), **headers}
    # ok
    r = requests.get(
        url, headers=headers, params=params, **{"timeout": TIMEOUT, **kwargs}, 
    timeout=60)
    return r
