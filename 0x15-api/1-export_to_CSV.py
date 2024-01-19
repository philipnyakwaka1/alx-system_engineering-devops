#!/usr/bin/python3
"""
Python script that, using this REST API, for a given employee ID,
returns information about his/her TODO list progress
"""
import csv
import json
import requests
import sys


def my_func():
    """my func"""
    url_n = f'https://jsonplaceholder.typicode.com/users/{sys.argv[1]}/'
    username = json.loads(requests.get(url_n).text).get('username')
    response = requests.get('https://jsonplaceholder.typicode.com/todos/')
    task_list = json.loads(response.text)
    completed = 0
    total = 0
    titles = []
    my_list = []
    for task in task_list:
        if int(task.get('userId')) == int(sys.argv[1]):
            tmp = [task['userId'], username,
                   task['completed'], task['title']]
            my_list.append(tmp)
    with open('USER_ID.csv', 'w') as f:
        writer = csv.writer(f)
        writer.writerows(my_list)


if __name__ == '__main__':
    my_func()
