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


## How to run the project ?
  Git clone the project in Azure Cloud Shell
  ```
  git clone git@github.com:ChandrakantNaik/flask-sklearn.git
  ```
  
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
  
  Make prediction using ./make_prediction.sh on another cloud shell. The output should match the below :
  ![](./images%20%26%20screenshots/run-local-prediction.GIF)

## Create an Azure Webapp and deploy it

  Create an azure webapp using the below command in azure cloud shell
  ```
  az webapp up -n flask-ml-sklearn --resource-group Azuredevops --runtime "PYTHON:3.7"
  ```
  
  The newly created web app resource can be viewed in Azure portal as well. Screenshot for your reference
  ![](./images%20%26%20screenshots/az-webapp-in-azure.GIF)

  The azure web app provides the website url, which can be used to access flask app
  ![Viewing the deployed app in chrome](./images%20%26%20screenshots/azure-webapp-chrome.GIF)

## Setup Azue Devops to automate the CI/CD Process via Azure pipeline.
  - Log into the https://dev.azure.com/ in a separate browser tab using the same Azure account
  - Before you create a new project, ensure to make your DevOps project allow public access by turning the visibility on in the Organization settings >> Policies section. Steps are outlined [here](https://docs.microsoft.com/en-us/azure/devops/organizations/public/make-project-public?view=azure-devops#enable-anonymous-access-to-projects-for-your-organization)
  - Create a new DevOps project in the newly created DevOps org. Let's name the project as flask-sklearn, as shown below.
  ![](./images%20%26%20screenshots/azure-devops-project.GIF)
  - Under Project Settings create a new service connection to Azure Resource Manager, scoped to your subscription and resource group.
  - Create a new Personal Access Token (PAT) that will be used instead of a password by the build agent (Linux VM) for authentication/authorization and ensure that it has a "Full access" scope
  - Create an self-hosted Agent pool
  - Create and configure a new Linux VM as an Azure DevOps Build Agent
  - Prepare the agent for building the Flask application
  - Go back to the DevOps project, select Pipeline and create a new one.
  - Connect to the Github repo as the source code location
  - Choose the **Existing Azure Pipelines YAML** file option
  - Edit and Review the azure-pipelines-for-self-hosted-agent.yml file. 
  - Running Azure App Service from Azure Pipelines automatic deployment
    ![](./images%20%26%20screenshots/azure-pipeline-run.GIF)
  
- Successful prediction from deployed flask app in Azure Cloud Shell.
  The output should look similar to this:
  ```bash
  (.udacity-devops) (base) odl_user [ ~/flask-sklearn ]$ ./make_predict_azure_app.sh
  Port: 443
  {"prediction":[20.869782939832444]}
  ```

- Output of streamed log files from deployed application
  ```bash
  (.udacity-devops) (base) odl_user [ ~/flask-sklearn ]$ az webapp log tail -g azuredevops --name flask-ml-sklearn
  2022-10-09T18:27:01  Welcome, you are now connected to log-streaming service.

  Starting Log Tail -n 10 of existing logs ----

  /home/LogFiles/__lastCheckTime.txt  (https://flask-ml-sklearn.scm.azurewebsites.net/api/vfs/LogFiles/__lastCheckTime.txt)
  10/09/2022 14:28:19

  /home/LogFiles/kudu/trace/43a77e492c99-9202abbc-082a-404a-b0dd-32de46434146.txt  (https://flask-ml-sklearn.scm.azurewebsites.net/api/vfs/LogFiles/kudu/trace/43a77e492c99-9202abbc-082a-404a-b0dd-32de46434146.txt)
  2022-10-09T14:24:19  Startup Request, url: /api/zipdeploy?isAsync=true&trackDeploymentProgress=true, method: POST, type: request, pid: 71,1,5, SCM_DO_BUILD_DURING_DEPLOYMENT: True, ScmType: None
  ```
>

## Load Testing
## Enhancements
- Currently the predictions are observed via Azure Cloud Shell. The Azure web app can be further enhanced to dispaly the predictions in web page.

## Demo

<TODO: Add link Screencast on YouTube>
