import json
from pathlib import Path
from score import get_score

def ler_todos_jsons(caminho_pasta):
    """
    Lê todos os arquivos .json em uma pasta e retorna uma lista 
    contendo os objetos Python desserializados.
    """
    caminho = Path(caminho_pasta)
    resultados = {}
    
    # Itera sobre todos os arquivos que correspondem ao padrão "*.json"
    for arquivo_json in caminho.glob('*.json'):
        print(f"Lendo: {arquivo_json.name}")

        col = arquivo_json.name[6:-5]
        
        # Abre o arquivo com encoding 'utf-8' para leitura
        with open(arquivo_json, 'r', encoding='utf-8') as f:
            # Usa json.load() para ler o objeto do arquivo e adicionar à lista
            dados = json.load(f)
            resultados[col] = dados
            
    return resultados

def encontrar_focos(dicionarios_temas):
    focos = {}
    for col in dicionarios_temas.keys():
        for dicionario in dicionarios_temas[col]:
            foco = dicionario[col]
            for tema in dicionario['aulas']:
                if tema in focos.keys():
                    if not foco in focos[tema]:
                        focos[tema].append(foco)
                else:
                    focos[tema] = [foco]

    return focos

def calcular_relevancia(focos):
    lista_score = get_score("Fase 2/data/acidentes2025_todas_causas_tipos.csv")
    dicionario_score = {}
    for tup in lista_score:
        dicionario_score[tup[0]] = tup[1]
    
    print(dicionario_score)

    dicionario_relevancia = {}

    for tema in focos.keys():
        relevancia = 0

        lista_focos = focos[tema]
        lista_focos = sorted(lista_focos, key=lambda x: dicionario_score[x], reverse=True)

        for foco in lista_focos:
            relevancia += dicionario_score[foco]

        dicionario_relevancia[tema] = {}

        dicionario_relevancia[tema]["relevancia"] = relevancia

        for i in range(min(len(lista_focos), 3)):
            dicionario_relevancia[tema][f"foco_{i+1}"] = lista_focos[i]

    return dicionario_relevancia

def pipeline_relevancia():
    resultados = ler_todos_jsons("Fase 2/outputs")
    focos = encontrar_focos(resultados)
    dicionario_relevancia = calcular_relevancia(focos)

    return dicionario_relevancia