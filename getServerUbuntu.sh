which git
OUT1=$?
if [ $OUT1 -eq 1 ];then
	echo "We will attempt to install git in order to compile the server jar files. If this fails, you may need to run this script in SUDO"
	apt-get install git
fi

which java
OUT2=$?
if [ $OUT2 -eq 1 ];then
	echo "We will attempt to install java in order to compile the server jar files. If this fails, you may need to run this script in SUDO"
	apt-get install openjdk-7-jre
fi

which tar
OUT3=$?
if [ $OUT3 -eq 1 ];then
	echo "We will install the tar file command as it is needed to compile the server jar files. If this fails, you may need to run this script in SUDO"
	apt-get install tar
fi

echo "Removing old buildtools (if any exist)"
rm BuildTools.jar

echo "Removing old server jars and other stuff"
find ! -name 'getServerUbuntu.sh' -type f -exec rm -f {} +

echo "Retrieving latest build tools"
wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

echo "Unsetting git config option as required by buildtools"
git config --global --unset core.autocrlf

echo "Compiling jars."
java -jar BuildTools.jar


echo "Done compiling"
