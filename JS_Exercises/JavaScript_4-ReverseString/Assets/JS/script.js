function reverseString(event) {
    event.preventDefault();
    var input = document.getElementById("sentence").value.trim();
    var message = document.getElementById("message");
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
    else if (input.length < 2){
        message.textContent = "Please Enter More Than One Character!"
        return;
    }

    var result = "";
    for (var i = input.length - 1; i >= 0; i--) {
        
        var ch = input[i];
        result = result + ch;
        message.textContent = "Reverse String=" + result;
        message.textContent.color = "green";
        
    }

}

function clearForm() {
    document.getElementById("message").textContent = "";
}