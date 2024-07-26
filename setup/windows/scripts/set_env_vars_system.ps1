# [Environment]::SetEnvironmentVariable('ANDROID_HOME', "$env:LOCALAPPDATA\Android\Sdk", [System.EnvironmentVariableTarget]::Machine)

# $newPath = $env:ANDROID_HOME
# $currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
# [System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$newPath", [System.EnvironmentVariableTarget]::Machine)

# short hand to add to system path
# $env:PATH += ";SomeRandomPath"
