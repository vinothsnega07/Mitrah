function getValidNums(event) {
    event.preventDefault();
    var input = document.getElementById("number").value.trim().replace(/\s/g, "").replace(/[, ]+/g, ',');
    var message = document.getElementById("message");
    message.style.color = "red";
    if (input === "") {
        message.textContent = "Please enter a Number!";
        return;
    }
    else if (/[a-zA-Z]/g.test(input)) {
        message.textContent = "Letters  Are not Allowed!";
        return;
    }
    else if (/[^-?\d.,\s ]/g.test(input)) {
        message.textContent = "Special Character Are not Allowed";
        return;
    }
    var parts = input.split(",");
    var nums = [];
    for (var i = 0; i < parts.length; i++) {
        var num = parseFloat(parts[i]);
        if (isNaN(parts[i])) {
            message.textContent = "Special Character Not Allowed";
            return;
        }
        else if (!isNaN(num)) {
            nums.push(num)
        }
    }
    return nums;

}

function additionMultiplication(action) {
    var message = document.getElementById("message");
    var nums = getValidNums(event);
    var sum = 0;
    var product = 1;
    for (var i = 0; i < nums.length; i++) {
        if (nums.length <= 1) {
            message.textContent = "Please Enter Atleast Two Numbers To Validate"
            return;
        }
        else if (action === "addition") {
            sum = sum + nums[i];
            message.textContent = "Sum: " + sum;
            message.style.color = "green";
        }
        else if (action === "multiply") {
            product = product * nums[i];
            message.textContent = "Product: " + product;
            message.style.color = "green";
        }
    }
}

function clearForm() {
    document.getElementById("message").textContent = "";
}
