How to run quay stack on local machine.

I'm using Docker for Mac. For docker-machine, the access from host machine to the container may be different.

1. run cert.sh to setup the TLS

1. Run env.sh to bring up postgres and redis
2. Change your host setting to direct `quay` to 127.0.0.1, and trust the rootCA.pem.
2. Run config.sh to run the config tool, accessable by quay:444
5. Click on generate pre-shared key in security scanner panel, record the KID and the PEM file as `security_scanner.pem`. The URL to clair is `https://clair:6060`
6. Finish other setup in the config tool.
7. In Clairconfig, change config.yaml KID under the jwt proxy to be your recorded one from config tool, and replace the PEM file already in the folder.
8. Start Clair
9. Start Quay
10. To test, post an image, and it should be picked up by the security worker very quickly. 

If jwt says: aud Missing or wrong: check config.yaml in Clair
If clair says: could not download layer blob, check the download link, it's likely that the server host name on Quay is set to something unreachable from Clair instance.
If jwt says: bad baseline, check the TLS setting.
