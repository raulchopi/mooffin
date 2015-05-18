#!/bin/bash
 
function pause(){
   read -p "$*"
}
 
echo"Limpiando recursos..."
bundle exec rake assets:clobber RAILS_ENV="production"
 
echo"Precompilando..."
bundle exec rake assets:precompile RAILS_ENV="production"
 
rm tmp/restart.txt
touch tmp/restart.txt
 
echo"Reiniciado passenger..."
 
pause 'Pulsa ENTER para finalizar'
