function result = getFlowStats(tcpData, udpData, cropping)

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
totalSum = 0;
endTime=int64(endTime(end));
maxFlows = 0;
minFlows = inf;
maxFlowOverTime = zeros(1,endTime);
scndMaxFlowOverTime = zeros(1,endTime);
minFlowOverTime = zeros(1,endTime);
avgFlowOverTime = zeros(1,endTime);
top16 = zeros(1,endTime);
top4 = zeros(1,endTime);
top2 = zeros(1,endTime);
flowsFor25 = zeros(1, endTime);
flowsFor50 = zeros(1, endTime);
flowsFor75 = zeros(1, endTime);
throughputSum = zeros(1,endTime);
activeFlows = zeros(1,endTime);
loopStart = 1;
loopEnd = endTime;
if (cropping > 0)
    loopEnd = endTime - cropping;
    loopStart = cropping;
end

for i=loopStart:loopEnd
    i
    temp = findFlowsAtTimeFast(tcpData,udpData,i);
    activeFlows(i) = length(temp.bps);
    bps = temp.bps;
    
    % Sum up number of active Flows for average calculation
    totalSum = totalSum + activeFlows(i);
    
    % Get min and max number of active Flows
    if (activeFlows(i) > maxFlows)
        maxFlows = activeFlows(i);
    end
    if (activeFlows(i) < minFlows)
        minFlows = activeFlows(i);
    end
    % Get min max and average flow size at time i
    if (~isempty(temp.bps))
        maxFlowOverTime(i) = temp.bps(end);
        scndMaxFlowOverTime(i) = temp.bps(end-1);
        minFlowOverTime(i) = temp.bps(1);
        avgFlowOverTime(i) = mean(temp.bps);
    end
    
    % Get bps sum of top 16/4/2 flows at time i
    if (activeFlows(i) >= 16)
        top16(i) = sum(bps(end-15:end));
    end
    if (activeFlows(i) >= 4)
        top4(i) = sum(bps(end-3:end));
    end
    if (activeFlows(i) >= 2)
        top2(i) = sum(bps(end-1:end));
    end
    
    % Get total bps at time i
    throughputSum(i) = sum(bps);
    
    cSum = 0;
    m25 = 0;
    m50 = 0;
    m75 = 0;
    for j = 1:activeFlows(i)
        cSum = cSum + bps(end-(j-1));
        cFraction = cSum / throughputSum(i);
        if (~m25 && cFraction >= 0.25)
            flowsFor25(i) = j;
            m25 = 1;
        end
        if (~m50 && cFraction >= 0.50)
            flowsFor50(i) = j;
            m50 = 1;
        end
        if (~m75 && cFraction >= 0.75)
            flowsFor75(i) = j;
            m75 = 1;
            break;
        end
    end
end

% Assign result struct
result.avgActiveFlows = totalSum/endTime;
result.minActiveFlows = minFlows;
result.maxActiveFlows = maxFlows;
result.maxFlowOverTime = maxFlowOverTime;
result.scndMaxFlowOverTime = scndMaxFlowOverTime;
result.minFlowOverTime = minFlowOverTime;
result.avgFlowOverTime = avgFlowOverTime;
result.totalFlowCount = length(src);
result.top16overTime = top16;
result.top4overTime = top4;
result.top2overTime = top2;
result.traceDuration = endTime;
result.throughput.total = throughputSum;
result.throughput.min = min(throughputSum);
result.throughput.avg = mean(throughputSum);
result.throughput.max = max(throughputSum);
top16 = top16 ./ throughputSum;
top16(isnan(top16)) = [];
result.percentage.top16.min = min(top16);
result.percentage.top16.avg = mean(top16);
result.percentage.top16.max = max(top16);
top4 = top4 ./ throughputSum;
top4(isnan(top4)) = [];
result.percentage.top4.min = min(top4);
result.percentage.top4.avg = mean(top4);
result.percentage.top4.max = max(top4);
top2 = top2 ./ throughputSum;
top2(isnan(top2)) = [];
result.percentage.top2.min = min(top2);
result.percentage.top2.avg = mean(top2);
result.percentage.top2.max = max(top2);
result.percentageOverTime.top2 = top2;
result.percentageOverTime.top4 = top4;
result.percentageOverTime.top16 = top16;
result.neededFlows.for25 = flowsFor25;
result.neededFlows.for50 = flowsFor50;
result.neededFlows.for75 = flowsFor75;
result.activeFlows = activeFlows;