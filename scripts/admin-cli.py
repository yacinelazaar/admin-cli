import subprocess

command = "/scripts/script.sh"

process = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)

(output, err) = process.communicate()  

#This makes the wait possible
process_status = process.wait()

#This will give you the output of the command being executed
print("Command output: " + output.decode("utf-8"))