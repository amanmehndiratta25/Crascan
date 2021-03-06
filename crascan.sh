#!/bin/bash
# Crascan V 1.1
# Release on 12/09/2018
# © Copyright ~ 4WSec

clear
# color
f=3 b=4s
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done

useragents="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"

# banner
banner(){
printf "${f6}\t _______  ______ _______ ${f7}_______ _______ _______ __   _ \n"
printf "${f6}\t |       |_____/ |_____| ${f7}|______ |       |_____| | \  | \n"
printf "${f6}\t |_____  |    \_ |     | ${f7}______| |_____  |     | |  \_|   ${f3}V 1.1\n"
echo ""
echo "${f3}Author      : ${f7}Arya Narotama (4WSec)"
echo "${f3}Team        : ${f7}Anon Cyber Team"
echo "${f3}Disclaimer  : ${f7}I am not responsible for damage caused by Crascan. Attacking targets without mutual consent is illegal!"
}

# menu
banner
echo ""
echo "${f2}[ ${f1}Crascan Menu ${f2}]"
echo ""
echo "   ${f2}[${f1}1${f2}] ${f6}LFI ${f5}Scanner"
echo "   ${f2}[${f1}2${f2}] ${f6}RFI ${f5}Scanner"
echo "   ${f2}[${f1}3${f2}] ${f6}RCE ${f5}Scanner"
echo "   ${f2}[${f1}4${f2}] ${f6}Directory ${f5}Scanner"
echo "   ${f2}[${f1}5${f2}] ${f6}Files ${f5}Scanner"
echo ""
echo -e ${f6}"┌─[${f1}Crascan${f6}]──[${f1}Skid${f6}]"
read -p "└─────► " cras;
echo "${f1}Ex: ${f7}http://0x666.com"
read -p "${f2}[${f1}*${f2}]${f1} Input URL${f2}> "  urlz;

######### Save Result ###########
save1="result/result-lfi.txt"
save2="result/result-rfi.txt"
save3="result/result-rce.txt"
save4="result/result-dir.txt"
save5="result/result-files.txt"
#################################

##########
miring=/
##########


######################### Func Curl ############################################
# func lfi
lfi(){
	scan=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zlfi})
	if [[ $scan == 200 ]] || [[ $scan == 301 ]] || [[ $scan =~ "/etc/passwd" ]]; then
		echo "${f2}[${f1}+${f2}] $urlz$miring$zlfi ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zlfi" >> $save1
	elif [[ $scan =~ "/bin/bash" ]]; then
			echo "${f2}[${f1}+${f2}] $urlz$miring$zlfi ~> ${f6}[${f3}OK${f6}]${f2}"
		else
			echo "${f2}[${f1}+${f2}] $urlz$miring$zlfi ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
}

# func rfi
rfi(){
	scan2=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zrfi})
	if [[ $scan2 == 200 ]] || [[ $scan2 == 301 ]] || [[ $scan2 =~ "/etc/passwd" ]]; then
		echo "${f2}[${f1}+${f2}] $urlz$miring$zrfi ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zrfi" >> $save2
	else
		echo "${f2}[${f1}+${f2}] $urlz$miring$zrfi ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}

# func rce
rce(){
	scan3=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zrce})
	if [[ $scan3 == 200 ]] || [[ $scan3 == 301 ]] || [[ $scan3 =~ "/etc/passwd" ]]; then
		echo "$urlz$miring$zrce ~> ${f6}[${f7}OK${f6}]${f2}"
	elif [[ $scan3 =~ "/etc/passwd" ]]; then
			echo "${f2}[${f1}+${f2}] $urlz$miring$zrce ~> ${f6}[${f7}OK${f6}]${f2}"
			echo "$urlz$miring$zrce" >> $save3
		else
			echo "${f2}[${f1}+${f2}] $urlz$miring$zrce ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}

# func dir
dir(){
	scan4=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zdir})
	if [[ $scan4 == 200 ]] || [[ $scan4 == 301 ]]; then
		echo "${f2}[${f1}+${f2}] $urlz$miring$zdir ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zdir" >> $save4
	else
		echo "${f2}[${f1}+${f2}] $urlz$miring$zdir ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}

# func files
files(){
	scan5=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zfiles})
	if [[ $scan5 == 200 ]] || [[ $scan5 == 301 ]]; then
		echo "${f2}[${f1}+${f2}] $urlz$miring$zfiles ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zfiles" >> $save5
	else
		echo "${f2}[${f1}+${f2}] $urlz$miring$zfiles ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}
############################################################################




###################### LIST ######################
ceklistlfi(){
listlfi=$(wc -l lib/LFI | cut -f1 -d '')
echo "Total LFI List ~> $listlfi"
}

ceklistrfi(){
listrfi=$(wc -l lib/RFI | cut -f1 -d '')
echo "Total RFI List ~> $listrce"
}

ceklistrce(){
listrce=$(wc -l lib/RCE | cut -f1 -d '')
echo "Total RCE List ~> $listrce"
}

ceklistdir(){
listdir=$(wc -l lib/Dir | cut -f1 -d '')
echo "Total Directory List ~> $listdir"
}

ceklistfiles(){
listfiles=$(wc -l lib/Files | cut -f1 -d '')
echo "Total Files List ~> $listfiles"
}
#################################################


############ Ekse (LFI) ####################
luplfi(){
for zlfi in $(cat lib/LFI)
do
	lfi
done
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-lfi.txt ${f6}]"
cat $save1
}
############################################


############ Ekse (RFI) ####################
luprfi(){
for zrfi in $(cat lib/RFI)
do
	rfi
done
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-rfi.txt ${f6}]"
cat $save2
}
############################################



############ Ekse (RCE) ####################
luprce(){
for zrce in $(cat lib/RCE)
do
	rce
done
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-rce.txt ${f6}]"
cat $save3
}
############################################


############ Ekse (DIR) ####################
lupdir(){
for zdir in $(cat lib/Dir)
do
	dir
done
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-dir.txt ${f6}]"
cat $save4
}
############################################


############ Ekse (FILES) ####################
lupfiles(){
for zfiles in $(cat lib/Files)
do
	files 
done
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-files.txt ${f6}]"
cat $save5
}
############################################



############## Condition #################
if [[ $cras == 1 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}LFI ${f2}..."
	sleep 2
	ceklistlfi
	sleep 1
	luplfi
elif [[ $cras == 2 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}RFI ${f2}..."
	sleep 2
	ceklistrfi
	sleep 1
	luprfi
elif [[ $cras == 3 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}RCE ${f2}..."
	sleep 2
	ceklistrce
	sleep 1
	luprce
elif [[ $cras == 4 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}Directory ${f2}..."
	sleep 2
	ceklistdir
	sleep 1
	lupdir
elif [[ $cras == 5 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}Files ${f2}..."
	sleep 2
	ceklistfiles
	sleep 1
	lupfiles
else
	echo "${f2}[${f1}X${f2}]${f1} Wrong Command!"
fi
##########################################
