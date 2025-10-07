# Caminho do projeto e pasta de publica��o
$ProjectPath = ".\Portifolio6.csproj"
$PublishFolder = ".\bin\Release\net8.0\publish"

# Compila o projeto em Release
dotnet publish $ProjectPath -c Release -o $PublishFolder

# Salva o branch atual (master ou main)
$CurrentBranch = git branch --show-current
Write-Host "Branch atual: $CurrentBranch"

# Cria branch gh-pages local se n�o existir
if (-not (git rev-parse --verify gh-pages 2>$null)) {
    git checkout --orphan gh-pages
    git rm -rf . | Out-Null
    git commit --allow-empty -m "Inicializando gh-pages"
    git push -u origin gh-pages
    git checkout $CurrentBranch
}

# Cria uma pasta tempor�ria para copiar os arquivos do gh-pages
$TempGhPages = "$env:TEMP\ghpages_temp"

if (Test-Path $TempGhPages) { Remove-Item $TempGhPages -Recurse -Force }
New-Item -ItemType Directory -Path $TempGhPages

# Clona o branch gh-pages para a pasta tempor�ria
git clone --branch gh-pages --single-branch . $TempGhPages

# Limpa arquivos antigos dentro da pasta tempor�ria (exceto .git)
Get-ChildItem -Path $TempGhPages -Exclude ".git" | Remove-Item -Recurse -Force

# Copia os arquivos compilados do publish para a pasta tempor�ria
Copy-Item -Path "$PublishFolder\*" -Destination $TempGhPages -Recurse -Force

# Vai para a pasta tempor�ria e faz commit + push
Push-Location $TempGhPages
git add .
git commit -m "Atualiza��o do site Blazor" -a
git push origin gh-pages
Pop-Location

Write-Host "Publica��o conclu�da! Branch $CurrentBranch preservado, gh-pages atualizado."
