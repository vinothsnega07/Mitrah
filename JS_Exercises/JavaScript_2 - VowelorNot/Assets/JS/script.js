function vowelCheck(event)
{
    event.preventDefault();
    var input=document.getElementById("sentence").value.trim();
    var message=document.getElementById("message");
    var specialCharsRegex = /[^a-zA-Z ]/g;
    message.style.color = "red";

    if (input === "") {
        message.textContent = "Please enter a sentence!";
        return;
    }
    else if (specialCharsRegex.test(input)) {
        message.textContent = "Special characters And Numbers Are not allowed";
        return;
    }
    var vowels="aeiouAEIOU";
    var result=[];
    for(var i=0;i<input.length;i++)
    {
        var char=input[i];
        if(input.length < 2){
            message.textContent="Please Enter More Than One Character!"
            return;
        }
        else if(vowels.includes(char) && !result.includes(char))
        {
            result.push(char);
        }
    }
    if(result.length==0)
    {
        message.textContent="No Vowels Found In String";
    }
    else{
        message.textContent="Vowels= "+result.join(" ,");
        message.style.color="green";
    }

}

function reSet(){
    document.getElementById("message").textContent="";
}