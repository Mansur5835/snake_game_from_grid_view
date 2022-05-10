String? HorizantalToRight(List list) {
  if(list.contains(list.last+1)){
    return "game over";
  }
  list.removeAt(0);
  list.add(list.last+1);
  if((list.last)%20==0){
    list[list.length-1] -=20;
  }

}

String? HorizantalToLeft(List list) {
  if(list.contains(list.last-1)){
    return "game over";
  }
  list.removeAt(0);
  list.add(list.last-1);
  if((list.last+1)%20==0&&list.last!=0||list.last==-1){
    list[list.length-1] +=20;
  }
}

String? VerticalToDown(List list, int i) {
  if(list.contains(list.last+20)){
    return "game over";
  }
  list.removeAt(0);
  list.add(list.last+20);
  if((list.last)>=i*20-21){
    list[list.length-1] =list.last - (i*20-20);
  }
}

String? VerticalToUp(List list, int i) {
  if(list.contains(list.last-20)){
    return "game over";
  }
  list.removeAt(0);
  list.add(list.last-20);
  if((list.last)<0){
    list[list.length-1] =list.last +=(i*20-20);
  }

}

