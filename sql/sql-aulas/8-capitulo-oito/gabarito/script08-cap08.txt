# Script 08

SELECT * FROM cap08.TB_INCIDENTES;

# Na tabela cap08.TB_INCIDENTES, coluna IncidntNum, considere os 4 primeiros dígitos como o código local do incidente 
# e os 4 últimos dígitos como o código nacional do incidente
SELECT IncidntNum,
       SUBSTR(IncidntNum, 1, 4) AS local_code,
       SUBSTR(IncidntNum, -4, 4) AS nacional_code
FROM cap08.TB_INCIDENTES;

SELECT IncidntNum,
       SUBSTRING(IncidntNum, 1, 4) AS local_code,
       SUBSTRING(IncidntNum, -4, 4) AS nacional_code
FROM cap08.TB_INCIDENTES;

# Na tabela cap08.TB_INCIDENTES, coluna Address, retorne tudo que estiver até o primeiro espaço (possivelmente o número do endereço)
SELECT Address,
       POSITION(" " IN Address) AS posicao_espaco
FROM cap08.TB_INCIDENTES;

SELECT Address,
       SUBSTR(Address, 1, POSITION(" " IN Address)) AS desc_final
FROM cap08.TB_INCIDENTES;

# Imputação com Replace
SELECT * FROM cap08.TB_MAP_ANIMAL_ZOO;
SELECT REPLACE(id_zoo, 1001, 1007) FROM cap08.TB_MAP_ANIMAL_ZOO;



