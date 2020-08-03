function locationPlotLL(data, requestedProvider,color)

providerData = [data(:).provider];

indexes = find(strcmp(requestedProvider ,providerData));

latitude = [data(indexes).latitude];
longitude = [data(indexes).longitude];
p = plot(longitude, latitude, '.-');
set(p,'Color',color);