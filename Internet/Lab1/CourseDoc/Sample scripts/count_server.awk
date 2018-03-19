($1 ~ "130.192." || $15 ~ "130.192"){
		print $1,$15, $116
       client[$128]++
}
END {
for (key in client) 
   print key, client[key]
}