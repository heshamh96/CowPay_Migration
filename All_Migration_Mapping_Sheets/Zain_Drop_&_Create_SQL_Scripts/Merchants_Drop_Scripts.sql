USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[Merchants] DROP CONSTRAINT [FK_Merchants_Cities]
GO

---======================================
USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[Merchants] DROP CONSTRAINT [FK_Merchants_Countries]
GO


--========================


USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[Merchants] DROP CONSTRAINT [FK_Merchants_StatusTypes]
GO


--==================================

USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[MerchantSocialLinks] DROP CONSTRAINT [FK_MerchantSocialLinks_Merchants]
GO


--======================

USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[MerchantAttachments] DROP CONSTRAINT [FK_MerchantAttachments_Merchants]
GO

