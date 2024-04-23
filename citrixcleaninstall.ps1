# Define the URL of the file to download
$url = 'https://www.citrix.com/downloads/workspace-app/windows/workspace-app-for-windows-latest.html#ctx-dl-eula'

# Use Invoke-WebRequest to get the content of the page
$response = Invoke-WebRequest -Uri $url

# Find the parent element (anchor) containing the span with specific text content
$downloadLinkElement = $response.ParsedHtml.getElementsByTagName('span') | Where-Object { $_.innerText -eq 'Download Citrix Workspace app for Windows' } | ForEach-Object { $_.parentNode }

if ($downloadLinkElement) {
    # Extract the direct download link from the found element
    $downloadLink = $downloadLinkElement.href

    # Set the output file path to the $env:TEMP directory
    $outputFile = Join-Path $env:TEMP 'CitrixWorkspaceApp.exe'

    # Use Invoke-WebRequest to download the file
    Invoke-WebRequest -Uri $downloadLink -OutFile $outputFile

    Write-Host "File downloaded successfully to $outputFile"
} else {
    Write-Host "Download link element not found on the page."
}
