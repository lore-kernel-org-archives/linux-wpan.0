Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:53919 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbbELMZ2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 May 2015 08:25:28 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t4CCPQ6x015327
	for <linux-wpan@vger.kernel.org>; Tue, 12 May 2015 14:25:26 +0200
Date: Tue, 12 May 2015 14:25:24 +0200
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: [PATCH bluetooth-next 3/3] mac802154: remove mib lock
Message-ID: <20150512142524.79d9a2a4@zoidberg>
In-Reply-To: <20150512122254.GG733@omega>
References: <1431290456-25524-1-git-send-email-alex.aring@gmail.com>
	<1431290456-25524-4-git-send-email-alex.aring@gmail.com>
	<20150512075018.GB733@omega>
	<20150512130615.3f8409f6@zoidberg>
	<20150512115258.GF733@omega>
	<20150512122254.GG733@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, 12 May 2015 14:22:56 +0200
Alexander Aring <alex.aring@gmail.com> wrote:

> On Tue, May 12, 2015 at 01:52:58PM +0200, Alexander Aring wrote:
> > Hi,
> > 
> > ...
> > > > 
> > > > Introduce a percpu counter for the sequence numbers,
> > > > incrementation of this counter is an atomic operation then and
> > > > we are sure that we don't sending the same sequence number when
> > > > calling this function at the same time.
> > > 
> > > With this, two threads running on the same interface can send
> > > different packets with the same sequence number back to back.
> > > Maybe better make it atomic instead of percpu instead to avoid
> > > that?
> > > 
> > 
> > Yes you are right, that's not correct. Because per_cpu is a local
> > variable what's the name said _per_ _cpu_. For this kind of very
> > global mib value which needs to be incremented after each transmit
> > a atomic_t should be correct here and that's also what the comment
> > said.
> > 
> > Damn, why I thought that a percpu variable should be correct here.
> > 
> 
> So I updated the draft with this, I hope that is more correct than the
> previous one, which really makes no sense:
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index c6aa1d2..4de59aa 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -177,9 +177,9 @@ struct wpan_dev {
>         __le64 extended_addr;
>  
>         /* MAC BSN field */
> -       u8 bsn;
> +       atomic_t bsn;
>         /* MAC DSN field */
> -       u8 dsn;
> +       atomic_t dsn;
>  
>         u8 min_be;
>         u8 max_be;
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 866d27f..b99a6f6 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -365,10 +365,7 @@ static int mac802154_header_create(struct
> sk_buff *skb, hdr.fc.type = cb->type;
>         hdr.fc.security_enabled = cb->secen;
>         hdr.fc.ack_request = cb->ackreq;
> -       /* TODO: use atomic_t as dsn, dsn need to be locked when
> AF_IEEE802154
> -        * and IEEE802154 6LoWPAN call this at the same time.
> -        */
> -       hdr.seq = dev->ieee802154_ptr->dsn++;
> +       hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
>  
>         if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
>                 return -EINVAL;
> @@ -464,13 +461,16 @@ ieee802154_setup_sdata(struct
> ieee802154_sub_if_data *sdata, enum nl802154_iftype type)
>  {
>         struct wpan_dev *wpan_dev = &sdata->wpan_dev;
> +       u8 tmp;
>  
>         /* set some type-dependent values */
>         sdata->vif.type = type;
>         sdata->wpan_dev.iftype = type;
>  
> -       get_random_bytes(&wpan_dev->bsn, 1);
> -       get_random_bytes(&wpan_dev->dsn, 1);
> +       get_random_bytes(&tmp, 1);
> +       atomic_set(&wpan_dev->bsn, tmp);
> +       get_random_bytes(&tmp, 1);
> +       atomic_set(&wpan_dev->dsn, tmp);
>  
>         /* defaults per 802.15.4-2011 */
>         wpan_dev->min_be = 3;
> 
> - Alex

LGTM
