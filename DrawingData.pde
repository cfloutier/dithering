import controlP5.*; 


class DrawingData
{
    String name = "";
    
    //this field is modified by the UIPanel
    //on any UI change
    boolean changed = true;
    
    float width = 800;
    float height = 600;

    Style style = new Style();
    
    void setSize(float width, float height)
    {
        if (this.width != width)
        {
            changed = true;
            this.width = width;
        }
        
        if (this.height != height)
        {
            changed = true;
            this.height = height;
        }
    }
    
    boolean Black = false;
    
    String source_file = "eye.jpg";
    
    String sketch_name()
    {
        return source_file.substring(0, source_file.length() - 4);  
    }  
    
    PImage image = null;
    
    //can be adjusted
    float Width = 500;
    float ImageAlpha = 0;
    int   Blur = 2; 
    int Contrast = 0;
    
    float CellSize = 4;
    float DotDensity = 10;
    int seed = 0;
    
    boolean drawCells = false;
    
    // computed
    float Height()
    {
        if (image == null)
            return 0;
        
        return image.height * Width / image.width;
    }
    
    public void setImage(String source_file)
    {
        this.source_file = source_file;
        image = loadImage(source_file);
        image.filter(GRAY);
        //image.filter(BLUR, 20);
    }
    
    void LoadJson(String path)
    {
        JSONObject src = loadJSONObject(path);
        
        Width = src.getFloat("Width", Width);  
        
        ImageAlpha = src.getFloat("ImageAlpha", ImageAlpha);
        Blur = src.getInt("Blur", Blur);
        Contrast = src.getInt("Contrast", Contrast);
        DotDensity = src.getFloat("DotDensity", DotDensity);
        seed = src.getInt("seed", seed);
        setImage(src.getString("source_file", source_file));
    }
    
    void SaveJson(String path)
    {
        JSONObject dest = new JSONObject();
        
        dest.setFloat("Width", Width);    
        dest.setString("source_file", source_file);
        
        dest.setFloat("ImageAlpha", ImageAlpha);
        dest.setInt("Blur", Blur);
        dest.setFloat("Contrast", Contrast);
        dest.setFloat("CellSize", Contrast);
        dest.setFloat("DotDensity", DotDensity);
        dest.setInt("seed", seed);

        saveJSONObject(dest, path);
    }
    
}
