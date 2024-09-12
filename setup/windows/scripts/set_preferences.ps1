# Set the shortest keyboard repeat delay (0 is the shortest)
Set-ItemProperty -Path 'HKCU:\Control Panel\Keyboard' -Name "KeyboardDelay" -Value 0
# Set the fastest keyboard repeat rate (2 is the fastest)
Set-ItemProperty -Path 'HKCU:\Control Panel\Keyboard' -Name "KeyboardSpeed" -Value 2

# to view current property values
# get-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay"
# get-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed"
