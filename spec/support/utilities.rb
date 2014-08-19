# Save and open screenshot
def saos
  save_screenshot("screenshot.png")
  system "display screenshot.png"
  system "rm screenshot.png"
end

def saop
  save_and_open_page
end

# See https://github.com/thoughtbot/formulaic/issues/18
def fast_fill_form(*args)
  using_wait_time 0 do
    fill_form *args
  end
end
