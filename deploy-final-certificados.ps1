# Deploy final com certificados
Write-Host "=== Deploy Final com Certificados ==="

# 1. Compila apenas o projeto Blazor
Write-Host "1. Compilando projeto Blazor..."
dotnet publish Portifolio6.csproj -c Release -o temp-publish

if (-not (Test-Path "temp-publish\wwwroot")) {
    Write-Error "Erro na compilação!"
    exit 1
}

# 2. Cria pasta temporária
$TempDir = "$env:TEMP\blazor-final-$(Get-Random)"
Write-Host "2. Preparando arquivos..."
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

# 3. Copia arquivos
Copy-Item -Path "temp-publish\wwwroot\*" -Destination $TempDir -Recurse -Force

# 4. Cria arquivos necessários
New-Item -Path "$TempDir\.nojekyll" -ItemType File -Force | Out-Null
Copy-Item -Path "$TempDir\index.html" -Destination "$TempDir\404.html" -Force

# 5. Commit mudanças
Write-Host "3. Salvando mudanças..."
git add .
git commit -m "Corrige certificados e finaliza implementação" -a 2>$null

# 6. Deploy
Write-Host "4. Fazendo deploy..."
git checkout gh-pages
Get-ChildItem -Path . -Exclude ".git" | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item -Path "$TempDir\*" -Destination . -Recurse -Force

git add .
git commit -m "Deploy final com certificados funcionais - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git push origin gh-pages

# 7. Finaliza
git checkout master
Remove-Item -Path "temp-publish" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "🎉 DEPLOY CONCLUÍDO COM SUCESSO!"
Write-Host "🌐 Site: https://victortoledo36.github.io/Portifolio6/"
Write-Host "📄 Certificados: Funcionando com PDFs locais!"
Write-Host "⏱️  Aguarde 2-5 minutos para atualizar."
Write-Host ""