# setting JAVA_HOME
#export JAVA_HOME=$(/usr/libexec/java_home)
if [ -e ${ZSHHOME}/java_home ]; then
	export JAVA_HOME=`cat ${ZSHHOME}/java_home`
else
	export JAVA_HOME=$(/usr/libexec/java_home)
fi
