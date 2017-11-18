# eclipse_j2ee_python_go
Extends my docker build of __Eclipse for Java 2 EE Developers__ accessible via [xpra](https://xpra.org/) to include python, golang, and the docker toolset.

## Features
* The build checks the sha512 signature of the eclipse download to ensure the download mirror hasn't been compromised.
* The eclipse process won't start until an xpra client attaches.  This keeps DPI sane, which is especially important if you have a HighDPI monitor.
* Preinstalls pydev
* Preinstalls goclipse

## Recommended Usage
1. Start the container.
	```bash
	$ docker run --rm -it -p 127.0.0.1:9999:9999 -v eclipse:/opt/eclipse -v ~/workspace:/opt/workspace -v /var/run/docker.sock:/var/run/docker.sock aronahl/eclipse_j2ee
	```
	* The eclipse install will be copied to the eclipse volume.
		* If no eclipse volume exists, it will be created and filled with a copy of eclipse from the image.
		* You'll want to keep the eclipse volume around to persist any updates or package installs between runs.
	* The workspace will exist in a local workspace subdir of your home directory.

2. Attach to tcp:localhost:9999 with an xpra client.

3. Configure go and python.

## Alternative Usage With HTML5 Client

1. Start the container.
	```bash
	$ docker run --rm -it -p 127.0.0.1:9999:9999 -e HTTP=1 -v eclipse:/opt/eclipse -v ~/workspace:/opt/workspace -v /var/run/docker.sock:/var/run/docker.sock aronahl/eclipse_j2ee
	```
	* The eclipse install will be copied to the eclipse volume.
		* If no eclipse volume exists, it will be created and filled with a copy of eclipse from the image.
		* You'll want to keep the eclipse volume around to persist any updates or package installs between runs.
	* The workspace will exist in a local workspace subdir of your home directory.

2. Browse to http://127.0.0.1:9999
3. Reloading the page can help with resizing the workspace and making maximize match your browser window size.
4. Popups will hide behind the main eclipse window.  Use the maximize/roll-up button to get to them.

5. Configure go and python.