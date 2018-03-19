{
   if ($38==1 && $127 ~ /googlevideo/) {
     tot_int[$15]++;
     alreadyIn = match (name[$15],$127);
     if(alreadyIn==0)
       name[$15]=name[$15] "," $127
    }
}
END {
  print "number\tIP address\tnames";
  for (addr in tot_int) {
     print tot_int[addr] "\t" addr "\t" name[addr]
  }
}


