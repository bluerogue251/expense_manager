# Save and open screenshot
def saos
  save_screenshot("screenshot.png")
  system "display screenshot.png"
  system "rm screenshot.png"
end
