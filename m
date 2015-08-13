Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35664 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbbHMURh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Aug 2015 16:17:37 -0400
Received: by wicne3 with SMTP id ne3so151919319wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 13 Aug 2015 13:17:35 -0700 (PDT)
Date: Thu, 13 Aug 2015 22:17:26 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC 14/16] ieee802154: 6lowpan: add check for reserved dispatch
Message-ID: <20150813201712.GA2732@omega>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-15-git-send-email-alex.aring@gmail.com>
 <55CB4C1D.8000300@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55CB4C1D.8000300@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed, Aug 12, 2015 at 03:37:33PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 03/08/15 08:23, Alexander Aring wrote:
> >This patch adds checks for reserved dispatch value by check on all known
> >dispatch values.
> >
> >Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> >---
> >  net/ieee802154/6lowpan/rx.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> >diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> >index 146aa14..48869ac 100644
> >--- a/net/ieee802154/6lowpan/rx.c
> >+++ b/net/ieee802154/6lowpan/rx.c
> >@@ -248,6 +248,15 @@ static inline bool lowpan_is_nalp(u8 dispatch)
> >  	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
> >  }
> >+static inline bool lowpan_is_reserved(u8 dispatch)
> >+{
> >+	return !(lowpan_is_nalp(dispatch) || lowpan_is_iphc(dispatch) ||
> 
> OK, this is fishy. First of all you check lowpan_is_nalp here and negate it,
> but below you are checking without negation.
> One must be wrong. :)
> 
> 
> >+		 lowpan_is_ipv6(dispatch) || lowpan_is_hc1(dispatch) ||
> >+		 lowpan_is_bc0(dispatch) || lowpan_is_mesh(dispatch) ||
> >+		 lowpan_is_esc(dispatch) || lowpan_is_frag1(dispatch) ||
> >+		 lowpan_is_fragn(dispatch));
> >+}
> >+
> >  /* lowpan_rx_h_check checks on generic 6LoWPAN requirements
> >   * in MAC and 6LoWPAN header.
> >   *
> >@@ -259,7 +268,8 @@ static bool lowpan_rx_h_check(struct sk_buff *skb)
> >  	if (unlikely(!skb->len))
> >  		return false;
> >-	if (lowpan_is_nalp(*skb_network_header(skb)))
> >+	if (lowpan_is_nalp(*skb_network_header(skb)) ||
> 
> Here are you checking it as well. but without negating it.
> 

yes, I think we should work here with ranges. Not checking all known
values. (Maybe we can also do some bit magic there then).

Also I should lookup more iana registrations for dispatches. I forget

LOWPAN_DFF

See [0]. But then somebody else should send a patch to introduce some
"netdev warning message".

btw: we should add some of these warning messages for lowpan_nhc as well.
[1]. I am fine for introduce just a name and known nhc id for printing
some warning that we don't support $NAME right now, instead of
"unknown".

(Also wondering why "11111111 - Unassigned, reserved for extensions" -
does this mean now that when we have "11111111" an additional nhc id
byte is there? I don't see anything in rfc6282 which mention that. For
this reason I had implement the such complicated rbtree lookup mechanism
because I was not sure about this -> "When we know an additional nhc id
byte is there". Anyway it's some variable length bitstring and rbtree
structure should be fit there (I hope).

- Alex

[0] https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#_6lowpan-parameters-1
[1] https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#lowpan_nhc
