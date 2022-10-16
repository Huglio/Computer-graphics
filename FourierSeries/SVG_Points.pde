import geomerative.*;

class Reader {

    RShape shp;
    RShape polyshp;
    RPoint[] points;

    Reader(PApplet x){

        RG.init(x);
        shp = RG.loadShape("Lion.svg");
        shp = RG.centerIn(shp, g, 100);
    }
    
    RPoint[] getPoints() {
        
    float pointSeparation = 1;
    RG.setPolygonizer(RG.UNIFORMLENGTH);
    RG.setPolygonizerLength(pointSeparation);
    return shp.getPoints();
    }
}
