#!/bin/sh

# Check package receipts to make sure all apps have been installed from configuration
# Written by macnetdaemon 11-18-2015

myerror=0;
missing="";

#----------- user defined: the package list array variable ------------
# The packagelist array variable (below) is the only line you have to edit.
# Simply enter the package receipt names delimited by spaces.
# Be sure to put quotes around receipts with spaces in the name (or escape the spaces with \ )

packagelist=(packageName1 PackageName2 'Package Name 3')

#----------- end of user defined: package list array variable ------------

# iterate through the array to search for the package receipts.
# on success or fail set myerror to 0 : false or 1 : true

for((i=0; i<${#packagelist[*]}; i++))
do
	thispackage=${packagelist[$i]}

#	We must put quotes around $thispackage in case the file filename contains spaces

	if [ -f /Library/Application\ Support/Jamf/Receipts/"$thispackage" ]; then
		echo "Found: "$thispackage
	else
		myerror=1;
		missing=$missing"\n=============\n"$thispackage;
	fi
done

if [ $myerror -eq 1 ]; then
	echo "\n==============\nError: "$myerror" : Missing : "$missing"\n=============\n\nPlease install these packages from Self Service or reimage the computer again.";
	exit 1;
else
	echo "All packages installed successfully!"
	exit 0;
fi
