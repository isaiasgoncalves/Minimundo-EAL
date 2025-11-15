import anthropic
import pandas as pd
import os
import prompts as pt
from pathlib import Path

"""
Vou organizar agora o esqueleto do nosso script, com o pipeline geral
"""

def data_reading():

    base_dir = Path(__file__).parent.parent
    csv_path = base_dir / 'acidentes2025_todas_causas_tipos.csv'
    df = pd.read_csv(csv_path, encoding='latin1')

    print(df)






if __name__ == "__main__":
    data_reading()