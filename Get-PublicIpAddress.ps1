<#
.Synopsis
    Determine Public IP address
.DESCRIPTION
    Queries Bing and Google to determine public IP address of the device which is running the code
.EXAMPLE
    Get-PublicIpAddress
.Outputs
    String containing IPv4 Address
.NOTES
    Robert D. Biddle 6.05.2015
.FUNCTIONALITY
    If you need to know the public IP address which is being used by the device running this code (i.e. NAT is in play), then this should do the trick.
#>
function Get-PublicIpAddress
{
[regex]$regex = '([0-9]{1,3}\.){3}([0-9]{1,3})'
$pageBing = Invoke-WebRequest -Uri "http://www.bing.com/search?q=what+is+my+ip+address"
$pageGoogle = Invoke-WebRequest -Uri "http://www.google.com/search?q=what+is+my+ip+address&num=1" # num parameter limits search results to 1, otherwise the results end up containing other valid IP adddresses.
$resultsFromBing = $($regex.Matches($pageBing.Content).Value)[0]
$resultsFromGoogle = $($regex.Matches($pageGoogle.Content).Value)
if( $resultsFromBing -like $resultsFromGoogle ) 
	{
	$ipAddress = $resultsFromGoogle
	$ipAddress
	}
Else
    {
    $e = "Something broke :( `nBing Results: $($resultsFromBing) `nGoogle Results: $($resultsFromGoogle)"
    Write-Error -Message $e
    }
}
Get-PublicIpAddress
