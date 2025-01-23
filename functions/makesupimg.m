% Created and Copyright by Daniel Rowe
% perform color/gray mapping
% xdimf     = x dimension of image to be mapped
% ydimf     = y dimension of image to be mapped
% zdimf     = z dimension of image to be mapped
% newmap    = image to be displayed 
% Useage is  
% makesupimg(newmap,xdimf,ydimf,zdimf);

function makesupimg(newmap,xdimf,ydimf,zdimf);

%disp('Making montage.')
load supmap.txt     % Loading colormap

xinc=xdimf/4;
yinc=ydimf/4;

% This was made general to handle different numbers of slices automatically.
for count2=1:zdimf
    if (zdimf<=3)
        subplot(1,zdimf,count2), colormap(supmap)
        image(newmap(:,:,count2));  
        axis image
        set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(['Image ',num2str(1+count2-1)],'FontSize',12)
    end
    if (zdimf==4)
        subplot(2,2,count2), colormap(supmap)
        image(newmap(:,:,count2));
        axis image
        set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(1+count2-1,'FontSize',10)
    end
    if (zdimf>4)&(zdimf<=6)
        subplot(2,3,count2), colormap(supmap)
        image(newmap(:,:,count2));
        axis image
        set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(1+count2-1,'FontSize',10)
    end
    if (zdimf>6)&(zdimf<=9)
        subplot(3,3,count2), colormap(supmap)
        image(newmap(:,:,count2));
        axis image
        set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(1+count2-1,'FontSize',10)
    end
    if (zdimf>9)&(zdimf<=12)
        subplot(3,4,count2), colormap(supmap)    
        image(newmap(:,:,count2));
        axis image
        set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(1+count2-1,'FontSize',10)
    end
    if (zdimf>12)&(zdimf<=16)
        subplot(4,4,count2), colormap(supmap)
        image(newmap(:,:,count2));
        axis image
        set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(1+count2-1,'FontSize',8)
        %xlim([31 66]), ylim([18 53])%%%%%%%%take out!!!!!!!
        xlim([29 64]), ylim([18 53])
    end
    if (zdimf>16)&(zdimf<=20)
        subplot(4,5,count2), colormap(supmap)
        image(newmap(:,:,count2));
        axis image
        set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(1+count2-1,'FontSize',6)
    end
    if (zdimf>20)&(zdimf<=25)
        subplot(5,5,count2), colormap(supmap)
        image(newmap(:,:,count2));
        axis image
        set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(1+count2-1,'FontSize',6)
    end
    if (zdimf>25)
        temp=sqrt(zdimf);
        subplot(round(temp),round(temp),count2), colormap(supmap)
        image(newmap(:,:,count2));
        axis image
        axis off
        %set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(1+count2-1,'FontSize',6)
    end
    
end















