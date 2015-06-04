require 'file'

class Encrypt

  def initialize
    message = "message.txt"
    message = File.open("sample.txt", "r")
    contents = file.read
    puts contents

    File.open("message.txt").readlines.each do |line|
      puts line

      output = "output.txt"
      output = File.open("output.txt", "w")
      output.puts
      output.close
    end
  end

end

