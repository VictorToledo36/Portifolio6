# Deploy com certificados para GitHub Pages
Write-Host "=== Deploy Blazor com Certificados ==="

# 1. Compila o projeto
Write-Host "1. Compilando projeto..."
dotnet publish Portifolio6.csproj -c Release -o temp-publish

# 2. Cria pasta temporária
$TempDir = "$env:TEMP\blazor-certificados-$(Get-Random)"
Write-Host "2. Criando pasta temporária..."
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

# 3. Copia arquivos compilados
Write-Host "3. Copiando arquivos..."
Copy-Item -Path "temp-publish\wwwroot\*" -Destination $TempDir -Recurse -Force

# 4. Cria arquivos necessários
New-Item -Path "$TempDir\.nojekyll" -ItemType File -Force | Out-Null
Copy-Item -Path "$TempDir\index.html" -Destination "$TempDir\404.html" -Force

# 5. Commit mudanças atuais
Write-Host "4. Salvando mudanças..."
git add .
git commit -m "Adiciona certificados e estrutura completa" -a 2>$null

# 6. Muda para gh-pages
Write-Host "5. Mudando para gh-pages..."
git checkout gh-pages

# 7. Atualiza arquivos
Write-Host "6. Atualizando site..."
Get-ChildItem -Path . -Exclude ".git" | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item -Path "$TempDir\*" -Destination . -Recurse -Force

# 8. Deploy
Write-Host "7. Fazendo deploy..."
git add .
git commit -m "Deploy com certificados completos - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git push origin gh-pages

# 9. Volta para master
Write-Host "8. Voltando para master..."
git checkout master

# 10. Limpa
Remove-Item -Path "temp-publish" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "✅ Deploy concluído!"
Write-Host "🌐 https://victortoledo36.github.io/Portifolio6/"
Write-Host "📄 Certificados funcionando com PDFs!"
Write-Host "⏱️  Aguarde alguns minutos para atualizar."