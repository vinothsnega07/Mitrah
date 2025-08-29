function checkValidation(action) {
   var checkBox = document.getElementsByName("myCheck");
   for (var i = 0; i < checkBox.length; i++) {
      if (action==="select"){
         checkBox[i].checked = true;
      }
      else if (action==="deselect"){
         checkBox[i].checked = false;
      }

      else if(action==="modify"){
         checkBox[i].checked = !checkBox[i].checked;
      }
   }
}  