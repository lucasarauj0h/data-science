class Brasileirao():
    def __init__(self, df_initial):
        import pandas as pd
        import numpy as np
        
        df_adjusted = df_initial
        
        #`data` field conversion from object to datetime
        df_adjusted['data'] = pd.to_datetime(df_adjusted['data'], dayfirst=True)

        #Creation of a new feature `temporada`
        df_adjusted['temporada'] = df_adjusted['data'].dt.year

        conditions = [(df_adjusted['data'].dt.year == 2003),
                       (df_adjusted['data'].dt.year == 2004),
                       (df_adjusted['data'].dt.year == 2005),
                       (df_adjusted['data'].dt.year == 2006),
                       (df_adjusted['data'].dt.year == 2007),
                       (df_adjusted['data'].dt.year == 2008),
                       (df_adjusted['data'].dt.year == 2009),
                       (df_adjusted['data'].dt.year == 2010),
                       (df_adjusted['data'].dt.year == 2011),
                       (df_adjusted['data'].dt.year == 2012),
                       (df_adjusted['data'].dt.year == 2013),
                       (df_adjusted['data'].dt.year == 2014),
                       (df_adjusted['data'].dt.year == 2015),
                       (df_adjusted['data'].dt.year == 2016),
                       (df_adjusted['data'].dt.year == 2017),
                       (df_adjusted['data'].dt.year == 2018),
                       (df_adjusted['data'].dt.year == 2019),
                       (df_adjusted['data'].between('2020-01-01', '2021-02-28')),
                       (df_adjusted['data'].between('2021-05-20', '2021-12-31')),
                       (df_adjusted['data'].dt.year == 2022),
                       (df_adjusted['data'].dt.year == 2023)]

        values = list(range(2003, 2024))

        df_adjusted['temporada'] = np.select(conditions, values)

        #Drop columns that will not be used in next analysis
        column_drop = ['hora', 'formacao_mandante', 'formacao_visitante', 'tecnico_mandante', 'tecnico_visitante',
                       'arena']

        df_adjusted = df_adjusted.drop(column_drop, axis=1)

        #Creation of columns related to points earned for a match
        points_conditions = [(df_adjusted['vencedor'] == df_adjusted['mandante']),
                             (df_adjusted['vencedor'] == df_adjusted['visitante']),
                             (df_adjusted['vencedor'] == '-')]

        #Points for home team
        point_values_1 = [3, 0, 1]
        df_adjusted['pontos_mandante'] = np.select(points_conditions, point_values_1)

        #Points for away team
        point_values_2 = [0, 3, 1]
        df_adjusted['pontos_visitante'] = np.select(points_conditions, point_values_2)
        
        df_unique = df_adjusted

        ## Create a new Dataframe containing clubs in only one column (information regarding home and away team is lost in this process) 
        # Adjusting column names for concat
        sup_tab1_br = df_unique[
            ['rodata', 'mandante', 'mandante_Placar', 'visitante_Placar', 'pontos_mandante', 'temporada']]
        sup_tab2_br = df_unique[
            ['rodata', 'visitante', 'visitante_Placar', 'mandante_Placar', 'pontos_visitante', 'temporada']]

        #Renaming columns to match enomeando as colunas  para poder fazer o concat
        sup_tab1_br = sup_tab1_br.rename(columns={'mandante':'clube', 'mandante_Placar':'gols', 'visitante_Placar':'gols_adversario', 'pontos_mandante':'pontos'})
        sup_tab2_br = sup_tab2_br.rename(columns={'visitante':'clube', 'visitante_Placar':'gols', 'mandante_Placar': 'gols_adversario', 'pontos_visitante':'pontos'})

        #Concatenating for Dataframe creationriando o concat
        sup_table_br = pd.concat([sup_tab1_br, sup_tab2_br], ignore_index=True)

        #Self properties definition
        self.df_inicial = df_initial
        self.df_pontos = df_adjusted
        self.df_unico = sup_table_br


    def Tabela(self, year):
        import pandas as pd
        #Applying a filter by year on df_unico dataset
        df_table = self.df_unico.loc[self.df_unico['temporada'] == year]

        #Determining the distinct list of clubs that played in that season
        clubs = df_table['clube'].unique()

        #Creating features for table creation? points, played, won, drawn, lost, goals for, goals against, goal difference
        pontos = []
        partidas = []
        vitorias = []
        empates = []
        derrotas = []
        gols_pro = []
        gols_contra = []
        saldo = []
    
        for time in clubs:
            pontos.append(df_table['pontos'].loc[df_table['clube'] == time].sum())
            partidas.append(df_table['pontos'].loc[df_table['clube'] == time].count())
            vitorias.append(df_table['clube'].loc[
                                (df_table['pontos'] == 3) & (df_table['clube'] == time)].count())
            empates.append(df_table['clube'].loc[
                               (df_table['pontos'] == 1) & (df_table['clube'] == time)].count())
            derrotas.append(df_table['clube'].loc[
                                (df_table['pontos'] == 0) & (df_table['clube'] == time)].count())
            gols_pro.append(df_table['gols'].loc[df_table['clube'] == time].sum())
            gols_contra.append(df_table['gols_adversario'].loc[df_table['clube'] == time].sum())
            saldo.append(df_table['gols'].loc[df_table['clube'] == time].sum() -
                        df_table['gols_adversario'].loc[df_table['clube'] == time].sum())


        dict_tabela = {'clube': clubs, 'pontos': pontos, 'partidas': partidas, 'vitorias': vitorias,
                       'empates': empates, 'derrotas': derrotas, 'gols_pro': gols_pro, 'gols_contra': gols_contra,
                       'saldo': saldo}

        tabela = pd.DataFrame.from_dict(dict_tabela)

        #`Suporte` column create to consider brazilian rules and priorization on points matches won and goal difference
        tabela['suporte'] = tabela['pontos'] + (tabela['vitorias'] / 100) + (tabela['saldo'] / 10000)

        tabela = tabela.sort_values('suporte', ascending=False, ignore_index=True)
        return tabela.drop(['suporte'], axis=1)



    def Clubes(self, year):
        import pandas as pd
        # Applying a filter by year on df_unico dataset
        df_table = self.df_unico.loc[self.df_unico['temporada'] == year]

        # Determining the distinct list of clubs that played in that season
        clubs = df_table['clube'].unique()

        clubs = pd.DataFrame(clubs, columns=['clube'])

        return clubs


    def Clubes_geral(self):
        import pandas as pd
        # Applying a filter by year on df_unico dataset
        df_table = self.df_unico

        # Determining the distinct list of clubs that played in that season
        clubs = df_table['clube'].unique()

        clubs = pd.DataFrame(clubs, columns=['clube'])

        return clubs


    def Classificacao(self, year, club):
        import pandas as pd
        # Applying a filter by year on df_unico dataset
        df_table = self.df_unico.loc[self.df_unico['temporada'] == year]

        # Determining the distinct list of clubs that played in that season
        clubs = df_table['clube'].unique()

        # Creating features for table creation? points, played, won, drawn, lost, goals for, goals against, goal difference
        pontos = []
        partidas = []
        vitorias = []
        empates = []
        derrotas = []
        gols_pro = []
        gols_contra = []
        saldo = []

        for time in clubs:
            pontos.append(df_table['pontos'].loc[df_table['clube'] == time].sum())
            partidas.append(df_table['pontos'].loc[df_table['clube'] == time].count())
            vitorias.append(df_table['clube'].loc[
                                (df_table['pontos'] == 3) & (df_table['clube'] == time)].count())
            empates.append(df_table['clube'].loc[
                               (df_table['pontos'] == 1) & (df_table['clube'] == time)].count())
            derrotas.append(df_table['clube'].loc[
                                (df_table['pontos'] == 0) & (df_table['clube'] == time)].count())
            gols_pro.append(df_table['gols'].loc[df_table['clube'] == time].sum())
            gols_contra.append(df_table['gols_adversario'].loc[df_table['clube'] == time].sum())
            saldo.append(df_table['gols'].loc[df_table['clube'] == time].sum() -
                         df_table['gols_adversario'].loc[df_table['clube'] == time].sum())

        dict_tabela = {'clube': clubs, 'pontos': pontos, 'partidas': partidas, 'vitorias': vitorias,
                       'empates': empates, 'derrotas': derrotas, 'gols_pro': gols_pro, 'gols_contra': gols_contra,
                       'saldo': saldo}

        tabela = pd.DataFrame.from_dict(dict_tabela)

        # `Suporte` column create to consider brazilian rules and priorization on points matches won and goal difference
        tabela['suporte'] = tabela['pontos'] + (tabela['vitorias'] / 100) + (tabela['saldo'] / 10000)

        tabela = tabela.sort_values('suporte', ascending=False, ignore_index=True)
        tabela = tabela.drop(['suporte'], axis=1)

        indices = tabela.loc[tabela['clube']==club].index.values

        return (pd.to_numeric(indices) + 1)



    def Guardiola(self,year):
        import pandas as pd
        # Applying a filter by year on df_unico dataset
        df_table = self.df_unico.loc[self.df_unico['temporada'] == year]

        # Determining the distinct list of clubs that played in that season
        clubs = df_table['clube'].unique()

        pontos = []

        primeiras = range(1,9)
        ultimas = range(31,39)
        rodadas_16 = list(range(1,9))+list(range(31,39))

        df_table_prim8 = df_table.loc[(df_table['temporada']==year) & (df_table['rodata'].isin(primeiras))]
        df_table_ult8 =df_table.loc[(df_table['temporada']==year) & (df_table['rodata'].isin(ultimas))]
        df_table_16 = df_table.loc[(df_table['temporada']==year) & (df_table['rodata'].isin(rodadas_16))]
        df_table_final =df_table.loc[(df_table['temporada']==year)]


        for time in clubs:
            pontos.append(df_table_prim8['pontos'].loc[df_table_prim8['clube'] == time].sum())

        dict_tabela_prim8 = {'clube': clubs, 'pontos': pontos}

        tabela_prim8 = pd.DataFrame.from_dict(dict_tabela_prim8).sort_values('pontos', ascending=False).reset_index(drop=True)


        pontos = []
        for time in clubs:
            pontos.append(df_table_ult8['pontos'].loc[df_table_ult8['clube'] == time].sum())

        dict_tabela_ult8 = {'clube': clubs, 'pontos': pontos}

        tabela_ult8 = pd.DataFrame.from_dict(dict_tabela_ult8).sort_values('pontos', ascending=False).reset_index(drop=True)


        # pontos = []
        # for time in clubs:
        #     pontos.append(df_table_16['pontos'].loc[df_table_16['clube'] == time].sum())
        #
        # dict_tabela_16 = {'clube': clubs, 'pontos': pontos}
        #
        # tabela_16 = pd.DataFrame.from_dict(dict_tabela_16).sort_values('pontos', ascending=False).reset_index(drop=True)


        pontos = []
        for time in clubs:
            pontos.append(df_table_final['pontos'].loc[df_table_final['clube'] == time].sum())

        dict_tabela_final = {'clube': clubs, 'pontos': pontos}

        tabela_final = pd.DataFrame.from_dict(dict_tabela_final).sort_values('pontos', ascending=False).reset_index(drop=True)


        return [tabela_prim8, tabela_ult8, tabela_final]
