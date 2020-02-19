var images = document.querySelectorAll("img");

// images[0].setAttribute("alt", "www.google.com");
// images[0].setAttribute("src", "https://www.google.com/logos/dna.gif");
// images[1].setAttribute("alt", "www.google.com");
// images[1].setAttribute("src", "https://www.google.com/logos/dna.gif");
// images[2].setAttribute("alt", "www.google.com");
// images[2].setAttribute("src", "https://www.google.com/logos/dna.gif");


alert(images.length)

for (var i = 0; i < images.length; i++) {
    images[i].setAttribute("alt", "www.google.com");
    images[i].setAttribute("src", "https://www.google.com/logos/dna.gif");
}