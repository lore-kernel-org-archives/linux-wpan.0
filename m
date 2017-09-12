Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59114
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751214AbdILKYa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Sep 2017 06:24:30 -0400
Subject: Re: [PATCH] ieee802154: fix gcc-4.9 warnings
References: <20170912101636.3811626-1-arnd@arndb.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <e0712b42-050c-a992-b33b-42fd84f44cf6@osg.samsung.com>
Date: Tue, 12 Sep 2017 12:24:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170912101636.3811626-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Harry Morris <h.morris@cascoda.com>, linuxdev@cascoda.com, Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Markus Elfring <elfring@users.sourceforge.net>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Florian Westphal <fw@strlen.de>, Johannes Berg <johannes.berg@intel.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Colin Ian King <colin.king@canonical.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 09/12/2017 12:16 PM, Arnd Bergmann wrote:
> All older compiler versions up to gcc-4.9 produce these
> harmless warnings:
> 
> drivers/net/ieee802154/ca8210.c: In function 'ca8210_skb_tx':
> drivers/net/ieee802154/ca8210.c:1947:9: warning: missing braces around initializer [-Wmissing-braces]
> 
> This changes the syntax to something that works on all versions
> without warnings.
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ieee802154/ca8210.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 24a1eabbbc9d..e6b8ce81a6c3 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1944,7 +1944,7 @@ static int ca8210_skb_tx(
>   )
>   {
>   	int status;
> -	struct ieee802154_hdr header = { 0 };
> +	struct ieee802154_hdr header = { };
>   	struct secspec secspec;
>   	unsigned int mac_len;
>   


Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
