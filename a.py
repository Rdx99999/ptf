import subprocess

def run_docker():
    # Docker command to run Firefox in a container with the specified options
    command = [
        "docker", "--allow-root", "run",
        "-v", "/content/tools/firefox:/config",
        "-p", "5800:5800",
        "jlesage/firefox"
    ]
    
    try:
        # Run the command
        subprocess.run(command, check=True)
        print("Docker container is running successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error running Docker command: {e}")
    except FileNotFoundError:
        print("Docker is not installed or not found in the system path.")

if __name__ == "__main__":
    run_docker()
