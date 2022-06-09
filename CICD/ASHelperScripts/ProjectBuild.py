
import argparse
import json
import os
import subprocess
import sys
from os import path

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-r', '--repository', help='Repository Directory', dest='repo', required=True)
    parser.add_argument('-c', '--config', help='Configuration File Name', dest='config', required=False, default='build.json')
    args = parser.parse_args()
    if (path.exists(args.repo + '\\' + args.config) != True):
        print('config file not found in ' + args.repo + '\\' + args.config)
        return 0
    sequence = json.load(open(args.repo + '\\' + args.config))

    result = 0
    failedJobs = []
    for job in sequence:
        command = job['command']
        name = job['name'] if 'name' in job else command
        if (('disable' in job) and (job['disable'].lower() == 'true')):
            print(f'skipping {name}')
            continue
        command_args = ''
        for arg in job['args']:
            if ('${projectDir}' in arg):
                arg = arg.replace('${projectDir}', '"' + args.repo) + '"'
            command_args += arg + ' '
        cmd_result = subprocess.run('python "' + os.path.dirname(os.path.realpath(__file__)) + '\\' + command + '" ' + command_args, cwd=args.repo, capture_output=True, text=True)
        print(cmd_result.stdout)
        if (cmd_result.returncode > result):
            failedJobs.append(name)
            result = cmd_result.returncode
    for job in failedJobs:
        print('Failed at ' + job)
    sys.exit(result)
    return

if __name__ == '__main__':
    main()