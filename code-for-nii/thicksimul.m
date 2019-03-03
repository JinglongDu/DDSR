function thickim=thicksimul(orim,scale,direction)
% orim------is the original image;
% scale-----the down-sample scale;
% direction---if the value is 1, the direction is along Z;
%             if the value is 2, the direction is along Y;
%             if the value is 3, the direction is along X;
s=size(orim);
s1=mod(s,scale);
s2=s-s1;
if direction==1
    for i=1:scale:s2(3)
        thickim(:,:,(i+scale-1)/scale)=mean(orim(:,:,i:i+scale-1),3);
    end
elseif direction==2
    for i=1:scale:s2(2)
        thickim(:,(i+scale-1)/scale,:)=mean(orim(:,i:i+scale-1,:),2);
    end
elseif direction==3
    for i=1:scale:s2(1)
        thickim((i+scale-1)/scale,:,:)=mean(orim(i:i+scale-1,:,:),1);
    end
else
    disp('Wrong input parameters');
end

