clc;
close all;
[fname, path]=uigetfile('.jpg','Open an Image to Train');
fname=strcat(path, fname);
f=imread(fname);

f = imresize(f, [300 300]);
f=rgb2gray(f);
sub=zeros(size(f));
[ROW,COLUMN]=size(sub);
f=im2double(f);
imshow(f);

% Global Thresholding
T=0.5*(min(f(:))+max(f(:)));
r=imbinarize(f,T);
R=double(r);

%Image Subtraction
for i=1:ROW
        for j=1:COLUMN
            sub(i,j)=R(i,j)-f(i,j);
        end
end

% Sliding Neighborhood Normalization
fun = @(x) mode(x(:));
im = nlfilter(sub,[3 3],fun);

title('Input Image');
c=input('Enter the Class(Number from 1-12)');
%% Feature Extraction

F=ExtractFeatures(im);
try 
    load db;
    F=[F c];
    db=[db; F];
    save db.mat db 
catch 
    db=[F c]; % 10 12 1
    save db.mat db 
end



