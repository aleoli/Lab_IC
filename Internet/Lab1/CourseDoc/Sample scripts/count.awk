(($38==1) && /facebook.com/) {
    tot++
    if($42 == 1) tot_http++
    if($42 == 8192) tot_https++
    if($42 != 1 && $42 != 8192) {
       type[$42]++
       print $16, $7, $21
       }
    }
END {
    print "http: ", tot_http, "https: ", tot_https
    print "http: ", tot_http/tot*100, "%  https: ", tot_https/tot*100, "%"
    
    for (t in type) {
       print t, type[t]
       }
    }