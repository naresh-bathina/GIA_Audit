--A1_GETTING_COACCOUNT
--COA_toberequested table
select bseg.hkont, count(bseg.hkont), skat.txt50 
from app_0104_audit_vendor_transaction.sd_bam_bseg bseg
join (select * from app_0104_audit_vendor_transaction.sd_bam_skat 
where spras = 'E' and ktopl = 'PCOA') skat
on bseg.hkont = skat.saknr
where bseg.bukrs = 'AR01' and bseg.gjahr between 2021 and 2022
group by bseg.hkont, skat.txt50;

--A2_FILTERING_TABLES
select bukrs, belnr, gjahr, blart, bldat, budat, cpudt, cputm, usnam, tcode, bktxt, hwaer, waers, bstat, awtyp,
awkey, xblnr, xref1_hd, xref2_hd from app_0104_audit_vendor_transaction.sd_bam_bkpf

--BSEG_WITH_HEADERS TABLE
select bseg.bukrs, bseg.werks, bseg.belnr, bseg.gjahr, bseg.buzei, bseg.shkzg, round(bseg.dmbtr,2) as dmbtr,
case
	when shkzg='H' then round((-1*dmbtr),2)
    else round((1*dmbtr),2)
end as dmbtr_usar,
case
	when shkzg='H' then round(dmbtr,2)
    else 0.00
end as dmbtr_credit,
case
	when shkzg='H' then 0.00
    else round(dmbtr,2)
end as dmbtr_debit,
bseg.wrbtr, bseg.sgtxt, bseg.hkont, bseg.kostl, bseg.prctr, bseg.projk, 
bkpf.bukrs, bkpf.belnr, bkpf.gjahr, bkpf.blart, bkpf.bldat, 
bkpf.budat, bkpf.cpudt, bkpf.cputm, bkpf.usnam, bkpf.tcode, bkpf.bktxt, bkpf.hwaer, 
bkpf.waers, bkpf.bstat, bkpf.awtyp, bkpf.awkey, bkpf.xblnr, bkpf.xref1_hd, bkpf.xref2_hd 
from app_0104_audit_vendor_transaction.sd_bam_bseg bseg
join app_0104_audit_vendor_transaction.sd_bam_bkpf bkpf
on bseg.bukrs = bkpf.bukrs and bseg.belnr = bkpf.belnr and bseg.gjahr = bkpf.gjahr
where bseg.bukrs = 'AR01' and bseg.gjahr between 2021 and 2022
order by bseg.belnr;





with skat_e as (select * from app_0104_audit_vendor_transaction.sd_bam_skat 
where spras = 'E' and ktopl = 'PCOA') select * from skat_e;

select distinct(bukrs), count(bukrs) from app_0104_audit_vendor_transaction.sd_bam_bseg
group by bukrs;