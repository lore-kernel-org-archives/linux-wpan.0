Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:46108 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbaJMQH5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Oct 2014 12:07:57 -0400
Date: Mon, 13 Oct 2014 19:07:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC
 decompression.
Message-ID: <20141013160747.GA27248@t440s.P-661HNU-F1>
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>
 <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
 <1413200959.2705.90.camel@jrissane-mobl.ger.corp.intel.com>
 <543BCF44.1030001@xsilon.com>
 <1413211468.2705.104.camel@jrissane-mobl.ger.corp.intel.com>
 <543BE816.80304@xsilon.com>
 <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <martin.townsend@xsilon.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com

Hi,

On Mon, Oct 13, 2014, Jukka Rissanen wrote:
> On ma, 2014-10-13 at 15:56 +0100, Martin Townsend wrote:
> > Hi Jukka,
> > 
> > Does this patch help?
> 
> Unfortunately no, I still see inconsistent lock state. It would probably
> have been too easy :)
> > 
> > ---
> >  net/bluetooth/l2cap_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index b6f9777..fb7b2ff 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -5494,6 +5494,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
> >  	if (credits > max_credits) {
> >  		BT_ERR("LE credits overflow");
> >  		l2cap_send_disconn_req(chan, ECONNRESET);
> > +		l2cap_chan_unlock(chan);
> >  
> >  		/* Return 0 so that we don't trigger an unnecessary
> >  		 * command reject packet.

I'd appreciate if you could still send a proper patch for this since
it's clearly a locking bug (something even worth sending to stable
trees).

Johan
