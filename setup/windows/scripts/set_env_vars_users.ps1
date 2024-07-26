[Environment]::SetEnvironmentVariable('ANDROID_HOME', "$env:LOCALAPPDATA\Android\Sdk", [System.EnvironmentVariableTarget]::User)

# $newPath = $env:ANDROID_HOME
# $currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
# [System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$newPath", [System.EnvironmentVariableTarget]::User)

