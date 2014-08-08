# Save and open screenshot
def saos
  save_screenshot("screenshot.png")
  system "display screenshot.png"
  system "rm screenshot.png"
end

def saop
  save_and_open_page
end
