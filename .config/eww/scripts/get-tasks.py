from json import dumps
from todoist_api_python.api import TodoistAPI
from os import environ
from sys import stderr

api = TodoistAPI(environ['TODOIST_API_KEY'])
project_id = environ['TODOIST_PROJECT_ID']

try:
    sections = list(map(lambda x: {'order': x.order, 'name': x.name, 'id': x.id}, api.get_sections(project_id=project_id)))
    tasks = [ {'name': section['name'], 'tasks': (list(map(lambda x: {'order': x.order, 'content': x.content, 'due': x.due.string if x.due is not None else None, 'priority': x.priority, 'url': x.url}, api.get_tasks(project_id=project_id, section_id=section['id']))))} for section in sections ]
    print(dumps(tasks))
except Exception as error:
    print(dumps('{}'))
    stderr.write(error)
