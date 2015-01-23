Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:43640 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbbAWMht (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 23 Jan 2015 07:37:49 -0500
Received: by mail-lb0-f171.google.com with SMTP id u14so6782925lbd.2
        for <linux-wpan@vger.kernel.org>; Fri, 23 Jan 2015 04:37:48 -0800 (PST)
Message-ID: <54C2409A.6020506@cogentembedded.com>
Date: Fri, 23 Jan 2015 15:37:46 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ieee802154: cc2520: Fix coding style issues
References: <1422005180-13230-1-git-send-email-md.jamalmohiuddin@gmail.com>
In-Reply-To: <1422005180-13230-1-git-send-email-md.jamalmohiuddin@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Mohammad Jamal <md.jamalmohiuddin@gmail.com>, varkabhadram@gmail.com, alex.aring@gmail.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 1/23/2015 12:26 PM, Mohammad Jamal wrote:

> This patch solves the coding style issues such as space after ,

    s/after/before/?

> and removes the blank lines

   Extra blank lines, you mean?

> Signed-off-by: Mohammad Jamal <md.jamalmohiuddin@gmail.com>
> ---
>   drivers/net/ieee802154/cc2520.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index f9df9fa..dd129be 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
[...]
> @@ -551,14 +550,14 @@ cc2520_ed(struct ieee802154_hw *hw, u8 *level)
>   	u8 rssi;
>   	int ret;
>
> -	ret = cc2520_read_register(priv , CC2520_RSSISTAT, &status);
> +	ret = cc2520_read_register(priv, CC2520_RSSISTAT, &status);
>   	if (ret)
>   		return ret;
>
>   	if (status != RSSI_VALID)
>   		return -EINVAL;
>
> -	ret = cc2520_read_register(priv , CC2520_RSSI, &rssi);
> +	ret = cc2520_read_register(priv, CC2520_RSSI, &rssi);
[...]

WBR, Sergei

