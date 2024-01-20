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
    response = requests.get('https://jsonplaceholder.typicode.com/todos/')
    task_list = json.loads(response.text)
    my_list = []
    all_tasks = {}
    for task in task_list:
        url_n = f'https://jsonplaceholder.typicode.com/users/' + \
            str(task.get('userId'))
        username = json.loads(requests.get(url_n).text).get('username')
        my_dict = {}
        my_dict.update(
            {'task': task['title'], 'completed': task['completed'],
             'username': username})
        my_list.append(my_dict)
        if task['userId'] in all_tasks:
            pass
        else:
            all_tasks.update({task['userId']: my_list})

    with open('todo_all_employees.json', 'w', encoding='utf-8') as f:
        json.dump(all_tasks, f, ensure_ascii=False)


if __name__ == '__main__':
    my_func()
