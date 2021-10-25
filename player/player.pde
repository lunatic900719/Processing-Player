import processing.video.*;
Movie myMovie = null;
PImage img1, img2;
int ps=1;
String pmod = "Select a video";
String filename="";
float wr, hr;
float pwd, pht;

void setup() {
  size(1140, 740);
  img1=loadImage("button.png");
  img2=loadImage("open.png");
  textSize(24);
}

void draw() {
  background(255);
  if (myMovie!=null && myMovie.width>0 && myMovie.height>0)
  {
    wr=(float)width/myMovie.width;
    hr=(float)(height-110)/myMovie.height;
    if (wr<hr)
    {
      pwd=wr*myMovie.width;
      pht=wr*myMovie.height;
      image(myMovie, 0, (height-pht)/2, pwd, pht);
    } else
    {
      pwd=hr*myMovie.width;
      pht=hr*myMovie.height;
      image(myMovie,  (width-pwd)/2,0, pwd, pht);
    }
  }
  image(img1, 480, 660, 320, 75);
  image(img2, 400, 655, 80, 85);
  fill(0);
  rect(0, 640, 1140, 5);
  fill(255, 0, 0);
  if (myMovie!=null) rect(0, 640, 1140*myMovie.time()/myMovie.duration(), 5);
  text(pmod, 100, 700);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void mousePressed()
{
  if (mouseX>=400 && mouseX<480 && mouseY>=655 && mouseY<740)
  {
    selectInput("Select a file to play:", "fileSelected");
  } 
  else if (mouseX>=480 && mouseX<560 && mouseY>=660 && mouseY<745)
  {
    myMovie.pause();
    pmod="Pause";
  } 
  else if (mouseX>=560 && mouseX<640 && mouseY>=660 && mouseY<745)
  {
    myMovie.stop();
    pmod="Stop";
  } 
  else if (mouseX>=640 && mouseX<720 && mouseY>=660 && mouseY<745)
  {
    ps=1;
    myMovie.speed(ps);
    if (myMovie.time()>=myMovie.duration())myMovie.jump(0);
    myMovie.play();
    pmod="Play";
  } 
  else if (mouseX>=720 && mouseX<800 && mouseY>=660 && mouseY<745)
  {
    ps*=2;
    myMovie.speed(ps);
    myMovie.play();
    pmod="Forward, Speed="+str(ps);
  }
  else if (mouseX>=0 && mouseX<1140 && mouseY>=640 && mouseY<=645) myMovie.jump(myMovie.duration()*mouseX/1140);
}
void fileSelected(File selection) {
  if (selection == null) {
    pmod="No file was selected";
  } else {
    filename=selection.getPath();
    if ((myMovie = new Movie(this, filename))==null) pmod="Cannot open video";
    else pmod="Press play button";
  }
}
