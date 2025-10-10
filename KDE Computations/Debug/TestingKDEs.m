close all

WalDF = readtable("WalDF.csv");

%%
maxVal = length(unique(WalDF.pID));
ceil(max(WalDF.Event))
BW = 4;

figure
yyaxis left
A = histogram(WalDF.Event, 'BinWidth',BW,'Normalization','count', 'BinLimits',[0,ceil(max(WalDF.Event))]);
binCenters = A.BinEdges(1:(end-1))+diff(A.BinEdges)/2;
round(A.BinCounts(1)/maxVal,2)
%---------- For PDF: Gives local probability
round(A.Values(1)*length(WalDF.Event)*BW/maxVal)
% hold on
% xline(binCenters)


yyaxis right
hold on

[C, cX]= kde(WalDF.Event,Bandwidth = BW, EvaluationPoints= binCenters,Kernel="normal");
plot(cX,C,'-r','LineWidth',2)
%-------- should be close to 1
sum(C)*BW

%-------- Scale to local probability
round(A.Values(1)*length(WalDF.Event)*BW/maxVal,2)
round((C(1)*BW)*length(WalDF.Event)*BW/maxVal,2)


%%
figure
yyaxis left
ceil(max(WalDF.Event))
BW=4;
A = histogram(WalDF.Event, 'BinWidth',BW,'Normalization','pdf', 'BinLimits',[0,ceil(max(WalDF.Event))]);

binCenters = A.BinEdges(1:(end-1))+diff(A.BinEdges)/2;
% hold on
% xline(binCenters)
% A.Values(1)
% sum(A.Values)
% A.BinCounts(1)/(length(WalDF.Event)*A.BinWidth)

% B.Values(1)
% B.BinCounts(1)/(length(WalDF.Event)*B.BinWidth)

% yyaxis right
hold on
BW = 0.05;
BW = BW*std(WalDF.Event) * numel(WalDF.Event)^(-1/5);
[C, cX]= kde(WalDF.Event,Bandwidth = BW, EvaluationPoints= binCenters,Kernel="normal");
plot(cX,C,'-r','LineWidth',2)
% sum(C)*(length(WalDF.Event)*BW)
% C(1)*(length(WalDF.Event)*BW)