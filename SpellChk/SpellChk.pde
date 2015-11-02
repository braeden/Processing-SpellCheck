void setup() {
  String misspelledPassage = "/home/braeden/sketchbook/Projects/SpellChk/SpellChk/words.txt"; //User can change this
  String[] rawMs = loadStrings("/home/braeden/sketchbook/Projects/SpellChk/SpellChk/missspelled.txt"); //Import the misspelled passage
  String stripMs = ""; //Declare string to append to
  for (int i = 0; i < rawMs.length; i++) {
    stripMs += rawMs[i].replaceAll("[^\\w\\s\\-']", "").toLowerCase(); //Replace everything thats not a-zA-Z, whitespace, -, or ' with nothing
  }
  stripMs = stripMs.replace("--", ""); //Handle double hypens for this passage, could not get regex lookaround to work
  stripMs = stripMs.replace("/\\s{2,}/g"," "); //Strip if more than 1 space
  String[] MsArray = split(stripMs, ' '); //Split it at any spaces, and put in string array
  String[] rawDict = loadStrings(misspelledPassage); //Proccessing splits on line break (/n) automatically
  Hash h = new Hash(rawDict.length);
  for (int i = 0; i < rawDict.length; i++) {
    h.insert(rawDict[i], i);
  }
  println("Misspellings:");
  for (int i = 0; i < MsArray.length; i++) {
    if (h.fetch(MsArray[i]) == null && MsArray[i].length() != 0) { 

/*
**Imporant NOTE:**
The program generates seemingly blank values for the array 
and the element length is the best way to check.

-They occur when stripping "--"
-.charAt(anyNum) returns out of bounds - (0),(1),(-1)
-There are 4 that occur in the passage [202],[225],[240],[253]

-They are ""

**Does not effect the functionality of the program**

*/ 
      println(MsArray[i] + " - Word number: " + i);
    }
  }
  /*
  Expected:
   equel
   natiom
   geat
   peeple
   */
  exit(); //Kill window when complete
}

class HashEntry {
  String keyA;
  int value;
  HashEntry link;
  HashEntry(String k, int v) {
    keyA = k;
    value = v;
  }
}

class Hash {
  HashEntry table[];
  int size;
  Hash(int s) {
    table = new HashEntry[s];
    size = s;
  }
  int HashIt(String k) { //Abstracted the hash function
    return(abs(k.hashCode()) % table.length);
  }
  void insert(String keyA, int index) { //Add to hash function
    int hashVal = HashIt(keyA);
    HashEntry entry = table[hashVal];
    if (entry != null && entry.keyA.equals(keyA)) { //If its already there
      entry.value = index;
    } else if (entry != null && !entry.keyA.equals(keyA)) {
      while (entry.link != null) { //Keep checking links while something exists in the entry
        entry = entry.link;
      }
      HashEntry oldEntry = new HashEntry(keyA, index); 
      entry.link = oldEntry; //When thats finished make a new link
    } else { //Insert directly since there is nothing
      HashEntry newEntry = new HashEntry(keyA, index);
      table[hashVal] = newEntry;
    }
  }
  String fetch(String keyA) { //Get from hash function
    int hashVal = HashIt(keyA);
    HashEntry entry = table[hashVal];
    while (entry != null) {
      if (entry.keyA.equals(keyA)) {
        return entry.keyA; //Found it
      }
      entry = entry.link; //Goes to next link
    }
    return null; //Does not occur in hash (misspelled)
  }
}