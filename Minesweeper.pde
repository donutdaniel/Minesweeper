

import de.bezier.guido.*;
int num_bombs = 40;
int NUM_ROWS = 20;
int NUM_COLS = 20;//Declare and initialize NUM_ROWS and NUM_COLS = 20
public MSButton[][] buttons = new MSButton[NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
public ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    for(int r=0; r<NUM_ROWS; r++){
        for(int c=0; c<NUM_COLS; c++){
            buttons[r][c] = new MSButton(r,c);
        }
    }
    
    setBombs(num_bombs);
}

public void keyPressed(){
    if(key=='1'){
        num_bombs=10;
        for(int r=0; r<NUM_ROWS; r++){
            for(int c=0; c<NUM_COLS; c++){
                buttons[r][c].reset();
            }
        }
        ArrayList <MSButton> bombs = new ArrayList <MSButton>();
        setup();
    }
    if(key=='2'){
        num_bombs=40;
        for(int r=0; r<NUM_ROWS; r++){
            for(int c=0; c<NUM_COLS; c++){
                buttons[r][c].reset();
            }
        }
        ArrayList <MSButton> bombs = new ArrayList <MSButton>();
        setup();
    }
    if(key=='3'){
        num_bombs=100;
        for(int r=0; r<NUM_ROWS; r++){
            for(int c=0; c<NUM_COLS; c++){
                buttons[r][c].reset();
            }
        }
        ArrayList <MSButton> bombs = new ArrayList <MSButton>();
        setup();
    }
    if(key=='4'){
        num_bombs=399;
        for(int r=0; r<NUM_ROWS; r++){
            for(int c=0; c<NUM_COLS; c++){
                buttons[r][c].reset();
            }
        }
        ArrayList <MSButton> bombs = new ArrayList <MSButton>();
        setup();
    }
}

public void setBombs(int count)
{
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);
    if(count>0){
        if(!bombs.contains(buttons[row][col])){
            bombs.add(buttons[row][col]);
            setBombs(count-1);
        } else {
        setBombs(count);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int poo = 0;
    for(int r=0; r<NUM_ROWS; r++){
        for(int c=0; c<NUM_COLS; c++){
            if(buttons[r][c].isClicked()){
                poo++;
            }
        }
    }
    if( (400-poo) == num_bombs ){
        return true;
    }
    return false;
}
public void displayLosingMessage()
{
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][10].setLabel("L");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("S");
    buttons[9][13].setLabel("E");
    for(int i=0; i<bombs.size(); i++){
        bombs.get(i).click();
    }
}
public void displayWinningMessage()
{
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][11].setLabel("W");
    buttons[9][12].setLabel("I");
    buttons[9][13].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public void click(){
        clicked=true;
    }

    public void reset(){
        clicked=false;
        marked=false;
    }

    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true){
            marked = true;
        } else if (bombs.contains(this)){
            displayLosingMessage();
        } else if (countBombs(r,c)>0){
            String poo = "" + countBombs(r,c);
            setLabel(poo);
        }
        if(isValid(r-1,c) && !buttons[r-1][c].isClicked() && !bombs.contains(buttons[r-1][c]) && countBombs(r,c)==0)
            buttons[r-1][c].mousePressed();

        if(isValid(r+1,c) && !buttons[r+1][c].isClicked() && !bombs.contains(buttons[r+1][c]) && countBombs(r,c)==0)
            buttons[r+1][c].mousePressed();

        if(isValid(r,c-1) && !buttons[r][c-1].isClicked() && !bombs.contains(buttons[r][c-1]) && countBombs(r,c)==0)
            buttons[r][c-1].mousePressed();

        if(isValid(r,c+1) && !buttons[r][c+1].isClicked() && !bombs.contains(buttons[r][c+1]) && countBombs(r,c)==0)
            buttons[r][c+1].mousePressed();

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100,142,41 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if((r>=0 && r<20) && (c>=0 && c<20)){
            return true;  
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int r=-1; r<2; r++){
            for(int c=-1; c<2; c++){
                if(isValid(row+r,col+c) && !(r==0 && c==0)){
                    if(bombs.contains(buttons[row+r][col+c])){
                        numBombs++;
                    }
                }
            }
        }
        return numBombs;
    }
}



