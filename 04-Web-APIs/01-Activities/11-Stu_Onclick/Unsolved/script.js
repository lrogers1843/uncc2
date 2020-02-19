var inc = document.querySelector("#increment")
var dec = document.querySelector("#decrement")
var count = document.querySelector("#count")
countValue = 0;

inc.addEventListener("click", function() {
    countValue = countValue + 1;
    count.textContent = countValue.toString();
})

dec.addEventListener("click", function() {
    if (countValue === 0) {
        count.textContent = countValue.toString() + " Be positive!";
    } else {
        countValue = countValue - 1;
        count.textContent = countValue.toString();
    }
})