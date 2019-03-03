%change the 3D images to 2D images.
clear all;
clc;
A=load_nii('/home/ch166315/yuan-work/my-test/data/WIP_SPACE_607_OPTIMIZED_5262010_shifted.nii');
I=A.img;
[x,y,z]=size(I);
% for i=1:z
%     dir=strcat('/home/ch166315/yuan-work/my-test/data/7-1/',num2str(i),'.bmp');
%     imwrite(mat2gray(I(:,:,i)),dir,'BMP');
%     clear dir;
% end
temp2=zeros(x,z,y);
for j=1:y
    temp2(:,:,j)=I(:,j,:);
    dir=strcat('/home/ch166315/yuan-work/my-test/data/7-2/',num2str(j),'.bmp');
    imwrite(mat2gray(temp2(:,:,j)),dir,'BMP');
    clear dir;
end
temp3=zeros(y,z,x);
for r=1:x
    temp3(:,:,r)=I(r,:,:);
    dir=strcat('/home/ch166315/yuan-work/my-test/data/7-3/',num2str(r),'.bmp');
    imwrite(mat2gray(temp3(:,:,r)),dir,'BMP');
    clear dir;
end