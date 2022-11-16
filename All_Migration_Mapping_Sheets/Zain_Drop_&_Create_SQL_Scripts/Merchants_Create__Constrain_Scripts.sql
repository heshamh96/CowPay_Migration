USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[Merchants]  WITH CHECK ADD  CONSTRAINT [FK_Merchants_Cities] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([Id])
GO

ALTER TABLE [dbo].[Merchants] CHECK CONSTRAINT [FK_Merchants_Cities]
GO


--===========================


USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[Merchants]  WITH CHECK ADD  CONSTRAINT [FK_Merchants_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO

ALTER TABLE [dbo].[Merchants] CHECK CONSTRAINT [FK_Merchants_Countries]
GO


--============================

USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[Merchants]  WITH CHECK ADD  CONSTRAINT [FK_Merchants_StatusTypes] FOREIGN KEY([StatusTypeId])
REFERENCES [dbo].[StatusTypes] ([Id])
GO

ALTER TABLE [dbo].[Merchants] CHECK CONSTRAINT [FK_Merchants_StatusTypes]
GO

--========================

USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[MerchantSocialLinks]  WITH CHECK ADD  CONSTRAINT [FK_MerchantSocialLinks_Merchants] FOREIGN KEY([MerchantId])
REFERENCES [dbo].[Merchants] ([Id])
GO

ALTER TABLE [dbo].[MerchantSocialLinks] CHECK CONSTRAINT [FK_MerchantSocialLinks_Merchants]
GO

--===========================

USE [MerchantManagement_Stage]
GO

ALTER TABLE [dbo].[MerchantAttachments]  WITH CHECK ADD  CONSTRAINT [FK_MerchantAttachments_Merchants] FOREIGN KEY([MerchantId])
REFERENCES [dbo].[Merchants] ([Id])
GO

ALTER TABLE [dbo].[MerchantAttachments] CHECK CONSTRAINT [FK_MerchantAttachments_Merchants]
GO
