class Dorian
{
  int notesCount = 7;
  int[] dorianScale = {0, 2, 3, 5, 7, 9, 10};
  
  int baseKey = 50; //default key is D
  
  //constructor, sets the base key  
  Dorian(int baseKey)
  {
    this.baseKey = baseKey;
  }
  
  int getIthNote(int which)
  {
    return dorianScale[which%notesCount] + 12*(which/notesCount) + baseKey;
  }
}

class Blues
{
  int notesCount = 6;  
  int[] bluesScale = {0, 3, 5, 6, 7, 10};
  
  int baseKey = 48; //default key is C
  
  //constructor, sets the base key  
  Blues(int baseKey)
  {
    this.baseKey = baseKey;
  }
  
  int getIthNote(int which)
  {
    return bluesScale[which%notesCount] + 12*(which/notesCount) + baseKey;
  }
}


