# Copyright Temenos @ 2018
# This repository contains following files that will be used to create Weblogic Server Image
# As a pre-requisite, Account should be created in https://container-registry.oracle.com, 
# in order to use container-registry.oracle.com/java/serverjre:8 to build WLS image

1) fmw_12.2.1.3.0_wls_quick_Disk1_1of1.zip
2) fmw_12.2.1.3.0_wls_supplemental_quick_Disk1_1of1.zip
3) install.file
4) oraInst.loc
5) Dockerfile

fmw_12.2.1.3.0_wls_quick_Disk1_1of1.zip contains Weblogic Server in zipped version. The same can be downloaded from 
http://www.oracle.com/technetwork/middleware/fusion-middleware/downloads/index.html

fmw_12.2.1.3.0_wls_supplemental_quick_Disk1_1of1.zip contains Weblogic Server supplements like Sample Domains etc in zipped version. 
The same can be downloaded from http://www.oracle.com/technetwork/middleware/fusion-middleware/downloads/index.html

install.file and oraInst.loc contains the information required to build Weblogic Server Image.

Dockerfile contains the commands to create Docker Image of Weblogic Server

Build Docker Image:
To build Docker Image of Weblogic Server, place all the files listed above in a folder. Select the location and execute 

$ docker build -t wlslocal .

System will create the docker image, whose name is wlslocal. This image will be used to create T24 domain.