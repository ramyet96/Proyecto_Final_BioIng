function barPlot = barPlotComparison(modelsNames,modelsVectors,rxnsOfInterestIDs,rxnOfInterest,objFunctionName)
% barPlotComparison - Generate a bar plot to compare the scaled flux of specific reactions between CAFs and NFs models of patients.
%
% USAGE:  
%       barPlot = barPlotComparison(modelsNames, modelsVectors, rxnsOfInterestIDs, rxnOfInterest, objFunctionName)
%
%   Input:
%       - modelsNames: Cell array of model names, typically representing CAFs and NFs.
%       - modelsVectors: Structure containing flux vectors for each model.
%       - rxnsOfInterestIDs: Structure with reaction IDs of interest.
%       - rxnOfInterest: Name of the reaction of interest.
%       - objFunctionName: Name of the objective function used for determine flux vectors.
%
%   Output:
%       - barPlot: Bar plot object representing the comparison of scaled fluxes.
modelsOrdered = [modelsNames(2:2:end),modelsNames(1:2:end)];
x = categorical({'P1','P2','P3','P4','P5','P6','P7'});
figure;
values = zeros(2,(numel(modelsOrdered)/2));
for j=1:numel(modelsOrdered)
    if j<=(numel(modelsOrdered)/2)
        values(1,j) = modelsVectors.(modelsOrdered{j}).([objFunctionName,'_Scaled']).x(rxnsOfInterestIDs.(modelsOrdered{j}).(rxnOfInterest));
    else
        values(2,(j-(numel(modelsOrdered)/2))) = modelsVectors.(modelsOrdered{j}).([objFunctionName,'_Scaled']).x(rxnsOfInterestIDs.(modelsOrdered{j}).(rxnOfInterest));
    end
end
barPlot = bar(x,values);