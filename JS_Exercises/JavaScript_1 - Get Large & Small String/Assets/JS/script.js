function largeSmall() {
    let input = document.getElementById("sentence").value.trim().replace(/\s\s+/g, ' ');
    let message = document.getElementById("message");
    let specialCharsRegex = /[^a-zA-Z0-9 ]/g;
    message.style.color = "red"
    if (input === "") {
        message.textContent = "Please enter a sentence!";
        return;
    }
    else if (specialCharsRegex.test(input)) {
        message.textContent = "Special characters not allowed";
        return;
    }
    let words = input.split(/\s+/);
    let largest = words[0];
    let smallest = words[0];

    for (let i = 0; i < words.length; i++) {
        let currentWord = words[i];
        if (words.length < 2) {
            message.textContent = "Please enter more than one word";
            return;
        }
        else if (currentWord.length < smallest.length) {
            smallest = currentWord;
        }
        else if (currentWord.length > largest.length) {
            largest = currentWord;
        }
    }
    if (largest == smallest) {
        message.textContent = "All are equal";
        return;
    }
    message.textContent = "Large-" + largest + " && " + "small-" + smallest;
    message.style.color = "green";
}

function reSet() {
    document.getElementById("sentence").value = " ";
    document.getElementById("message").textContent = "";

}