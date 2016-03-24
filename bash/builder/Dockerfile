FROM deis/builder:v1.12.2

ADD ./slugbuilder/Dockerfile /usr/local/src/slugbuilder/Dockerfile
ADD ./slugbuilder/builder/install-buildpacks /usr/local/src/slugbuilder/builder/install-buildpacks
ADD ./slugrunner/Dockerfile /usr/local/src/slugrunner/Dockerfile
ADD ./slugbuilder/buildpacks/ /usr/local/src/slugbuilder/buildpacks

RUN chmod +x /usr/local/src/slugbuilder/builder/install-buildpacks
