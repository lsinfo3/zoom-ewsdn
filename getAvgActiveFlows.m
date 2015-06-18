function res = getAvgActiveFlows(tcpData, udpData)

src = [tcpData{1}; tcpData{3}; udpData{1}; udpData{3}];
srcPort = [tcpData{2}; tcpData{4}; udpData{2}; udpData{4}];
dst = [tcpData{3}; tcpData{1}; udpData{3}; udpData{1}];
dstPort = [tcpData{4}; tcpData{2}; udpData{4}; udpData{2}];
startTime = [tcpData{11}; tcpData{11}; udpData{11}; udpData{11}];
endTime = [tcpData{11}+tcpData{12}; tcpData{11}+tcpData{12}; udpData{11}+udpData{12}; udpData{11}+udpData{12}];
bps = [tcpData{13}; tcpData{14}; udpData{13}; udpData{14}];

[endTime, indy] = sort(endTime);

src = src(indy);
srcPort = srcPort(indy);
dst = dst(indy);
dstPort = dstPort(indy);
startTime = startTime(indy);
bps = bps(indy);
sum = 0;
max=int64(endTime(end));
for i=1:max
    temp = findFlowsAtTime(tcpData,udpData,i);
    sum = sum + length(temp.src);
end

res = sum/max;