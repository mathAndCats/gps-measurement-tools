% 
% Parameter	Description
% PRN	Satellite PRN number
% TOVF	Time of Validity for WAAS Fast correction (GPS Time of Week in seconds)
% UDREI	User Differential Range Error Index (0 15)
% UDRE	User Differential Range Error (meters)
% PRCF	Fast Pseudorange Correction + Range-Rate Correction (meters)
% CLKL	Satellite Clock offset Long correction (meters)
% NM	WAAS Not Monitored satellite status (0 = Monitored, 1 = Not Monitored)
% DNU	WAAS Do Not Use satellite status (0 = Usable, 1 = Not Usable)
% TOVL	Time of Validity for WAAS Long correction (GPS Time of Week in seconds)
% XLC	X-axis Satellite Long term Ephemeris correction in WGS-84 ECEF (meters)
% YLC	Y-axis Satellite Long term Ephemeris correction in WGS-84 ECEF (meters)
% ZLC	Z-axis Satellite Long term Ephemeris correction in WGS-84 ECEF (meters)
% EPHML	WAAS SV Ephemeris position correction along the SV to normal user line of sight vector (meters)
% WAASCORR	WAAS SV Range correction along the SV to normal user line of sight vector (meters)
% IODE	WAAS Issue of Data Ephemeris for Satellite Long term Ephemeris correction
% TOA	Time of Applicability for Satellite Long term correction (seconds of day)
% VC	Velocity Code status of Satellite Long term correction Rates (1 = Available)
% LAT	Latitude of satellite over Earth's surface
% LNG	Longitude of satellite over Earth's surface
function outData = readWAAS(dirName,fileName)

fullFileName = fullfile(dirName, fileName);

fid = fopen(fullFileName);
fgetl(fid);

fseek(fid,0,-1);
outIndex=1;
while ~feof(fid)
    line = fgetl(fid);
    if contains(line,'#')
        continue %skip to next line
    end
    %Now 'line' contains the raw measurements header or data
    
    data = strsplit(line,' ');
    outData(outIndex).PRN = str2double(data{1});
    outData(outIndex).TOVF = str2double(data{2});
    outData(outIndex).UDREI = str2double(data{3});
    outData(outIndex).UDRE = str2double(data{4});
    outData(outIndex).PRCF = str2double(data{5});
    outData(outIndex).CLKL = str2double(data{6});
    outData(outIndex).NM = str2double(data{7});
    outData(outIndex).DNU = str2double(data{8});
    outData(outIndex).TOVL = str2double(data{9});
    outData(outIndex).XLC = str2double(data{10});
    outData(outIndex).YLC = str2double(data{11});
    outData(outIndex).ZLC = str2double(data{12});
    outData(outIndex).EPHML = str2double(data{13});
    outData(outIndex).WAASCORR = str2double(data{14});
    outData(outIndex).IODE = str2double(data{15});
    outData(outIndex).TOA = str2double(data{16});
    outData(outIndex).VC = str2double(data{17});
    outData(outIndex).LAT = str2double(data{18});
    outData(outIndex).LNG = str2double(data{19});
    
    outIndex = outIndex + 1;
    
end
fclose(fid);

