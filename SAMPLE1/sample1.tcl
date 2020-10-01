#CREATE SIMULATOR OBJECT
set ns [new Simulator]

#OPEN TRACE FILES
set f [open out.tr w]
$ns trace-all $f

#OPEN NAM FILES
set nf [open out.nam w]
$ns namtrace-all $nf

#DEFINE FINISH PROCEDURE
proc finish {} {
	global ns f 
	$ns flush-trace
	close $f
	exit 0	
}

#CREATING A NODE
set S1 [$ns node]
set D1 [$ns node]

#LABELLING THE NODE
$S1 label "STEFAN"
$D1 label "DAMON"

#COLOURING THE NODE
$S1 color red
$D1 color red

#CREATING DUPLEX LINK
$ns duplex-link $S1 $D1 1Mb 10ms DropTail

#FINISHING THE PROGRAM
$ns at 10.0 "finish"

#RUN THE PROGRAM
$ns run
