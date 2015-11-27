%% Setup configuration variables
clear all;
close all;

paperUnits = 'centimeters';
printTitle = 0;
dpi = 600;
fontsize = 11;
linewidth = 2;
sizex = 10;
sizey = 5;
legendpos = 'NorthWest';

input = {'results_waikato_0_120'}; output = 'figures_waikato';
%input = {'results_ISPDSL-II'}; output = 'figures_ISPDSL-II';
for i=1:length(input)
    input{i}
    fid = fopen(strcat(input{i},'/tcp'));
    convData(i).tcpData = textscan(fid, '%s%d%s%d%d%d%d%d%d%d%f%f%f%f');
    fclose(fid);
    fid = fopen(strcat(input{i},'/udp'));
    convData(i).udpData = textscan(fid, '%s%d%s%d%d%d%d%d%d%d%f%f%f%f');
    fclose(fid);
end

traceStats = [];
percentage2 = [];
percentage4 = [];
percentage16 = [];
flows25 = [];
flows50 = [];
flows75 = [];
activeFlows = [];

for i=1:length(convData)
    traceStats = [traceStats getFlowStats(convData(i).tcpData, convData(i).udpData, 0)];
    percentage2 = [percentage2 traceStats.percentageOverTime.top2];
    percentage4 = [percentage4 traceStats.percentageOverTime.top4];
    percentage16 = [percentage16 traceStats.percentageOverTime.top16];
    flows25 = [flows25 traceStats.neededFlows.for25];
    flows50 = [flows50 traceStats.neededFlows.for50];
    flows75 = [flows75 traceStats.neededFlows.for75];
    activeFlows = [activeFlows traceStats.activeFlows];
end
%% Plot percentage cdf
cmap = copper(3);
fig = figure();
hold on;
h = cdfplot(percentage2);
    set(h, 'color', cmap(1,:));     
    set(h,'lineWidth', linewidth);
h = cdfplot(percentage4);
    set(h, 'color', cmap(2,:));     
    set(h,'lineWidth', linewidth);
h = cdfplot(percentage16);
    set(h, 'color', cmap(3,:));     
    set(h,'lineWidth', linewidth);
xlabel('Contribution of n_{top} Flows to Total Traffic', 'FontSize', fontsize);
ylabel('Fraction of Observations', 'FontSize', fontsize);
title('');
legend('2','4','16');
box on;
save2pdf(strcat(output, '/percentage_cdf'), fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);

%% Plot flow count cdf
fig = figure();
hold on;
h = cdfplot(flows25);
    set(h, 'color', cmap(1,:));     
    set(h,'lineWidth', linewidth);
h = cdfplot(flows50);
    set(h, 'color', cmap(2,:));     
    set(h,'lineWidth', linewidth);
h = cdfplot(flows75);
    set(h, 'color', cmap(3,:));     
    set(h,'lineWidth', linewidth);
xlabel('Required Number of Active Flows', 'FontSize', fontsize);
ylabel('Fraction of Observations', 'FontSize', fontsize);
legend('25%', '50%', '75%');
title('');
box on;
save2pdf(strcat(output, '/flowCount_total_cdf'), fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);

%% Plot flow count cdf
fig = figure();
hold on;
h = cdfplot(flows25./activeFlows);
    set(h, 'color', cmap(1,:));     
    set(h,'lineWidth', linewidth);
h = cdfplot(flows50./activeFlows);
    set(h, 'color', cmap(2,:));     
    set(h,'lineWidth', linewidth);
h = cdfplot(flows75./activeFlows);
    set(h, 'color', cmap(3,:));     
    set(h,'lineWidth', linewidth);
xlabel('Required Fraction of Active Flows', 'FontSize', fontsize);
ylabel('Fraction of Observations', 'FontSize', fontsize);
legend('25%', '50%', '75%');
title('');
box on;
save2pdf(strcat(output, '/flowCount_fraction_cdf'), fig, dpi, fontsize, linewidth, [0 0 sizex sizey]);

