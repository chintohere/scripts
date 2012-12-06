#Springboard
GA_RASP_6.7.1_2012112
GA_RASP_CORE_2.6.5_20121023
GA_DATA_IMPORT_1.8_20121023
GA_RASP_COMPONENT_1.4_20120806
GA_RASP_ACTION_1.1.1_20110117
jspa-persistence-2.4.0_20111026

#Webservices
GA_rasp-ws-ear-6.0.0-20110726
jspa-peristence-2.3.6_20101201

#RASP 5
BR_RASP_5.4.3_20090602
GA_RASP_UTIL_2.2.0_20090401

#Rules Engine
GA_RULES_1.1.0_20110208
GA_RASP_CORE_2.3.2_20110207
GA_RASP_ACTION_1.1.1_20110117

#PDF Tool
GA_BULKPRINT_1.1.0_20120119

#Linked In Webservice
linkedin-integration_1.0.3_20120521

#SMS Services
GA_SMS_SERVICES_1.1.0_20121022

#Orbeon Integration
GA_ORBEON_INTEGRATION_2.3.3_20120907
GA_ORBEON_PARSER_1.0.0_20120907

#Rasp Core Latest Release
GA_RASP_CORE_3.6.6_20121203

#Data Import Latest Release
GA_DATA_IMPORT_1.9_20121203

#JSPA - DAO Persistence Latest Release
jspa-persistence_2.4.2_20120529  







#!/bin/sh

#trim spaces around
function trim()
{
  local var=$1
	var="${var#"${var%%[![:space:]]*}"}" #remove leading whitespace characters
	var="${var%"${var##*[![:space:]]}"}" #remove trailing whitespace characters
	echo -n "$var"
}

#Initialize where all the sources will be exported to
sources="sources"

if [ -n "$1" ]; then
	sources=$1
fi

echo "Starting code export...."
echo "======================================"
echo "Code will be exported to '"$sources"'."

#Read releases to export
input=export.releases
echo "Reading release tags from file: "$input

#Repository tags base on SVN
repo_tags="http://integ:90/repos/RASP/tags/GA/" 

#Start processing file line by line
while read line
do
	#for each non empty line which is not a comment
	if [ -n "$line" ] && [[ $line != \#* ]]; then
		tag=$(trim $line)
		release="$repo_tags$tag"
		dest="$sources/$tag"
		echo "Exporting : "$release" to dir: "$dest"..."
		svn  export -q $release $dest
		echo "Done."
	fi
done < "$input"

#Tar and zip them sources up
echo "Packaging "$sources"..."
tar czf "$sources.tar.gz" $sources
echo "Done."
echo "======================================"
echo "Export complete!"
