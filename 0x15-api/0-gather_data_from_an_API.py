#!/usr/bin/python3
"""
Python script that, using this REST API, for a given employee ID,
returns information about his/her TODO list progress
"""
import requests
import sys
import json


def my_func():
    """my func"""
    url_n = f'https://jsonplaceholder.typicode.com/users/{sys.argv[1]}/'
    name = json.loads(requests.get(url_n).text).get('name')
    print(name)
    response = requests.get('https://jsonplaceholder.typicode.com/todos/')
    task_list = json.loads(response.text)
    completed = 0
    total = 0
    titles = []
    for task in task_list:
        if int(task.get('userId')) == int(sys.argv[1]):
            if task.get('completed') is True:
                titles.append(task.get('title'))
                completed += 1
                total += 1
            else:
                total += 1
    print(f'Employee {name} is done with tasks({completed}/{total})')
    for title in titles:
        print(f'\t{title}')


if __name__ == '__main__':
    my_func()
