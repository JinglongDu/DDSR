clc;
clear;
%ddsr+ÇÐ¿éÖØ½¨
warning off;
addpath('./code-for-nii/');
% add your matcaffe path 
addpath('/home/mlg/programs/caffe-master/matlab');
scale =2;
mri_block = [45, 45 ,45];
rf=42;
% the path of your MR image
imagepath='\test\KKI2009-01-MPRAGE.nii';
% the path of model and network
model ='.\DDSR+\test\caffe_model\DDSR+_X2_X3_X2X3.prototxt';
weights ='.\DDSR+\test\caffe_model\DDSR+_X2.caffemodel';
caffe.set_mode_gpu();
caffe.set_device(0);
% generate LR
nii=load_nii(imagepath);
img=single(nii.img);
img = gauss3filter(img, 1);  
img=modcrop(img, scale);
im_low=imresize3(img,1/scale);  
maxpixel=max(max(max(im_low)));
minpixel=min(min(min(im_low)));
im_low=im_low/maxpixel; 
% SR reconstruction
if scale>2
    im_low=imresize3(im_low,scale/2);
end
im_h = cut(im_low ,model,weights,scale,mri_block,rf);    
im_h=im_h*maxpixel;   
im_h(im_h<minpixel)=minpixel;
