SELECT * FROM ibm_hr_analytics;

# Nota-se um problema de decodificação da coluna Age
# Descrevendo as colunas para colar o nome 'ï»¿Age' e assim altera-lo
DESCRIBE ibm_hr_analytics;

# Alterando nome da coluna age
ALTER TABLE ibm_hr_analytics
CHANGE ï»¿Age Age int;

# Verificando os departamentos e quantidade de funcionários por setor
SELECT Department AS Departamento,
		COUNT(*) AS Funcionarios
FROM IBM_HR_Analytics
GROUP BY Departamento;

# Analisando taxa de atrito por departamento
SELECT Department AS Departamento,
		COUNT(*) AS Funcionarios,
        SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Funcionario_Atrito,
        CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics
GROUP BY Departamento
ORDER BY Taxa_Atrito DESC;

# Verificando a média de satisfação por departamento com atrito e sem atrito
SELECT 
    Department AS Departamento,
    Attrition AS Atrito, 
    ROUND(AVG(JobSatisfaction),2) Trabalho,
	ROUND(AVG(EnvironmentSatisfaction),2) Ambiente,
	ROUND(AVG(RelationshipSatisfaction),2) Relacionamento
FROM IBM_HR_Analytics
GROUP BY Atrito, Department
ORDER BY Department;

# Verificando a média salarial por departamento com atrito e sem atrito
SELECT 
    Department AS Departamento,
    Attrition AS Atrito, 
	ROUND(AVG(MonthlyIncome), 2) AS Media_Salarial,
	MAX(MonthlyIncome) AS Maior_Salario,
	MIN(MonthlyIncome) AS Menor_Salario
FROM IBM_HR_Analytics
GROUP BY Departamento, Atrito
ORDER BY Departamento;

WITH Salaries AS (
    SELECT 
        Department AS Departamento,
        Attrition AS Atrito,
        ROUND(AVG(MonthlyIncome), 2) AS Media_Salarial
    FROM ibm_hr_analytics
    GROUP BY Departamento, Atrito
)

# Diferença salarial em % por 
SELECT 
    Department AS Departamento,
    'No' AS Atrito,
    ROUND(AVG(CASE WHEN Attrition = 'No' THEN MonthlyIncome END), 2) AS Media_Salarial_No,
    'Yes' AS Atrito,
    ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END), 2) AS Media_Salarial_Yes,
    ROUND(((AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END) - AVG(CASE WHEN Attrition = 'No' THEN MonthlyIncome END)) / AVG(CASE WHEN Attrition = 'No' THEN MonthlyIncome END)) * 100, 2) AS Diferenca_Percentual
FROM IBM_HR_Analytics
GROUP BY Departamento
ORDER BY Diferenca_Percentual;

# Aqueles que deixaram a empresa ('Atrittion = yes') tem uma media salarial menor do que aqueles que se manteram na empresa.
# No caso mais extremo, no departamento de Human Resources essa diferença chegou a ser próximo de 50% a menos entre aqueles que deixaram a empresa.

# Verificando o aumento percentual de salário do funcionario por departamento com atrito e sem atrito
SELECT 
    Department AS Departamento,
    Attrition AS Atrito, 
    ROUND(AVG(PercentSalaryHike), 2) AS Média_Aumento_Salarial,
    MIN(PercentSalaryHike) AS Menor_Aumento_Salarial,
    MAX(PercentSalaryHike) AS Maior_Aumento_Salarial
FROM IBM_HR_Analytics
GROUP BY Departamento, Atrito
ORDER BY Departamento;


# Verificando a horas extras dos funcionarios por departamento onde os funcionarios deixaram a empresa
SELECT 
    Department AS Departamento,
    OverTime AS Horas_Extras,
    COUNT(*) AS Total_Funcionarios,
    ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (PARTITION BY Department), 2) AS Percentual_Funcionarios
FROM 
    IBM_HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY Department, OverTime
ORDER BY Percentual_Funcionarios;

# Verificando a horas extras dos funcionarios por departamento onde os funcionarios se manteram na empresa
SELECT 
    Department AS Departamento,
    OverTime AS Horas_Extras,
    COUNT(*) AS Total_Funcionarios,
    ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (PARTITION BY Department), 2) AS Percentual_Funcionarios
FROM 
    IBM_HR_Analytics
WHERE Attrition = 'no'
GROUP BY Department, OverTime
ORDER BY Percentual_Funcionarios;

# Verificando departamentos e quantidade de funcionários por setor
SELECT
	Department AS Departamento,
	JobRole AS Cargo,
	JobLevel,
	COUNT(1) AS Total_Funcionarios,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics
GROUP BY Department, JobRole, JobLevel
ORDER BY Department, JobRole, JobLevel;

# Análise por departamento da variável 'JobInvolvement'
SELECT 
	Department AS Departamento,
	JobInvolvement,
	CONCAT(ROUND(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER(PARTITION BY Department) * 100, 2), '%') AS '%_Envolvimento',
	COUNT(*) AS Total_Funcionarios,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
	CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics
GROUP BY Department, JobInvolvement
ORDER BY Department, JobInvolvement;

# Análise de Gênero
SELECT 
    Gender AS Genero,
    COUNT(*) AS Total_Funcionarios,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics
GROUP BY Gender
ORDER BY Taxa_Atrito DESC;

# Análise de Idade
SELECT
	MIN(Age) Idade_Minima,
	MAX(Age) Idade_Maxima,
	ROUND(AVG(Age), 0) Media
FROM
	IBM_HR_Analytics;


# Taxa de atrito por faixa etária
SELECT 
    Faixa_Etaria,
    COUNT(*) AS 'Total_Funcionarios',
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS Taxa_Atrito
FROM (
    SELECT 
        CASE 
            WHEN Age BETWEEN 18 AND 29 THEN '18-29'
            WHEN Age BETWEEN 30 AND 39 THEN '30-39'
            WHEN Age BETWEEN 40 AND 49 THEN '40-49'
            WHEN Age BETWEEN 50 AND 59 THEN '50-59'
            ELSE '60+'
        END AS Faixa_Etaria,
        Age,
        Attrition
    FROM 
        IBM_HR_Analytics
) AS Subquery
GROUP BY Faixa_Etaria
ORDER BY Faixa_Etaria;

# Atrito entre Estado Civil e Viagens
SELECT 
    BusinessTravel,
    MaritalStatus,
    COUNT(*) AS Total_Funcionarios,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics
GROUP BY BusinessTravel, MaritalStatus
ORDER BY BusinessTravel, MaritalStatus;

# Verificando as Distâncias de Casa e Taxa de Atrito
SELECT 
    Distancia,
    COUNT(*) AS Total_Funcionarios,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(FORMAT((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2'), '%') AS Taxa_Atrito
FROM (
	SELECT
		CASE
			WHEN DistanceFromHome BETWEEN 1 AND 5 THEN '1-5'
			WHEN DistanceFromHome BETWEEN 6 AND 10 THEN '6-10'
			WHEN DistanceFromHome BETWEEN 11 AND 15 THEN '11-15'
			WHEN DistanceFromHome BETWEEN 16 AND 20 THEN '16-20'
			WHEN DistanceFromHome BETWEEN 21 AND 25 THEN '21-25'
			WHEN DistanceFromHome BETWEEN 26 AND 29 THEN '26-29'
		END AS Distancia,
		DistanceFromHome,
		Attrition
	FROM IBM_HR_Analytics
) AS Subquery
GROUP BY Distancia
ORDER BY CONVERT(SUBSTRING_INDEX(Distancia, '-', 1), SIGNED);

# Análise da Educação

# Criando tabela para Educação
CREATE TABLE Education (
    EducationLevel INT PRIMARY KEY,
    EducationDescription VARCHAR(50)
);

INSERT INTO Education (EducationLevel, EducationDescription)
VALUES
    (1, 'Below College'),
    (2, 'College'),
    (3, 'Bachelor'),
    (4, 'Master'),
    (5, 'Doctor');

SELECT * FROM Education;

# Consulta Educação
SELECT 
    E.EducationDescription AS Educacao,
    COUNT(*) AS Total_Funcionarios,
	ROUND(AVG(MonthlyIncome), 2) AS Media_Salarial,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics AS HR
INNER JOIN Education AS E 
	ON HR.Education = E.EducationLevel
GROUP BY E.EducationDescription, E.EducationLevel
ORDER BY E.EducationLevel;

# Taxa de Atrito relacionado ao nº de treinamentos
SELECT  
	TrainingTimesLastYear, 
	COUNT(*) AS Total_Funcionarios,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics
GROUP BY TrainingTimesLastYear
ORDER BY TrainingTimesLastYear;

# Taxa de Atrito Relacionado aos Anos de Empresa
SELECT 
    AnosNaEmpresa,
    COUNT(*) AS Total_Funcionarios,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM (
    SELECT
        CASE
            WHEN YearsAtCompany BETWEEN 0 AND 5 THEN '00-05'
            WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '06-10'
            WHEN YearsAtCompany BETWEEN 11 AND 15 THEN '11-15'
            WHEN YearsAtCompany BETWEEN 16 AND 20 THEN '16-20'
            WHEN YearsAtCompany BETWEEN 21 AND 25 THEN '21-25'
            WHEN YearsAtCompany BETWEEN 26 AND 30 THEN '26-30'
            WHEN YearsAtCompany BETWEEN 31 AND 35 THEN '31-35'
            WHEN YearsAtCompany >= 36 THEN '36+'
        END AS 'AnosNaEmpresa',
        YearsAtCompany,
        Attrition
    FROM IBM_HR_Analytics
) AS Subquery
GROUP BY AnosNaEmpresa
ORDER BY CAST(SUBSTRING(AnosNaEmpresa, 1, 2) AS UNSIGNED);

# Taxa de Atrito relacionado aos anos desempenhando mesmo cargo
SELECT 
	YearsInCurrentRole,
	COUNT(*) AS Total_Funcionarios,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrit,
    CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics
GROUP BY YearsInCurrentRole
ORDER BY YearsInCurrentRole;

# Taxa de Atrito relacionado ao último ano que obteve promoção
SELECT  
	YearsSinceLastPromotion	,
	COUNT(*) AS Total_Funcionarios,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics
GROUP BY YearsSinceLastPromotion	
ORDER BY YearsSinceLastPromotion;

# WorkLifeBalance
SELECT
	WorkLifeBalance,
	COUNT(*) AS Total_Funcionarios,
	CONCAT(ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 2) + '%') AS Percentual_Funcionarios_Por_Nivel,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Funcionarios_Atrito,
    CONCAT(ROUND((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2), '%') AS Taxa_Atrito
FROM IBM_HR_Analytics
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance; 
