JSON='{"username": "admin", "password": "Password1"}'
echo $JSON

apiKey=$(curl -i --header "Content-Type: application/json" --data '{"username": "admin", "password": "Password1"}' http://34.210.71.26:8081/rest/abl/admin/v2/@authentication| sed -n 's/.*"apikey": "\(.*\)",/\1/p' | sed 's/"//g' | sed "s/[,].*//")

echo APIKEY: $apiKey

projectID=$(curl -i --header "Content-Type: application/json" --header "Authorization:CALiveAPICreator "${apiKey}":1" --data '{"name": "Vista","url_name": "Vista","is_active": true,"account_ident": 1000,"authprovider_ident": 1000 }' http://34.210.71.26:8081/rest/abl/admin/v2/admin:projects | tr -d '\n'|sed 's/ //g'|sed 's@.*:@@'|sed 's/}.*//')


echo projectID: $projectID
 

curl -i --header "Content-Type:application/json" --header "Authorization:CALiveAPICreator "${apiKey}":1" --data \{\"name\":\"CustomerDataSource\",\"role_strategy\":\"\simplicity\",\"schema_editable\":false,\"active\":true,\"project_ident\":"${projectID}",\"dbasetype_ident\":23,\"comments\":\"Created\ using\ Connect\ Wizard\",\"url\":\"jdbc\:csv:Data\ Source=./\;Include\ Files=.csv\;Extended\ Properties=LineEnding=LF\;HDR=Yes\;FMT=CSVDelimited\"\} http://34.210.71.26:8081/rest/abl/admin/v2/DbSchemas -v
