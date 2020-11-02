### Pre-requsistes
- Docker
- Make user can access the docker socket with the right privileges (user must be member of the docker group):
https://docs.docker.com/engine/install/linux-postinstall/

### Build the custom image
```
docker build --tag custom-admin-cli:latest .
```

### Run the container in detached mode with the scripts mounted
### On Linux
```
docker run --name admin-cli -v ${PWD}/scripts:/scripts -d custom-admin-cli:latest
```
### On Windows
```
docker run --name admin-cli -v %cd%/scripts:/scripts -d custom-admin-cli:latest
```

### Execute the script within the container
```
docker exec admin-cli python /scripts/admin-cli.py
```

### Side notes:
- When adding extra python dependency through the requirement.txt file make sure to rebuild the image and run a new container:
```
docker stop admin-cli && docker rm admin-cli 
docker build --tag custom-admin-cli:latest .
docker run -d custom-admin-cli:latest --name=admin-cli -v ./scripts:/scripts
```