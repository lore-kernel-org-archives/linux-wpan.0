Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:52032
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753758AbdKFPfE (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 6 Nov 2017 10:35:04 -0500
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH 01/14] ieee802154: adf7242: use unsigned int over only
 unsigned
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-2-stefan@osg.samsung.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <45c7b95b-fff6-aef6-eae6-b82e957cdf91@analog.com>
Date: Mon, 6 Nov 2017 16:37:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170922121405.31789-2-stefan@osg.samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us

On 22.09.2017 14:13, Stefan Schmidt wrote:
> Bring it in line with the rest of the ieee802154 drivers.
> Found by checkpatch.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/net/ieee802154/adf7242.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
> index 3e4c8b21403c..400fdbd3a120 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -311,8 +311,8 @@ static int adf7242_status(struct adf7242_local *lp, u8 *stat)
>   	return status;
>   }
>   
> -static int adf7242_wait_status(struct adf7242_local *lp, unsigned status,
> -			       unsigned mask, int line)
> +static int adf7242_wait_status(struct adf7242_local *lp, unsigned int status,
> +			       unsigned int mask, int line)
>   {
>   	int cnt = 0, ret = 0;
>   	u8 stat;
> @@ -477,7 +477,7 @@ static int adf7242_write_reg(struct adf7242_local *lp, u16 addr, u8 data)
>   	return status;
>   }
>   
> -static int adf7242_cmd(struct adf7242_local *lp, unsigned cmd)
> +static int adf7242_cmd(struct adf7242_local *lp, unsigned int cmd)
>   {
>   	int status;
>   
> @@ -920,7 +920,7 @@ static void adf7242_debug(u8 irq1)
>   static irqreturn_t adf7242_isr(int irq, void *data)
>   {
>   	struct adf7242_local *lp = data;
> -	unsigned xmit;
> +	unsigned int xmit;
>   	u8 irq1;
>   
>   	adf7242_wait_status(lp, RC_STATUS_PHY_RDY, RC_STATUS_MASK, __LINE__);
> 


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
