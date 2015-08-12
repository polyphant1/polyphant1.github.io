`chartSeries3d0` <-
  function(Z, theta=30, r=10, col=c("yellow","red"), smoother=1, border=NA, shade=.3, ltheta=20,  x.cex=.75, srt=0,...) {
    cnames <- colnames(Z)
    yred <- colorRampPalette(col)
    par(mar=c(3,1,1,1))
    time.axis <- axTicksByTime(Z)
    if(smoother > 1)
      Z <- as.xts(t(apply(Z,1,function(x) spline(as.vector(coredata(x)), n=smoother*length(x))$y)))
    pm <- persp(z=Z,
                x=(1:NROW(Z))/length(time.axis),
                y=(1:NCOL(Z))/smoother,
                shade=shade, ltheta=ltheta,
                r=r,
                theta=theta,
                col=rep(rep(yred(NCOL(Z)/smoother),each=smoother),each=(NROW(Z)-1)),
                scale=F, border=border,box=FALSE,...)
    
    x_axis <- seq(1, NROW(Z), length.out=length(time.axis))/length(time.axis)
    y_axis <- seq(1, NCOL(Z), length.out=NCOL(Z)/smoother)/smoother
    
    # x-axis
    xy0 <- trans3d(x_axis,y_axis[1],0,pm)
    xy1 <- trans3d(x_axis,y_axis[1]-0.3,0,pm)
    lines(trans3d(x_axis,y_axis[1],0,pm),col="#555555")
    segments(xy0$x,xy0$y,xy1$x,xy1$y, col="#555555")
    #text(xy1$x, xy1$y, labels=as.character(format(index(Z)[x_axis*10],"%m/%d/%y")), pos=1, offset=.25,cex=x.cex, srt=srt)
    text(xy1$x, xy1$y, labels=names(time.axis), pos=1, offset=.25,cex=x.cex, srt=srt)
    
    # y-axis
    xy0 <- trans3d(x_axis[length(x_axis)], y_axis, 0, pm)
    xy1 <- trans3d(x_axis[length(x_axis)]+.3, y_axis, 0, pm)
    yz0 <- trans3d(x_axis[length(x_axis)], y_axis, coredata(Z)[NROW(Z),seq(1,NCOL(Z),by=smoother)], pm) # vertical y
    lines(trans3d(x_axis[length(x_axis)], y_axis, 0, pm),col="#555555")
    segments(xy0$x,xy0$y,xy1$x,xy1$y,col="#555555")
    text(xy1$x, xy1$y, labels=cnames, pos=4, offset=.5,cex=x.cex)
    
    segments(xy0$x,xy0$y,yz0$x,yz0$y, col="#555555") # y-axis vertical lines
    
    # z-axis
    z_axis <- seq(trunc(min(Z,na.rm=TRUE)), round(max(Z, na.rm=TRUE)))
    xy0 <- trans3d(x_axis[length(x_axis)], y_axis[length(y_axis)], z_axis, pm)
    xy1 <- trans3d(x_axis[length(x_axis)]+0.3, y_axis[length(y_axis)], z_axis, pm)
    lines(trans3d(x_axis[length(x_axis)], y_axis[length(y_axis)], z_axis, pm))
    segments(xy0$x,xy0$y,xy1$x,xy1$y)
    text(xy1$x, xy1$y, labels=paste(z_axis,'%',sep=''), pos=1, offset=-.5,cex=x.cex)
    
    title("")
    par(mar=c(5.1,4.1,4.1,3.1))
    return(invisible(pm))
  }
