V = load_nii('recontemp_it3.nii');
F = fftn(double(V.img));
FS = fftshift(F);
meanFmag = mean(mean(mean(abs(FS))))
FSL = FS(size(FS,1)/4:size(FS,1)*3/4,size(FS,2)/4:size(FS,2)*3/4,size(FS,2)/4:size(FS,2)*3/4);
meanFmag = mean(mean(mean(abs(FSL))))