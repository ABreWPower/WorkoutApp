cd server

DIR=".serverless"
if [ -d "$DIR" ]; then
  ### Take action if $DIR exists ###
  echo "Serverless already deployed, only pushing up package"
  serverless deploy function -f workoutapp
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Serverless not deployed yet, deploy the whole thing"
  serverless deploy
fi

cd ..