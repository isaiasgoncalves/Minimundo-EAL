import pandas as pd
from pathlib import Path
from dotenv import load_dotenv
import json
import anthropic
import os
import json
import ast

"""
Tratamento de dados
"""

path = Path(__file__).parent / 'acidentes2025_todas_causas_tipos.csv'
df = pd.read_csv(path, encoding='latin1', sep=";")
df = df.dropna()
df["ano_fabricacao_veiculo"] = df["ano_fabricacao_veiculo"]>0

# Obtendo a chave de API
envpath = Path(__file__).parent.parent / ".env"
load_dotenv(dotenv_path=envpath)
API_KEY = os.getenv("ANTHROPIC_API_KEY")
client = anthropic.Anthropic(api_key=API_KEY)

# Obtendo uma lista com os temas de aula
temas_path = Path(__file__).parent / "temas_aulas.json"

with open(temas_path, 'r', encoding='utf-8') as t:
    aulas = json.load(t)

temas_aula = []
for aula in aulas:
    temas_aula.append(aula["tema_aula"])


# Colunas a serem avaliadas
important_col = ["causa_acidente",
                 "tipo_acidente", 
                 "classificacao_acidente", 
                 "estado_fisico", 
                 "condicao_metereologica"]

# Função principal
def classificar_colunas(df: pd.DataFrame, nome_coluna:str):

    print(f"Rodando para {nome_coluna}")

    values_list = list(df[nome_coluna].unique())
    values = []

    for i, item in enumerate(values_list):

        print(f"Rodando para {item}")

        base_prompt = f"""
                Você é um sistema de categorização de conteúdo, projetado para operar como uma API.

                ## Tarefa
                Sua tarefa é receber dois parâmetros:
                1.  `{nome_coluna}`: Uma string descrevendo a características de um acidente de trânsito.
                2.  `lista_de_temas`: Uma lista de strings contendo temas de aulas de autoescola.

                Sua única função é analisar a `{nome_coluna}` e filtrar a `lista_de_temas`, retornando uma nova lista que contenha **apenas** os temas da lista original que são relevantes para prevenir ou entender a causa fornecida.

                ## Regras de Saída (Obrigatórias)
                1.  Retorne **exclusivamente** um bloco de código Python.
                2.  O bloco de código deve conter **apenas** a declaração da variável `temas`.
                3.  Os nomes dos temas na lista de saída devem ser **idênticos** (maiúsculas, minúsculas e acentos) aos da `lista_de_temas` de entrada.
                4.  Não inclua **nenhum** texto, explicação, saudação, comentário ou qualquer conteúdo antes ou depois do bloco de código.

                ## Exemplo de Execução

                ### Input Exemplo:
                `{nome_coluna}` = "Atropelamento de pedestre na faixa"
                lista_de_temas = ["Direção Defensiva", "Sinalização de Trânsito", "Mecânica Básica", "Processo de Habilitação e Documentação"]

                ### Output Exemplo (Sua resposta deve ser *apenas* isso):
                ```python
                temas = ["Direção Defensiva", "Sinalização de Trânsito"]         
                ```
              """


        prompt = base_prompt + f"\n**{nome_coluna}:**{item}\n**Lista de temas de aula**{temas_aula}"

        message = client.messages.create(
            model='claude-haiku-4-5',
            max_tokens=1000,
            messages=[{"role":"user", "content":prompt}]
        )

        text = str(message.content[0].text)
        first = text.find("[")
        second = text.find("]")

        # Obtendo a lista retornada
        aulas =  ast.literal_eval(text[first:second+1])
        
        print(aulas)

        causa_dict = {
            "id" : i + 1,
            f"{nome_coluna}" : item,
            "aulas" : aulas
        }

        values.append(causa_dict)

    # Salvando o JSON com os dados
    output_path = Path(__file__).parent / f"outputs/temas_{nome_coluna}.json"
    # Criar a pasta se não existir
    output_path.parent.mkdir(parents=True, exist_ok=True)

    print(f"Salvando para {nome_coluna}")

    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(values, f, ensure_ascii=False, indent=2)

for coluna in important_col:
    classificar_colunas(df, coluna)
