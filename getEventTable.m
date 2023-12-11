function getEventTable(filePath)

% Load table
load(filePath, "evnts_tbl")

% Get patientID and walkNum
splitFilePath = split(filePath, '/');
patient = splitFilePath{6};
walkNum = splitFilePath{8};

% Add info to preserve file identify
pID = cell(size(evnts_tbl,1), 1);
walk = cell(size(evnts_tbl,1), 1);

for i = 1:size(evnts_tbl, 1)
    pID{i} = patient;
    walk{i} = walkNum;
end

% Add the new columns to the table
evnts_tbl = addvars(evnts_tbl, pID);
evnts_tbl = addvars(evnts_tbl, walk);

% Name table
fileName = strcat(patient, '-', walkNum, 'Events.xlsx');
filePath = strcat('/Users/justincampbell/Desktop/', fileName);

% Write to Excel Table
writetable(evnts_tbl, filePath);