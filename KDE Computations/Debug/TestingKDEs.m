close all
figure
yyaxis left
ceil(max(WalDF.Event))
A = histogram(WalDF.Event, 'BinWidth',4,'Normalization','pdf', 'BinLimits',[0,ceil(max(WalDF.Event))]);

binCenters = A.BinEdges(1:(end-1))+diff(A.BinEdges)/2;
hold on
xline(binCenters)
% A.Values(1)
% sum(A.Values)
% A.BinCounts(1)/(length(WalDF.Event)*A.BinWidth)

% B.Values(1)
% B.BinCounts(1)/(length(WalDF.Event)*B.BinWidth)

yyaxis right
hold off
BW = std(WalDF.Event) * numel(WalDF.Event)^(-1/5);
[C, cX]= kde(WalDF.Event,Bandwidth = BW, EvaluationPoints= binCenters,Kernel="normal");
plot(cX,C,'LineWidth',2)
sum(C)*(length(WalDF.Event)*BW)
C(1)*(length(WalDF.Event)*BW)