function replaceArray(event)
{
    event.preventDefault();
    var input=document.getElementById("sentence").value.trim().replace(/[, ]+/g, ',');
    var position=document.getElementById("position").value.trim();
    var newValue=document.getElementById("newElement").value.trim();
    var message=document.getElementById("message");
    var numberRegex = /[0-9 ]/g;
    var splCharRegex = /[^a-zA-Z, 0-9 ]/g;
    
    if (input === "" ) {
        message.textContent = "Please enter a Sentence!";
        message.style.color="red";
        return;
    }
    
    else if(numberRegex.test(input)){
        message.textContent="Numbers Are Not Allowed"
        message.style.color="red";
        return;
    }
    else if (splCharRegex.test(input)) {
        message.textContent = "Specialcharacters Are not Allowed!";
        message.style.color="red";
        return;
    }
    else if (splCharRegex.test(newValue)) {
        message.textContent = " Cannot Accept Specialcharacters Will Be New Value ";
        message.style.color="red";
        return;
    }
    else if(numberRegex.test(newValue)){
        message.textContent="Numbers Are Not Accepted As New Value"
        message.style.color="red";
        return;
    }

    var array=input.split(",");
    if(position <= 0 || position > array.length){
        message.textContent="Invalid Index Position";
        message.style.color="red";
        return;
    }
    else if(array.length <=1){
        message.textContent="Please Enter More Than One Character In The Input Field";
        message.style.color="red";
        return;
    }
    else if(position==="" ||newValue===""){
        message.textContent="Make Sure All the Boxes Mandatory Contains Values";
        message.style.color="red";
        return;
    }

    array[position - 1]=newValue;

    message.textContent="Result= "+array.join(",");
    message.style.color="green";
}

function clearForm() {
    document.getElementById("message").textContent = "";
}