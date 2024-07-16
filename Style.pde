


class Style
{
  ColorRef lineColor = new ColorRef(color(255, 255, 255), "lineColor");
  ColorRef backgroundColor = new ColorRef(color(0, 0, 0), "backgroundColor");
  float lineWidth = 1;


  void LoadJson(JSONObject src)
  {
    if (src == null)
      return;

    backgroundColor.LoadJson(src);
    lineColor.LoadJson(src);

    lineWidth = src.getFloat("lineWidth", lineWidth);
  }

  JSONObject SaveJson()
  {
    JSONObject dest = new JSONObject();

    backgroundColor.SaveJson(dest);
    lineColor.SaveJson(dest);

    dest.setFloat("lineWidth", lineWidth);

    return dest;
  }
}


class StyleGUI extends GUIPanel
{
  Slider lineWidth;
  Style style;
  ColorGroup backgroundColor;
  ColorGroup lineColor;

  void setGUIValues()
  {
    lineWidth.setValue(style.lineWidth);
  }

  void setupControls(ControlP5 cp5)
  {
    style = data.style;
    super.Init("Style", cp5);
    lineWidth = addSlider("lineWidth", "Line Width", style, 0, 5, false);
    lineColor = addColorGroup("Line Color", style.lineColor);
    backgroundColor = addColorGroup("background Color", style.backgroundColor);
  }

  void update()
  {
 
  }
}
