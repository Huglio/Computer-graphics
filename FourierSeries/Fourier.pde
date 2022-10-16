import geomerative.*;

class Fourier {
    
    PVector[] points;
    
    Fourier (RPoint[] points) throws Exception {
        this.points = new PVector[points.length];
        for (int i = 0; i < points.length; i++)
            this.points[i] = new PVector(points[i].x, points[i].y);
    }
    
    PVector F(float p) {
        int pos = floor(p * points.length) % points.length;
        int pos_n = (pos + 1) % points.length;
        p = (p * points.length) - floor(p * points.length);
        
        float x = lerp(points[pos].x, points[pos_n].x, p);
        float y = lerp(points[pos].y, points[pos_n].y, p);
        
        return new PVector(x, y);
    }
    
    PVector Eto(float x) {
        
        float Ex = cos(x * TWO_PI);
        float Ey = sin(x * TWO_PI);
                
        return new PVector(Ex, Ey);
    }
    
    PVector getCn(int n) {
        
        float x = 0;
        float y = 0;
        
        for (float at = 0, step = 0.00001; at <= 1; at += step) {
            PVector p1 = F(at);
            PVector p2 = Eto(-n * at);
            
            x += (p1.x * p2.x - p1.y * p2.y) * step;
            y += (p1.y * p2.x + p1.x * p2.y) * step;
        }
        
        return new PVector(x, y);
    }
    
    PVector[] getVectors(int n) {
        
        n = n * 2 + 1;
        PVector[] v = new PVector[n];
        
        int aux = 0;
        for (int i = -n / 2; i <= n / 2; i++) {
            v[aux] = getCn(i);
            v[aux++].z = i;
        }
        
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n - 1; j++)
                if (sqrt(v[j].x * v[j].x + v[j].y * v[j].y) < sqrt(v[j + 1].x * v[j + 1].x + v[j + 1].y * v[j + 1].y)) {
                //if (abs(v[j].z) > abs(v[j + 1].z)) {
                    PVector temp = v[j].copy();
                    v[j] = v[j + 1];
                    v[j + 1] = temp;
                }
        
        return v;
    }
    
    
}
