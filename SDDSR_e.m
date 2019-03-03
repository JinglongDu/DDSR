% SR reconstruct a complete MR image using SDDSR+
clear;
warning off;
addpath('./code-for-nii/');
% add your matcaffe path 
addpath('/home/mlg/programs/caffe-master/matlab');
scale =2;
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
im_h1 = do_cnn(model,weights,im_low); 
im_h2 = do_cnn(model,weights, rot90(im_low)); % rotate MR image
im_h3 = do_cnn(model,weights, rot90(im_low,2)); % rotate MR image
im_h4 = do_cnn(model,weights, rot90(im_low,3)); % rotate MR image
im_h2 = rot90(im_h2,3);
im_h3=rot90(im_h3,2);
im_h4=rot90(im_h4);
im_h=(im_h1+im_h2+im_h3+im_h4)./4;% generate HR  MR image
im_h=im_h*maxpixel;   
im_h(im_h<minpixel)=minpixel;
