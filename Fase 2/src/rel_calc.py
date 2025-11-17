import json
from pathlib import Path
from score import get_score

def ler_todos_jsons(caminho_pasta: str) -> dict:
    """
    Lê todos os jsons de uma pasta e retorna um dicionario de dicionarios com os resultados.

    Args:
        caminho_pasta (str): Caminho da pasta

    Returns:
        dict: Dicionario com os resultados
    """
    caminho = Path(caminho_pasta)
    resultados = {}
    
    # Itera sobre todos os arquivos que correspondem ao padrão "*.json"
    for arquivo_json in caminho.glob('*.json'):
        print(f"Lendo: {arquivo_json.name}")

        col = arquivo_json.name[6:-5]
        
        # Abre o arquivo com encoding 'utf-8' para leitura
        with open(arquivo_json, 'r', encoding='utf-8') as f:
            # Usa json.load() para ler o objeto do arquivo e adicionar ao dicionario
            dados = json.load(f)
            resultados[col] = dados
            
    return resultados

def encontrar_focos(dicionarios_temas: dict) -> dict:
    """
    Transforma o dicionario que diz para cada foco quais são os temas em um dicionario que diz para cada tema quais são os focos.

    Args:
        dicionarios_temas (dict): Dicionario com os temas de cada foco

    Returns:
        dict: Dicionario com os focos de cada tema
    """
    # Inicializa o dicionario
    focos = {}

    for col in dicionarios_temas.keys():
        for dicionario in dicionarios_temas[col]:
            # Seleciona o foco usando o seu dicionario
            foco = dicionario[col]
            for tema in dicionario['aulas']:
                # Para cada tema, se o tema já estiver no dicionario, insere o foco na lista de focos daquele tema
                if tema in focos.keys():
                    if not foco in focos[tema]:
                        focos[tema].append(foco)
                # Se não estiver no dicionario, cria a lista de focos daquele tema
                else:
                    focos[tema] = [foco]

    # Retorna o dicionario
    return focos

def calcular_relevancia(focos: dict) -> dict:
    """
    Calcula a relevância de cada tema, a relevância é a soma das proporções de ocorrências de cada foco

    Args:
        focos (dict): Dicionario que para cada tema, retorna a lista de focos.

    Returns:
        dict: Dicionario, que para cada tema, retorna a relevância e os 3 focos com mais ocorrências
    """
    # Calcula as ocorrências de cada foco
    lista_score = get_score("Fase 2/data/acidentes2025_todas_causas_tipos.csv")

    # Converte para dicionario
    dicionario_score = {}
    for tup in lista_score:
        dicionario_score[tup[0]] = tup[1]

    # Inicializa o dicionario
    dicionario_relevancia = {}

    # Para cada tema, inicializa a relevancia como 0
    for tema in focos.keys():
        relevancia = 0

        # Ordena os focos pelas ocorrências
        lista_focos = focos[tema]
        lista_focos = sorted(lista_focos, key=lambda x: dicionario_score[x], reverse=True)

        # Para cada foco, incrementa a relevância
        for foco in lista_focos:
            relevancia += dicionario_score[foco]

        # Inicializa o dicionario do tema e insere a relevancia
        dicionario_relevancia[tema] = {}
        dicionario_relevancia[tema]["relevancia"] = relevancia

        # Adiciona os 3 focos com mais ocorrências, se houverem
        for i in range(min(len(lista_focos), 3)):
            dicionario_relevancia[tema][f"foco_{i+1}"] = lista_focos[i]

    return dicionario_relevancia

def pipeline_relevancia() -> dict:
    """
    Chama todas as funções do módulo

    Returns:
        dict: Resultado da função calcular_relevancia
    """
    resultados = ler_todos_jsons("Fase 2/outputs")
    focos = encontrar_focos(resultados)
    dicionario_relevancia = calcular_relevancia(focos)

    return dicionario_relevancia