#! /bin/bash

file=$1
sub=$(assetfinder $file | tee sublist.txt)
echo -e "!!!SUB_DOMAIN!!! \n${sub}"
echo "------------------------"
alive=$(cat sublist.txt | httprobe | tee alive.txt)
echo -e "!!!LIVE_DOMAIN!!!! \n${alive}"
echo "---------------------------------"
rm sublist.txt
mv alive.txt tmp_subs.txt

while read url ; do
	echo ${url#*//} >> urls.txt
done < tmp_subs.txt
sort -u urls.txt > sorted_subs.txt
count=$(cat sorted_subs.txt | wc -l)
rm urls.txt
rm tmp_subs.txt

echo "Script Execution Completed"
echo "Total ${count} subdomain found"
