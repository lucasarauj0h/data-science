# Módulo de conversão de tipos de dados


# Imports
import numpy as np
import pandas as pd


def convert_to_string(df, columns):
    for col in columns:
        df[col] = df[col].astype("string")


def convert_to_int(df, columns):
    for col in columns:
        df[col] = df[col].astype("int64")


def convert_to_datetime(df, columns):
    for col in columns:
        df[col] = pd.to_datetime(df[col])


def multiply_by_factor(df, columns, factor):
    for col in columns:
        df[col] = df[col] * factor
