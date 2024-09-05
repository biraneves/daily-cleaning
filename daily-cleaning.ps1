# Define the paths to work with
$downloadsPath = "$env:USERPROFILE\Downloads"

# Function to empty a folder
function Empty-Folder {
    param (
        [string]$folderPath
    )
    try {
        # Get all files and directories in the specified folder
        $items = Get-ChildItem -Path $folderPath -Recurse

        foreach ($item in $items) {
            if ($item.PSIsContainer) {
                # Delete folders
                Remove-Item -Path $item.Fullname -Recurse -Force
            } else {
                # Delete files
                Remove-Item -Path $item.Fullname -Force
            }
        }
        Write-Host "Folder '$folderPath' has been emptied."
    } catch {
        Write-Host "An error occurred while emptying the folder: $_"
    }
}

# Confirmation prompt for user
$confirmation = Read-Host "This script will empty your Downloads folder. Are you sure you want to proceed? (y/N)"
if ($confirmation -ne 'Y' -and $confirmation -ne 'y') {
    Write-Host "Operation cancelled."
    exit
}

# Empty the Downloads folder
Write-Host "Emptying the Downloads folder..."
Empty-Folder -folderPath $downloadsPath

Write-Host "Folder Downloads has been emptied."