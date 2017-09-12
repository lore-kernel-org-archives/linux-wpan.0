Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:37128 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750988AbdILWkT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 12 Sep 2017 18:40:19 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 17A2718028E9E
        for <linux-wpan@vger.kernel.org>; Tue, 12 Sep 2017 22:34:59 +0000 (UTC)
Message-ID: <1505255692.8969.2.camel@perches.com>
Subject: Re: [PATCH] ieee802154: fix gcc-4.9 warnings
From: Joe Perches <joe@perches.com>
Date: Tue, 12 Sep 2017 15:34:52 -0700
In-Reply-To: <20170912101636.3811626-1-arnd@arndb.de>
References: <20170912101636.3811626-1-arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Harry Morris <h.morris@cascoda.com>, linuxdev@cascoda.com, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Markus Elfring <elfring@users.sourceforge.net>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Florian Westphal <fw@strlen.de>, Johannes Berg <johannes.berg@intel.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Colin Ian King <colin.king@canonical.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2017-09-12 at 12:16 +0200, Arnd Bergmann wrote:
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
[]
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
[]
> @@ -1944,7 +1944,7 @@ static int ca8210_skb_tx(
>  )
>  {
>  	int status;
> -	struct ieee802154_hdr header = { 0 };
> +	struct ieee802154_hdr header = { };
>  	struct secspec secspec;
>  	unsigned int mac_len;

Presumably gcc does this because the first member
of struct ieee802154_hdr is another struct.

I wonder if "struct foo bar = { 0 };" should be
discouraged by checkpatch.

Right now it's about 4:3 in favor of
	struct foo bar = {};
over
	struct foo bar = { 0 };

$ git grep -E "struct\s+\w+\s+\w+\s*=\s*\{\s*0\s*\}\s*[,;]" | wc -l
826
$ git grep -E "struct\s+\w+\s+\w+\s*=\s*\{\s*\}\s*[,;]" | wc -l
990

There are many instances on multiple lines too.
The git grep above doesn't span multiple lines.

