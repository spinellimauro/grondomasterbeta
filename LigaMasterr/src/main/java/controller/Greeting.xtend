package controller

class Greeting {

   long id;
   String content;

   new(){
   }
   
   def Greeting(long id, String content) {
       this.id = id;
       this.content = content;
   }

   def long getId() {
       return id;
   }

   def String getContent() {
       return content;
   }
   
   def void setContent(String content) {
      this.content = content;
   }
}

