# Caminho do projeto e pasta de publicação
$ProjectPath = ".\Portifolio6.csproj"
$PublishFolder = ".\bin\Release\net8.0\publish\wwwroot"

# Compila o projeto
dotnet publish $ProjectPath -c Release -o $PublishFolder

# Muda para o branch gh-pages
git checkout gh-pages

# Copia os arquivos compilados
# Remove arquivos antigos
Get-ChildItem -Path . -Exclude ".git" | Remove-Item -Recurse -Force

# Copia arquivos do publish
Copy-Item -Path "$PublishFolder\*" -Destination "." -Recurse

# Commit e push
git add .
git commit -m "Atualização do site Blazor"
git push origin gh-pages

# Volta para o branch principal
git checkout main
