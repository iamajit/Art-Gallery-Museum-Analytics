
CREATE TABLE [dbo].[artist](
	[artist_id] [int] NOT NULL,
	[full_name] [nvarchar](50) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[middle_names] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[nationality] [nvarchar](50) NOT NULL,
	[style] [nvarchar](50) NOT NULL,
	[birth] [int] NOT NULL,
	[death] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[canvas_size](
	[size_id] [int] NOT NULL,
	[width] [int] NOT NULL,
	[height] [int] NULL,
	[label] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[image_link](
	[work_id] [int] NOT NULL,
	[url] [nvarchar](450) NOT NULL,
	[thumbnail_small_url] [nvarchar](250) NULL,
	[thumbnail_large_url] [nvarchar](250) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[museum](
	[museum_id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[address] [nvarchar](50) NOT NULL,
	[city] [nvarchar](50) NOT NULL,
	[state] [nvarchar](50) NULL,
	[postal] [nvarchar](50) NULL,
	[country] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](50) NOT NULL,
	[url] [nvarchar](100) NOT NULL
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[museum_hours](
	[museum_id] [int] NOT NULL,
	[day] [nvarchar](50) NOT NULL,
	[open] [time](7) NOT NULL,
	[close] [time](7) NOT NULL
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[product_size](
	[work_id] [int] NOT NULL,
	[size_id] [decimal](8, 2) NOT NULL,
	[sale_price] [int] NOT NULL,
	[regular_price] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[subject](
	[work_id] [int] NOT NULL,
	[subject] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[work](
	[work_id] [int] NOT NULL,
	[name] [nvarchar](150) NOT NULL,
	[artist_id] [int] NOT NULL,
	[style] [nvarchar](50) NULL,
	[museum_id] [int] NULL
) ON [PRIMARY]
GO
