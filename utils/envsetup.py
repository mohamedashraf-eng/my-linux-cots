import yaml
import os
import subprocess
import threading

ENVSETUPYAML_PATH = "./envsetup.yaml"

def run_preconditions(preconditions):
    query = preconditions.get('setup_query')
    if query:
        subprocess.run(query, shell=True)

def clone_git_repo(git_repo, abs_path):
    if not os.path.exists(abs_path):
        os.makedirs(abs_path)

    os.chdir(abs_path)
    subprocess.run(["git", "clone", git_repo])

def validate_directory(directory):
    if not os.path.exists(directory):
        print(f"Error: Directory '{directory}' does not exist.")
        return False
    return True

def validate_file(file_path, expected_content):
    if not os.path.isfile(file_path):
        print(f"Error: File '{file_path}' does not exist.")
        return False
    with open(file_path, 'r') as file:
        content = file.read()
    if content != expected_content:
        print(f"Error: Content of '{file_path}' is not as expected.")
        return False
    return True

def validate_git_repo(git_repo, abs_path):
    if not validate_directory(abs_path):
        return False
    # Additional checks for the Git repository can be added here
    return True

def validate_setup_stage(stage, details):
    abs_path = os.path.expanduser(details['abs_path'])
    if isinstance(details, list):
        for item in details:
            for key, value in item.items():
                if key == 'git_repo':
                    git_repo = value
                elif key == 'abs_path':
                    abs_path = os.path.expanduser(value)
            if not validate_git_repo(git_repo, abs_path):
                return False
    else:
        if not validate_git_repo(details['git_repo'], abs_path):
            return False
    return True

def process_stage(stage, abs_path):
    for key, value in stage.items():
        if key == 'git_repo':
            git_repo = value
        elif key == 'abs_path':
            abs_path = os.path.expanduser(value)

    clone_git_repo(git_repo, abs_path)

def setup_thread(stage, details):
    abs_path = os.path.expanduser(details['abs_path'])
    if isinstance(details, list):
        for item in details:
            process_stage(item, abs_path)
    else:
        process_stage(details, abs_path)

def parse_setup_yaml(yaml_file):
    with open(yaml_file, 'r') as file:
        try:
            yaml_data = yaml.safe_load(file)
        except yaml.YAMLError as e:
            print(f"Error loading YAML file {yaml_file}: {e}")
            return

    setup = yaml_data.get('setup', {})

    run_preconditions(setup.get('preconditions', {}))

    threads = []
    for stage, details in setup.items():
        if stage == 'preconditions':
            continue
        if not validate_setup_stage(stage, details):
            return
        thread = threading.Thread(target=setup_thread, args=(stage, details))
        threads.append(thread)
        thread.start()

    for thread in threads:
        thread.join()

if __name__ == '__main__':
    parse_setup_yaml(ENVSETUPYAML_PATH)
