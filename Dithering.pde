import java.lang.String; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import controlP5.*;
import processing.pdf.*;
import processing.dxf.*;
import processing.svg.*;


DrawingData data;
DataGUI dataGui;
DrawingGenerator drawer;
//SourceFiles sourceFilesGui;
PGraphics current_graphics;

ControlP5 cp5;

void setup() 
{
    size(1200,800);
    
    data = new DrawingData();
    drawer = new DrawingGenerator();
    dataGui = new DataGUI();

   //drawer.center =  new PVector(800,400);
    
    setupControls();
    surface.setResizable(true);
    
    //noLoop();  // Run once and stop
}
   
void setupControls()
{ 
  cp5 = new ControlP5(this);
   
  cp5.getTab("default").setLabel("Hide GUI");

  // init loading
  data.setImage(data.source_file);                     
  dataGui.setupControls( );     
  addFileTab();
    
         
  //sourceFilesGui.setupControls(data, cp5); 
  //addExportTab();
           
  addFileTab();

  cp5.getTab("Image").bringToFront(); 
}


void updateUI()
{
  ui.updateUI();
}


void draw()
{
  if (data.Black)
    background(255);
   else
    background(0);
  
  if (data.image != null)
  {
    drawer.buildBlurredImage();

    // draw centered 
      PImage image =  drawer.blurred_image;
    float image_w = image.width;
    float image_h = image.height;

    tint(255, data.ImageAlpha);  
    image(drawer.blurred_image, width/2 - image_w/2, height/2- image_h/2, image_w, image_h);
  }
  

  drawer.buildCells(new PVector(width/2, height/2));
  drawer.buildPoints();
  
  if (data.drawCells)
    drawer.drawCells();
    
    
  if (record) 
  {
    // Note that #### will be replaced with the frame number. Fancy!
        
      fileName = "Export/" + data.sketch_name() +"_"+ year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second(); 
      if (mode == 0)
        beginRecord(PDF, fileName + ".pdf"); 
      else if (mode == 1)
        beginRecord(DXF, fileName + ".dxf"); 
      else if (mode ==2)
        beginRecord(SVG, fileName + ".svg"); 
        
        stroke(0);
   }
   else
       stroke(255);
    
    drawer.drawPoints();
  
   if (record) 
   {
      endRecord();
      record = false;
   }
    
      
  /*
  
  background(0);
  
   if (record) 
   {
    // Note that #### will be replaced with the frame number. Fancy!
        
      fileName = "Export/Spiral_" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second(); 
      if (mode == 0)
        beginRecord(PDF, fileName + ".pdf"); 
      else if (mode == 1)
        beginRecord(DXF, fileName + ".dxf"); 
      else if (mode ==2)
        beginRecord(SVG, fileName + ".svg"); 
        
        stroke(0);
   }
   else
       stroke(255);
       
    spiral.center =  new PVector(width/2,height/2);
   
    spiral.data = data;
    spiral.draw();
     
     if (record) 
     {
        endRecord();
        record = false;
     }*/
}
