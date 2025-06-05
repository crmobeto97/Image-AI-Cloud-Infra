# Image-AI-Cloud-Infra

this project is for create for Cloud Infraestructure (Cloud Services) to Image Models input AI

## Technology Stack

Tecnologies used in the project (including cloud platform)

1. Ubuntu
1. Docker
1. Terraform

## Project Structure

```

```

## Environment Variable



### Quick Start

1.  Create the network follow  [README.md](https://github.com/crmobeto97/Image-AI-Backend/blob/main/network/README.md ) in [network](https://github.com/crmobeto97/Image-AI-Backend/tree/main/network)

    1.  Enter in  [network](https://github.com/crmobeto97/Image-AI-Backend/tree/main/network)
    1.  Run script [create_docker_network.sh](https://github.com/crmobeto97/Image-AI-Backend/blob/main/network/create_docker_network.sh) 

    if you creatred before only run in your terminal

    1. network_name="image-ia"
    
1.  Build and Run Terraform container
    1.  Build insided root folder with the command:
        ```bash
        docker build . -t terraform-1
        
        o
        
        docker build --no-cache . -t terraform-1
        ```
    1.  Run the Container App:
        *   For interactive terminal session with the host local files (for modification and test in real team, not need re-build) run
            Linux
            ```bash
            $ docker run -it --rm --name=infra --network $network_name --ip 10.0.0.4 -v $(pwd):"/home/realtime" terraform-1 bash
            ```
            PowerShell
            ```bash
            $ docker run -it --rm --name=infra --network "image-ia" --ip "10.0.0.4" -v ${PWD}:"/home/realtime" terraform-1 bash
            ```

            or

            ```bash
            $ docker run -it \
                --rm \
                --name infra \
                --network $network_name \
                --ip 10.0.0.4 \
                -v $(pwd):"/home/realtime" \
                terraform-1 bash
            ```
            For run the application inside the terminal run:

            ```bash
            cd ../realtime
            terraform init
            terraform workspace new dev
            terraform workspace select dev
            terraform plan  -var-file=./vars/0-dev/terraform.tfvars
            terraform apply --auto-approve  -var-file=./vars/0-dev/terraform.tfvars
            ```

        *   For non interactive run

            ```bash
            docker run --rm -d --name=infra -p 8000:8000 terraform-1
            ```

        flags:

        * `--rm`&nbsp;&nbsp;&nbsp;&nbsp;    Erase the docker after stop
        * `-d`&nbsp;&nbsp;&nbsp;&nbsp;      Run container in background and print container ID
        * `-it`&nbsp;&nbsp;&nbsp;&nbsp;      Interactive session
        * `--name`&nbsp;&nbsp;&nbsp;&nbsp;   Containers name
        * `-p`&nbsp;&nbsp;&nbsp;&nbsp;       Publish a container's port(s) to the host (e.g., `-p <host port>:<container port>`)


        more information flags in [docker container run options](https://docs.docker.com/reference/cli/docker/container/run/#options) 
    

<!-- Bibliografy -->
[1]: https://example          "example documentation"