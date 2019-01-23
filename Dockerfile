FROM microsoft/dotnet:2.2-sdk-alpine AS build-env
WORKDIR /app

RUN apk update && \
    apk add git && \
    git clone https://github.com/danielpalme/ReportGenerator.git && \
    cd ReportGenerator/src/ReportGenerator.DotnetCliTool && \
    dotnet restore && \
    dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:2.2-runtime-alpine
WORKDIR /app
COPY --from=build-env /app/ReportGenerator/src/ReportGenerator.DotnetCliTool/out .
ENTRYPOINT ["dotnet", "dotnet-reportgenerator.dll"]
