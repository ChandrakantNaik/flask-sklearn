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

<TODO:

- Architectural Diagram

<TODO: Instructions for running the Python project. How could a user with no context run this project without asking you for any help. Include screenshots with explicit steps to create that work. Be sure to at least include the following screenshots:

- Project running on Azure App Service

- Project cloned into Azure Cloud Shell

- Passing tests that are displayed after running the `make all` command from the `Makefile`

- Output of a test run

- Successful deploy of the project in Azure Pipelines. [Note the official documentation should be referred to and double checked as you setup CI/CD](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops).

- Running Azure App Service from Azure Pipelines automatic deployment

- Successful prediction from deployed flask app in Azure Cloud Shell. [Use this file as a template for the deployed prediction](https://github.com/udacity/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C2-AgileDevelopmentwithAzure/project/starter_files/flask-sklearn/make_predict_azure_app.sh).
  The output should look similar to this:

```bash
udacity@Azure:~$ ./make_predict_azure_app.sh
Port: 443
{"prediction":[20.35373177134412]}
```

- Output of streamed log files from deployed application

>

## Enhancements

<TODO: A short description of how to improve the project in the future>

## Demo

<TODO: Add link Screencast on YouTube>
