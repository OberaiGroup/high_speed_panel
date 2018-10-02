
function J = read_mm_file( filename)
  file = fopen( filename);

  line_num = 0;
  line_txt = ' ';

  % while not at end of file
  while ~feof( file)
    line_num = line_num + 1;
    line_txt = fgetl( file);
    
    % Get size from second line
    if line_num == 2
      meta_data = str2num( line_txt);
      rows = meta_data( 1);
      cols = meta_data( 2);

      J = zeros( rows, cols);
    end

    % skip first two lines, then read data
    if line_num > 2
      num = str2num( line_txt);

      row = num(1);
      col = num(2);
      data = num(3);

      J(row, col) = data;
    end
  end
  
  fclose( file);
end
