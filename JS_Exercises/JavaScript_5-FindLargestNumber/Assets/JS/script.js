function maxNum(event) {
    event.preventDefault();
    var input = document.getElementById("number").value.trim().replace(/\s/g, "").replace(/[, ]+/g, ',');
    var message = document.getElementById("message");
    
    var letterRegex = /[a-zA-Z ]/g;
    var splCharRegex = /[^a-zA-Z, 0-9 ]/g;
    message.style.color = "red";

    if (input === "") {
        message.textContent = "Please enter a Number!";
        return;
    }
    else if (letterRegex.test(input)) {
        message.textContent = "Letters  Are not Allowed!";
        return;
    }
    else if (splCharRegex.test(input)) {
        message.textContent = "Special Characters Are not Allowed!";
        return;
    }

    var nums = input.split(",");
    if (nums.length <= 1) {
        message.textContent = "Enter Atleast Two Numbers Coma Separated";
        return;
    }
    else if (nums.length > 2) {
        message.textContent = "Only Allowed Two Numbers!";
        return;
    }
    var max = Number(nums[0]);
    var secondMax = Number(nums[1]);
    if (max == secondMax) {
        message.textContent = "Both Are Equal!!";
        message.style.color = "green";
        return;
    }
    else {
        var large = findMaxNum(max, secondMax);
        message.textContent = "Large Number Is: " + large;
        message.style.color = "green";
    }
}

function findMaxNum(max, secondMax) {
    if (max > secondMax) {
        return max;
    }
    else {
        return secondMax;
    }
}

function clearForm() {
    document.getElementById("message").textContent = "";
}

