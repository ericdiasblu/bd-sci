-- 1. Quantidade De Seleções Por Continente

SELECT
c.bdcontinente,
COUNT(s.bdcodigoselecao) as "QTDSELECOES"
FROM tselecao s
JOIN tcontinente c on (s.bdcodigocontinente = c.bdcodigocontinente)
GROUP BY c.bdcontinente;

-- 2. Quantidade De Jogos Por Estádio

SELECT
e.bdnomeestadio,
COUNT(j.bdcodigojogo) as "QTDJOGOS"
FROM tjogo j
JOIN testadio e on (j.bdcodigoestadio = e.bdcodigoestadio)
GROUP BY e.bdnomeestadio;

-- 3. Quantidade De Jogos Por Cidade

SELECT
c.bdnomecidade,
COUNT(j.bdcodigojogo) as "QTDJOGOSCIDADE"
FROM tjogo j
JOIN testadio e on (j.bdcodigoestadio = e.bdcodigoestadio)
JOIN tcidade c on (c.bdcodigocidade = e.bdcodigocidade)
GROUP BY c.bdnomecidade;

-- 4. Quantidade De Jogos Por Fase

SELECT
f.bddescfase,
COUNT(j.bdcodigojogo) as "QTDJOGOSFASE"
FROM tjogo j
JOIN tfase f on (f.bdcodigofase = j.bdcodigofase)
GROUP BY f.bddescfase;

-- 5. Total De Gols Por Fase

SELECT
f.bddescfase,
SUM(ji.bdgols) as "QTDFASE"
FROM tjogositens ji
JOIN tjogo J on (j.bdcodigojogo = ji.bdcodigojogo)
JOIN tfase f on (f.bdcodigofase = j.bdcodigofase)
GROUP BY f.bddescfase;

-- 6. Média De Gols Por Fase

SELECT
f.bddescfase,
AVG(ji.bdgols) as "QTDFASE"
FROM tjogositens ji
JOIN tjogo J on (j.bdcodigojogo = ji.bdcodigojogo)
JOIN tfase f on (f.bdcodigofase = j.bdcodigofase)
GROUP BY f.bddescfase;

-- 7. Quantidade De Jogos Apitados Por Árbitro

SELECT
a.bdnomearbitro,
COUNT(j.bdcodigojogo) as QTDJOGOS
FROM tjogo j
JOIN tarbitro a on (a.bdcodigoarbitro = j.bdcodigoarbitro)
GROUP BY a.bdnomearbitro;

-- 8. Quantidade De Árbitros Por País

SELECT
p.bdpais,
COUNT(a.bdcodigoarbitro) as "QTDARBITROS"
FROM tarbitro a
JOIN tpais p on (p.bdcodigopais = a.bdcodigopais)
GROUP BY p.bdpais;

-- 9. Total De Gols Como Mandante Por Seleção

SELECT
p.bdpais,
SUM(ji.bdgols) as "BDOTOTALMANDANTE"
FROM tselecao s
JOIN tpais p on (p.bdcodigopais = s.bdcodigopais)
LEFT JOIN tjogositens ji on (ji.bdcodigoselecao = s.bdcodigoselecao) and ji.bdcodigotiposelecao=1
GROUP BY p.bdpais;

-- 10. Total De Gols Como Visitante Por Seleção

SELECT
p.bdpais,
SUM(ji.bdgols) as "BDOTOTALMANDANTE"
FROM tselecao s
JOIN tpais p on (p.bdcodigopais = s.bdcodigopais)
LEFT JOIN tjogositens ji on (ji.bdcodigoselecao = s.bdcodigoselecao) and ji.bdcodigotiposelecao=2
GROUP BY p.bdpais;

-- 11. Quantidade De Jogos Por Seleção Como Mandante

SELECT
p.bdpais,
COUNT(j.bdcodigojogo) as "QTDJOGOS"
FROM tjogo j
JOIN tjogositens ji on (ji.bdcodigojogo = j.bdcodigojogo)
JOIN tselecao s on (s.bdcodigoselecao = ji.bdcodigoselecao) and ji.bdcodigotiposelecao = 1
JOIN tpais p on (p.bdcodigopais = s.bdcodigopais)
GROUP BY p.bdpais;

-- 12. Quantidade De Jogos Por Seleção Como Visitante

SELECT
p.bdpais,
COUNT(j.bdcodigojogo) as "QTDJOGOS"
FROM tjogo j
JOIN tjogositens ji on (ji.bdcodigojogo = j.bdcodigojogo)
JOIN tselecao s on (s.bdcodigoselecao = ji.bdcodigoselecao) and ji.bdcodigotiposelecao = 2
JOIN tpais p on (p.bdcodigopais = s.bdcodigopais)
GROUP BY p.bdpais;

-- 13. Total De Público Possível Por Cidade

SELECT
c.bdnomecidade,
SUM(e.bdcapacidadepublico) as "BDTOTALPUBLICO"
FROM testadio e
JOIN tcidade c on (c.bdcodigocidade = e.bdcodigocidade)
GROUP BY c.bdnomecidade;

-- 14. Fases Com Mais De Um Jogo
SELECT
f.bddescfase,
COUNT(j.bdcodigofase) as bdQTDJogo
FROM tfase f
JOIN tjogo J on (j.bdcodigofase = f.bdcodigofase)
GROUP BY f.bddescfase
HAVING COUNT(j.bdcodigofase)>1

-- 15. Criar uma consulta que mostre o placar completo dos jogos no seguinte formato:

-- Brasil 2 x 0 México
-- Argentina 1 x 1 Japão
-- Franca 3 x 1 Marrocos
--OBS: Não ficou no formatado desejado, mas apresenta os resultados dos jogos

SELECT
j.bdcodigojogo,
p.bdpais,
ji.bdgols
FROM tjogo j
JOIN tjogositens ji on (j.bdcodigojogo = ji.bdcodigojogo)
JOIN tselecao s on (s.bdcodigoselecao = ji.bdcodigoselecao)
JOIN tpais p on (p.bdcodigopais = s.bdcodigopais)




