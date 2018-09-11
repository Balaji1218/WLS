# Step 1 - Pre-requisites Downloads
# Create account in https://container-registry.oracle.com
# Accept Terms and Conditions
# docker login container-registry.oracle.com -u cse.praveen@gmail.com -p Muruga009
# docker pull container-registry.oracle.com/java/serverjre:8

FROM container-registry.oracle.com/java/serverjre:8
LABEL maintainer "cse.praveen@gmail.com"

# Image Name : wlslocal

EXPOSE 9010

# WLS related files
RUN mkdir -p /weblogic && \
    chmod a+xr /weblogic && \
    useradd -b /weblogic -d /weblogic/oracle -m -s /bin/bash oracle

COPY fmw_12.2.1.3.0_wls_quick_Disk1_1of1.zip install.file oraInst.loc /weblogic/
COPY fmw_12.2.1.3.0_wls_supplemental_quick_Disk1_1of1.zip /weblogic/

# Step 2 - Set Environment Variables required for Server
ENV FMW_QUICK_PKG=fmw_12.2.1.3.0_wls_quick_Disk1_1of1.zip \
    FMW_QUICK_JAR=fmw_12.2.1.3.0_wls_quick.jar \
	FMW_SUPP_PKG=fmw_12.2.1.3.0_wls_supplemental_quick_Disk1_1of1.zip \
    FMW_SUPP_JAR=fmw_12.2.1.3.0_wls_supplemental_quick.jar \
    ORACLE_HOME=/weblogic/oracle

	
# Step 3 -  Unzip Weblogic Server
RUN  chown oracle:oracle -R /weblogic
	 
USER oracle

RUN cd /weblogic && $JAVA_HOME/bin/jar xf /weblogic/$FMW_QUICK_PKG && cd - && \
	$JAVA_HOME/bin/java -jar /weblogic/$FMW_QUICK_JAR -invPtrLoc /weblogic/oraInst.loc -jreLoc $JAVA_HOME -ignoreSysPrereqs -force -novalidation ORACLE_HOME=$ORACLE_HOME && \
    rm /weblogic/$FMW_QUICK_JAR /weblogic/$FMW_QUICK_PKG
	
RUN cd /weblogic && $JAVA_HOME/bin/jar xf /weblogic/$FMW_SUPP_PKG && cd - && \
	$JAVA_HOME/bin/java -jar /weblogic/$FMW_SUPP_JAR -invPtrLoc /weblogic/oraInst.loc -jreLoc $JAVA_HOME -ignoreSysPrereqs -force -novalidation ORACLE_HOME=$ORACLE_HOME && \
    rm /weblogic/$FMW_SUPP_JAR /weblogic/$FMW_SUPP_PKG /weblogic/oraInst.loc /weblogic/install.file

# cd C:\Docker\Weblogic\WLSLocal
# docker build -t wlslocal .

