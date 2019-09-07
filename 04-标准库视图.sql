CREATE OR REPLACE VIEW V_SZ_DJ_QYBG  --企业变更信息视图名称待确定
AS
select 
cast(a.ALTID as varchar2(80))  as BG_ID,
cast(a.pripid as varchar2(80))  as marprid,
cast(substr(a.altaf,1,3995) as varchar2(3996)) as BGH,
cast(substr(a.altbe,1,3995) as varchar2(3996)) as BGQ,
a.ALTITEM as BGSX,
null as BGYY,--(标准库取不到)
NULL as ID,--变更受理ID(标准库取不到)
a.ALTDATE as SHRQ,---审核日期
null as sljg,---受理机关
null as orgid,----机构标识
a.altdate as slrq, --时间戳
null as bgcs,---需单独计算（标准库取不到）
null as bgslbs,--(标准库取不到)
null as alttype, --变更类型(标准库取不到)
null as shr,---审核人(标准库取不到)
null as slr,--受理人(标准库取不到)
null as bgslzt,----变更受理状态(标准库取不到)
null as cxbgbz, --变更撤销标志1撤销，0未撤销(标准库取不到)
(select cast(a.PRIPID as varchar(80)) from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as NBXH,--主体标识
(select zt.UNISCID from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as UNISCID ,--统一社会信用代码
(select zt.REGNO from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as ZCH,--注册号
(select zt.ENTNAME from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as QYMC,--企业名称
(select RPAD(zt.REGORG,'10','0') from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as DJJG,--登记机关
(select RPAD(zt.REGORG,'10','0') from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as GXGSS,--管辖工商所
(select zt.name from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as FDDBR,--法定代表人
case when exists (select 1 from E_FI_SUPL fi where a.PRIPID=fi.PRIPID) then (select tel FROM E_FI_SUPL fi where a.PRIPID=fi.PRIPID and rownum=1)   
      when exists (select 1 from E_DI_SUPL di where a.PRIPID=di.PRIPID) then (select tel FROM E_DI_SUPL DI where a.PRIPID=di.PRIPID and rownum=1)  
      when exists (select 1 from E_SFC_SUPL sfc where a.PRIPID=sfc.PRIPID) then (select tel  FROM E_SFC_SUPL SFC where a.PRIPID=SFC.PRIPID and rownum=1)  
else null END  as LXDH,--联系电话
(select zt.ESTDATE from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as CLRQ,---成立日期
(select zt.INDUSTRYPHY from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as HYML,---行业门类
(select zt.INDUSTRYCO from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as HYDM,--行业代码
(select zt.DOMDISTRICT from E_BASEINFO zt where a.PRIPID=zt.PRIPID  and rownum=1) as XZQH,--行政区划
(select zt.ENTTYPE from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as QYLX,--在维表中加入9900--在报表上处理不在代码表中的数据
(select case when zt.enttype in  ('1110','1120','1121','1122','1123','1140','1153',
'1190','1211','1213','1219','1221','1223','1229',
'2110','2120','2121','2122','2123','2140','2153',
'2190','2211','2213','2219','2221','2223','2229',
'3000','3100','3200','3300','3400','3500','4100',
'4110','4120','4200','4210','4220','4300','4310',
'4320','4330','4340','4400','4410','4420','4600',
'4700') then '01' 
when zt.enttype in('1000','1100','1130','1150','1151','1152',
'1200','1210','1212','1220','1222','2000',
'2100','2130','2150','2151','2152','2200',
'2210','2212','2220','2222','4000','4500',
'4530','4531','4532','4533','4540','4550',
'4551','4552','4553','4560') then '03'
when substr(zt.enttype,1,1) in('5','6','7') then '02'
when zt.enttype in('9100','9200') then '07' else null end  from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as QYSX,--企业属性,--企业属性
 (select CASE  WHEN  zt.REGSTATE='1' THEN '06'
      WHEN zt.REGSTATE IN('2','3') THEN '11'
      WHEN zt.REGSTATE='4' THEN '07'
      WHEN zt.REGSTATE='6' THEN '06'
	  ELSE zt.REGSTATE
      END  from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) AS  JYZT,
(select zt.DOM from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as JYDZ,--经营地址
(select zt.OPSCOPE from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as JYFW,--经营范围
(select cast((case when substr(zt.enttype,1,1) in('5','6','7') then 
(select DOMEREGCAP FROM E_FI_SUPL wz where wz.pripid=zt.pripid and rownum=1) else zt.REGCAP end) as number(38,6)) 
from E_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as  ZCZB--注册资本
from E_ALTER_RECODER a
UNION ALL
select 
cast(a.ALTID as varchar2(80))  as BG_ID,
cast(a.pripid as varchar2(80))  as marprid,
cast(substr(a.altaf,1,3995) as varchar2(3996)) as BGH,
cast(substr(a.altbe,1,3995) as varchar2(3996)) as BGQ,
a.ALTITEM as BGSX,
null as BGYY,--(标准库取不到)
NULL as ID,--变更受理ID(标准库取不到)
a.ALTDATE as SHRQ,---审核日期
null as sljg,---受理机关
null as orgid,----机构标识
a.altdate as slrq, --时间戳
null as bgcs,---需单独计算（标准库取不到）
null as bgslbs,--(标准库取不到)
null as alttype, --变更类型(标准库取不到)
null as shr,---审核人(标准库取不到)
null as slr, --受理人(标准库取不到)
null as bgslzt,----变更受理状态(标准库取不到)
null as cxbgbz, --变更撤销标志1撤销，0未撤销(标准库取不到)
(select cast(a.PRIPID as varchar(80)) from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as NBXH,--主体标识
(select zt.UNISCID from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as UNISCID ,--统一社会信用代码
(select zt.REGNO from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as ZCH,--注册号
(select zt.TRANAME from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as QYMC,--企业名称
(select RPAD(zt.REGORG,'10','0') from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as DJJG,--登记机关
(select RPAD(zt.REGORG,'10','0') from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as GXGSS,--管辖工商所
(select zt.name from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as FDDBR,--管辖工商所
(select zt.tel from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as LXDH,--管辖工商所
(select zt.ESTDATE from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as CLRQ,---成立日期
(select zt.INDUSTRYPHY from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as HYML,---行业门类
(select zt.INDUSTRYCO from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as HYDM,--行业代码
(select zt.OPLOCDISTRICT from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID  and rownum=1) as XZQH,--行政区划
'9600' as qylx,--企业类型
'04' as QYSX,--企业属性
(select CASE  WHEN  zt.REGSTATE='1' THEN '06'
      WHEN zt.REGSTATE IN('2','3') THEN '11'
      WHEN zt.REGSTATE='4' THEN '07'
      WHEN zt.REGSTATE='6' THEN '06'
	  ELSE zt.REGSTATE
      END  from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) AS  JYZT,
(select zt.OPLOC from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as JYDZ,--经营地址
(select zt.OPSCOPE from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as JYFW,--经营范围
(select zt.FUNDAM from E_PB_BASEINFO zt where a.PRIPID=zt.PRIPID and rownum=1) as ZCZB--经营范围
from E_GT_ALTER_RECODER a
;
