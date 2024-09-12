# Set the shortest keyboard repeat delay (0 is the shortest)
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value 0
# Set the fastest keyboard repeat rate (31 is the fastest i guess)
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed" -Value 100

# to view current property values
# get-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay"
# get-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed"
#
Set-Location "HKCU:\Control Panel\Accessibility\Keyboard Response"

Set-ItemProperty -Path . -Name AutoRepeatDelay       -Value 300
Set-ItemProperty -Path . -Name AutoRepeatRate        -Value 30
Set-ItemProperty -Path . -Name DelayBeforeAcceptance -Value 0
Set-ItemProperty -Path . -Name BounceTime            -Value 0
Set-ItemProperty -Path . -Name Flags                 -Value 47
