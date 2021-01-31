import fnmatch
import os
import sys

import inquirer
import yaml

if __name__ == "__main__":
    exclude_dirs_args = sys.argv[1].split(",")
    exclude_dirs = ["src", "test", "assets"] + exclude_dirs_args
    exclude_files = ["personalize.py"]

    matches = []
    for root, dirs, file_names in os.walk("."):
        dirs[:] = [d for d in dirs if d not in exclude_dirs and not d.startswith(".")]
        file_names[:] = [f for f in file_names if f not in exclude_files]
        for filename in fnmatch.filter(file_names, "*"):
            matches.append(os.path.join(root, filename))

    with open(r"./pyflask-preferences.yaml") as file:
        # The FullLoader parameter handles the conversion from YAML
        # scalar values to Python the dictionary format
        pyflask_pref_dict = yaml.load(file, Loader=yaml.FullLoader)

    new_service_name = input(f"Enter service name: (current_name = {pyflask_pref_dict['service_name']}) :: ")
    pyflask_pref_dict["service_name"] = new_service_name if new_service_name != "" else pyflask_pref_dict["service_name"]

    new_python_env_name = input(f"Enter python environment name: (current_name {pyflask_pref_dict['python_env_name']}) :: ")
    pyflask_pref_dict["python_env_name"] = (
        new_python_env_name if new_python_env_name != "" else pyflask_pref_dict["python_env_name"]
    )

    questions = [inquirer.List("python_version", message="Use python version :: ", choices=["3.7", "3.8"])]
    answers = inquirer.prompt(questions)
    if answers["python_version"] == "3.8":
        pyflask_pref_dict["python_base_version_minor"] = 8
    elif answers["python_version"] == "3.7":
        pyflask_pref_dict["python_base_version_minor"] = 7

    questions = [inquirer.List("python_env_manager", message="Use python env manager :: ", choices=["conda", "venv"])]
    answers = inquirer.prompt(questions)
    pyflask_pref_dict["python_env_manager"] = answers["python_env_manager"]

    new_docker_maintainer_username = input("Enter docker maintainer username :: ")
    new_docker_maintainer_email = input("Enter docker maintainer email :: ")
    pyflask_pref_dict["docker_maintainer_details"] = f"{new_docker_maintainer_username} <{new_docker_maintainer_email}>"

    pyflask_pref_dict["is_personalized"] = True

    with open(r"./pyflask-preferences.yaml", "w") as file:
        documents = yaml.dump(pyflask_pref_dict, file)

    for f in matches:
        with open(f) as open_f:
            for num, line in enumerate(open_f, 1):
                if "pyflask_config" in line:
                    print(line)
