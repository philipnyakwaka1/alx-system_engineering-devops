#!/usr/bin/python3
"""check for hostname"""
import requests

DD_API_KEY = "e0b05777fb20cda8f77db622e1231fc6"
DD_APP_KEY = "884a9183c461eef2650482beabab7f72e05400a6"

target_hostname = "XX-web-01"

api_url = "https://api.datadoghq.com/api/v1/hosts"

headers = {
    "Content-Type": "application/json",
    "DD-API-KEY": DD_API_KEY,
    "DD-APPLICATION-KEY": DD_APP_KEY,
}

params = {
    "filter": f"host:{target_hostname}",
}

response = requests.get(api_url, headers=headers, params=params)

if response.status_code == 200:
    data = response.json()

    if data["total_returned"] > 0:
        print(f"Host {target_hostname} exists.")
    else:
        print(f"Host {target_hostname} does not exist.")
else:
    print(response.text)
