function checkStringChar(event)
{
    event.preventDefault();
    var input=document.getElementById("sentence").value.trim().replace(/\s/g, "");
    var lower=input.toLowerCase();
    var message=document.getElementById("message");
    var specialCharsRegex = /[^a-zA-Z ]/g;
    message.style.color = "red";

    if (input === "") {
        message.textContent = "Please enter a sentence!";
        return;
    }
    else if (specialCharsRegex.test(lower)) {
        message.textContent = "Special characters And Numbers Are not allowed";
        return;
    }

    if(lower.length < 2){
        message.textContent="Please Enter More Than One Character";
    }
    else if(lower[0] == lower[lower.length -1]){
        message.textContent="The First And Last Letter Are Same";
        message.style.color="green";
    }
    else{
        message.textContent="The First And Last Letter Are Not Same"
    }

}
function reSet(){
    document.getElementById("message").textContent="";
}

