%% COBRA Initializer
initCobraToolbox(false);
changeCobraSolver('mosek', 'all');

%% Create Folders
% Get the current script's path
base_path = 'C:\Users\ramye\OneDrive\Escritorio\PF BioIng\'; 
folder = 'XomicsGenerator\results';

% Create main folder "Specific Models"
mainFolderPath = fullfile(base_path, 'Specific_Models');
mkdir(mainFolderPath);

scrippath = fullfile(base_path, folder);
disp(scrippath);

% Get the list of txt files in the same folder
txtFiles = dir(fullfile(scrippath, '*.txt'));

% Iterate over each txt file
for i = 1:length(txtFiles)
    % Get the file name without extension
    [~, name, ~] = fileparts(txtFiles(i).name);
    
    % Create a folder within the main folder
    folderPath = fullfile(mainFolderPath, name);
    mkdir(folderPath);
    
    fprintf('Folder created: %s\n', folderPath);
    filenames{i} = name; % Update the file name without extension
end

%% Save Folder Information
folder_save = filenames;
foldernames = fullfile(mainFolderPath, filenames);

% Extract file names from the structure
filenames = fullfile(scrippath, filenames);
filenames = strcat(filenames, '.txt')

%% Load Base Recon3D version
load('Recon3D.mat');
model = Recon3D;

%% Bibliomic integration
% Specify the .xlsx file path
file = 'bibliomicData.xlsx';
specificData = preprocessingOmicsModel(file);

%% Transcriptomic integration
genes = cell(numel(model.genes),1);
pattern = '\d+';
for i = 1:numel(model.genes)
    match = regexp(model.genes{i}, pattern, 'match','once');
    genes{i} = match;
end
model.genes = genes;

grRules = cell(numel(model.grRules),1);
pattern = '[_,.#/-]\w*';
for i=1:numel(model.grRules)
    newElem = regexprep(model.grRules{i}, pattern,'');
    grRules{i} = newElem;
end
model.grRules = grRules;

for i = 1: length(filenames)   

    %% Parameters
    specificData.transcriptomicData = readtable([filenames{i}]);
    disp(['File name being reconstructed: ', filenames{i}]);

    param.TolMinBoundary = -1e4;
    param.TolMaxBoundary =  1e4;
    feasTol = getCobraSolverParams('LP', 'feasTol');
    param.boundPrecisionLimit = feasTol * 10;
    
    param.closeIons = false; 
    param.closeUptakes = false;
    param.nonCoreSinksDemands = 'closeNone';
    param.sinkDMinactive = false;
    
    param.activeGenesApproach = 'oneRxnPerActiveGene';
    param.tissueSpecificSolver = 'thermoKernel'; 
    param.fluxEpsilon = feasTol * 10;
    param.fluxCCmethod = 'fastcc';
    
    param.curationOverOmics = false;
    param.inactiveGenesTranscriptomics = true; 
    param.metabolomicWeights='mean';
    param.transcriptomicThreshold = 2; 
    param.weightsFromOmics = true;
    
    param.printLevel = 1;
    param.debug = true;
    if isunix()
        name = getenv('USER');
    else
        name = getenv('username');
    end

    disp(['Folder being saved to: ', foldernames{i}]);

    param.diaryFilename = [pwd filesep datestr(now,30) '_' name '_diary.txt'];
    
    %% Create Specific Model
    [specificModel, modelGenerationReport] = XomicsToModel(model, specificData, param);

    %% Save Files
    % Save the specific model
    filename_specificModel = fullfile(foldernames{i}, [folder_save{i} '_specificModel.mat']);
    save(filename_specificModel, 'specificModel');

    % Save the model report
    movefile(fullfile(base_path, '*debug_*'), foldernames{i});
    movefile(fullfile(base_path, '*thermoKernel*'), foldernames{i});
    movefile(param.diaryFilename, foldernames{i});

    disp(['Model ', filenames{i}, ' has been succesfully saved'])
    
end

disp ("All models had been succesfully saved")

