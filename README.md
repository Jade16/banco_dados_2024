## Instalando as dependências

### 1. Crie um novo ambiente virtual

```bash
python -m venv bd-venv
```

### 2. Ative o ambiente virtual

- Windows

    ```bash
    bd-venv\Scripts\activate
    ```

- Linux

    ```bash
    source bd-venv/bin/activate
    ```

### 4. Instalando as dependências do requirements.txt

1. Certifique-se de estar no mesmo diretório onde o requirements.txt está localizado.

2. Execute:
    ```bash
    pip install -r requirements.txt
    ```

---

## Instalando Oracle Instant Client no Linux

O `cx_Oracle` requer o Oracle Instant Client, que pode ser baixado do [site oficial da Oracle](https://www.oracle.com/database/technologies/instant-client.html).

- Baixe o pacote zip correspondente.

### 1. Instalando o zip

- Extraia o arquivo em um diretório, por exemplo:

```bash
mkdir -p ~/oracle_instantclient
unzip instantclient-basic-linux.x64-*.zip -d ~/oracle_instantclient
```

OBS: troque o * pela versão que você baixou

- Navegue até o diretório criado:

```bash
cd ~/oracle_instantclient/instantclient_*
```

OBS: Troque o * pela versão que você baixou (a pasta vai ter o nome instantclient_<versão>), dê um `ls ~/oracle_instantclient` pra não ter erro

### 2. Configure o `LD_LIBRARY_PATH`

- Adicione o diretório do Oracle Instant Client à variável de ambiente LD_LIBRARY_PATH

```bash
export LD_LIBRARY_PATH=~/oracle_instantclient/instantclient_*:$LD_LIBRARY_PATH
```

- Para tornar permanente:

```bash
echo 'export LD_LIBRARY_PATH=~/oracle_instantclient/instantclient_*:$LD_LIBRARY_PATH' >> ~/.bashrc
```

OBS: Não esqueça de trocar o * pela versão que você baixou!!!

---

## Instalando Oracle Instant Client no Windows

tutorial: https://cx-oracle.readthedocs.io/en/latest/user_guide/installation.html#wininstall

- Resumindo: baixe o zip nesse [link](https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html) e extrai no diretório `C:\\oracle\\instantclient_23_6`
- Se alterar o diretório, terá que alterar o caminho no arquivo `db_connection.py`

---

## Rodando a Aplicação

1. Certifique de ter ativado o ambiente virtual

- Windows

    ```bash
    bd-venv\Scripts\activate
    ```

- Linux

    ```bash
    source bd-venv/bin/activate
    ```

2. Inicie a aplicação:

```bash
python3 ./src/Main.py
```

OBS: No linux pode ser que demore um pouco para carregar hihi :)
