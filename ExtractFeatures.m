function [F]=ExtractFeatures(im)
im=double(im);
m=mean(mean(im));
s=std(std(im));
F=[m s];
end

