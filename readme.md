Credit Card Finder
==================

A Powershell script for discovering clear text credit cards on a Windows machine. The script has the following features:

Features
--------

- It searches all files recursively in the provided path in a memory efficient way
- Credit card numbers are validated using the Luhn algorithm to reduce false positives
- The script reads files upto 25mb in size to minimise its usage of system resources. Larger files are reported in the output for manual review.
- File formats tested and supported:
	- Text files
	- PDF documents (text is parsed using the awesome [iTextSharp](http://sourceforge.net/projects/itextsharp/), no OCR is performed)
	- Excel worksheets (requires Excel to be installed on the system)
- File formats expected to be supported in the future:
	- Zipped archives
	- Office documents
	- Note: Warning is thrown when these documents are encountered

Usage
-----

1. Open a Powershell commandlet
2. Clone the repository using `git clone https://github.com/jksdua/credit-card-finder`
3. Enter the directory using `cd credit-card-finder`
4. Ensure you have execution permissions by running `Get-ExecutionPolicy`. It **should be** `Unrestricted`. See [Execution Policy](#execution-policy) for more details.
5. Execute the script using `.\credit-card-finder.ps1 -path C:\path\to\dir`. Path can be relative or absolute.

> Run the script with Administrator privileges for best results.

![Output screenshot](./screenshot.png)

Troubleshooting
---------------

### Execution Policy

The script requires your user account to have execution permissions. This can be checked by running `Get-ExecutionPolicy`.

![Execution policy status](./execution-policy-status.png)

If this value is not set to `Unrestricted`, you will see an error similar to below:

![Execution policy error](./execution-policy-error.png)

Change this setting temporarily to `Unrestricted` by running `Set-ExecutionPolicy Unrestricted -Scope CurrentUser`. ** You will need administrative privileges on the machine to do this. **

Once the script has finished, make sure to run `Set-ExecutionPolicy <original value>` to reset it to its original state, otherwise you'll be lowering the security of your machine.

Issues
------

This script is currently in alpha stage.

- It uses `Write-Host` to output colored console output. Unfortunately, this breaks file output using redirection. This will be fixed in a future release.

Future
------

- It would be great to port this to other platforms such as Linux and OSX.

Changelog
---------

### 2014-03-14
- Removed recursive function making the library stable enough to be used on larger systems without much memory usage
- To stabilise the library, file size is now restricted to 25mb. 

### 2014-01-07
- Initial commit
- Basic support for common file types