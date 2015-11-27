function result = findFlowsAtTimeFast(tcpData, udpData, time)

startTime = [tcpData{11}; tcpData{11}; udpData{11}; udpData{11}];
endTime = [tcpData{11}+tcpData{12}; tcpData{11}+tcpData{12}; udpData{11}+udpData{12}; udpData{11}+udpData{12}];
bps = [tcpData{13}; tcpData{14}; udpData{13}; udpData{14}];

[bps, indy] = sort(bps);
startTime = startTime(indy);
endTime = endTime(indy);

indyStart = find(startTime<=time);
indyEnd = find(endTime>time);
indy = intersect(indyStart, indyEnd);

result.start = startTime(indy);
result.end = endTime(indy);
result.bps = bps(indy);

end