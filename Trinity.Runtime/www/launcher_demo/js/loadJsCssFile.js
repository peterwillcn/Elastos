function loadJs(url){
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = url;
    head.appendChild(script);
}
function loadCss(url){
    var head = document.getElementsByTagName('head')[0];
    var link = document.createElement('link');
    link.type='text/css';
    link.rel = 'stylesheet';
    link.href = url;
    head.appendChild(link);
}

function loadFiles() {

    if (navigator.userAgent.indexOf('Android') >1) {
        loadJs("file:///android_asset/www/cordova.js");
    }
    else if (indexOf('iPhone') > -1) {

    }
}

//loadFiles();
