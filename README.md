# Instalando as dependências

## 1. Crie um novo ambiente virtual

```bash
python -m venv bd-venv
```

## 2. Ative o ambiente virtual

- Windows

    ```bash
    bd-venv\Scripts\activate
    ```

- Linux

    ```bash
    source bd-venv/bin/activate
    ```

## 4. Instalando as dependências do requirements.txt

1. Certifique-se de estar no mesmo diretório onde o requirements.txt está localizado.

2. Execute:
    ```bash
    pip install -r requirements.txt
    ```

---

## Instalando cx_Oracle no Windows

tutorial: https://cx-oracle.readthedocs.io/en/latest/user_guide/installation.html#wininstall

- Resumindo: baixe o zip nesse [link](https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html) e extrai no diretório `C:\\oracle\\instantclient_23_6`
- Se alterar o diretório, terá que alterar o caminho no arquivo `db_connection.py`