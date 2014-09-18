Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39290 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754831AbaIRWyJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 18 Sep 2014 18:54:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway2.nyi.internal (Postfix) with ESMTP id BCC63207F2
	for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 18:54:08 -0400 (EDT)
Message-ID: <541B6292.2020902@signal11.us>
Date: Thu, 18 Sep 2014 18:54:10 -0400
From: Alan Ott <alan@signal11.us>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 1/3] ieee802154: mrf24j40: fix Missing
 a blank line after declarations
References: <1410842922-10564-1-git-send-email-varkab@cdac.in> <1410842922-10564-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1410842922-10564-2-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

Make the first line of the commit message:
     mrf24j40: fix Missing a blank line after declarations

On 09/16/2014 12:48 AM, Varka Bhadram wrote:
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   drivers/net/ieee802154/mrf24j40.c |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 9e6a124..466da57 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -412,6 +412,7 @@ static void mrf24j40_stop(struct ieee802154_dev *dev)
>   	struct mrf24j40 *devrec = dev->priv;
>   	u8 val;
>   	int ret;
> +
>   	dev_dbg(printdev(devrec), "stop\n");
>   
>   	ret = read_short_reg(devrec, REG_INTCON, &val);
> @@ -465,6 +466,7 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
>   	if (changed & IEEE802515_AFILT_SADDR_CHANGED) {
>   		/* Short Addr */
>   		u8 addrh, addrl;
> +
>   		addrh = le16_to_cpu(filt->short_addr) >> 8 & 0xff;
>   		addrl = le16_to_cpu(filt->short_addr) & 0xff;
>   
> @@ -493,6 +495,7 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
>   	if (changed & IEEE802515_AFILT_PANID_CHANGED) {
>   		/* PAN ID */
>   		u8 panidl, panidh;
> +
>   		panidh = le16_to_cpu(filt->pan_id) >> 8 & 0xff;
>   		panidl = le16_to_cpu(filt->pan_id) & 0xff;
>   		write_short_reg(devrec, REG_PANIDH, panidh);

