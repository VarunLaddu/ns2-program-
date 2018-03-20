set ns [new Simulator]

set nf [open out.nam w]

$ns namtrace-all $nf

set nr [open out.tr w]
$ns trace-all $nr






set f0 [open x1.tr w]
set f1 [open x2.tr w]
set f2 [open x3.tr w]
set f3 [open x4.tr w]
set f4 [open x5.tr w]
set f5 [open x6.tr w]
set f6 [open x7.tr w]
set f7 [open x8.tr w]


proc finish {} {

global ns nr nf

global f0 f1 f2 f3 f4 f5 f6 f7 f8

$ns flush-trace

close $nf

close $nr

close $f0
close $f1
close $f2
close $f3
close $f4
close $f5
close $f6
close $f7




exec nam out.nam &
for {set i 0} {$i<13} {incr i} {
        for {set j 0} {$j<13} {incr j} {
        exec  awk -v a=$i -v b=$j -f end2.awk out.tr >> avgndelay.tr &
        exec  awk -v a=$i -v b=$j -f end.awk out.tr >> graph$i$j.xg &
	exec awk -v a=$i -v b=$j -f end3.awk out.tr >> testit2.tr &
#exec xgraph -geometry 500X500 -p -bg white -t delay -x times -y endtoend graph$i$j.xg &


  } }
  #exec awk -f latency.awk testit2.tr &

#exec xgraph x1.tr -geometry 800*400 -x time -y bandiwidth &
#exec xgraph x2.tr -geometry 800*400 -x time -y time &
#exec xgraph x3.tr -geometry 800*400 -x time -y time &
#exec xgraph x4.tr -geometry 800*400 -x time -y time &
#exec xgraph x5.tr -geometry 800*400 -x time -y time &
#exec xgraph x6.tr -geometry 800*400 -x time -y time &
#exec xgraph x7.tr -geometry 800*400 -x time -y time &
#exec xgraph x8.tr -geometry 800*400 -x time -y time &
#exec xgraph graph02.xg
#exec xgraph graph411.xg
#exec xgraph graph710.xg
#exec xgraph graph36.xg

}


proc record {} {
global f1 sink1 f2 f3 f4 f5 f6 sink2 sink3 sink4 sink5 sink6  sink7 f7  f0 sink0 var

set ns [Simulator instance]

set time 0.01
set bw0 [$sink0 set bytes_]

set bw1 [$sink1 set bytes_]
set bw2 [$sink2 set bytes_]
set bw3 [$sink3 set bytes_]
set bw4 [$sink4 set bytes_]
set bw5 [$sink5 set bytes_]
set bw6 [$sink6 set bytes_]
set bw7 [$sink7 set bytes_]



set now [$ns now]


puts $f0 "$now [expr $bw0/$time*8/1000000]"
puts $f1 "$now [expr $bw1/$time*8/1000000]"
puts $f2 "$now [expr $bw2/$time*8/1000000]"
puts $f3 "$now [expr $bw3/$time*8/1000000]"
puts $f4 "$now [expr $bw4/$time*8/1000000]"
puts $f5 "$now [expr $bw5/$time*8/1000000]"
puts $f6 "$now [expr $bw6/$time*8/1000000]"
puts $f7 "$now [expr $bw7/$time*8/1000000]"

set b0 [expr $bw0/$time*8/1000000]
set b1 [expr $bw1/$time*8/1000000]
set b2 [expr $bw2/$time*8/1000000]
set b3 [expr $bw3/$time*8/1000000]
set b4 [expr $bw4/$time*8/1000000]
set b5 [expr $bw5/$time*8/1000000]
set b6 [expr $bw6/$time*8/1000000]
set b7 [expr $bw7/$time*8/1000000]

set var [expr {$b0+$b1+$b2+$b3+$b4+$b5+$b6+$b7}]


#set var [expr {$bw0+$bw1+$bw2+$bw3+$bw4+$bw5+$bw6+$bw7}]

$sink0 set bytes_ 0
$sink1 set bytes_ 0
$sink2 set bytes_ 0
$sink3 set bytes_ 0
$sink4 set bytes_ 0
$sink5 set bytes_ 0
$sink6 set bytes_ 0
$sink7 set bytes_ 0


$ns at [expr $now+$time] "record"

}
proc record2 {} {

global bw8 var

set bw8 [expr {$var/8}]
puts "Average bandwidth: $bw8 MBits per second"

}



set n0 [$ns node]

set n1 [$ns node]

set n2 [$ns node]

set n3 [$ns node]

set n4 [$ns node]

set n5 [$ns node]

set n6 [$ns node]

set n7 [$ns node]

set n8 [$ns node]

set n9 [$ns node]

set n10 [$ns node]

set n11 [$ns node]

set n12 [$ns node]

set n13 [$ns node]



$ns duplex-link $n0 $n2 1Mb 10ms RED
$ns duplex-link $n1 $n2 3Mb 10ms FQ

$ns duplex-link $n2 $n3 5Mb 10ms RED

$ns duplex-link $n2 $n4 7Mb 10ms FQ

$ns duplex-link $n3 $n4 9Mb 10ms FQ

$ns duplex-link $n3 $n5 11Mb 10ms RED

$ns duplex-link $n3 $n6 13Mb 10ms RED

$ns duplex-link $n4 $n11 15Mb 10ms FQ

$ns duplex-link $n4 $n5 13Mb 10ms RED

$ns duplex-link $n6 $n5 11Mb 10ms RED

$ns duplex-link $n6 $n7 9Mb 10ms RED

$ns duplex-link $n7 $n8 7Mb 10ms RED

$ns duplex-link $n7 $n9 5Mb 10ms RED

$ns duplex-link $n7 $n10 3Mb 10ms RED

$ns duplex-link $n11 $n12 1Mb 10ms RED

$ns duplex-link $n11 $n13 3Mb 10ms RED



$ns duplex-link-op $n0 $n2 orient right-down

$ns duplex-link-op $n1 $n2 orient down

$ns duplex-link-op $n2 $n3 orient down

$ns duplex-link-op $n2 $n4 orient right-down

$ns duplex-link-op $n3 $n4 orient right-up

$ns duplex-link-op $n3 $n5 orient right-down

$ns duplex-link-op $n3 $n6 orient down

$ns duplex-link-op $n4 $n11 orient right-up

$ns duplex-link-op $n4 $n5 orient down

$ns duplex-link-op $n6 $n5 orient right-up

$ns duplex-link-op $n6 $n7 orient down

$ns duplex-link-op $n7 $n8 orient left-down

$ns duplex-link-op $n7 $n9 orient right-down

$ns duplex-link-op $n7 $n10 orient down

$ns duplex-link-op $n11 $n12 orient right-up

$ns duplex-link-op $n11 $n13 orient right-down



set tcp0 [new Agent/TCP]

$ns attach-agent $n0 $tcp0
$tcp0 set packetSize_ 512

set ftp0 [new Application/FTP]

$ftp0 attach-agent $tcp0

set sink0 [new Agent/TCPSink]

$ns attach-agent $n8 $sink0

$ns connect $tcp0 $sink0



set tcp1 [new Agent/TCP]
$tcp1 set packetSize_ 512

$ns attach-agent $n0 $tcp1


set ftp1 [new Application/FTP]

$ftp1 attach-agent $tcp1

set sink1 [new Agent/TCPSink]

$ns attach-agent $n9 $sink1

$ns connect $tcp1 $sink1



set tcp2 [new Agent/TCP]
$tcp2 set packetSize_ 512
$ns attach-agent $n0 $tcp2

set ftp2 [new Application/FTP]

$ftp2 attach-agent $tcp2

set sink2 [new Agent/TCPSink]

$ns attach-agent $n10 $sink2

$ns connect $tcp2 $sink2





set tcp3 [new Agent/TCP]
$tcp3 set packetSize_ 512

$ns attach-agent $n0 $tcp3

set ftp3 [new Application/FTP]

$ftp3 attach-agent $tcp0

set sink3 [new Agent/TCPSink]

$ns attach-agent $n13 $sink3

$ns connect $tcp3 $sink3



set tcp4 [new Agent/TCP]
$tcp4 set packetSize_ 512

$ns attach-agent $n1 $tcp4

set ftp4 [new Application/FTP]

$ftp4 attach-agent $tcp4

set sink4 [new Agent/TCPSink]

$ns attach-agent $n8 $sink4

$ns connect $tcp4 $sink4



set tcp5 [new Agent/TCP]
$tcp5 set packetSize_ 512

$ns attach-agent $n1 $tcp5

set ftp5 [new Application/FTP]

$ftp5 attach-agent $tcp5

set sink5 [new Agent/TCPSink]

$ns attach-agent $n9 $sink5

$ns connect $tcp5 $sink5



set tcp6 [new Agent/TCP]
$tcp6 set packetSize_ 512

$ns attach-agent $n1 $tcp6

set ftp6 [new Application/FTP]

$ftp6 attach-agent $tcp6

set sink6 [new Agent/TCPSink]

$ns attach-agent $n10 $sink6

$ns connect $tcp6 $sink6



set tcp7 [new Agent/TCP]
$tcp7 set packetSize_ 512

$ns attach-agent $n1 $tcp7

set ftp7 [new Application/FTP]

$ftp5 attach-agent $tcp7

set sink7 [new Agent/TCPSink]

$ns attach-agent $n13 $sink7

$ns connect $tcp7 $sink7



$ns at 0.1 "$ftp0 start"
$ns at 3.0 "$ftp0 stop"

$ns at 0.3 "$ftp1 start"

$ns at 3.0 "$ftp1 stop"

$ns at 0.5 "$ftp2 start"

$ns at 3.0 "$ftp2 stop"

$ns at 0.8 "$ftp3 start"

$ns at 3.0 "$ftp3 stop"



$ns rtproto DV

$ns rtmodel-at 0.1 down $n2 $n3

$ns rtmodel-at 0.15 down $n6 $n7

$ns rtmodel-at 0.20 up $n2 $n3

$ns rtmodel-at 0.30 up $n6 $n7



$ns at 0.01 "record"

$ns at 1.2 "$ftp4 start"

$ns at 4.0 "$ftp4 stop"

$ns at 1.5 "$ftp5 start"

$ns at 4.0 "$ftp5 stop"

$ns at 1.7 "$ftp6 start"

$ns at 4.0 "$ftp6 stop"

$ns at 1 "record2"

$ns at 5.0 "finish"

$ns run
