Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:47024 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbbBKNAK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Feb 2015 08:00:10 -0500
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t1BD07R2002506
	for <linux-wpan@vger.kernel.org>; Wed, 11 Feb 2015 14:00:07 +0100
Date: Wed, 11 Feb 2015 13:59:58 +0100
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154: cleanup
 ieee802154_be64_to_le64
Message-ID: <20150211135958.3aa2caa1@zoidberg>
In-Reply-To: <20150211123556.GA7351@omega>
References: <1423606461-16945-1-git-send-email-alex.aring@gmail.com>
	<1423606461-16945-3-git-send-email-alex.aring@gmail.com>
	<54DB486E.4080905@pengutronix.de>
	<20150211123556.GA7351@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed, 11 Feb 2015 13:36:03 +0100
Alexander Aring <alex.aring@gmail.com> wrote:

> On Wed, Feb 11, 2015 at 01:17:50PM +0100, Marc Kleine-Budde wrote:
> > On 02/10/2015 11:14 PM, Alexander Aring wrote:
> > > This patch cleanups the ieee802154_be64_to_le64 function. This
> > > patch removes an unnecessary temporary variable.
> > > 
> > > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > > ---
> > >  include/net/mac802154.h | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> > > index 8506478..a4dcefe 100644
> > > --- a/include/net/mac802154.h
> > > +++ b/include/net/mac802154.h
> > > @@ -233,9 +233,7 @@ struct ieee802154_ops {
> > >   */
> > >  static inline void ieee802154_be64_to_le64(void *le64_dst, const
> > > void *be64_src) {
> > > -	__le64 tmp = (__force __le64)swab64p(be64_src);
> > > -
> > > -	memcpy(le64_dst, &tmp, IEEE802154_EXTENDED_ADDR_LEN);
> > > +	*((__le64 *)le64_dst) = (__force
> > > __le64)swab64p(be64_src);
> > 
> > I assume the compiler optimizes the memcpy, due to the constant
> > length argument. It the dst always 64 bit aligned?
> 
> should be. I can't check this, but dst and src should always 64 bit
> long. (Otherwise the programmer do something wrong).
> 
> It's just byte swapping a little endian 64 bit value to big endian 64
> bit value. Because mac header is little and the most netdev core api
> uses big endian. These function are some helper function to transfer
> __le64 to __be64. Sometimes the __le64 and __be64 are implementated as
> arrays so I do this over some void pointers, like [0].

If you convert into an array (which happens sometimes, as you point
out), you cannot assume alignment stronger than single bytes. If you do
remove the memcpy, please adjust the dst argument pointer to be
__le64* to catch these cases of possible misalignment.

> At [0] you see the assigned MAC PIB extended addr (saved as __le64)
> which is set to the netdevice dev_addr array (assumes big endian).
> 
> The swab64p is an architecture optimized byte swapping function.
> 
> Do you think that this patch will decrease the perfomance of this
> function? I know the casts looks a little bit ugly but swab64p isn't
> made for "endianness swapping" and assumes u64 as parameter (pointer)
> and result.
> 
> - Alex
> 
> [0]
> http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac802154/iface.c#n558
> -- To unsubscribe from this list: send the line "unsubscribe
> linux-wpan" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

