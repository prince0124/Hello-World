set -e
echo "Start"

main() {
	
	export CF_TRACE=false
	welcome
        loginCf
	checkPrereq
	lab3

}
loginCf()
{
   cf login -a https://api.system.aws-usw02-pr.ice.predix.io -u student10 -p 'PrediX20!7' -o Predix-Training -s Training3 || echoP
   
}


checkPrereq()
{
  {
    echo "Checking prerequisites ..."
    verifyCommand 'cf -v'
    verifyCommand 'uaac -v'
    nodeVersion 'node -v'
    npmVersion  'npm -v'
    echo ""
  }||
  {
    echo echoP
  }
}
lab3(){
	cd ~/PredixApps/training_labs/UI_Lab/predix-seed/
	sudo npm install gulp-cli -g && sudo npm install && yes !1 | bower install || echoP
        gulp dist
	cf push test-seed --random-route || echoP
        echo "Succeed"
}

welcome() {
echo "Starting Testing Labs"
}

echoP() {
echo $errorlevel
exit 0
}
# Verifies a given command exisitance
verifyCommand()
{
  x=$($1)
  # echo "x== $x"
  if [[ ${#x} -gt 5 ]];
  then
    echo "OK - $1"
  else
    echoc r "$1 not found!"
    echoc g "Please install: "
    echoc g "\t CF - https://github.com/cloudfoundry/cli"
    echoc g "\t UAAC -https://github.com/cloudfoundry/cf-uaac"
    sadKitty
  fi

}
nodeVersion(){
x=$($1)
if [ "$x" == 'v7.10.0' ]
then 
  echo "Node Version Okay"
else
  echoP
fi
}

npmVersion(){
x=$($1)
if [ "$x" == '4.2.0' ]
then 
  echo "npm Version Okay"
else
  echoP
fi
}

main


