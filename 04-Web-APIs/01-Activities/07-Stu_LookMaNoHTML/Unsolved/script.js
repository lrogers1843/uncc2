var headerOne = document.createElement("h1");
var headerTwo = document.createElement("h2");
var image = document.createElement("img");
var caption = document.createElement("p");


headerOne.textContent = "Header One";
document.body.appendChild(headerOne);
headerOne.setAttribute("style", "text-align:center")

headerTwo.textContent = "Header Two";
document.body.appendChild(headerTwo);
headerTwo.setAttribute("style", "text-align:center")

image.setAttribute("src", "https://cdn.pixabay.com/photo/2015/02/24/15/41/dog-647528__340.jpg")
document.body.appendChild(image);
image.setAttribute("style", "display:block;margin-left:auto;margin-right:auto;width:50%")

var li1 = document.createElement("li");
li1.textContent = "Grapes";
var li2 = document.createElement("li");
li2.textContent = "Apples";

var ul = document.createElement("ul");
ul.appendChild(li1);
ul.appendChild(li2);
document.body.appendChild(ul);
ul.style.textAlign = "center"
ul.style.listStylePosition = "inside";