import controlP5.*; //<>// //<>// //<>// //<>//


class DotGUI extends GUIPanel
{   
    Slider CellSize;
    Slider DotDensity;
    Toggle Black;
    Toggle drawCells;
    
    void setupControls()
    {    
        super.Init("Dots");
        
        Black = addToggle("Black", "Black Dots", data); 
        
        nextLine();  
        drawCells = addToggle("drawCells", "Draw Cells", data); 
        
        CellSize = addSlider("CellSize", "Cell Size", data, 2, 40, true);          
        DotDensity = addSlider("DotDensity", "Dots Density", data, 1, 40, true);       
    }
    
    void update()        
    {
        
    }

    void setGUIValues()
    {
        CellSize.setValue(data.CellSize);
        DotDensity.setValue(data.DotDensity);
    }
}

class ImageGUI extends GUIPanel
{ 
    void update()
    {   
        if (data.source_file == "")
            file_Label.setText("please select a file");
        else
            file_Label.setText(data.source_file);
    }
    
    Slider Width;
    Slider ImageAlpha;
    Slider Blur;
    
    Textlabel file_Label;
    
    void setupControls()
    {   
        addButton("SelectSourceImage");
        file_Label = addLabel("File Label");            
        nextLine();
        
        Width = addSlider("Width", "Width", data, 200, 2000, true); 
        ImageAlpha = addSlider("ImageAlpha", "Image Alpha",data, 0, 255, true);
        
        Blur = addIntSlider("Blur", "Blur", data, 1, 20, true);
        
        updateUI();
    }

    void setGUIValues()
    {
        Width.setValue(data.Width);
        ImageAlpha.setValue(data.ImageAlpha);
        Blur.setValue(data.Blur);
    }
    
}
