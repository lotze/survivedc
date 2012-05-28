// Polyline with arrows
//
// Bill Chadwick May 2008 (Ported to v3 by Peter Bennett)
// 
// Free for any use
//


//Constructor
function BDCCArrowedPolyline(points, color, weight, opacity, opts, gapPx, headLength, headColor, headWeight, headOpacity) {	
    
    this.gapPx = gapPx;
    this.points = points;
    this.color = color;
    this.weight = weight;
    this.opacity = opacity;
    this.headLength = headLength;
    this.headColor = headColor;
    this.headWeight = headWeight;
    this.headOpacity = headOpacity;
    this.opts = opts;
    this.heads = new Array();
    this.line = null;
}

// Overlay v3
BDCCArrowedPolyline.prototype = new google.maps.OverlayView();

BDCCArrowedPolyline.prototype.setMap = function(map) {
	this.map = map;
	google.maps.OverlayView.prototype.setMap.call(this, map);
}

// onRemove function
BDCCArrowedPolyline.prototype.onRemove = function() {
	
    try{
        if (this.line)
            //this.map.removeOverlay(this.line);
				this.line.setMap(null);
        for(var i=0; i<this.heads.length; i++)
            //this.map.removeOverlay(this.heads[i]); 
				this.heads[i].setMap(null);
    }
    catch(ex)
    {
    }

}

BDCCArrowedPolyline.prototype.onAdd = function() {

   //this.onRemove();
   
   this.line = new google.maps.Polyline({
               		clickable:false,
					editable:false,
					geodesic:false,
					map:this.map,
					path:this.points,
					strokeColor:this.color,
					strokeOpacity:this.opacity,
					strokeWeight:this.weight,
					visible:true
					});
	
}

BDCCArrowedPolyline.prototype.draw = function() {
	
   var zoom = this.map.getZoom();
   
   // the arrow heads
   this.heads = new Array();
   
   var projection = this.map.getProjection();
   console.log(projection);
   var p1 = projection.fromLatLngToPoint(this.points[0]);//first point
   
   var p2;//next point
   var dx;
   var dy;
   var sl;//segment length
   var theta;//segment angle
   var ta;//distance along segment for placing arrows
   
   for (var i=1; i<this.points.length; i++){
            
	  p2 = projection.fromLatLngToPoint(this.points[i]);
      dx = p2.x-p1.x;
      dy = p2.y-p1.y;

	if (Math.abs(this.points[i-1].lng() - this.points[i].lng()) > 180.0)
		dx = -dx;

      sl = Math.sqrt((dx*dx)+(dy*dy)); 
      theta = Math.atan2(-dy,dx);
      


      j=1;
      
	if(this.gapPx == 0){
		//just put one arrow at the end of the line
        	this.addHead(p2.x,p2.y,theta,zoom);
	}
	else if(this.gapPx == 1) {
		//just put one arrow in the middle of the line
        	var x = p1.x + ((sl/2) * Math.cos(theta)); 
        	var y = p1.y - ((sl/2) * Math.sin(theta));
        	this.addHead(x,y,theta,zoom);        
	}
	else{
      	//iterate along the line segment placing arrow markers
      	//don't put an arrow within gapPx of the beginning or end of the segment 

	      ta = this.gapPx;
      	while(ta < sl){
        	var x = p1.x + (ta * Math.cos(theta)); 
        	var y = p1.y - (ta * Math.sin(theta));
        	this.addHead(x,y,theta,zoom);
        	ta += this.gapPx;  
      	}  
      
        	//line too short, put one arrow in its middle
      	if(ta == this.gapPx){
        		var x = p1.x + ((sl/2) * Math.cos(theta)); 
        		var y = p1.y - ((sl/2) * Math.sin(theta));
        		this.addHead(x,y,theta,zoom);        
      	}
	}
      
      p1 = p2;   
   }
	
}

BDCCArrowedPolyline.prototype.addHead = function(x,y,theta,zoom) {
	
    //add an arrow head at the specified point
    var t = theta + (Math.PI/4) ;
    if(t > Math.PI)
        t -= 2*Math.PI;
    var t2 = theta - (Math.PI/4) ;
    if(t2 <= (-Math.PI))
        t2 += 2*Math.PI;
    var pts = new Array();
    var x1 = x-Math.cos(t)*this.headLength;
    var y1 = y+Math.sin(t)*this.headLength;
    var x2 = x-Math.cos(t2)*this.headLength;
    var y2 = y+Math.sin(t2)*this.headLength;
    var projection = this.map.getProjection();
    pts.push(projection.fromPointToLatLng(new google.maps.Point(x1,y1)));
    pts.push(projection.fromPointToLatLng(new google.maps.Point(x,y)));    
    pts.push(projection.fromPointToLatLng(new google.maps.Point(x2,y2)));

 	var arrow = new google.maps.Polyline({
                clickable:false,
					 editable:false,
					 geodesic:false,
					 path:pts,
					 strokeColor:this.color,
					 strokeOpacity:this.opacity,
					 strokeWeight:this.weight,
					 visible:true
					 });
 
    this.heads.push(arrow);
	 
	this.heads[this.heads.length-1].setMap(this.map);
	 
}

