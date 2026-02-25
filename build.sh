#!/bin/bash

# 1. Limpa a pasta dist para garantir um build do zero
if [ -d "dist" ]; then
    echo "Sending old build to trash..."
    gio trash dist
fi

mkdir -p dist

# 2. Espelha a pasta assets para dentro da dist
# Usamos -r para recursivo
echo "Syncing assets..."
cp -r assets dist/

# 3. Executa o Pandoc
# Note que o caminho do CSS no -c é relativo ao HTML final que estará na dist.
# Como agora a pasta assets estará LÁ DENTRO, o caminho é direto.
echo "Running Pandoc..."
pandoc src/index.md \
    -s \
    --metadata title="3D Resource Library" \
    -c assets/css/style.css \
    --include-in-header=assets/js/script.js \
    -o dist/index.html

echo "✅ Build finalizado com sucesso em /dist!"
