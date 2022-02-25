/**
 * 
 */

 function changeBorder(){
  // let vdiv = document.getElementsByTagName("div");

  let width = parseInt(Math.random() * 10);

  let red = parseInt(Math.random() * 256);
  let green = parseInt(Math.random() * 256);
  let blue = parseInt(Math.random() * 256);

  let type = ["solid", "dashed", "dotted", "inset", "outset", "double"];
  let num = parseInt(Math.random() * type.length);

  vdiv.style.border = `${width}px ${type[num]} rgb(${red},${green},${blue})`;


}
function changeColor(){
  // let vdiv = document.getElementsByTagName("div");

  //0~255의 난수 발생
  let red = parseInt(Math.random() * 256);
  let green = parseInt(Math.random() * 256);
  let blue = parseInt(Math.random() * 256);
  vdiv.style.color = `rgb(${red},${green},${blue})`;
}
function changeSize(){
  // let vdiv = document.getElementsByTagName("div");

  let fSize = (Math.random() * 5 + 5);

  vdiv.style.fontSize = `${fSize}em`;
}

changeBorderRadius = ()=>{
  // let vdiv = document.getElementsByTagName("div");

  let borderR = (Math.random() * 50 + 10)
  vdiv.style.borderRadius = `${borderR}px`;
}