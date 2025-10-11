close all

WalDF = readtable("WalDF.csv");

%%
numVoters = length(unique(WalDF.pID));
totalVotes = length(WalDF.Event);

tMax = ceil(max(WalDF.Event));
BW = 2;


[A, binEdges]= histcounts(WalDF.Event, 'BinWidth',BW,'Normalization','count', 'BinLimits',[0,ceil(max(WalDF.Event))]);
binCenters = binEdges(1:(end-1))+diff(binEdges)/2;
round(A(1)/numVoters,2)
histVal = A/(numVoters);

BW = BW/2;
f = 100;
xKDE = 0:1/f:tMax;
% xKDE= binCenters;
[C, cX]= kde(WalDF.Event,Bandwidth = BW, EvaluationPoints= xKDE, Kernel="normal",Support="positive");
% Always has to be 1
% disp(sum(C)*f)

% C = C/max(C)*max(histVal);
C = C*BW*totalVotes/numVoters;


figure
stem(binCenters, histVal)
hold on
plot(cX,C,'-r','LineWidth',2)


%%
numVoters = length(unique(WalDF.pID));
totalVotes = length(WalDF.Event);

tMax = ceil(max(WalDF.Event));
BW = 2;
[A, binEdges]= histcounts(WalDF.Event, 'BinWidth',BW,'Normalization','count', 'BinLimits',[0,ceil(max(WalDF.Event))]);
binCenters = binEdges(1:(end-1))+diff(binEdges)/2;
round(A(1)/numVoters,2)
histVal = A/(numVoters)*numVoters;

% f = binCenters;
xKDE = 0:1/f:tMax;
% xKDE= binCenters;
C = zeros(numVoters,length(xKDE));
pIDs = unique(WalDF.pID);
for pIdx=1:numVoters
    [C(pIdx,:), cX]= kde(WalDF.Event(WalDF.pID==pIDs(pIdx)),Bandwidth = BW, EvaluationPoints= xKDE, Kernel="normal",Support="positive");
end
% Always has to be 1
% disp(sum(C)*f)

% C = C/max(C)*max(histVal);
C = C*BW*totalVotes/numVoters*numVoters;


figure
stem(binCenters, histVal)
hold on
plot(cX,C,'-r','LineWidth',2)

%%
figure
yyaxis left
ceil(max(WalDF.Event))
BW = 2;
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