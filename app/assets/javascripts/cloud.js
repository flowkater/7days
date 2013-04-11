var o1 = {
  textFont: 'Arial, Helvetica, sans-serif', maxSpeed: 0.05, minSpeed: 0.01,
  textColour: '#900', textHeight: 25, outlineMethod: 'colour',
  outlineColour: '#039', outlineOffset: 0, depth: 2.5, minBrightness: 0.2,
  wheelZoom: true, reverse: true, shadowBlur: 2, shuffleTags: true,
  shadowOffset: [1,1], stretchX: 1.7, initial: [0,0.1], zoom: 0.8
};

var o = {
  textFont: 'Arial, Helvetica, sans-serif', maxSpeed: 0.05, minSpeed: 0.01,
  textColour: '#900', textHeight: 25, outlineMethod: 'colour',
  outlineColour: '#039', outlineOffset: 0, depth: 0.98, minBrightness: 0.2,
  wheelZoom: true, reverse: true, shadowBlur: 2, shuffleTags: true,
  shadowOffset: [1,1], stretchX: 1.7, initial: [0,0.1], zoom: 0.8
};

$(document).ready(function(){
  if(!$('#mainCanvas').tagcanvas(o1,'todos')) {
    $('#mainCanvasContainer').hide();
  }
});


// {
//      minSpeed: 0.01,
//     textColour: '#ff0000',
//     outlineColour: '#ff00ff',
//     reverse: true,
//     depth: 0.8,
//     maxSpeed: 0.05,
//     initial: [0,0.1],
//     wheelZoom: false
//   }

