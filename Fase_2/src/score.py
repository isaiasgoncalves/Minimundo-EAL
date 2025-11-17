import pandas as pd


def get_score(caminho: str) -> list[tuple[str, float]]:
    """
    
    Reads CSV, calculates relative score for each fact, 
    creates tuples with  them
        
    Args:
            caminho (str): Path to the explored CSV file .

    Returns:
            list: List of tuples in the format ('column.fact',  calculated score.)
        """
    
    data = pd.read_csv(caminho, encoding='latin-1', sep=";")

    data_cleaned = data.dropna()

    data_cleaned = data_cleaned[data_cleaned["ano_fabricacao_veiculo"]>0]
    important_col = [ "causa_acidente", "tipo_acidente", "classificacao_acidente", "estado_fisico", "condicao_metereologica"]

    dicionario_score =[]
    for col in important_col:
        dicionario_score_cat = (data_cleaned.groupby(col)['id'].count()/data_cleaned.shape[0]).to_dict()
        dicionario_score_cat =sorted(dicionario_score_cat.items(), key=lambda item:item[1], reverse=True)
        
        dicionario_score_cat = [(f"{elem[0]}", elem[1]) for elem in dicionario_score_cat]
        dicionario_score+=dicionario_score_cat

    return dicionario_score

