Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48724 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaK2PDm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 29 Nov 2014 10:03:42 -0500
Date: Sat, 29 Nov 2014 16:03:34 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/2] 6lowpan: add generic nhc layer
 interface
Message-ID: <20141129150331.GA9625@omega>
References: <1417271082-10068-1-git-send-email-alex.aring@gmail.com>
 <1417271082-10068-2-git-send-email-alex.aring@gmail.com>
 <FB346BA3-CBC9-42DC-8D49-220A6B8A9371@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FB346BA3-CBC9-42DC-8D49-220A6B8A9371@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>

Hi Marcel,

On Sat, Nov 29, 2014 at 03:47:57PM +0100, Marcel Holtmann wrote:
> Hi Alex,
> 
> > This patch adds a generic next header compression layer interface. There
> > exists various methods to do a header compression after 6LoWPAN header
> > to save payload. This introduce a generic nhc header which allow a
> > simple adding of a new header compression format instead of a static
> > implementation inside the 6LoWPAN header compression and uncompression
> > function.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> > Cc: Martin Townsend <mtownsend1973@gmail.com>
> > ---
> > net/6lowpan/Makefile |   4 +-
> > net/6lowpan/nhc.c    | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > net/6lowpan/nhc.h    | 128 ++++++++++++++++++++++++++++++++++++
> > 3 files changed, 313 insertions(+), 1 deletion(-)
> > create mode 100644 net/6lowpan/nhc.c
> > create mode 100644 net/6lowpan/nhc.h
> > 
> > diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
> > index 415886b..ba6bf47 100644
> > --- a/net/6lowpan/Makefile
> > +++ b/net/6lowpan/Makefile
> > @@ -1,3 +1,5 @@
> > obj-$(CONFIG_6LOWPAN) := 6lowpan.o
> > 

...

> > +
> > +/**
> > + * LOWPAN_NHC - helper macro to generate nh id fields and lowpan_nhc struct
> > + *
> > + * @__nhc: variable name of the lowpan_nhc struct.
> > + * @_name: const char * of common header compression name.
> > + * @_nexthdr: ipv6 nexthdr field for the header compression.
> > + * @_nexthdrlen: ipv6 nexthdr len for the reserved space.
> > + * @_idsetup: callback to setup id and mask values.
> > + * @_idlen: len for the next header id and mask, should be always the same.
> > + * @_uncompress: callback for uncompression call.
> > + * @_compress: callback for compression call.
> > + */
> > +#define LOWPAN_NHC(__nhc, _name, _nexthdr,	\
> > +		   _nexthdrlen, _idsetup,	\
> > +		   _idlen, _uncompress,		\
> > +		   _compress)			\
> > +	static u8 __nhc##_val[_idlen];		\
> > +	static u8 __nhc##_mask[_idlen];		\
> > +	static struct lowpan_nhc __nhc = {	\
> 
> any reason why these are not declared as static const?
> 

no this should also not changeable at runtime, I will change it to
const. Thanks.

> > +		.name		= _name,	\
> > +		.nexthdr	= _nexthdr,	\
> > +		.nexthdrlen	= _nexthdrlen,	\
> > +		.id		= __nhc##_val,	\
> > +		.idmask		= __nhc##_mask,	\
> > +		.idlen		= _idlen,	\
> > +		.idsetup	= _idsetup,	\
> > +		.uncompress	= _uncompress,	\
> > +		.compress	= _compress,	\
> > +	}
> 
> I also wonder if we should mix lowpan_nhc_add and lowpan_nhc_del handling into this macro as well. If the next header compression would be auto-loadable modules, then creating a module_lowpan_nhc() macro similar to module_usb_driver() etc. would help. We could in theory use module aliases to auto-load compression modules once needed. However it might be a bit too much overhead.
> 

yes, I will change it in v2. This is a great idea. Thanks.

- Alex
