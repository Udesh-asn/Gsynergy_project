/****** Object:  StoredProcedure [dbo].[final_process]    Script Date: 07-03-2025 23:31:19 ******/
DROP PROCEDURE [dbo].[final_process]
GO

/****** Object:  StoredProcedure [dbo].[final_process]    Script Date: 07-03-2025 23:31:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[final_process]
AS 

BEGIN

IF OBJECT_ID('tempdb..#Accumulated', 'U') IS NOT NULL
DROP TABLE #Accumulated

IF OBJECT_ID('tempdb..#Final', 'U') IS NOT NULL
DROP TABLE #Final

TRUNCATE TABLE [gold].[mview_weekly_sales]

Select	tr.sales_units as sales_units, 
	tr.sales_dollars as sales_dollars,
	tr.discount_dollars as discount_dollars,
	tr.pos_site_id as pos_site_id,
	tr.sku_id as sku_id,
	tr.price_substate_id as price_substate_id,
	tr.type as type,
	cl.fsclwk_id as fsclwk_id
INTO #Accumulated
FROM [dbo].[transactions] tr LEFT JOIN [dbo].[clnd] cl
ON tr.fscldt_id = cl.fscldt_id;


Select pos_site_id,
	sku_id,
	fsclwk_id,
	price_substate_id,
	type,
	SUM(sales_units) as sales_units,
	SUM(sales_dollars) as sales_dollars,
	SUM(discount_dollars) as discount_dollars
INTO #FINAL
FROM #Accumulated
GROUP BY pos_site_id,sku_id,fsclwk_id,price_substate_id,type


INSERT INTO [gold].[mview_weekly_sales]
([pos_site_id], [sku_id], [fsclwk_id], [price_substate_id], [type], [sales_units], [sales_dollars], [discount_dollars])
SELECT [pos_site_id], [sku_id], [fsclwk_id], [price_substate_id], [type], [sales_units], [sales_dollars], [discount_dollars]
FROM #FINAL

END

;

  
GO


