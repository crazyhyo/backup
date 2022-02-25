/**
 * 
 */

 function formCheck(){

  let form = document.form;

  let id = form.ID.value.trim();
  let pw = form.password.value.trim();
  let pconfirm = form.pconfirm.value.trim();
  let name = form.name.value.trim();
  let gender = form.gender.value.trim();
  let tel = form.tel.value.trim();
  let email = form.email.value.trim();

  if(id.length < 1){
    alert('input id!');
    return false;
  }else if(id.length < 8 || id.length > 20){
    alert('invalid size(valid size between 8~20)');
    return false;
  }

  let regId = /^[a-z][a-zA-Z0-9-_]{7,19}$/;

  if(regId.test(id)){
    alert('valid id!');
  }else{
    alert('invalid format!');
  }

  if(pw.length < 1){
    alert('input pw!');
    return false;
  }else if(pw.length < 8 || pw.length > 20){
    alert('invalid size(valid size between 8~20)');
    return false;
  }

  let regPw = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&_-]).{8,20}$/;

  if(regPw.test(pw)){
    alert('valid pw!');
  }else{
    alert('invalid format!');
  }

  if(pw == pconfirm){
    alert('correct confirm!');
  }else{
    alert('invalid confirm!');
  }
  if(name.length < 1){
    alert('input name!');
    return false;
  }else if(name.length < 2 || name.length > 5){
    alert('invalid size(valid size between 2~5)');
    return false;
  }

  let regName = /^[가-힣]{2,5}$/;

  if(regName.test(name)){
    alert('valid name!');
  }else{
    alert('invalid format!');
  }

  if(tel.length < 1){
    alert('input tel!');
    return false;
  }

  let regTel = /^\d{2,3}-\d{3,4}-\d{4}$/;

  if(regTel.test(tel)){
    alert('valid tel!');
  }else{
    alert('invalid format!');
  }

  if(email.length < 1){
    alert('input email!');
    return false;
  }

  let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;

  if(regEmail.test(email)){
    alert('valid email!');
    return true;
  }else{
    alert('invalid format!');
    return false;
  }
}