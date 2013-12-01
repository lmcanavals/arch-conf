
export JAVA_HOME="/opt/java"
export MVN_HOME="/home/martin/Archive/usr/maven"
export CLASSPATH=".:$JAVA_HOME/lib"
ANDSTUDIO="/home/martin/Archive/usr/android-studio"
PATH="$ANDSTUDIO/sdk/platform-tools:$ANDSTUDIO/sdk/tools:$PATH"
PATH="$ANDSTUDIO/bin:$PATH"
export PATH="$JAVA_HOME/bin:$MVN_HOME/bin:$PATH"
unset ANDSTUDIO
