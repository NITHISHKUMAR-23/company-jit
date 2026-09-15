fetch("/audio_list")

.then(response => response.json())

.then(files => {


    let list = document.getElementById("audioList");


    files.forEach(function(file){


        let item = document.createElement("li");

        item.innerHTML = file;

        list.appendChild(item);


    });


});