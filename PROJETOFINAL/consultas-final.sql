-- 1.

SELECT
u.bddescuf,
c.bdcodcliente,
c.bdnomecliente,
td.bddescdocumento,
c.bddocumentocliente,
c.bdenderecocliente
FROM tcliente c
JOIN ttipodocumento td on (td.bdcodtpdocumento = c.bdcodtipodocumento)
JOIN tuf u on (u.bdcoduf = c.bdcoduf)
--GROUP BY u.bddescuf
ORDER BY u.bddescuf, td.bddescdocumento, c.bddocumentocliente;

-- 2.

SELECT
u.bddescuf,
SUM(nf.bdvalortotal) as BDTOTALBRUTO
FROM tnotafiscal nf
JOIN tcliente c on (c.bdcodcliente = nf.bdcodcliente)
JOIN tuf u on (u.bdcoduf = c.bdcoduf)
GROUP BY u.bddescuf
ORDER BY SUM(nf.bdvalortotal) desc;

-- 3.

SELECT
nf.bdcodnotafiscal,
c.bdnomecliente,
u.bddescuf,
p.bddescproduto,
ai.bdaliquota
FROM tnotafiscal nf
JOIN tnotafiscalitem nfi on (nfi.bdcodnota = nf.bdcodnotafiscal)
JOIN tproduto p on (p.bdcodproduto = nfi.bdcodproduto)
JOIN tcliente c on (c.bdcodcliente = nf.bdcodcliente)
JOIN tuf u on (u.bdcoduf = c.bdcoduf)
JOIN taliquotaicms ai on (ai.bdcoduf = u.bdcoduf);

-- 4.

--PRECISA DE PROCEDURE

-- 5.

SELECT
u.bddescuf,
COUNT(nf.bdcodnotafiscal),
AVG(nf.bdvalortotal)
FROM tnotafiscal nf
JOIN tcliente c on (c.bdcodcliente = nf.bdcodcliente)
JOIN tuf u on (u.bdcoduf = c.bdcoduf)
GROUP by u.bddescuf;

--considerando apenas os estados que possuem mais de 5 vendas realizadas.





