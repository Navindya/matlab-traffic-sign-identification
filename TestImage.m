%% Test Image
clc;
clear all;
close all;
[fname, path]=uigetfile('.png','Open an Image as input for training');
fname=strcat(path, fname);
f=imread(fname);
f = imresize(f, [300 NaN]);
f=rgb2gray(f);
sub=zeros(size(f));
[ROW COLUMN]=size(sub);
f=im2double(f);

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
imshow(r);

title('Test Image');
%% Find the class the test image belongs
Ftest=ExtractFeatures(im);
%% Compare with the feature of training image in the database
load db.mat
Ftrain=db(:,1:2);
Ctrain=db(:,3);
for (i=1:size(Ftrain,1));
    dist(i,:)=sum(abs(Ftrain(i,:)-Ftest));
end 

Min=min(dist);
if(Min<50)
m=find(dist==Min,1);
det_class=Ctrain(m);
msgbox(strcat('detected class',num2str(det_class)));
else
    msgbox('Not Exist');
end

%%m=find(dist==min(dist),1);
%%det_class=Ctrain(m);
%%msgbox(strcat('Detected Class=',num2str(det_class)));





