com1 = open("/dev/ttyACM0","r+b");
system(" stty < /dev/ttyACM0 9600")

stream = ""

begin
  loop do
    p stream = com1.read(1)
    sleep 1
  end
ensure
  com1.close
end
