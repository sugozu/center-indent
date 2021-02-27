wtsp=' \t'
for file in "$@"; do
	lnc=`cat ${file} | wc -l`
	printf "${lnc} "
	declare -i maxlen=(`awk '{gsub(/^['"${wtsp}"']+/,"");gsub(/['"${wtsp}"']+$/,"")}; {print}' ${file} | wc -L`+1)/2
	newfile=`dirname ${file}`'/improved_'`basename ${file}`
	rm ${newfile} 2> /dev/null
	for (( ln=1; ln<=lnc+1; ln++)); do
	printf "${ln} "
		declare -i len=${maxlen}-`awk 'NR=='"${ln}"'{gsub(/^['"${wtsp}"']+/,"");gsub(/['"${wtsp}"']+$/,""); print int((length+1)/2)}' ${file}`
		str=`printf '%*s' ${len}`
		awk 'NR=='"${ln}"'{gsub(/^['"${wtsp}"']+/,"");gsub(/['"${wtsp}"']+$/,""); gsub(/^/,"'"${str}"'");gsub(/$/,"'"${str}"'"); print >> "'"${newfile}"'"}' ${file}
done; done
