fileList = textread('Jrip_Hospital_Case3_4.txt', '%s');

fid = fopen('Rule_Map.txt', 'w');
j=1;
k=1;
fprintf(fid, '@info(name= "FileSourceTestQuery1")\r\n');
fprintf(fid, 'from InputStream [');

for i=0:length(fileList)
    if fileList{k} == "=>class="
        j=j+1;
        k=k+1;
        fprintf(fid, ']\r\n');
        fprintf(fid, 'select *\r\n');
        fprintf(fid, 'insert into ');
        fprintf(fid,fileList{k});
        fprintf(fid, ';\r\n\r\n');
        fprintf(fid, '@info(name= "FileSourceTestQuery');
        fprintf(fid, num2str(j));
        fprintf(fid, '")\r\n');
        fprintf(fid, 'from InputStream [');
        k=k+2;
    else
        fprintf(fid, ' ');
        fprintf(fid,fileList{k});
        k=k+1
    end
    if k > length(fileList)
        break;
    end
end

fclose(fid);