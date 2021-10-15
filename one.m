background = vision.ForegroundDetector('NumGaussians', 5, ...
    'NumTrainingFrames', 150);


vid = videoinput('winvideo',3,'YUY2_320x240');
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb');
 % vid.FrameGrabInterval = 50;
 start(vid);
 
se = strel('square', 3);
blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, 'MinimumBlobArea', 150, 'ExcludeBorderBlobs', true);

hshapeinsBox = vision.ShapeInserter('BorderColorSource', 'Input port', ... 
                                    'Fill', false, ...
                                    'Opacity', 0.4);





videoPlayer = vision.VideoPlayer('Name', 'Detected Cars');
videoPlayer.Position(3:4) = [650,400];  
 

while (true)

    frame = getsnapshot(vid);

    
    foreground = step(background, frame);

    
    filteredForeground = imopen(foreground, se);

   
    bbox = step(blobAnalysis, filteredForeground);

    
    

   
    numCars = size(bbox, 1);
    
    
  
    
    step(videoPlayer,numCars);
    
 
   
end

