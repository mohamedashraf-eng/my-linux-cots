import yaml
import os
import subprocess
import threading

def run_preconditions(preconditions):
    query = preconditions.get('setup_query')
    if query:
        subprocess.run(query, shell=True, check=True)

def clone_git_repo(git_repo, abs_path):
    if not os.path.exists(abs_path):
        os.makedirs(abs_path)
    os.chdir(abs_path)
    subprocess.run(["git", "clone", git_repo], check=True)

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

def validate_setup_stage(details):
    if isinstance(details, list):
        for item in details:
            if not validate_setup_stage(item):
                return False
    elif isinstance(details, dict):
        abs_path = os.path.expanduser(details.get('abs_path', ''))
        if not validate_git_repo(details.get('git_repo', ''), abs_path):
            return False
    elif isinstance(details, str):  # Handle simple string format
        abs_path = os.path.expanduser(details)
        if not validate_directory(abs_path):
            return False
    else:
        print(f"Error: Invalid setup stage format - {details}")
        return False
    return True

def process_stage(details):
    if isinstance(details, dict):
        abs_path = os.path.expanduser(details.get('abs_path', ''))
        clone_git_repo(details.get('git_repo', ''), abs_path)
    elif isinstance(details, str):  # Handle simple string format
        abs_path = os.path.expanduser(details)
        if not os.path.exists(abs_path):
            os.makedirs(abs_path)
    else:
        print(f"Error: Invalid setup stage format - {details}")

def setup_thread(details):
    process_stage(details)

def parse_setup_yaml(yaml_file):
    with open(yaml_file, 'r') as file:
        try:
            yaml_data = yaml.safe_load(file)
        except yaml.YAMLError as e:
            print(f"Error loading YAML file {yaml_file}: {e}")
            return

    general_info = yaml_data.get('general_info', {})
    setup = yaml_data.get('setup', {})

    print_general_info(general_info)

    run_preconditions(setup.get('preconditions', {}))

    threads = []
    for stage, details in setup.items():
        if stage == 'preconditions':
            continue
        if not validate_setup_stage(details):
            return
        thread = threading.Thread(target=setup_thread, args=(details,))
        threads.append(thread)
        thread.start()

    for thread in threads:
        thread.join()

def print_general_info(info):
    print("General Information:")
    print(f"Author: {info.get('author_name')}")
    print(f"Email: {info.get('author_email')}")
    print(f"Version: {info.get('version')}")
    print(f"Date: {info.get('date')}")
    print(f"License: {info.get('license')}")
    print(f"Description: {info.get('description')}")
    print("\n")

if __name__ == '__main__':
    ENVSETUPYAML_PATH = 'envsetup.yaml'  # Replace with the path to your YAML file
    parse_setup_yaml(ENVSETUPYAML_PATH)
