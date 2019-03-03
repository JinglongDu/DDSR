% SR reconstruct LR MR patches using DDSR+, and then fuse HR patches into a HRMR image

clear;
warning off;
addpath('./code-for-nii/');
% add your matcaffe path 
addpath('/home/mlg/programs/caffe-master/matlab');
scale =2;
mri_block = [45, 45 ,45];  % mri_block > rf
rf=42; % overlapping area, for accurate reconstruction rf should be larger than 42 
% the path of your MR image
imagepath='\test\KKI2009-01-MPRAGE.nii';
% the path of model and network
model ='.\SDDSR\test\caffe_model\DDSR+_X2_X3_X2X3.prototxt';
weights ='.\SDDSR\test\caffe_model\DDSR+_X2.caffemodel';
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
im_h1 = cut(im_low ,model,weights,scale,mri_block,rf); 
im_h2 = cut(rot90(im_low) ,model,weights,scale,mri_block,rf); % rotate MR image
im_h3 = cut(rot90(im_low,2),model,weights,scale,mri_block,rf); % rotate MR image
im_h4 = cut(rot90(im_low,3) ,model,weights,scale,mri_block,rf); % rotate MR image

im_h2 = rot90(im_h2,3);
im_h3=rot90(im_h3,2);
im_h4=rot90(im_h4);
im_h=(im_h1+im_h2+im_h3+im_h4)./4; % generate HR  MR image
im_h=im_h*maxpixel;   
im_h(im_h<minpixel)=minpixel;
