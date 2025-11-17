import psycopg2
from rel_calc import pipeline_relevancia

def atualizar_colunas():
    """
    Atualiza a coluna da dimensão tema no dw
    """
    # Calcula a relevancia
    dicionario_relevancia = pipeline_relevancia()

    # Conecta no dw
    conn = psycopg2.connect(dbname="josethevez")
    conn.autocommit = True
    cursor = conn.cursor()
    cursor.execute("SET search_path TO dw_eal;")

    # Prepara os comandos de alteração de tabela
    TABELA_NOME = 'DimTema'
    comandos_sql_add_colunas = [
        f"ALTER TABLE {TABELA_NOME} ADD COLUMN IF NOT EXISTS relevancia REAL;",
        f"ALTER TABLE {TABELA_NOME} ADD COLUMN IF NOT EXISTS foco_1 TEXT;",
        f"ALTER TABLE {TABELA_NOME} ADD COLUMN IF NOT EXISTS foco_2 TEXT;",
        f"ALTER TABLE {TABELA_NOME} ADD COLUMN IF NOT EXISTS foco_3 TEXT;"
    ]

    # Executa os comandos de alteração de tabela
    for sql_command in comandos_sql_add_colunas:
        cursor.execute(sql_command)

    conn.autocommit = False

    for tema, dados in dicionario_relevancia.items():
        # Garantir que mesmo focos opcionais ausentes tenham um valor (ex: None)
        # para que o psycopg2 possa tratá-los como NULL no SQL
        valores = {
            'relevancia': dados.get('relevancia'),
            'foco_1': dados.get('foco_1'),
            'foco_2': dados.get('foco_2'),
            'foco_3': dados.get('foco_3'),
            'tema_chave': tema  # O tema que será usado no WHERE
        }

        # Comando SQL de UPDATE parametrizado
        comando_update = f"""
            UPDATE {TABELA_NOME}
            SET
                relevancia = %(relevancia)s,
                foco_1 = %(foco_1)s,
                foco_2 = %(foco_2)s,
                foco_3 = %(foco_3)s
            WHERE
                TemaNome = %(tema_chave)s;
        """
        
        # Executa os comandos de update para cada tema
        cursor.execute(comando_update, valores)

    # Commita e encerra a conexão
    conn.commit()

    cursor.close()
    conn.close()

# TODO: MOVER PARA MAIN
atualizar_colunas()