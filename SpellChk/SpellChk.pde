void setup() {
  String[] rawMs = loadStrings("/home/braeden/sketchbook/Projects/SpellChk/SpellChk/missspelled.txt"); //Import the misspelled passage
  String stripMs = ""; //Declare string to append to
  for (int i = 0; i < rawMs.length; i++) {
    stripMs += rawMs[i].replaceAll("[^\\w\\s]", "").toLowerCase(); //Strip punctuation with regex from the rest of the elements and downcase it
  }
  String[] MsArray = split(stripMs, ' '); //Split it at any spaces, and put in string array
  String[] rawDict = loadStrings("/home/braeden/sketchbook/Projects/SpellChk/SpellChk/words.txt"); //Proccessing splits on line break (/n) automatically
  Hash h = new Hash();
  for (int i = 0; i < rawDict.length; i++) { //Add dictonary to array
    h.addto(rawDict[i]);
  }
  println("Misspellings:");
  for (int i = 0; i < MsArray.length; i++) {
    if (h.getfrom(MsArray[i]) == null) {
      println(MsArray[i] + " - word number: " + i);
    }
  }
  /*
  Expected:
   equel
   natiom
   geat
   peeple
   */
  exit();
}
class Hash {
  String[] storage;
  Hash() {
    storage = new String[200000];
  }
  void addto(String k) {
    int index = abs(k.hashCode()) % storage.length;
    storage[index] = k;
  }
  String getfrom(String k) {
    int index = abs(k.hashCode()) % storage.length;
    return(storage[index]);
  }
}