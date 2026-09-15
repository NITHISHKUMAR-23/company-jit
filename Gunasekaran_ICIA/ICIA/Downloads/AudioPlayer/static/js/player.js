// =========================================
// Global Variables
// =========================================

let shuffle = false;

const audioList = document.getElementById("audioList");

const folder = document.getElementById("folder");

const currentFileLabel = document.getElementById("currentFile");

const statusText = document.getElementById("status");

const progress = document.getElementById("progress");

const time = document.getElementById("time");

const equalizerBars = document.querySelectorAll("#equalizer span");

let currentStatus = {};

const playButton = document.getElementById("playBtn");

const pauseButton = document.getElementById("pauseBtn");

const stopButton = document.getElementById("stopBtn");

const nextButton = document.getElementById("nextBtn");

const previousButton = document.getElementById("previousBtn");

//------------------------------------------------------
// Player State
//------------------------------------------------------

let currentFile = "";

let playerState = "stopped";

let kodiConnected = false;

let refreshTimer = null;

let equalizerTimer = null;

// =========================================
// Utility
// =========================================

//------------------------------------------------------
// Auto Refresh
//------------------------------------------------------

function startStatusMonitor() {

    if (refreshTimer !== null)
        return;

    refreshTimer = setInterval(function(){

        updateStatus();

    },1000);

}

function stopStatusMonitor() {

    if (refreshTimer == null)
        return;

    clearInterval(refreshTimer);

    refreshTimer = null;

}


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
    document.getElementById("fileCount").innerHTML = files.length;
    audioList.innerHTML = "";

    files.forEach(file=>{

        let option = document.createElement("option");

        option.text = file;

        option.value = file;
        option.ondblclick = function(){
        play();
        };

        audioList.add(option);

    });

}


// =========================================
// Refresh Folder
// =========================================

async function refreshFolder(){

    await fetch("/refresh");

    await loadAudioFiles();

    updateStatus();

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

    await loadAudioFiles();

    updateStatus();

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
    highlight(file);
    updateStatus();
    startEqualizer();

}


// =========================================
// Pause
// =========================================

async function pause(){

    await fetch("/pause",{

        method:"POST"

    });

    updateStatus();

}


// =========================================
// Stop
// =========================================

async function stop(){

    await fetch("/stop",{

        method:"POST"

    });
    updateStatus();
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
    updateStatus();
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
    updateStatus();
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
    updateRepeatButtons(mode);
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

    currentStatus = status;

    currentFileLabel.innerHTML =
        status.current_file || "--";

    statusText.innerHTML =
        status.state;

    progress.value =
        currentStatus.percentage || 0;

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
    playerState = status.state;
    updatePlayPauseButton();

    currentFile = status.current_file;
    highlight(currentFile);

//    kodiConnected = status.kodi_connected;
    kodiConnected = true;

    updateButtons();

    updateConnection();
}

function updateButtons() {

    playButton.disabled =
        playerState === "playing";

    pauseButton.disabled =
        playerState === "stopped";

    stopButton.disabled =
        playerState === "stopped";

    nextButton.disabled =
        !kodiConnected;

    previousButton.disabled =
        !kodiConnected;

}

function updatePlayPauseButton() {

    if (playerState === "playing") {

        pauseButton.innerHTML = "⏸ Pause";

    }

    else if (playerState === "paused") {

        pauseButton.innerHTML = "▶ Resume";

    }

    else {

        pauseButton.innerHTML = "⏸ Pause";

    }

}

function updateConnection() {

    const label =
        document.getElementById("connection");

    if (kodiConnected) {

        label.innerHTML =
            "🟢 Kodi Connected";

    }

    else {

        label.innerHTML =
            "🔴 Kodi Disconnected";

    }

}

function showError(message) {

    console.error(message);
    statusText.innerHTML = message.toString();

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

window.onload = function () {

    loadAudioFiles();

    updateStatus();

    startStatusMonitor();

};