# simple script that extracts useful information from a wireshark exported txt file
# WARNING : THIS HAS NOT BEEN TESTED

# extract the time information
# I need to squeeze multiple spaces, then cut on space and get the time column
# I use grep to avoid the first line.
# from the grep man page:
# -v Invert the sense of matching, to select non-matching lines.
# i.e., do NOT print lines that match ...

cat client.data.txt | grep -v Source | tr -s ' ' | cut -d' ' -f 3 > client.time.txt

# extract the seqno
cat client.data.txt | grep -v Source | cut -d'=' -f 2 | cut -d' ' -f 1 > client.seqno.txt
# extract the ackno
cat client.data.txt | grep -v Source | cut -d'=' -f 3 | cut -d' ' -f 1 > client.ackno.txt
# extract the rwin
cat client.data.txt | grep -v Source | cut -d'=' -f XXXX | cut -d' ' -f 1 > client.rwin.txt

# paste all columns together
paste client.time.txt client.seqno.txt client.ackno.txt client.rwin.txt > client.dat

#plot it using gnuplot
gnuplot plot.gnu

