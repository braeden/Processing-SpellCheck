//

void setup() {
  String[] rawMs = loadStrings("/home/braeden/sketchbook/Projects/SpellChk/SpellChk/missspelled.txt"); //Import the misspelled passage
  rawMs[0] = rawMs[0].replaceAll("[^\\w\\s]", "").toLowerCase();
  String[] MsArray = split(rawMs[0], ' '); //Split it at any spaces, and put in string array - file must have no line breaks 
  String[] rawDict = loadStrings("/home/braeden/sketchbook/Projects/SpellChk/SpellChk/words.txt"); //Proccessing splits on line break (/n) automatically
  println(rawDict[90]);
  Hash h = new Hash();
  for (int i = 0; i < rawDict.length; i++) { //Add dictonary to array
    h.addto(rawDict[i]);
  }
  for (int i = 0; i < MsArray.length; i++) {
    if (h.getfrom(MsArray[i]) == null) {
      println(MsArray[i]);
    }
  }
 // println(h.getfrom("dog"));
  //println(h.getfrom("horse"));
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