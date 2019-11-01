
DROP database if exists ContactPage;
Go

--Create database for contact page
Create database ContactPage;
GO
Use ContactPage;
GO
--Create Contact table:
CREATE TABLE [dbo].[Contact](
[visitor_id] [int] IDENTITY(1,1) NOT NULL,
[fullName] [nvarchar](50) NOT NULL,
[email] [nvarchar](50) NOT NULL,
[phone] [nvarchar](50) NOT NULL,
[contactReason] [nvarchar](50) NOT NULL,
[msg] [nvarchar](200) NOT NULL,
) ON [PRIMARY]

GO

-- Create stored procedure for insert
DROP  PROC IF EXISTS InsContact;
GO
create procedure InsContact

@fullName nvarchar (50),
@email nvarchar (50),
@phone nvarchar (50),
@contactReason nvarchar(50),
@msg nvarchar(200)

as
INSERT INTO [dbo].[Contact]
           ([fullName]
           ,[email]
           ,[phone]
		   ,[contactReason]
           ,[msg])
     VALUES
           (@fullName
           ,@email
           ,@phone
		   ,@contactReason
           ,@msg)
GO

-- Use exec to try if the stored procedure works
exec InsContact "Mickey Mouse", "mickey@mouse.com", "123456789","General question", "Insert using SP from SSMS";
Go


select * from Contact;
Go

-- Create new login who can use InsContact 
CREATE LOGIN sams WITH PASSWORD='Pa$$w0rd', DEFAULT_DATABASE=[ContactPage]
go
use ContactPage
go
CREATE USER sams FOR LOGIN sams WITH DEFAULT_SCHEMA=[dbo]
GO
grant execute on InsContact to sams
go
