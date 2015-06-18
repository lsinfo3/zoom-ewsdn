% Copyright (c) 2015 Stefan Geißler, Steffen Gebert
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

paperUnits = 'centimeters';
printTitle = 0;
dpi = 600;
fontsize = 11;
linewidth = 2;
sizex = 10;
sizey = 5;
legendpos = 'NorthWest';
%
fid = fopen('tcp');
tcpData = textscan(fid, '%s%d%s%d%d%d%d%d%d%d%f%f%f%f');
fclose(fid);
fid = fopen('udp');
udpData = textscan(fid, '%s%d%s%d%d%d%d%d%d%d%f%f%f%f');
fclose(fid);


% Uncommented since this takes quite long.
%avgActiveFlows = getAvgActiveFlows(tcpData, udpData);


algorithm='ZoomTT';
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 5, 'time', 1); resStruct = temp;
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 5, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 5, 'time', 5); resStruct = [resStruct; temp];

temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 10, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 10, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 10, 'time', 5); resStruct = [resStruct; temp];

temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 20, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 20, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 20, 'time', 5); resStruct = [resStruct; temp];

temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 30, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 30, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 30, 'time', 5); resStruct = [resStruct; temp];

temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 50, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 50, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 256, 'ntop', 50, 'time', 5); resStruct = [resStruct; temp];

algorithm='ZoomBase';
temp = struct('algorithm', algorithm, 'nflows', 16, 'ntop', 8, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 16, 'ntop', 8, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 16, 'ntop', 8, 'time', 5); resStruct = [resStruct; temp];

temp = struct('algorithm', algorithm, 'nflows', 16, 'ntop', 4, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 16, 'ntop', 4, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 16, 'ntop', 4, 'time', 5); resStruct = [resStruct; temp];

temp = struct('algorithm', algorithm, 'nflows', 16, 'ntop', 1, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 16, 'ntop', 1, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 16, 'ntop', 1, 'time', 5); resStruct = [resStruct; temp];

temp = struct('algorithm', algorithm, 'nflows', 4, 'ntop', 2, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 4, 'ntop', 2, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 4, 'ntop', 2, 'time', 5); resStruct = [resStruct; temp];

temp = struct('algorithm', algorithm, 'nflows', 4, 'ntop', 1, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 4, 'ntop', 1, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 4, 'ntop', 1, 'time', 5); resStruct = [resStruct; temp];

temp = struct('algorithm', algorithm, 'nflows', 2, 'ntop', 1, 'time', 1); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 2, 'ntop', 1, 'time', 2); resStruct = [resStruct; temp];
temp = struct('algorithm', algorithm, 'nflows', 2, 'ntop', 1, 'time', 5); resStruct = [resStruct; temp];

deviation=[1 2 4 8];
deviationColor = copper(4);

deviationStyle = ['-', '-', '-', '-'];

for v=1:length(resStruct)
    resStruct(v)
    mkdir(strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/'));
    currentDir = strcat('results/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/');
    files = dir(currentDir);
    files = files(~[files.isdir]);
    files = sort_nat({files.name});
    accuracy = [];
    ci = [];
    tolerance = [];
    for t=1:length(deviation)
        data = struct('fP',[],'fN',[],'mse',[], 'fPnoDev', []);
        for k=1:length(files)
            fid = fopen(strcat(currentDir, files{k}));
            tmp = strsplit(files{k}, '_');
            time = str2double(tmp(2));     
            if (strcmp(resStruct(v).algorithm,'ZoomBase'))
                A = findFlowsAtTime(tcpData, udpData, time);
                resultFile = textscan(fid,'%s%s%s%s%d','CommentStyle','#','delimiter',';');
                fclose(fid);
                B.src = resultFile{1};
                B.dst = resultFile{3};
                B.bps = resultFile{5};
                indySrc = [];
                indyDst = [];
                for i=1:size(B.src,1)
                    indySrc = [indySrc; find(strcmp(A.src, B.src(i)))];
                    indyDst = [indyDst; find(strcmp(A.dst, B.dst(i)))];
                end
                indy = intersect(indySrc, indyDst);
                if (length(indy) > length(B.src))
                   indy = indy(end-length(B.src)+1:end); 
                end
            end
            if (strcmp(resStruct(v).algorithm,'ZoomTT'))
                A = findHeavyTalkerAtTime(tcpData, udpData, time);
                resultFile = textscan(fid,'%s%s%d','CommentStyle','#','delimiter',';');
                fclose(fid);
                B.src = resultFile{1};
                B.bps = resultFile{3};
                indySrc = [];
                for i=1:size(B.src,1)
                    indySrc = [indySrc; find(strcmp(A.src, B.src(i)))];
                end
                indy = indySrc;
                if (length(indy) > length(B.src))
                   indy = indy(end-length(B.src)+1:end); 
                end
            end

            data.fP = [data.fP falsePositives(indy, A, deviation(t))];
            data.fPnoDev = [data.fPnoDev falsePositives(indy, A, 1)];
            data.fN = [data.fN falseNegatives(indy, A)];
            data.fPPercent = data.fP/resStruct(v).ntop;
            data.fNPercent = data.fN/resStruct(v).ntop;
            data.mse = [data.mse mymse(indy, A)];
            data.mse(isnan(data.mse(:))) = [];
            data.testSize = length(data.fP);
        end
        [h,p,hans,stats] = ttest(data.fPPercent, mean(data.fPPercent));
        tmp = hans(2) - mean(data.fPPercent);
        ci = [ci tmp];
        tmp = 1 - mean(data.fPPercent);
        accuracy = [accuracy tmp];
        tolerance = [tolerance data];
        result.(resStruct(v).algorithm).(['nflows',  num2str(resStruct(v).nflows)]).(['ntop', num2str(resStruct(v).ntop)]).(['time', num2str(resStruct(v).time)]).accuracy = accuracy;
        result.(resStruct(v).algorithm).(['nflows',  num2str(resStruct(v).nflows)]).(['ntop', num2str(resStruct(v).ntop)]).(['time', num2str(resStruct(v).time)]).ci = ci;
        result.(resStruct(v).algorithm).(['nflows',  num2str(resStruct(v).nflows)]).(['ntop', num2str(resStruct(v).ntop)]).(['time', num2str(resStruct(v).time)]).tolerance = tolerance;
        
        figure(1); hold on;
            h = cdfplot(data.fPPercent);
            set(h, 'color', deviationColor(t,:));     
            set(h,'lineWidth', linewidth);
            set(h,'lineStyle', deviationStyle(t));
        figure(2); hold on;
            h = cdfplot(data.fP);
            set(h, 'color', deviationColor(t,:));
            set(h,'lineWidth', linewidth);
            set(h,'lineStyle', deviationStyle(t));
    end
    fig = figure(1);
        set(gca,'FontSize',fontsize);
        set(findall(gcf,'type','text'),'FontSize',fontsize);
        if printTitle == 1
            title('False Positives in Percent for Different Deviations');
        else
            title('');
        end
        legend(num2str(deviation(1)), num2str(deviation(2)), num2str(deviation(3)), num2str(deviation(4)));
        set(fig, 'PaperUnits', paperUnits);
        set(fig, 'PaperPosition', [0 0 sizex sizey]);
        xlabel('False Positive Rate');
        ylabel('CDF');
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falsePosRate'), 'png'); 
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falsePosRate'), 'fig');
        save2pdf(strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falsePosRate'), fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
        close;
    fig = figure(2);
        set(gca,'FontSize',fontsize);
        set(findall(gcf,'type','text'),'FontSize',fontsize);
        if printTitle == 1
            title('False Positives for Different Deviations');
        else
            title('');
        end
        xlabel('Absolute False Positives');
        ylabel('CDF');
        legend(num2str(deviation(1)), num2str(deviation(2)), num2str(deviation(3)), num2str(deviation(4))); 
        set(fig, 'PaperUnits', paperUnits);
        set(fig, 'PaperPosition', [0 0 sizex sizey]);
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falsePosAbs'), 'png'); 
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falsePosAbs'), 'fig');
        save2pdf(strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falsePosAbs'), fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
        close;
    fig = figure(3);
        set(gca,'FontSize',fontsize);
        set(findall(gcf,'type','text'),'FontSize',fontsize);
        h = cdfplot(data.fNPercent);
        set(h, 'color', deviationColor(1,:));
        set(h,'lineWidth', linewidth);
        if printTitle == 1
            title('False Negatives');
        else
            title('');
        end
        xlabel('False Negative Rate');
        ylabel('CDF');
        set(fig, 'PaperUnits', paperUnits);
        set(fig, 'PaperPosition', [0 0 sizex sizey]);
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falseNegRate'), 'png');
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falseNegRate'), 'fig');
        save2pdf(strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falseNegRate'), fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
        close;
    fig = figure(4);
        set(gca,'FontSize',fontsize);
        set(findall(gcf,'type','text'),'FontSize',fontsize);
        h = cdfplot(data.fN);
        set(h, 'color', deviationColor(1,:));
        set(h,'lineWidth', linewidth);
        if printTitle == 1
            title('False Negatives');
        else
            title('');
        end
        xlabel('Absolute False Negatives');
        ylabel('CDF');
        set(fig, 'PaperUnits', paperUnits);
        set(fig, 'PaperPosition', [0 0 sizex sizey]);
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falseNegAbs'), 'png'); 
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falseNegAbs'), 'fig');
        save2pdf(strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falseNegAbs'), fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
        close;
    fig = figure(5); hold on;
        set(gca,'FontSize',fontsize);
        set(findall(gcf,'type','text'),'FontSize',fontsize);
        h = bar(data.fN, 0.8, 'facecolor', deviationColor(1,:));
        bar(data.fPnoDev, 0.4, 'facecolor', deviationColor(2,:));
        legend(strcat('false negatives fN=', num2str(sum(data.fN)/(data.testSize*resStruct(v).ntop))), ...
            strcat('false positives fP=', num2str(sum(data.fPnoDev)/(data.testSize*resStruct(v).ntop))));
        xlabel('Results of One Run');
        if printTitle == 1
            title('False Positives and False Negatives of a Total Run');
        else
            title('');
        end
        set(fig, 'PaperUnits', paperUnits);
        set(fig, 'PaperPosition', [0 0 sizex sizey]);
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falseNegPosSingle'), 'png'); 
        saveas(fig, strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falseNegPosSingle'), 'fig');
        save2pdf(strcat('figures/', resStruct(v).algorithm, '/', num2str(resStruct(v).nflows), '/', num2str(resStruct(v).ntop), '/', num2str(resStruct(v).time), '/falseNegPosSingle'), fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
        close;
end

linewidth = 0.5;
paperUnits = 'centimeters';
printTitle = 0;
dpi = 600;
fontsize = 11;
sizex = 10;
sizey = 5;
legendpos = 'NorthWest';

fig = figure();
vector = [result.ZoomBase.nflows16.ntop1.time1.accuracy; ...
            result.ZoomBase.nflows16.ntop4.time1.accuracy; ...
            result.ZoomBase.nflows16.ntop8.time1.accuracy];
errorvector = [result.ZoomBase.nflows16.ntop1.time1.ci; ...
            result.ZoomBase.nflows16.ntop4.time1.ci; ...
            result.ZoomBase.nflows16.ntop8.time1.ci];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'1', '4', '8'});
legend('1', '2', '4', '8', 'Location', legendpos);
xlabel('n_{top}');
ylabel('Accuracy');
save2pdf('figures/accuracy_161', fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
close(fig);

fig = figure();
vector = [result.ZoomBase.nflows16.ntop1.time2.accuracy; ...
            result.ZoomBase.nflows16.ntop4.time2.accuracy; ...
            result.ZoomBase.nflows16.ntop8.time2.accuracy];
errorvector = [result.ZoomBase.nflows16.ntop1.time2.ci; ...
            result.ZoomBase.nflows16.ntop4.time2.ci; ...
            result.ZoomBase.nflows16.ntop8.time2.ci];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'1', '4', '8'});
legend('1', '2', '4', '8', 'Location', legendpos);
xlabel('n_{top}');
ylabel('Accuracy');
save2pdf('figures/accuracy_162', fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
close(fig);

fig = figure();
vector = [result.ZoomBase.nflows16.ntop1.time5.accuracy; ...
            result.ZoomBase.nflows16.ntop4.time5.accuracy; ...
            result.ZoomBase.nflows16.ntop8.time5.accuracy];
errorvector = [result.ZoomBase.nflows16.ntop1.time5.ci; ...
            result.ZoomBase.nflows16.ntop4.time5.ci; ...
            result.ZoomBase.nflows16.ntop8.time5.ci];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'1', '4', '8'});
legend('1', '2', '4', '8', 'Location', legendpos);
xlabel('n_{top}');
ylabel('Accuracy');
save2pdf('figures/accuracy_165', fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
close(fig);

fig = figure();
vector = [result.ZoomBase.nflows4.ntop1.time1.accuracy; ...
            result.ZoomBase.nflows4.ntop2.time1.accuracy];
errorvector = [result.ZoomBase.nflows4.ntop1.time1.ci; ...
            result.ZoomBase.nflows4.ntop2.time1.ci];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'1', '2'});
legend('1', '2', '4', '8', 'Location', legendpos);
xlabel('n_{top}');
ylabel('Accuracy');
save2pdf('figures/accuracy_41', fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
close(fig);

fig = figure();
vector = [result.ZoomBase.nflows4.ntop1.time2.accuracy; ...
            result.ZoomBase.nflows4.ntop2.time2.accuracy];
errorvector = [result.ZoomBase.nflows4.ntop1.time2.ci; ...
            result.ZoomBase.nflows4.ntop2.time2.ci];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'1', '2'});
legend('1', '2', '4', '8', 'Location', legendpos);
xlabel('n_{top}');
ylabel('Accuracy');
save2pdf('figures/accuracy_42', fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
close(fig);

fig = figure();
vector = [result.ZoomBase.nflows4.ntop1.time5.accuracy; ...
            result.ZoomBase.nflows4.ntop2.time5.accuracy];
errorvector = [result.ZoomBase.nflows4.ntop1.time5.ci; ...
            result.ZoomBase.nflows4.ntop2.time5.ci];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'1', '2'});
legend('1', '2', '4', '8', 'Location', legendpos);
xlabel('n_{top}');
ylabel('Accuracy');
save2pdf('figures/accuracy_45', fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);
close(fig);

fig = figure();
vector = [result.ZoomTT.nflows256.ntop5.time1.accuracy; ...
    result.ZoomTT.nflows256.ntop10.time1.accuracy; ...
    result.ZoomTT.nflows256.ntop20.time1.accuracy; ...
    result.ZoomTT.nflows256.ntop30.time1.accuracy; ...
    result.ZoomTT.nflows256.ntop50.time1.accuracy];
errorvector = [result.ZoomTT.nflows256.ntop5.time1.ci; ...
    result.ZoomTT.nflows256.ntop10.time1.ci; ...
    result.ZoomTT.nflows256.ntop20.time1.ci; ...
    result.ZoomTT.nflows256.ntop30.time1.ci; ...
    result.ZoomTT.nflows256.ntop50.time1.ci];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'5', '10', '20', '30', '50'});
legend('1', '2', '4', '8', 'Location', 'NorthEastOutside');
xlabel('n_{top}');
ylabel('Accuracy');
save2pdf('figures/accuracy_2561', fig, dpi, fontsize, linewidth, [0 0 sizex*2+1 sizey]);
close(fig);

fig = figure();
vector = [result.ZoomTT.nflows256.ntop5.time2.accuracy; ...
    result.ZoomTT.nflows256.ntop10.time2.accuracy; ...
    result.ZoomTT.nflows256.ntop20.time2.accuracy; ...
    result.ZoomTT.nflows256.ntop30.time2.accuracy; ...
    result.ZoomTT.nflows256.ntop50.time2.accuracy];
errorvector = [result.ZoomTT.nflows256.ntop5.time2.ci; ...
    result.ZoomTT.nflows256.ntop10.time2.ci; ...
    result.ZoomTT.nflows256.ntop20.time2.ci; ...
    result.ZoomTT.nflows256.ntop30.time2.ci; ...
    result.ZoomTT.nflows256.ntop50.time2.ci];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'5', '10', '20', '30', '50'});
legend('1', '2', '4', '8', 'Location', 'NorthEastOutside');
xlabel('n_{top}');
ylabel('Accuracy');
save2pdf('figures/accuracy_2562', fig, dpi, fontsize, linewidth, [0 0 sizex*2+1 sizey]);
close(fig);

fig = figure();
vector = [result.ZoomTT.nflows256.ntop5.time5.accuracy; ...
    result.ZoomTT.nflows256.ntop10.time5.accuracy; ...
    result.ZoomTT.nflows256.ntop20.time5.accuracy; ...
    result.ZoomTT.nflows256.ntop30.time5.accuracy; ...
    result.ZoomTT.nflows256.ntop50.time5.accuracy];
errorvector = [result.ZoomTT.nflows256.ntop5.time5.ci; ...
    result.ZoomTT.nflows256.ntop10.time5.ci; ...
    result.ZoomTT.nflows256.ntop20.time5.ci; ...
    result.ZoomTT.nflows256.ntop30.time5.ci; ...
    result.ZoomTT.nflows256.ntop50.time5.ci];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'5', '10', '20', '30', '50'});
legend('1', '2', '4', '8', 'Location', 'NorthEastOutside');
xlabel('n_{top}');
ylabel('Accuracy');
save2pdf('figures/accuracy_2565', fig, dpi, fontsize, linewidth, [0 0 sizex*2+1 sizey]);
close(fig);

fig = figure();
vector = [result.ZoomBase.nflows16.ntop4.time2.accuracy];
errorvector = [result.ZoomBase.nflows16.ntop4.time2.ci];
cols = copper(5);
cols(1,:) = [];
[x, hb, he] = errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig, 'optional_bar_arguments', {'barwidth', 0.9});
box on;
set(gca,'XTickLabel',{'2'});
legend('1', '2', '4', '8', 'Location', 'NorthEastOutside');
xlabel('t_{wait}');
save2pdf('figures/accuracy_time', fig, dpi, fontsize, linewidth, [0 0 sizex/2 sizey]);
close(fig);

fig = figure();
vector = [result.ZoomBase.nflows16.ntop4.time1.accuracy(1); ...
    result.ZoomBase.nflows16.ntop4.time2.accuracy(1); ...
    result.ZoomBase.nflows16.ntop4.time5.accuracy(1)];
errorvector = [result.ZoomBase.nflows16.ntop4.time1.ci(1); ...
    result.ZoomBase.nflows16.ntop4.time2.ci(1); ...
    result.ZoomBase.nflows16.ntop4.time5.ci(1)];
cols = copper(5);
cols(1,:) = [];
errorbar_groups(vector', errorvector', 'bar_colors', cols, 'FigID', fig);
box on;
set(gca,'XTickLabel',{'1', '2', '5'});
xlabel('t_{wait}');
ylabel('Accuracy');
save2pdf('figures/accuracy_time_no_tolerance', fig, dpi, fontsize, linewidth, [0 0 sizex/2.97 sizey]);
close(fig);
