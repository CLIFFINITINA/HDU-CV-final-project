function out=simple_descriptor(patch)

patch_std=std2(patch);%标准差
patch_mean=mean(patch(:));%均值

out=(patch-patch_mean)./patch_std;%标准正态化
out=out(:);

end