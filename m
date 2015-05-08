Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38308 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbEHHAP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 03:00:15 -0400
Received: by wiun10 with SMTP id n10so16754672wiu.1
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 00:00:13 -0700 (PDT)
Date: Fri, 8 May 2015 09:00:06 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 wpan-tools] interface: use hexadecimal for print
 extended addr
Message-ID: <20150508070004.GA1144@omega>
References: <1431001593-30128-1-git-send-email-alex.aring@gmail.com>
 <20150507142403.GA13559@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150507142403.GA13559@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Thu, May 07, 2015 at 04:24:03PM +0200, Guido Günther wrote:
> On Thu, May 07, 2015 at 02:26:33PM +0200, Alexander Aring wrote:
> > This patch prints the extended addr in hexadecimal value. This is what
> > the "0x...." prefix suggested.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > Cc: Guido Günther <agx@sigxcpu.org>
> > ---
> > changes since v2:
> >  - s/inteface/interface/
> >  - can't remove the v we are already at v2
> > 
> >  src/interface.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/src/interface.c b/src/interface.c
> > index 5e0ef89..e501763 100644
> > --- a/src/interface.c
> > +++ b/src/interface.c
> > @@ -203,7 +203,7 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
> >  		printf("%s\twpan_dev 0x%llx\n", indent,
> >  		       (unsigned long long)nla_get_u64(tb_msg[NL802154_ATTR_WPAN_DEV]));
> >  	if (tb_msg[NL802154_ATTR_EXTENDED_ADDR])
> > -		printf("%s\textended_addr 0x%016" PRIu64 "\n", indent,
> > +		printf("%s\textended_addr 0x%016" PRIx64 "\n", indent,
> 
> ACK.

Please answer with:

Acked-by: name of the great person which acked <mail of great person>

then I can take it into the git log.

- Alex
