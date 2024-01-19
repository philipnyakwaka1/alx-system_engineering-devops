#!/usr/bin/python3
"""requests datadog api"""
import requests
import json

headers = {
    "Content-Type": "application/json",
    "DD-API-KEY": 'e0b05777fb20cda8f77db622e1231fc6',
    "DD-APPLICATION-KEY": '884a9183c461eef2650482beabab7f72e05400a6',
}

response = requests.get(
    'https://api.datadoghq.com/api/v1/dashboard', headers=headers)

if response.status_code == 200:
    dashboards = json.loads(response.text)
    print(dashboards)
