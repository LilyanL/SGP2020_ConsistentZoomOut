function visualize_resulting_map_collection(Data, plotFigure, plotRefined)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if(nargin>=2)
    figure(plotFigure);
else
    figure;
end

boolPlotRefined = true;
if(nargin>=3)
    boolPlotRefined = plotRefined;
end

for i = 1:length(Data.shapes)
    for j = 1:i-1

        
        if(boolPlotRefined && ~isempty(Data.refined_maps))
       
            visualize_refined_map(Data.shapes{i}, Data.shapes{j}, Data.input_maps{i, j}, Data.refined_maps{i, j});

            %Add custom titles
            subplot(1, 3, 1);
            title(['Target: ' Data.shapes{j}.name]);

            subplot(1, 3, 2);
            title(['Initial mapping from:  ' Data.shapes{i}.name]);

            subplot(1, 3, 3);
            title(['Refined mapping from: ' Data.shapes{i}.name]);

        else

             visualize_initial_map(Data.shapes{i}, Data.shapes{j}, Data.input_maps{i, j}, Data.refined_maps{i, j});

            %Add custom titles
            subplot(1, 2, 1);
            title(['Target: ' Data.shapes{j}.name]);

            subplot(1, 2, 2);
            title(['Initial mapping from:  ' Data.shapes{i}.name]);

        end

        pause;
    end
end

end