# Portfólio Blazor WebAssembly

Este é um projeto de portfólio desenvolvido em Blazor WebAssembly.

## 🌐 Site Online

O site está disponível em: **https://victortoledo36.github.io/Portifolio6/**

## 🚀 Deploy para GitHub Pages

Para fazer o deploy do projeto para o GitHub Pages, execute o script:

```powershell
.\deploy-final-certificados.ps1
```

Este script irá:
1. Compilar o projeto em modo Release
2. Criar os arquivos necessários para o GitHub Pages (.nojekyll, 404.html)
3. Fazer o deploy para o branch `gh-pages`
4. Limpar arquivos temporários

## 📋 Pré-requisitos

- .NET 8.0 SDK
- Git configurado
- PowerShell

## 🛠️ Desenvolvimento Local

Para executar o projeto localmente:

```bash
dotnet run
```

## 📁 Estrutura do Projeto

- `Pages/` - Páginas Razor do portfólio
- `Layout/` - Layout principal da aplicação
- `wwwroot/` - Arquivos estáticos (CSS, imagens, etc.)
- `deploy-final-certificados.ps1` - Script de deploy para GitHub Pages

## ⚠️ Importante

- O arquivo `.nojekyll` é essencial para o funcionamento no GitHub Pages
- O arquivo `404.html` permite o roteamento SPA funcionar corretamente
- Aguarde 2-5 minutos após o deploy para o site atualizar