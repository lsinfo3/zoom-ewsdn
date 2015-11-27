function result = getResultFlowStats(input, resStruct)

    timeVec = [];
    maxVec = [];
    minVec = [];
    avgVec = [];
    
    fileStruct = [];
    for i=1:length(input)      
        currentDir = strcat(input{i},'/', resStruct.algorithm, '/', num2str(resStruct.nflows), '/', num2str(resStruct.ntop), '/', num2str(resStruct.time), '/');    
        files = dir(currentDir);
        files = files(~[files.isdir]);
        files = sort_nat({files.name});
        for j=1:length(files)
            tmpStruct(j).file = files{j};
            tmpStruct(j).dir = currentDir;
            tmpStruct(j).input = i;
        end
        fileStruct = [fileStruct, tmpStruct];
    end
    
    for i=1:length(fileStruct)
        file = fileStruct(i).file;
        currentDir = fileStruct(i).dir;
        inputMatch = fileStruct(i).input;
        fid = fopen(strcat(currentDir, file));
        tmp = strsplit(file, '_');
        time = ((inputMatch-1)*3600) + str2double(tmp(2));
        if (strcmp(resStruct.algorithm,'ZoomBase'))
            resultFile = textscan(fid,'%s%s%s%s%d','CommentStyle','#','delimiter',';');
            fclose(fid);
            B.src = resultFile{1};
            B.dst = resultFile{3};
            B.bps = resultFile{5};
        end
        if (strcmp(resStruct.algorithm,'ZoomTT'))
            resultFile = textscan(fid,'%s%s%d','CommentStyle','#','delimiter',';');
            fclose(fid);
            B.src = resultFile{1};
            B.bps = resultFile{3};
        end
        timeVec = [timeVec time];
        minVec = [minVec min(B.bps)];
        maxVec = [maxVec max(B.bps)];
        avgVec = [avgVec mean(B.bps)];
        
        result.time = timeVec;
        result.minFlows = minVec;
        result.maxFlows = maxVec;
        result.avgFlows = avgVec;
end