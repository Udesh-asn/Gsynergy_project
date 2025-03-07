/****** Object:  StoredProcedure [dbo].[TableLoading]    Script Date: 07-03-2025 23:31:36 ******/
DROP PROCEDURE [dbo].[TableLoading]
GO

/****** Object:  StoredProcedure [dbo].[TableLoading]    Script Date: 07-03-2025 23:31:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TableLoading]
AS

BEGIN 

ALTER TABLE [dbo].[averagecosts] DROP CONSTRAINT [FK_avgcost_sku_prod]


ALTER TABLE [dbo].[transactions] DROP CONSTRAINT [FK_trans_psite_possite]


ALTER TABLE [dbo].[transactions] DROP CONSTRAINT [FK_trans_psubstate_pricestate]


ALTER TABLE [dbo].[transactions] DROP CONSTRAINT [FK_trans_sku_prod]


TRUNCATE TABLE [dbo].[averagecosts]
TRUNCATE TABLE [dbo].[transactions]
TRUNCATE TABLE [dbo].[clnd]
TRUNCATE TABLE [dbo].[hldy]
TRUNCATE TABLE [dbo].[invloc]
TRUNCATE TABLE [dbo].[invstatus]
TRUNCATE TABLE [dbo].[possite]
TRUNCATE TABLE [dbo].[pricestate]
TRUNCATE TABLE [dbo].[prod]
TRUNCATE TABLE [dbo].[rtlloc]

ALTER TABLE [dbo].[averagecosts]
ADD CONSTRAINT FK_avgcost_sku_prod
FOREIGN KEY (sku_id) REFERENCES [dbo].[prod](sku_id);

ALTER TABLE [dbo].[transactions]
ADD CONSTRAINT FK_trans_psite_possite
FOREIGN KEY ([pos_site_id]) REFERENCES [dbo].[possite]([site_id]);

ALTER TABLE [dbo].[transactions]
ADD CONSTRAINT FK_trans_psubstate_pricestate
FOREIGN KEY ([price_substate_id]) REFERENCES [dbo].[pricestate]([substate_id]);

ALTER TABLE [dbo].[transactions]
ADD CONSTRAINT FK_trans_sku_prod
FOREIGN KEY ([sku_id]) REFERENCES [dbo].[prod]([sku_id]);

---------------------------------------------------------

INSERT INTO [dbo].[clnd]([fscldt_id], [fscldt_label], [fsclwk_id], [fsclwk_label], [fsclmth_id], [fsclmth_label], [fsclqrtr_id], [fsclqrtr_label], [fsclyr_id], [fsclyr_label], [ssn_id], [ssn_label], [ly_fscldt_id], [lly_fscldt_id], [fscldow], [fscldom], [fscldoq], [fscldoy], [fsclwoy], [fsclmoy], [fsclqoy], [date])
SELECT [fscldt_id], [fscldt_label], [fsclwk_id], [fsclwk_label], [fsclmth_id], [fsclmth_label], [fsclqrtr_id], [fsclqrtr_label], [fsclyr_id], [fsclyr_label], [ssn_id], [ssn_label], [ly_fscldt_id], [lly_fscldt_id], [fscldow], [fscldom], [fscldoq], [fscldoy], [fsclwoy], [fsclmoy], [fsclqoy], [date]
FROM raw.clnd

INSERT INTO [dbo].[hldy]([hldy_id], [hldy_label])
SELECT [hldy_id], [hldy_label]
FROM raw.hldy

INSERT INTO [dbo].[invloc]([loc], [loc_label], [loctype], [loctype_label])
SELECT [loc], [loc_label], [loctype], [loctype_label]
FROM raw.invloc

INSERT INTO [dbo].[invstatus]([code_id], [code_label], [bckt_id], [bckt_label], [ownrshp_id], [ownrshp_label])
SELECT [code_id], [code_label], [bckt_id], [bckt_label], [ownrshp_id], [ownrshp_label]
FROM raw.invstatus

INSERT INTO [dbo].[possite]([site_id], [site_label], [subchnl_id], [subchnl_label], [chnl_id], [chnl_label])
SELECT [site_id], [site_label], [subchnl_id], [subchnl_label], [chnl_id], [chnl_label]
FROM raw.possite

INSERT INTO [dbo].[pricestate]([substate_id], [substate_label], [state_id], [state_label])
SELECT [substate_id], [substate_label], [state_id], [state_label]
FROM raw.pricestate

INSERT INTO [dbo].[prod]([sku_id], [sku_label], [stylclr_id], [stylclr_label], [styl_id], [styl_label], [subcat_id], [subcat_label], [cat_id], [cat_label], [dept_id], [dept_label], [issvc], [isasmbly], [isnfs])
SELECT [sku_id], [sku_label], [stylclr_id], [stylclr_label], [styl_id], [styl_label], [subcat_id], [subcat_label], [cat_id], [cat_label], [dept_id], [dept_label], [issvc], [isasmbly], [isnfs]
FROM raw.prod

INSERT INTO [dbo].[rtlloc]([str], [str_label], [dstr], [dstr_label], [rgn], [rgn_label])
SELECT [str], [str_label], [dstr], [dstr_label], [rgn], [rgn_label]
FROM raw.rtlloc

INSERT INTO [dbo].[transactions]([order_id], [line_id], [type], [dt], [pos_site_id], [sku_id], [fscldt_id], [price_substate_id], [sales_units], [sales_dollars], [discount_dollars], [original_order_id], [original_line_id])
SELECT [order_id], [line_id], [type], [dt], [pos_site_id], [sku_id], [fscldt_id], [price_substate_id], [sales_units], [sales_dollars], [discount_dollars], [original_order_id], [original_line_id]
FROM raw.transactions

INSERT INTO [dbo].[averagecosts]([fscldt_id], [sku_id], [average_unit_standardcost], [average_unit_landedcost])
SELECT [fscldt_id], [sku_id], [average_unit_standardcost], [average_unit_landedcost]
FROM [raw].[averagecosts]

-----------------------------------------------------------------------
;

END
GO


