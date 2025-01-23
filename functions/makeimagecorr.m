% Created and Copyright by Daniel Rowe
% perform color/gray mapping
% anat      = anatomical grayscale image
% mingrey   = minimum anatomical value
% maxgrey   = maximum anatomical value
% supimg    = image to be superimposed (likely a t-stat)
% threshval = cutoff value for superimposing
% maxval    = maximum value of superimposed image colorbar

% Useage is  
% makeimagecorr(anat,mingrey,maxgrey,supimg,threshval,maxval);
function [newmap] = makeimagecorr(anat,mingrey,maxgrey,supimg,threshval,maxval)

load supMap.txt
glevels=128;
clevels=20;
threshvalu=threshval; threshvall=-threshval;
xydim=size(supimg,1);
maxval=maxval+.000001;

newanat=ones(xydim,xydim);
for count1=1:xydim
    for count2=1:xydim
        for countlevels=1:glevels
            if ( (anat(count1,count2) >= mingrey+(countlevels-1)/glevels*maxgrey) & (anat(count1,count2) < (countlevels)/glevels*maxgrey) )
                newanat(count1,count2)=countlevels;
            elseif (anat(count1,count2)==maxgrey)
                newanat(count1,count2)=glevels;
            end
        end
    end
end

newmap=newanat+clevels;

for count1=1:xydim
    for count2=1:xydim
        for countlevels=1:clevels
            if ( (supimg(count1,count2) < 0-(countlevels-1)/clevels*maxval) & (supimg(count1,count2) >= 0-(countlevels)/clevels*maxval)   )
                newmap(count1,count2)=clevels-countlevels+1;
            end
            if ( (supimg(count1,count2) >= 0+(countlevels-1)/clevels*maxval) & (supimg(count1,count2) < (countlevels)/clevels*maxval) )
                newmap(count1,count2)=countlevels+clevels+glevels;
            end
            if  (threshval~=0 ) %%%%
                if supimg(count1,count2)==0
                    newmap(count1,count2)=newanat(count1,count2)+clevels;
                end
                if ( 0< supimg(count1,count2) ) &( threshvalu>=supimg(count1,count2) )
                    newmap(count1,count2)=newanat(count1,count2)+clevels;
                end
                if  (0> supimg(count1,count2) ) &( supimg(count1,count2)>=threshvall )
                    newmap(count1,count2)=newanat(count1,count2)+clevels;
                end
            end
        end
    end
end


[xdimf,ydimf]=size(newmap);
xinc=xdimf/4; yinc=ydimf/4;
subplot(1,1,1), colormap(supMap)
image(newmap);  
axis image
set(gca,'xtick',[(0:xinc:xdimf)]), set(gca,'ytick',[(0:yinc:ydimf)]), axis image, xlabel(['Image ',num2str(1+count2-1)],'FontSize',12)
