***********************************************************************************************************
***********************************************************************************************************
Testing codes and models for “3D Dense Convolutional Neural Network for Fast and Accurate Single MR Image Super-resolution Reconstruction” 
and “Accelerated Super-resolution MR Image Reconstruction via a 3D Densely Connected Deep Convolutional Neural Network”.

### Citation
If you find ththese work useful in your research, please consider citing:

@inproceedings{du2018accelerated,
  title={Accelerated Super-resolution MR Image Reconstruction via a 3D Densely Connected Deep Convolutional Neural Network},
  author={Du, Jinglong and Wang, Lulu and Gholipour, Ali and He, Zhongshi and Jia, Yuanyuan},
  booktitle={2018 IEEE International Conference on Bioinformatics and Biomedicine (BIBM)},
  pages={349--355},
  year={2018},
  organization={IEEE}
}

***********************************************************************************************************
***********************************************************************************************************
NOTE:

1. Remember to compile the matlab wrapper: make matcaffe, since we use matlab and Caffe to do testing.

***********************************************************************************************************
***********************************************************************************************************
  
If your computer has sufficient GPU memory which can support to SR reconstruct a complete LR MR image, you can run:

DDSR.m		for DDSR method
DDSR_e.m  	for DDSR+ method
DDSR_e.m  	for SDDSR+ method

If not, you can crop MR image into LR patches and then SR reconstruct them using our methods, you can run: 
 
DDSR_crop.m 	for DDSR method
DDSR_e_crop.m 	for DDSR+ method
DDSR_e_crop.m 	for SDDSR+ method


 
