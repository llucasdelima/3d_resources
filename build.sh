#!/bin/bash

# 1. Validação de segurança: Garante que você está na pasta certa
if [ ! -f "src/index.md" ]; then
    echo "❌ Erro: O arquivo src/index.md não foi encontrado."
    echo "Certifique-se de rodar este script na raiz do projeto."
    exit 1
fi

# 2. Limpeza segura da pasta dist
if [ -d "dist" ]; then
    echo "🗑️  Limpando build antigo (movendo para a lixeira)..."
    gio trash dist
fi

# 3. Preparação do ambiente
echo "📂 Criando pasta dist e copiando assets..."
mkdir -p dist
cp -r assets dist/

# 4. O Build do Pandoc
# --standalone (-s): Para criar o documento HTML completo
# --metadata title: Define o nome da página na aba do navegador
# -c: Aponta para o CSS já dentro da pasta dist
# -o: Define o arquivo de saída
echo "🏗️  Convertendo Markdown para HTML..."
pandoc src/index.md \
    -s \
    --template=src/templates/template.html \
    --metadata title="Recursos Arte 3D" \
    -c assets/css/style.css \
    -o dist/index.html

echo "✅ Build concluído com sucesso!"
echo "🚀 Agora você pode rodar: git add . && git commit -m 'Novo build' && git push"
