function visualize_map_collection(Data, plotFigure)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if(nargin==2)
    figure(plotFigure);
else
    figure;
end

for i = 1:length(Data.shapes)
    for j = 1:i-1
        visualize_map(Data.shapes{i}, Data.shapes{j}, Data.input_maps{i, j}, Data.refined_maps{i, j});
        
        %Add custom titles
        subplot(1, 3, 1);
        title(['Target: ' Data.shapes{j}.name]);

        subplot(1, 3, 2);
        title(['Initial mapping from:  ' Data.shapes{i}.name]);

        subplot(1, 3, 3);
        title(['Refined mapping from: ' Data.shapes{i}.name]);
        pause;
    end
end

end