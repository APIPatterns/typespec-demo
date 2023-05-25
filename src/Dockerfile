#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["WebApi/WebApi.csproj", "WebApi/"]
COPY ["EngSysSdk/EngSysSdk.csproj", "EngSysSdk/"]
RUN dotnet restore "WebApi/WebApi.csproj"
RUN dotnet restore "EngSysSdk/EngSysSdk.csproj"

COPY . .
RUN dotnet build "WebApi/WebApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WebApi/WebApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
ARG BUILDTIME
ARG VERSION
ARG REVISION=*NOREV*
ARG APPNAME=WebApi

WORKDIR /app
COPY --from=publish /app/publish .

ENV APPNAME $APPNAME
RUN echo "echo -e \"Application\t: \$APPNAME\"" >> /root/.bashrc

ENV VERSION $VERSION
RUN echo "echo -e \"Version\t\t: \$VERSION\"" >> /root/.bashrc

ENV REVISION $REVISION
RUN echo "echo -e \"Revision\t: \$REVISION\"" >> /root/.bashrc

ENV BUILDTIME $BUILDTIME
RUN echo "echo -e \"Build time\t: \$BUILDTIME\"" >> /root/.bashrc

ENTRYPOINT ["dotnet", "WebApi.dll"]