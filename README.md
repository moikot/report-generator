# Docker file for ReportGenerator

See more information about [RegportGenerator](https://danielpalme.github.io/ReportGenerator/).

Assuming your Cobertura coverage report is in `./Report` directory, to generate the report you can use:

```shell
docker run -v $(pwd):/Report moikot/report-generator -reports:/Report/coverage.cobertura.xml -targetdir:/Report/Html
```

The generated HTML report should be found in `./Report/Html` directory.
