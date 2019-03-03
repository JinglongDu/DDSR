function imh = cut( im_low ,model,weights,scale,mri_block,rf)
[deep,wid,hei]=size(im_low);
stride_deep =mri_block(1); 
stride_wid = mri_block(2);
stride_hei = mri_block(3);

a=ceil((deep-stride_deep)/(stride_deep-rf))+1;
b=ceil((wid-stride_wid)/(stride_wid-rf))+1;
c= ceil((hei-stride_hei)/(stride_hei-rf))+1;
for i=1:a
    for j=1:b
        for k=1:c
            xend=i*stride_deep-rf*(i-1);
            yend=j*stride_wid-rf*(j-1);
            zend=k*stride_hei-rf*(k-1);
            xstart=(i-1)*(stride_deep-rf)+1;
            ystart=(j-1)*(stride_wid-rf)+1;
            zstart=(k-1)*(stride_hei-rf)+1;
            xhend=(i*stride_deep-rf*(i-1))*scale-rf*scale/2;
            yhend=(j*stride_wid-rf*(j-1))*scale-rf*scale/2;
            zhend=(k*stride_hei-rf*(k-1))*scale-rf*scale/2;
            xhstart=(i-1)*(stride_deep-rf)*scale+1+rf*scale/2;
            yhstart=(j-1)*(stride_wid-rf)*scale+1+rf*scale/2;
            zhstart=(k-1)*(stride_hei-rf)*scale+1+rf*scale/2;
            if i==a
                xend=deep;
                xhend=deep*scale;
            end
            if j==b
                yend=wid;
                yhend=wid*scale;
            end
            if c==k
                zend=hei;
                zhend=hei*scale;
            end
            if i==1
                xstart=1;
                xhstart=1;
            end
            if j==1
                ystart=1;
                yhstart=1;
            end
            if 1==k
                zstart=1;
                zhstart=1;
            end
            lowpatch=im_low(xstart:xend,ystart:yend,zstart:zend);
            highpatch=do_cnn(model,weights,lowpatch);
            xstarttmp=rf/2*scale+1;
            ystarttmp=rf/2*scale+1;
            zstarttmp=rf/2*scale+1;
            xendtmp=size(highpatch,1)-rf/2*scale;
            yendtmp=size(highpatch,2)-rf/2*scale;
            zendtmp=size(highpatch,3)-rf/2*scale;
            if xhstart==1
                xstarttmp=1;
            end
            if yhstart==1
                ystarttmp=1;
            end
            if zhstart==1
                zstarttmp=1;
            end
            if xend==deep
                xendtmp=size(lowpatch,1)*scale;
            end
            if yend==wid
                yendtmp=size(lowpatch,2)*scale;
            end
            if zend==hei
                zendtmp=size(lowpatch,3)*scale;
            end
            tmphighpatch=highpatch(xstarttmp:xendtmp,ystarttmp:yendtmp,zstarttmp:zendtmp);
            imh(xhstart:xhend,yhstart:yhend,zhstart:zhend)=tmphighpatch;
        end
    end
end