clear; close all; clc; % addpath(genpath(pwd)); 
dbstop if error

%% load shapes
mesh_dir = uigetdir(pwd, 'Select input folder');

mesh_info = dir([mesh_dir, '\*.off']);
nshapes = length(mesh_info);
shapes = cell(nshapes, 1);
for i = 1:nshapes
    shapes{i} = read_off_shape([mesh_dir, '\', mesh_info(i).name]);
    shapes{i}.name = mesh_info(i).name(1:end-4); 
    shapes{i} = compute_laplacian_basis(shapes{i}, 100); 
end

% subsample N points on each shape for accelerating the map
% synchonization
subsamples = cell(nshapes, 1); 
for i = 1:nshapes
    subsamples{i} = fps_euclidean(shapes{i}, 10000, i); 
end    

%% load initial maps
map_dir = mesh_dir;

ini_maps = cell(nshapes);
for i = 1:nshapes
    for j = 1:nshapes
        if isfile([map_dir, shapes{i}.name '_' shapes{j}.name '.map'])
            T = dlmread([shapes{i}.name '_' shapes{j}.name '.map']); 
            ini_maps{i, j} = T+1; 
        end
    end
end

% G encodes the topoloty of the initial map network.
G = 1 - cellfun(@isempty, ini_maps);

%% organize input 
Data = []; 
Data.shapes = shapes; 
Data.input_maps = ini_maps; 
Data.G = G; 
Data.sub = subsamples; 
Data.alpha = 0.9; 
Data.dim = 25:2:80; % zoomout from dim 30 to 80, with step size 2.

initialMapFigure = figure();
visualize_resulting_map_collection(Data, initialMapFigure, false);

%% run consistent zoomOut
Data = ConsistentZoomOut(Data);
initialMapFigure = figure();


%% visualize results
refinedMapFigure = figure(); 
visualize_resulting_map_collection(Data, refinedMapFigure);