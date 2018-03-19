# Simple gnuplot file
# lines starting with # are ignored...

# set the label on the x and y axis
set xlabel "time [s]"
set ylabel "bytes"

# plot the data from the "data.txt" file
# using values appearing on the X column as x values
# and values appearing on the Y as column y values
# X and Y have to be choosen properly...

plot "data.txt" using X:Y title "title" with linespoint

# if you want to plot several datasets/lines, simply separate them using a ',' (comma)

#plot "data.txt" using X:Y title "first line" with linespoint, "data2.txt" using X2:Y2 title "second line" with linespoint



# save the same on plot a png file to be imported later on

set term png
set output "plot.png"

replot
