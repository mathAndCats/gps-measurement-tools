function outData = readLocation(dirName,fileName)

fullFileName = fullfile(dirName, fileName);

fid = fopen(fullFileName);

line = fgetl(fid);

entryCount = 0;
while ~feof(fid)
    line = fgetl(fid);
    if ~contains(line,'Fix,') || contains(line,'#')
        continue %skip to next line
    else
        entryCount = entryCount + 1;
    end
end

outData.provider = '';
outData.latitude = 0;
outData.longitude = 0;
outData.latitude = 0;
outData.altitude = 0;
outData.speed = 0;
outData.bearing = 0;
outData.horizontalAccuracy = 0;
outData.verticalAccuracy = 0;
outData.speedAccuracy = 0;
outData.bearingAccuracy = 0;
outData.time = 0;
outData = repmat(outData,1,entryCount);

fseek(fid,0,-1);
outIndex=1;
while ~feof(fid)
    line = fgetl(fid);
    if ~contains(line,'Fix,') || contains(line,'#')
        continue %skip to next line
    end
    %Now 'line' contains the raw measurements header or data
    line = strrep(line,'Raw,','');
    line = strrep(line,'#',''); line = strrep(line,' ','');%remove '#' and spaces
    
    data = strsplit(line,',');
    outData(outIndex).provider = data(2);
    outData(outIndex).latitude = str2double(data(3));
    outData(outIndex).longitude = str2double(data(4));
    outData(outIndex).altitude = str2double(data(5));
    outData(outIndex).speed = str2double(data(6));
    outData(outIndex).bearing = str2double(data(7));
    outData(outIndex).horizontalAccuracy = str2double(data(8));
    outData(outIndex).verticalAccuracy = str2double(data(9));
    outData(outIndex).speedAccuracy = str2double(data(10));
    outData(outIndex).bearingAccuracy = str2double(data(11));
    outData(outIndex).time = str2double(data(12));
    
    outIndex = outIndex + 1;
    
end
fclose(fid);

