Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:40338 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbbAUUYs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Jan 2015 15:24:48 -0500
Received: by mail-wg0-f49.google.com with SMTP id l18so16303354wgh.8
        for <linux-wpan@vger.kernel.org>; Wed, 21 Jan 2015 12:24:47 -0800 (PST)
Received: from omega (p20030064A941E81CE2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a941:e81c:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id g2sm1200053wjn.11.2015.01.21.12.24.46
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jan 2015 12:24:46 -0800 (PST)
Date: Wed, 21 Jan 2015 21:24:44 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 2/4] ieee802154: 6lowpan: fix ARPHRD to
 ARPHRD_6LOWPAN
Message-ID: <20150121202442.GB664@omega>
References: <1421787462-24042-1-git-send-email-alex.aring@gmail.com>
 <1421787462-24042-3-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1421787462-24042-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

On Tue, Jan 20, 2015 at 09:57:40PM +0100, Alexander Aring wrote:
> Currently there exists two interface types with ARPHRD_IEEE802154. These
> are the 802.15.4 interfaces and 802.15.4 6LoWPAN interfaces. This is
> more a bug because some userspace applications checks on this value like
> wireshark. This occurs that wireshark will always try to parse a lowpan
> interface as 802.15.4 frames. With ARPHRD_6LOWPAN wireshark will parse
> it as IPv6 frames which is correct.
> 
> Much applications checks on this value to readout the EUI64 mac address
> which should be the same for ARPHRD_6LOWPAN. BTLE 6LoWPAN and ieee802154
> 6LoWPAN will share now the same ARPHRD.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/ieee802154/6lowpan/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 055fbb7..9dbe0d69 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -113,7 +113,7 @@ static void lowpan_setup(struct net_device *dev)
>  {
>  	dev->addr_len		= IEEE802154_ADDR_LEN;
>  	memset(dev->broadcast, 0xff, IEEE802154_ADDR_LEN);
> -	dev->type		= ARPHRD_IEEE802154;
> +	dev->type		= ARPHRD_6LOWPAN;
>  	/* Frame Control + Sequence Number + Address fields + Security Header */
>  	dev->hard_header_len	= 2 + 1 + 20 + 14;
>  	dev->needed_tailroom	= 2; /* FCS */
> -- 
> 2.2.2
> 

A little list of applications which need to update afterwards this patch:

 - radvd [0]
 - unstrung [1]


I know this will break the above software, but we need really to do this
step. Any complaints here according to this patch?

- Alex

[0] https://github.com/reubenhwk/radvd/blob/master/device-linux.c#L82
[1] https://github.com/mcr/unstrung/blob/5e7c4060730ab4f81ddcd75657d87ec78da91bd6/lib/libndmgmt/netlink.cpp#L358
