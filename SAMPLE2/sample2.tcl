# CREATE A SIMULATOR OBJECT
 set ns [new Simulator]

# OPEN TRACE FILES
 set f [open out.tr w]
 $ns trace-all $f

# OPEN NAM FILES
 set nf [open out.nam w]
 $ns namtrace-all $nf

# DEFINE FINISH PROCEDURE
 proc finish {} {
	global ns f
	$ns flush-trace 
	close $f
	exit 0
 }

# CREATE NODE OBJECTS
 set S1 [$ns node]
 set D1 [$ns node]

# LABELLING NODES
 $S1 label "STEFAN"
 $D1 label "DAMON"

# COLOURING NODES
 $S1 color blue
 $D1 color green

# DATA FLOW 
 $ns color 0 red

# CREATING DUPLEX LINK 
 $ns duplex-link $S1 $D1 1Mb 10ms DropTail

# CREATING UDP AGENT AND ATTACHING IT TO NODE S1
 set udp [new Agent/UDP]
 $ns attach-agent $S1 $udp

# CREATING CBR APPLICATION WITH TRAFFIC AND ATTACHING WITH UDP
 set cbr [new Application/Traffic/CBR]
 $cbr set packetSize_ 500
 $cbr set interval_ 0.05
 $cbr attach-agent $udp

# CREATING A NULL AGENT AND ATTACHING IT TO NODE D2
 set null [new Agent/Null]
 $ns attach-agent $D1 $null

# CONNECTING UDP AGENT WITH NULL AGENT
 $ns connect $udp $null

# EVENT SCHEDULING FOR CBR TRAFFIC
 $ns at 0.5 "$cbr start"
 $ns at 4.5 "$cbr stop"

# EVENT SCHEDULER TO FINISH THE SIMULATION
 $ns at 5.0 "finish"

# RUN SIMULATOR
 $ns run

