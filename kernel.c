
void some_function(){
  
}
void main(){
  char* video_memory = (char*) 0xb8000;
  *video_memory = 'L';
  some_function();
}