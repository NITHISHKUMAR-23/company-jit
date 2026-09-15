// =========================================
// Global Variables
// =========================================

let shuffle = false;

const audioList = document.getElementById("audioList");

const folder = document.getElementById("folder");

const currentFile = document.getElementById("currentFile");

const statusText = document.getElementById("status");

const progress = document.getElementById("progress");

const time = document.getElementById("time");

const equalizerBars = document.querySelectorAll("#equalizer span");


// =========================================
// Utility
// =========================================

function startEqualizer() {

    equalizerBars.forEach(bar => {

        bar.style.animationPlayState = "running";

    });

}

function stopEqualizer() {

    equalizerBars.forEach(bar => {

        bar.style.animationPlayState = "paused";

    });

}

function formatTime(t){

    if(!t)
        return "00:00";

    let h = t.hours || 0;
    let m = t.minutes || 0;
    let s = t.seconds || 0;

    if(h>0){

        return (
            String(h).padStart(2,'0') + ":" +
            String(m).padStart(2,'0') + ":" +
            String(s).padStart(2,'0')
        );

    }

    return (
        String(m).padStart(2,'0') + ":" +
        String(s).padStart(2,'0')
    );

}


// =========================================
// Load Audio Files
// =========================================

async function loadAudioFiles(){

    const response = await fetch("/audio");

    const files = await response.json();

    audioList.innerHTML = "";

    files.forEach(file=>{

        let option = document.createElement("option");

        option.text = file;

        option.value = file;

        audioList.add(option);

    });

}


// =========================================
// Refresh Folder
// =========================================

async function refreshFolder(){

    await fetch("/refresh");

    loadAudioFiles();

}


// =========================================
// Load Folder
// =========================================

async function loadFolder(){

    await fetch("/folder",{

        method:"POST",

        headers:{
            "Content-Type":"application/json"
        },

        body:JSON.stringify({

            folder:folder.value

        })

    });

    loadAudioFiles();

}


// =========================================
// Play
// =========================================

async function play(){

    if(audioList.selectedIndex==-1){

        alert("Select audio file.");

        return;

    }

    const file = audioList.value;

    await fetch("/play",{

        method:"POST",

        headers:{
            "Content-Type":"application/json"
        },

        body:JSON.stringify({

            file:file

        })

    });

    startEqualizer();

}


// =========================================
// Pause
// =========================================

async function pause(){

    await fetch("/pause",{

        method:"POST"

    });

}


// =========================================
// Stop
// =========================================

async function stop(){

    await fetch("/stop",{

        method:"POST"

    });

    stopEqualizer();

    progress.value = 0;

    time.innerHTML = "00:00 / 00:00";

}


// =========================================
// Next
// =========================================

async function next(){

    const response = await fetch("/next",{

        method:"POST"

    });

    const result = await response.json();

    if(result.success){

        highlight(result.file);

    }

}


// =========================================
// Previous
// =========================================

async function previous(){

    const response = await fetch("/previous",{

        method:"POST"

    });

    const result = await response.json();

    if(result.success){

        highlight(result.file);

    }

}


// =========================================
// Repeat
// =========================================

async function repeat(mode){

    await fetch("/repeat",{

        method:"POST",

        headers:{
            "Content-Type":"application/json"
        },

        body:JSON.stringify({

            mode:mode

        })

    });

}


// =========================================
// Shuffle
// =========================================

async function toggleShuffle(){

    shuffle = !shuffle;

    await fetch("/shuffle",{

        method:"POST",

        headers:{
            "Content-Type":"application/json"
        },

        body:JSON.stringify({

            enable:shuffle

        })

    });

    document.getElementById("shuffleBtn").innerHTML =
        shuffle ? "Shuffle ON" : "Shuffle OFF";

}


// =========================================
// Highlight Current Song
// =========================================

function highlight(file){

    for(let i=0;i<audioList.options.length;i++){

        if(audioList.options[i].value===file){

            audioList.selectedIndex=i;

            break;

        }

    }

}


// =========================================
// Update Status
// =========================================

async function updateStatus(){

    const response = await fetch("/status");

    const status = await response.json();

    currentFile.innerHTML =
        status.current_file || "--";

    statusText.innerHTML =
        status.state;

    progress.value =
        status.percentage || 0;

    time.innerHTML =
        formatTime(status.time)
        +
        " / "
        +
        formatTime(status.totaltime);

    if(status.state==="playing"){

        startEqualizer();

    }
    else{

        stopEqualizer();

    }

}


// =========================================
// Events
// =========================================

document.getElementById("playBtn")
.addEventListener("click",play);

document.getElementById("pauseBtn")
.addEventListener("click",pause);

document.getElementById("stopBtn")
.addEventListener("click",stop);

document.getElementById("nextBtn")
.addEventListener("click",next);

document.getElementById("previousBtn")
.addEventListener("click",previous);

document.getElementById("refreshBtn")
.addEventListener("click",refreshFolder);

document.getElementById("browseBtn")
.addEventListener("click",loadFolder);

document.getElementById("normalBtn")
.addEventListener("click",()=>repeat(0));

document.getElementById("repeatOneBtn")
.addEventListener("click",()=>repeat(1));

document.getElementById("repeatAllBtn")
.addEventListener("click",()=>repeat(2));

document.getElementById("shuffleBtn")
.addEventListener("click",toggleShuffle);


// =========================================
// Auto Refresh
// =========================================

loadAudioFiles();

updateStatus();

setInterval(updateStatus,1000);