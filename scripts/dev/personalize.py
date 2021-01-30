import os

if __name__ == "__main__":

    directory = os.listdir("scripts/dev")

    for f_name in directory:
        print(f_name)
