#!/bin/bash

# In classic mode, the containers run IPOP to form a vnet
# amongst themselves. This machine only hosts the support services

#Install dependencies required for building tincan
setup-build-deps

# Clone and build Tincan
setup-tincan

#Install dependencies required for building tincan
setup-build-deps

# Clone and build Tincan
setup-tincan

# Clone Controller
setup-controller

#Create default container that will be duplicated to create nodes
setup-base-container
