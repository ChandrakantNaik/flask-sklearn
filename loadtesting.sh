#!/usr/bin/env bash

locust -f locustfile.py --host https://flask-ml-sklearn.azurewebsites.net/ --users 500 --spawn-rate 5 
