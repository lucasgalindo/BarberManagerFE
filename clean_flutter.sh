#!/bin/bash

echo "=============================="
echo "🚀 Iniciando limpeza Flutter e sistema..."
echo "=============================="

# 🧹 Limpar build do Flutter
echo "➡️  Limpando build com 'flutter clean'..."
flutter clean

# 🧼 Limpar temporários do usuário (equivalente a %TEMP%)
echo "➡️  Limpando arquivos temporários do usuário..."
rm -rf /c/Users/$USERNAME/AppData/Local/Temp/*

# 🗑️ Limpar temporários do sistema (Cuidado: precisa de permissão!)
echo "➡️  Limpando arquivos temporários do Windows..."
rm -rf /c/Windows/Temp/*

echo "=============================="
echo "✅ Limpeza concluída com sucesso!"
echo "=============================="
