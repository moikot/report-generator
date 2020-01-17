FROM mcr.microsoft.com/dotnet/core/sdk:3.1.100-alpine AS build-env
WORKDIR /app

RUN apk update && \
    apk add git && \
    git clone https://github.com/danielpalme/ReportGenerator.git && \
    cd ReportGenerator/src/ReportGenerator.DotnetCliTool && \
    dotnet restore && \
    dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/runtime:3.1-alpine
WORKDIR /app
COPY --from=build-env /app/ReportGenerator/src/ReportGenerator.DotnetCliTool/out .
ENTRYPOINT ["dotnet", "dotnet-reportgenerator.dll"]
