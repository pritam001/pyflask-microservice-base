import fnmatch
import os
import sys

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
    print(pyflask_pref_dict)
    with open(r"./pyflask-preferences.yaml", "w") as file:
        documents = yaml.dump(pyflask_pref_dict, file)

    for f in matches:
        with open(f) as open_f:
            for num, line in enumerate(open_f, 1):
                if "pyflask_config" in line:
                    print(line)
