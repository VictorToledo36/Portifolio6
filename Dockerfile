# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copia apenas o csproj primeiro para otimizar cache
COPY ["Portifolio6.csproj", "./"]

# Restaura dependências
RUN dotnet restore "Portifolio6.csproj"

# Copia o resto do código
COPY . .

# Publica o projeto em Release
RUN dotnet publish "Portifolio6.csproj" -c Release -o /app/publish

# Lista os arquivos publicados para confirmar a DLL
RUN ls -l /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copia os arquivos publicados do build
COPY --from=build /app/publish .

# Expõe portas
EXPOSE 5204
EXPOSE 7037

# Variáveis de ambiente
ENV ASPNETCORE_URLS="http://+:5204;https://+:7037"
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

# Executa a DLL publicada
ENTRYPOINT ["dotnet", "Portifolio6.dll"]
