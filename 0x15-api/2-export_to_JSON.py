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
    my_list = []
    for task in task_list:
        if int(task.get('userId')) == int(sys.argv[1]):
            my_dict = {}
            my_dict.update(
                {'task': task['title'], 'completed': task['completed'],
                 'username': username})
            my_list.append(my_dict)

    with open(f'{sys.argv[1]}.json', 'w', encoding='utf-8') as f:
        data = {sys.argv[1]: my_list}
        json.dump(data, f, ensure_ascii=False)


if __name__ == '__main__':
    my_func()
