Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:59318 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbbEHHIF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 03:08:05 -0400
Date: Fri, 8 May 2015 09:08:01 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCHv2 wpan-tools] interface: use hexadecimal for print
 extended addr
Message-ID: <20150508070801.GA5732@bogon.m.sigxcpu.org>
References: <1431001593-30128-1-git-send-email-alex.aring@gmail.com>
 <20150507142403.GA13559@bogon.m.sigxcpu.org>
 <20150508070004.GA1144@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150508070004.GA1144@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Fri, May 08, 2015 at 09:00:06AM +0200, Alexander Aring wrote:
> On Thu, May 07, 2015 at 04:24:03PM +0200, Guido Günther wrote:
> > On Thu, May 07, 2015 at 02:26:33PM +0200, Alexander Aring wrote:
> > > This patch prints the extended addr in hexadecimal value. This is what
> > > the "0x...." prefix suggested.
> > > 
> > > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > > Cc: Guido Günther <agx@sigxcpu.org>
> > > ---
> > > changes since v2:
> > >  - s/inteface/interface/
> > >  - can't remove the v we are already at v2
> > > 
> > >  src/interface.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/src/interface.c b/src/interface.c
> > > index 5e0ef89..e501763 100644
> > > --- a/src/interface.c
> > > +++ b/src/interface.c
> > > @@ -203,7 +203,7 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
> > >  		printf("%s\twpan_dev 0x%llx\n", indent,
> > >  		       (unsigned long long)nla_get_u64(tb_msg[NL802154_ATTR_WPAN_DEV]));
> > >  	if (tb_msg[NL802154_ATTR_EXTENDED_ADDR])
> > > -		printf("%s\textended_addr 0x%016" PRIu64 "\n", indent,
> > > +		printf("%s\textended_addr 0x%016" PRIx64 "\n", indent,
> > 
> > ACK.
> 
> Please answer with:
> 
> Acked-by: name of the great person which acked <mail of great person>
> 
> then I can take it into the git log.

Although I'm certainly not a great person by any means:

Acked-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido
