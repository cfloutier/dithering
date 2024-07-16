import controlP5.*;  //<>// //<>//

ImageGUI images_ui= new ImageGUI(); 
DotGUI dots_ui = new DotGUI(); 

class DataGUI
{
  void updateUI()
  {
    if (!data.changed)
      return;

    //images_ui.update();
    //dots_ui.update();  
  }

  void setupControls()
  { 
    cp5.addTab("Image");
    cp5.addTab("Dots");

    images_ui.setupControls(  ) ;
    dots_ui.setupControls(  );   
    
    cp5.getTab("Dots").bringToFront();
  }
  
  void setGUIValues()
  {
    images_ui.setGUIValues();
    dots_ui.setGUIValues();

  }
}
