#!/bin/bash

zip -r9 apidemo.zip ./* -x tmp/\* models/\*.pyc .DS_Store \*.log \*.zip \*.old \*.out
