%% --- Frangi 2D ---
%% Read image from Wikipedia
input = double(rgb2gray(imread('https://upload.wikimedia.org/wikipedia/commons/6/66/Mra-mip.jpg')));

%% Apply Frangi 2D with scales=[5]
[J,Scale,Direction] = FrangiFilter2D(input, struct('FrangiScaleRange', [5 5], 'FrangiScaleRatio', 1, 'verbose', true, 'BlackWhite', false));
imwrite(J, 'result-matlab.png');
imshow(J);

%% Check different scales
for i=0.5:1
[J,Scale,Direction] = FrangiFilter2D(imageStack(:,:,4), struct('FrangiScaleRange', [i i], 'FrangiScaleRatio', 1, 'verbose', true));
imshow(J);
end

%% --- Frangi 3D ---
%% Load stack from file
fname = 'testFrangi-small.tif';
info = imfinfo(fname);
imageStack = [];
numberOfImages = length(info);
for k = 1:numberOfImages
    currentImage = imread(fname, k, 'Info', info);
    imageStack(:,:,k) = currentImage;
end

%% Apply Frangi 3D
[J,Scale,Vx,Vy,Vz] = FrangiFilter3D(imageStack, struct('FrangiScaleRange', [1 1], 'FrangiScaleRatio', 1, 'verbose', true, 'FrangiC', 500, 'FrangiAlpha', 0.5, 'FrangiBeta', 0.5));
maxVals = max(J, [], 3);
minVals = min(J, [], 3);