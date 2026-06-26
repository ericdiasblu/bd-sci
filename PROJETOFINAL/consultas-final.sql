-- 1.

SELECT
u.bddescuf as "UF",
c.bdcodcliente as "Código do cliente",
c.bdnomecliente as "Nome do cliente",
td.bddescdocumento as "Tipo de documento",
c.bddocumentocliente as "Documento do cliente",
c.bdenderecocliente as "Endereço do cliente"
FROM tcliente c
JOIN ttipodocumento td on (td.bdcodtpdocumento = c.bdcodtipodocumento)
JOIN tcidade ci on (ci.bdcodcidade = c.bdcodcidade)
JOIN tuf u on (u.bdcoduf = c.bdcodcidade)
ORDER BY u.bddescuf, td.bddescdocumento, c.bddocumentocliente;

-- 2.

SELECT
u.bddescuf as "UF",
SUM(nf.bdvalortotal) as "Total bruto"
FROM tnotafiscal nf
JOIN tcliente c on (c.bdcodcliente = nf.bdcodcliente)
JOIN tcidade ci on (ci.bdcodcidade = c.bdcodcidade)
JOIN tuf u on (u.bdcoduf = c.bdcodcidade)
GROUP BY u.bddescuf
ORDER BY SUM(nf.bdvalortotal) desc;

-- 3.

SELECT
nf.bdcodnotafiscal as "Código da nota fiscal",
c.bdnomecliente as "Nome do cliente",
u.bddescuf as "UF",
p.bddescproduto as "Produto",
ai.bdaliquota as "Alíquota ICMS"
FROM tnotafiscal nf
JOIN tnotafiscalitem nfi on (nfi.bdcodnota = nf.bdcodnotafiscal)
JOIN tproduto p on (p.bdcodproduto = nfi.bdcodproduto)
JOIN tcliente c on (c.bdcodcliente = nf.bdcodcliente)
JOIN tcidade ci on (ci.bdcodcidade = c.bdcodcidade)
JOIN tuf u on (u.bdcoduf = c.bdcodcidade)
JOIN taliquotaicms ai on (ai.bdcoduf = u.bdcoduf);

-- 4.

SELECT
ai.bdfaturamentobruto as "Faturamento bruto",
ai.bdtotalicms as "Total ICMS",
ai.bdtotalpis as "Total PIS",
ai.bdtotalcofins as "Total COFINS"
FROM sp_apuracao_impostos(06,2026) ai;

-- 5.

SELECT
u.bddescuf as "UF",
COUNT(nf.bdcodnotafiscal) as "Total de notas",
AVG(nf.bdvalortotal) as "Valor médio das notas"
FROM tnotafiscal nf
JOIN tcliente c on (c.bdcodcliente = nf.bdcodcliente)
JOIN tcidade ci on (ci.bdcodcidade = c.bdcodcidade)
JOIN tuf u on (u.bdcoduf = c.bdcodcidade)
GROUP by u.bddescuf
HAVING COUNT(nf.bdcodnotafiscal) > 5;

-- 6.

SELECT
p.bdcodproduto as "Código do Produto",
p.bddescproduto as "Produto",
p.bdprecoproduto as "Preço",
p.bdidentifcomercial as "Identificador comercial"
FROM tproduto p
LEFT JOIN tnotafiscalitem nfi on (nfi.bdcodproduto = p.bdcodproduto)
WHERE NFI.BDCODNOTAITEM IS NULL;









