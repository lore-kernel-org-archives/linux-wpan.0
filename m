Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:40813 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932263AbcDSOli (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 19 Apr 2016 10:41:38 -0400
Subject: Re: [PATCH bluetooth-next] at86rf230: increase sleep to off timings
References: <1461072862-1853-1-git-send-email-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5716439D.4030404@osg.samsung.com>
Date: Tue, 19 Apr 2016 16:41:33 +0200
MIME-Version: 1.0
In-Reply-To: <1461072862-1853-1-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Oleg Hahm <oliver.hahm@inria.fr>

Hello.

On 19/04/16 15:34, Alexander Aring wrote:
> I expierenced when setting channel while sleep mode it didn't changed
> the channel inside the hardware registers. Then I got another report of
> an user which has similar issues.
>
> I increased the sleep to off state change timing, which is according
> at86rf233 at maximum 1000 us. After this change I got no similar effects
> again.
>
> I tried another option to wait on AWAKE_END irq, which can be used to
> wait until the transceiver is awaked. I tested it and the IRQ took 4
> seconds after starting state change. I don't believe it takes 4 seconds
> to go into the TRX_OFF state from SLEEP state. The alternative is to
> increase the timings which seems to work.

Nicely spotted. Increasing the timing is fine here I think. Given the 
datasheet actually assumes a maximum of 1000 us we should allow for it 
as well.

Did you also check the maximum timing for 231 and 212 in the datasheet? 
Just to make sure they are not different (for example higher).
> Cc: Oleg Hahm <oliver.hahm@inria.fr>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   drivers/net/ieee802154/at86rf230.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index cb9e9fe..9f10da6 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1340,7 +1340,7 @@ static struct at86rf2xx_chip_data at86rf233_data = {
>   	.t_off_to_aack = 80,
>   	.t_off_to_tx_on = 80,
>   	.t_off_to_sleep = 35,
> -	.t_sleep_to_off = 210,
> +	.t_sleep_to_off = 1000,
>   	.t_frame = 4096,
>   	.t_p_ack = 545,
>   	.rssi_base_val = -91,
> @@ -1355,7 +1355,7 @@ static struct at86rf2xx_chip_data at86rf231_data = {
>   	.t_off_to_aack = 110,
>   	.t_off_to_tx_on = 110,
>   	.t_off_to_sleep = 35,
> -	.t_sleep_to_off = 380,
> +	.t_sleep_to_off = 1000,
>   	.t_frame = 4096,
>   	.t_p_ack = 545,
>   	.rssi_base_val = -91,
> @@ -1370,7 +1370,7 @@ static struct at86rf2xx_chip_data at86rf212_data = {
>   	.t_off_to_aack = 200,
>   	.t_off_to_tx_on = 200,
>   	.t_off_to_sleep = 35,
> -	.t_sleep_to_off = 380,
> +	.t_sleep_to_off = 1000,
>   	.t_frame = 4096,
>   	.t_p_ack = 545,
>   	.rssi_base_val = -100,

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt
