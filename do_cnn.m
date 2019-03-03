function [ outputdata ] = do_cnn( model_1, weights, inputdata )
%%%%% change TXT1  %%%%%
%   model_1 = 'H:\DRRN_CVPR17-master\test\DRRN_B1U9_20C128.prototxt';
%   weights = 'H:\DRRN_CVPR17-master\model\.DRRN_B1U9_20C128_iter_464056.caffemodel';
[wid,hei,deep,channels_num] = size(inputdata);
fidin1=fopen(model_1,'r+');
i=0;
while ~feof(fidin1)
    tline=fgetl(fidin1);
    i=i+1;
    newtline{i}=tline;
    if i == 4
        newtline{i}=[tline(1:4) num2str(channels_num)];
    end
    if i == 5
        newtline{i}=[tline(1:4) num2str(deep)];
    end
    if i == 6
        newtline{i}=[tline(1:4) num2str(hei)];
    end
    if i == 7
        newtline{i}=[tline(1:4) num2str(wid)];
    end
end
fclose(fidin1);
fidin1=fopen(model_1,'w+');
for j=1:i
    fprintf(fidin1,'%s\n',newtline{j});
end
fclose(fidin1);
%%%%%%%%%%%%%%%%%%%%%%%%
net_1 = caffe.Net(model_1, weights, 'test'); % create net and load weights
% net_1.copy_from( weights);
res = net_1.forward({inputdata});
outputdata = res{1};
% outputdata = uint8(outputdata'*255);
% outputdata = outputdata';
%outputdata=permute(outputdata,[2, 1, 2]);
caffe.reset_all();


end

