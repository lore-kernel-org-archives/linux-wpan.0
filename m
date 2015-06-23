Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36050 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbbFWPGm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Jun 2015 11:06:42 -0400
Message-ID: <558975EB.7020805@gmail.com>
Date: Tue, 23 Jun 2015 20:36:19 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] net: ieee802154: Remove redundant spi driver bus
 initialization
References: <1435070714-24174-1-git-send-email-borneo.antonio@gmail.com> <1435071172-24542-1-git-send-email-borneo.antonio@gmail.com>
In-Reply-To: <1435071172-24542-1-git-send-email-borneo.antonio@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Antonio Borneo <borneo.antonio@gmail.com>, Alan Ott <alan@signal11.us>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi Antonio Borneo,

On Tuesday 23 June 2015 08:22 PM, Antonio Borneo wrote:

> In ancient times it was necessary to manually initialize the bus
> field of an spi_driver to spi_bus_type. These days this is done in
> spi_register_driver(), so we can drop the manual assignment.
>
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> To: Alan Ott <alan@signal11.us>
> To: Alexander Aring <alex.aring@gmail.com>
> To: Varka Bhadram <varkabhadram@gmail.com>
> To: linux-wpan@vger.kernel.org
> To: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/net/ieee802154/cc2520.c   | 1 -
>   drivers/net/ieee802154/mrf24j40.c | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index f833b8b..bd957f1 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -1046,7 +1046,6 @@ MODULE_DEVICE_TABLE(of, cc2520_of_ids);
>   static struct spi_driver cc2520_driver = {
>   	.driver = {
>   		.name = "cc2520",
> -		.bus = &spi_bus_type,
>   		.owner = THIS_MODULE,
>   		.of_match_table = of_match_ptr(cc2520_of_ids),
>   	},

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index fba2dfd..bc8fb26 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -812,7 +812,6 @@ MODULE_DEVICE_TABLE(spi, mrf24j40_ids);
>   static struct spi_driver mrf24j40_driver = {
>   	.driver = {
>   		.name = "mrf24j40",
> -		.bus = &spi_bus_type,
>   		.owner = THIS_MODULE,
>   	},
>   	.id_table = mrf24j40_ids,

-- 
Best regards,
Varka Bhadram.

