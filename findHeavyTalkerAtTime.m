function result = findHeavyTalkerAtTime(tcpData, udpData, time)

src = [tcpData{1}; tcpData{3}; udpData{1}; udpData{3}];
startTime = [tcpData{11}; tcpData{11}; udpData{11}; udpData{11}];
endTime = [tcpData{11}+tcpData{12}; tcpData{11}+tcpData{12}; udpData{11}+udpData{12}; udpData{11}+udpData{12}];
bps = [tcpData{13}; tcpData{14}; udpData{13}; udpData{14}];

indyStart = find(startTime<=time);
indyEnd = find(endTime>time);
indy = intersect(indyStart, indyEnd);

bps = bps(indy);
src = src(indy);

[uniqueSrc,~,indy] = unique(src);
sumBps = accumarray(indy, bps);

% sumBps = [];
% for i=1:length(uniqueSrc)
%     indy=find(ismember(src,uniqueSrc(i)));
%     sumBps = [sumBps; sum(bps(indy))];
% end

[sumBps, indy] = sort(sumBps);
uniqueSrc = uniqueSrc(indy);

result.src = uniqueSrc;
result.bps = sumBps;

end