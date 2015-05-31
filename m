Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37158 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbbEaMYw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 31 May 2015 08:24:52 -0400
Received: by wifw1 with SMTP id w1so73665269wif.0
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2015 05:24:51 -0700 (PDT)
Date: Sun, 31 May 2015 14:24:49 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC wpan-tools] info: add frequency output to channel listing
Message-ID: <20150531122448.GB1476@omega>
References: <20150529121556.GA7422@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150529121556.GA7422@raspberrypi>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Fri, May 29, 2015 at 12:16:03PM +0000, Christoffer Holmstedt wrote:
>  
>  	if (tb_msg[NL802154_ATTR_CHANNEL])
> -		printf("current_channel: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
> +	{
> +		unsigned char curr_channel;
> +		curr_channel = nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]);
> +		printf("current_channel: %d (", curr_channel);
> +		print_freq(nla_get_u8(tb_msg[NL802154_ATTR_PAGE]), curr_channel);

Also this is problematic, because we don't check before if
tb_msg[NL802154_ATTR_PAGE] isn't null.

When you like to use this value there, the easiest way would be:

if (tb_msg[NL802154_ATTR_CHANNEL] && tb_msg[NL802154_ATTR_PAGE])

instead of

if (tb_msg[NL802154_ATTR_CHANNEL]) above.

- Alex
