import subprocess

def run_udocker():
    # Define the udocker command and its arguments
    command = [
        "udocker", 
        "--allow-root", 
        "run", 
        "-v", "/content/tools/firefox:/config", 
        "-p", "5800:5800", 
        "jlesage/firefox"
    ]
    
    # Run the command using subprocess
    try:
        subprocess.run(command, check=True)
        print("Udocker container started successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred: {e}")
    except FileNotFoundError:
        print("Udocker not found. Please make sure it's installed and available in your PATH.")
    
if __name__ == "__main__":
    run_udocker()
