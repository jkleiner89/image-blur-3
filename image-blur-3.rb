class ImageBlur
  # initialize
  def initialize(nested_array)
    @image = nested_array
  end
  # output_image
  def output_image
    @image.each do |row|
      row.each do |column|
        print column
      end
      puts
      #STDOUT.flush
    end
  end
  def ones # past ones collected and returned
    coords = []
    @image.each_with_index do |row, row_index|
      row.each_with_index do |position, col_index|
        if position == 1
          coords.push([row_index, col_index]) # row, col
          # a += 10 => a = a + 10
        end
      end
    end
    return coords
  end
  def change_neighbors(coord)
    # given row, col; turn up, down, left, right neighbors to ones respectively
    # returns nothing
    row_index = coord[0]
    col_index = coord[1]
    # 1,1 => 0,1
    # 2,3 => 1,3
    # r,c => r-1,c #up
    if row_index != 0
      @image[row_index - 1][col_index] = 1
    end
    # 1,1 => 2,1
    # 2,3 => 3,3
    # r,c => r+1,c #down
    if row_index != @image.length - 1
      @image[row_index + 1][col_index] = 1
    end
    # 1,1 => 1,0
    # 2,3 => 2,2
    # r,c => r,c-1 #left
    if col_index != 0
      @image[row_index][col_index - 1] = 1
    end
    # 1,1 => 1,2
    # 2,3 => 2,4
    # r,c => r,c+1 #right
    if col_index != @image[0].length - 1
      @image[row_index][col_index + 1] = 1
    end
  end
  # blur
  def blur(iterations)
    # go through the nested array
    # find the ones
      # for each one found, update its neighbors
        # remember the bounds of the image/2d array
    ## Think about having a copy so that your updates dont affect future ones [past vs future]
    iterations.times do
      ones.each do |coord|
        change_neighbors(coord)
      end
    end
  end
end

image = ImageBlur.new([
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0]])
image.output_image
image.blur(2)
puts "After Blur"
image.output_image
