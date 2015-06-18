function result = findFlowsAtTime(tcpData, udpData, time)

src = [tcpData{1}; tcpData{3}; udpData{1}; udpData{3}];
srcPort = [tcpData{2}; tcpData{4}; udpData{2}; udpData{4}];
dst = [tcpData{3}; tcpData{1}; udpData{3}; udpData{1}];
dstPort = [tcpData{4}; tcpData{2}; udpData{4}; udpData{2}];
startTime = [tcpData{11}; tcpData{11}; udpData{11}; udpData{11}];
endTime = [tcpData{11}+tcpData{12}; tcpData{11}+tcpData{12}; udpData{11}+udpData{12}; udpData{11}+udpData{12}];
bps = [tcpData{13}; tcpData{14}; udpData{13}; udpData{14}];

[bps, indy] = sort(bps);

src = src(indy);
srcPort = srcPort(indy);
dst = dst(indy);
dstPort = dstPort(indy);
startTime = startTime(indy);
endTime = endTime(indy);

indyStart = find(startTime<=time);
indyEnd = find(endTime>time);
indy = intersect(indyStart, indyEnd);

result.src = src(indy);
result.srcPort = srcPort(indy);
result.dst = dst(indy);
result.dstPort = dstPort(indy);
result.start = startTime(indy);
result.end = endTime(indy);
result.bps = bps(indy);

end