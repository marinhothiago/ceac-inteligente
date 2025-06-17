FROM node:18-slim

WORKDIR /app

# Copia apenas o package.json (não copiamos o lockfile gerado no Windows)
COPY package.json ./

# Instala as dependências (ignorando as opcionais, se necessário)
RUN yarn install --ignore-optional

# Cria um dummy para o módulo nativo problemático
RUN mkdir -p node_modules/@rollup/rollup-linux-x64-gnu && \
    echo "module.exports = {};" > node_modules/@rollup/rollup-linux-x64-gnu/index.js

# Copia o restante dos arquivos do projeto
COPY . .

EXPOSE 5173

CMD ["yarn", "dev"]