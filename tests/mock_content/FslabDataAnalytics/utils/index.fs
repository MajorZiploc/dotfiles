module FslabDataAnalytics.utils

open System.IO
open System.Collections.Generic

let setFullPaths (fileLocations: Dictionary<string,string>) (dir: string) =
  for entry in fileLocations do
    fileLocations.[entry.Key] <- Path.Combine(dir, entry.Value)

let getCurrentDir (fileName: string) =
  let thisDir = Path.Combine(Directory.GetCurrentDirectory(), "FslabDataAnalytics", fileName)
  thisDir
