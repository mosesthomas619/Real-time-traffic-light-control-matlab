
background1 = vision.ForegroundDetector('NumGaussians', 5,'AdaptLearningRate', true,'NumTrainingFrames',10 , 'LearningRate', 0.005);
background2 = vision.ForegroundDetector('NumGaussians', 5,'AdaptLearningRate', true,'NumTrainingFrames',10 , 'LearningRate', 0.005);

 a=arduino();
 writeDigitalPin(a,9,1);
 writeDigitalPin(a,12,1);

cam1 = imaqhwinfo;
cameraName1 = char(cam1.InstalledAdaptors(end));
cameraId1 = 4;
cameraFormat1 = char('YUY2_640x480');


cam2 = imaqhwinfo;
cameraName2 = char(cam2.InstalledAdaptors(end));
cameraId2 = 3;
cameraFormat2 = char('YUY2_640x480');



vidDevice1 = imaq.VideoDevice(cameraName1, cameraId1, cameraFormat1, ... 
                    'ReturnedColorSpace', 'RGB');
                
vidDevice2 = imaq.VideoDevice(cameraName2, cameraId2, cameraFormat2, ... 
                    'ReturnedColorSpace', 'RGB');                
 


 se = strel('square', 1);

  blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, 'MinimumBlobArea', 300 ,'ExcludeBorderBlobs', true);

counta=0;countb=0;countc=0;




while (true)

    
     frame1 =  step(vidDevice1);
     frame2 =  step(vidDevice2);
    
     
     
   
    foreground1 = step(background1, frame1);
    foreground2 = step(background2, frame2);
    
    

    
    filteredForeground1 = imopen(foreground1, se);
    filteredForeground2 = imopen(foreground2, se);
    

    
    bbox1 = step(blobAnalysis, filteredForeground1);
    bbox2 = step(blobAnalysis, filteredForeground2);
    

    
    result1 = insertShape(frame1, 'Rectangle', bbox1, 'Color', 'red');
    result2 = insertShape(frame2, 'Rectangle', bbox2, 'Color', 'red');
    

   
    numCars1 = size(bbox1, 1);
    numCars2 = size(bbox2, 1);
    
    
    
    result1 = insertText(result1, [10 10], numCars1, 'BoxOpacity', 1, ...
        'FontSize', 14);
    result2 = insertText(result2, [10 10], numCars2, 'BoxOpacity', 1, ...
        'FontSize', 14);
    
    
    
      x = figure; set(x,'Position',[180 200 600 500]); imshow(result1); title('Detected Cars in area A');
      y = figure; set(y,'Position',[1100 200 600 500]); imshow(result2); title('Detected Cars in area B');
      
      
   if(numCars1 > numCars2)
     countb=0;countc=0;  
     counta=counta+1; 
     if(counta>2)
       if(numCars2>0)
        counta=0; 
   writeDigitalPin(a,12,0); 
   writeDigitalPin(a,10,1); 
   pause(10.0);
   writeDigitalPin(a,10,0); 
   writeDigitalPin(a,11,1); 
   pause(2.0); 
   writeDigitalPin(a,11,0); 
   writeDigitalPin(a,12,1); 
       end
     end    
  writeDigitalPin(a,9,0); %red off
   writeDigitalPin(a,8,1); %green on
   pause(10.0);
   writeDigitalPin(a,8,0); %green off
   writeDigitalPin(a,7,1); %yellow on
   pause(2.0); 
   writeDigitalPin(a,7,0); %yellow off
   writeDigitalPin(a,9,1); %red on
   end
   
   
   
    if(numCars2 > numCars1)
       
     counta=0;countc=0;
     countb=countb+1; 
      if(countb>2)
         if(numCars1>0)
           countb=0; 
            writeDigitalPin(a,9,0); %red off
            writeDigitalPin(a,8,1); %green on
            pause(10.0);
            writeDigitalPin(a,8,0); %green off
            writeDigitalPin(a,7,1); %yellow on
            pause(2.0); 
            writeDigitalPin(a,7,0); %yellow off
            writeDigitalPin(a,9,1); %red on
         end 
      end    
     writeDigitalPin(a,12,0); %red off
     writeDigitalPin(a,10,1); %green on
     pause(10.0);
     writeDigitalPin(a,10,0); %green off
     writeDigitalPin(a,11,1); %yellow on
     pause(2.0); 
     writeDigitalPin(a,11,0); %yellow off
     writeDigitalPin(a,12,1); %red on
   end
  
  
  
    if(numCars1 == numCars2)
        if(numCars1>0 && numCars2>0)
          counta=0;countb=0;
          countc=countc+1;
          if(countc==2)
             writeDigitalPin(a,12,0); %red off
             writeDigitalPin(a,10,1); %green on
             pause(10.0);
            writeDigitalPin(a,10,0); %green off
            writeDigitalPin(a,11,1); %yellow on
            pause(2.0); 
            writeDigitalPin(a,11,0); %yellow off
            writeDigitalPin(a,12,1); %red on
          end
     writeDigitalPin(a,9,0); %red off
     writeDigitalPin(a,8,1); %green on
     pause(10.0);
     writeDigitalPin(a,8,0); %green off
     writeDigitalPin(a,7,1); %yellow on
     pause(2.0); 
     writeDigitalPin(a,7,0); %yellow off
     writeDigitalPin(a,9,1); %red on
        end
     
   end
  
   
   pause(5.0);
    
   
end
























 
 
 




 