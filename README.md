# ArtifactoryCleaner
This is a simple Docker container to keep a rolling history of artefact versions in Artifactory pruning older
versions each time the container is run. It assumes that semantic versioning is being used.
This is good for both library management as well as container management (just add it to the end of your build process)

## Running
It can be run with a simple

`docker run --env-file sample.env timothyclarke/artifactory-cleaner:latest`


## Usage
From the help text
```
usage: ArtifactoryCleaner [-h] [-a HOST] [-k KEEP] [-r REPO] [-n NAME]
                          [-u USER] [-p PASSWD] [-q]

optional arguments:
  -h, --help            show this help message and exit
  -a HOST, --artifactory-host HOST
                        (ENV Variable: ARTIFACTORY_HOST) Specify the
                        Artifactory host to use (For managed cloud offerings
                        this is typically in the form <account-
                        name>.jfrog.io/<account-name>)
  -k KEEP, --number-to-keep KEEP
                        (ENV Variable: NUMBER_TO_KEEP) Number of Artefacts to
                        Keep
  -r REPO, --repository REPO
                        (ENV Variable: REPOSITORY) Repository where the
                        artrefact resides
  -n NAME, --name NAME  (ENV Variable: ARTEFACT_NAME) Name of the artefact to
                        review
  -u USER, --username USER
                        (ENV Variable: ARTIFACTORY_USERNAME) Artifactory
                        Username with permissions to view and remove
  -p PASSWD, --password PASSWD
                        (ENV Variable: ARTIFACTORY_PASSWORD) Password for
                        Artifactory user
  -q, --quiet           Surpresses deletion messages
```

To use this in a CI process like [CircleCi](https://circleci.com/) code would be something like
```
jobs:
  CleanArtifactory:
    docker:
      - image: timothyclarke/artifactory-cleaner:latest
    environment:
      NUMBER_TO_KEEP: 25
      REPOSITORY=docker-containers
      ARTIFACTORY_USERNAME=my-username
      ARTEFACT_NAME=artifactory-cleaner
      ARTIFACTORY_PASSWORD=my-password
      ARTIFACTORY_HOST=example.jfrog.io/example
    steps:
      - run:
          name: Removing Old Artefacts from Artifactory
          command: /bin/ArtifactoryCleaner
```
Even better if you can add some of the above into contexts
