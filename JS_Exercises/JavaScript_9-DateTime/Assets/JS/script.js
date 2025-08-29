function showDateTime(event) {

    event.preventDefault();
    var now = new Date();
    var date = now.getDate();
    var month = now.getMonth() + 1;
    var year = now.getFullYear();
    var hour = now.getHours();
    var minutes = now.getMinutes();
    var seconds = now.getSeconds();
    var milliSeconds = now.getMilliseconds();

    document.getElementById("dataContainer").classList.remove("d-none");
    document.getElementById("year").textContent =  year;
    document.getElementById("month").textContent =  month;
    document.getElementById("date").textContent =  date;
    document.getElementById("hour").textContent = hour;
    document.getElementById("minutes").textContent =  minutes;
    document.getElementById("seconds").textContent =  seconds;
    document.getElementById("milliSeconds").textContent = milliSeconds;
    document.getElementById("local").textContent =  date + "-" + month + "-" + year + " " + hour + ":" + minutes + ":" + seconds;

    var utc = now.toUTCString();
    document.getElementById("result").textContent =  utc;
    document.getElementById("utcMilliSeconds").textContent =  now.getUTCMilliseconds();
    
}

function clearForm() {
    document.getElementById("dataContainer").classList.add("d-none");

}