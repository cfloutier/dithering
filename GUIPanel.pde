class GUIPanel__
{
  
  DrawingData data;
  
   float xPos = 20;
   float yPos = 20;
    
   int widthCtrl = 500; 
   int heightCtrl = 20;
    
   int widthButton = 100;
    
   String tabName = "Controls";
  
    public GUIPanel__(DrawingData data, String name)
    {
        this.data = data;
        tabName = name;
    }
  
  
    Slider addSlider(float defvalue, String name, float min, float max)
    {
      
      Slider slider = cp5.addSlider(data, name)     
            .setPosition(xPos,yPos)
            .setSize(widthCtrl,heightCtrl)
            .setRange(min, max)
            .moveTo(tabName)
            .setValue(defvalue);
            
    
      
       Label l = slider.getCaptionLabel();

      l.getStyle().padding(2,2,2,2);
      l.setColorBackground(#505050);
      
       yPos += heightCtrl +1;
            
      return slider;
    }
    
    Toggle addToggle(String name)
    {
      Toggle toggle = cp5.addToggle(data, name)
              .setPosition(xPos,yPos)
              .setSize(100,heightCtrl)  
            //  .setMode(ControlP5.SWITCH)
              .moveTo(tabName);
                    
      Label l = toggle.getCaptionLabel();
      l.getStyle().marginTop = -20; //move upwards (relative to button size)
      l.getStyle().marginLeft = 110; //move to the right
      l.getStyle().padding(2,2,2,2);
      l.setColorBackground(#505050);
      
      yPos += heightCtrl +1;
      return toggle;
     
    }
    
    void addButton(String fct, String label)
    {
       cp5.addButton(fct)
           .setCaptionLabel(label)
           .setPosition(xPos,yPos)
           .setSize(widthButton,heightCtrl)
           .moveTo(tabName);  
           
        
           
       xPos += widthButton + 1;
    }
    
    
    Textlabel addLabel(String name, String txt)
    {
 
       Textlabel label = cp5.addTextlabel(name)
                    .setText(txt)
                    .setPosition(xPos,yPos)
                    .setColorValue(0xffffffff)
                    .setFont(createFont("Arial",15))
                    .setColorBackground(#505050)
                    .moveTo(tabName);
                   
                   
        label.getStyle().padding(2,2,2,2);             
        
       return label;
    }
    
    void start()
    {
      xPos = 20;
      yPos = 20;
    }
    
      void nextLine()
    {
      xPos = 20;
      yPos += heightCtrl + 1;
      
    }
}
