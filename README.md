# Overview

This project specifies how to perform continuous integration and continuous delivery for a python based machine learning application using the Flask web framework. The project consists of a pre-trained, sklearn model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on.

The project is hosted on Github repo, which uses Github actions for Continuous Integration, Azure Pipeline for Continuous Delivery along with Azure Platform as-a Service (PaaS). You can either :

- deploy the project as local flask app
- deploy the project in Azure Cloud Shell on localhost
- deploy the project in Azure App Service

Any commits to the GitHub repo trigger automated code testing, linting and deployment using GitHub Actions. A pipeline has been created in Azure DevOps, and the updated code is also automatically tested in Azure DevOps and deployed to the Azure App Service.

This project is submitted as part of Udacity - Data Engingeer Nanodegree program.

## Project Plan

- <a href="https://trello.com/b/0iSwb1uu/flask-sklearn" target="_blank">Trello</a> board to track the project from intiation to deployment
- [Excel](project-management-template.xlsx) Spreadsheet is created and uploaded as part of project plan estimate.

## Instructions

- Architectural Diagram
  
  ![](./images%20%26%20screenshots/architecture-diagram.png)

## Instructions
## Deploying the application in Azur cloud Shell
  Git clone the project in Azure Cloud Shell
  ```
  git clone git@github.com:ChandrakantNaik/flask-sklearn.git
  ```
  ![git-clone](images%20&%20screenshots/git-clone.GIF)
  
  Create the virtual venv and activate it
  ```
  python -m venv ~/.udacity-devops
  source ~/.udacity-devops/bin/activate
  ```
  
  Install dependencies into the virtual env and run tests
  ```
  make all
  ```
  ![](./images%20%26%20screenshots/make-all.GIF)
  
  Run the flask application locally 
  ```
  python app.py
  ```
  ![](./images%20%26%20screenshots/run-locally.GIF)
  
  To make a prediction, you have to open a separate tab or terminal window. In this new window, navigate to the main project directory and activate the virtual env and run the below command. 
  ```
  ./make_prediction.sh
  ```
  The output should match the below :
  
  ![](./images%20%26%20screenshots/run-prediction-locally.GIF)
  

## Create an Azure Webapp and deploy it

  Create an azure webapp using the below command in azure cloud shell
  ```
  az webapp up -n flask-ml-sklearn --resource-group Azuredevops --runtime "PYTHON:3.7"
  ```
  
  The output of the cloud shell should match the below post successfull creation of web app

  ![](images%20&%20screenshots/az-webapp-creation.GIF)
  
  The newly created web app resource can be viewed in Azure portal as well. Screenshot for your reference

  ![](./images%20%26%20screenshots/az-webapp-in-azure.GIF)

  Verify the deployed application works by browsing to the deployed URL

  ![Viewing the deployed app in chrome](./images%20%26%20screenshots/azure-webapp-chrome.GIF)

## Azue Devops setup to automate the CI/CD Process via Azure pipeline.
  Log into the https://dev.azure.com/ in a separate browser tab using the same Azure account

  Before you create a new project, ensure to make your DevOps project allow public access by turning the visibility on in the Organization settings >> Policies section. Steps are outlined [here](https://docs.microsoft.com/en-us/azure/devops/organizations/public/make-project-public?view=azure-devops#enable-anonymous-access-to-projects-for-your-organization)
  Create a new DevOps project in the newly created DevOps org. Let's name the project as flask-sklearn, as shown below.

  ![](./images%20%26%20screenshots/azure-devops-project.GIF)

  Under Project Settings create a new service connection to Azure Resource Manager, scoped to your subscription and resource group.

  Create a new Personal Access Token (PAT) that will be used instead of a password by the build agent (Linux VM) for authentication/authorization and ensure that it has a "Full access" scope

  Create an self-hosted Agent pool

  Create and configure a new Linux VM as an Azure DevOps Build Agent

  Prepare the agent for building the Flask application

  Go back to the DevOps project, select Pipeline and create a new one.

  Connect to the Github repo as the source code location

  Choose the **Existing Azure Pipelines YAML** file option

  Edit and Review the azure-pipelines-for-self-hosted-agent.yml file. 

  Running Azure App Service from Azure Pipelines automatic deployment

  ![](./images%20%26%20screenshots/azure-pipeline-run.GIF)
  
  To perform a successful prediction from deployed flask app run the below command in Azure Cloud Shell .
  ```
  ./make_predict_azure_app.sh
  ```
  The output should look similar to this:

  ```bash
  (.udacity-devops) (base) odl_user [ ~/flask-sklearn ]$ ./make_predict_azure_app.sh
  Port: 443
  {"prediction":[20.869782939832444]}
  ```

  Output of streamed log files from deployed application
  ```bash
  (.udacity-devops) (base) odl_user [ ~/flask-sklearn ]$ az webapp log tail -g azuredevops --name flask-ml-sklearn
  2022-10-11T19:40:31  Welcome, you are now connected to log-streaming service.

  Starting Log Tail -n 10 of existing logs ----

  /home/LogFiles/__lastCheckTime.txt  (https://flask-ml-sklearn.scm.azurewebsites.net/api/vfs/LogFiles/__lastCheckTime.txt)
  10/11/2022 18:43:52

  /home/LogFiles/kudu/trace/00b8192c9f57-1e24b553-3b60-4635-8b0c-3cf0698cffda.txt  (https://flask-ml-sklearn.scm.azurewebsites.net/api/vfs/LogFiles/kudu/trace/00b8192c9f57-1e24b553-3b60-4635-8b0c-3cf0698cffda.txt)
  2022-10-11T19:34:49  Startup Request, url: /api/deployments/11665516888779, method: PUT, type: request, pid: 77,1,4, SCM_DO_BUILD_DURING_DEPLOYMENT: True, ScmType: VSTSRM
  ```
>

## Load Testing
Note: Azure cloud Shell is not enough good to perform locust there, so I used my own WSL having Ubuntu 18.0.4 on windows to run Locust. Follow the link [here](https://www.ssl.com/how-to/enable-linux-subsystem-install-ubuntu-windows-10/)

Now if you do a quick search in windows to see if newly installed Ubuntu. The output should match the below screen.

![](images%20&%20screenshots/ubuntu.GIF)

We have to prepare our Ubuntu app for our Flask application. We have to install some additional packages in our Ubuntu app to build the Flask application code. These commands are specific to our sample Flask application, you can extend them per your application requirements:
```
sudo apt-get update
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.7
sudo apt-get install python3.7-venv
sudo apt-get install python3-pip
python3.7 --version
pip --version 
sudo apt-get install python3.7-distutils
```

Navigate to the project directory create and activate the virtual env using the below commands
```
python3.7 -m venv ~/.udacity-devops
source ~/.udacity-devops/bin/activate
```

Verify if the installation and project setup is successfull by running the flask app. using below command
```
python3.7 app.py
```

The output should match the below screenshot

![](images%20&%20screenshots/local-app-output.png)

Let's get started with load tesing
Install locust
```
pip install locust
```

Ensure the app is running

Copy locustfile.py and run it using **locust** command. Open the browser on http://localhost:8089/ 
![](images%20&%20screenshots/locust.GIF)

You can then watch the load test:
![](images%20&%20screenshots/locust-chart.GIF)

## Enhancements
- Currently the predictions are observed via Azure Cloud Shell. The Azure web app can be further enhanced to dispaly the predictions in web page.

## Demo

<TODO: Add link Screencast on YouTube>
